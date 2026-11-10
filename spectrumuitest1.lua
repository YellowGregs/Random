local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local tws = game:GetService("TweenService")
local uis = game:GetService("UserInputService")

local small = uis.TouchEnabled and not uis.KeyboardEnabled
local playerGui = Players.LocalPlayer and Players.LocalPlayer:WaitForChild("PlayerGui")

local function wipe(holder)
	if not holder then
		return
	end
	pcall(function()
		for _, old in ipairs(holder:GetChildren()) do
			if old.Name == "Spectrum" then
				old:Destroy()
			end
		end
	end)
end

wipe(CoreGui)
wipe(playerGui)

local gui = Instance.new("ScreenGui")
gui.Name = "Spectrum"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 20
pcall(function()
	gui.ScreenInsets = Enum.ScreenInsets.None
end)

local inCore = pcall(function()
	gui.Parent = CoreGui
end)
if not inCore then
	gui.Parent = playerGui
end

local font = Enum.Font.GothamMedium
local bold = Enum.Font.GothamBold
local white = Color3.new(1, 1, 1)

local theme = {
	accent = Color3.fromRGB(96, 140, 255),
	accent2 = Color3.fromRGB(160, 190, 255),
	bg = Color3.fromRGB(16, 17, 22),
	top = Color3.fromRGB(25, 27, 34),
	card = Color3.fromRGB(25, 27, 34),
	hover = Color3.fromRGB(34, 37, 46),
	inset = Color3.fromRGB(18, 19, 25),
	track = Color3.fromRGB(45, 49, 61),
	text = Color3.fromRGB(235, 238, 246),
	sub = Color3.fromRGB(148, 154, 171),
	good = Color3.fromRGB(78, 210, 160),
	warn = Color3.fromRGB(255, 186, 92),
	bad = Color3.fromRGB(255, 96, 108),
}

local painters = {}
local running = {}
local windows = {}

local function viewport()
	local cam = Workspace.CurrentCamera
	return cam and cam.ViewportSize or Vector2.new(1280, 720)
end

local function new(class, props)
	local object = Instance.new(class)
	if props then
		for property, value in pairs(props) do
			if property ~= "Parent" then
				object[property] = value
			end
		end
		object.Parent = props.Parent
	end
	return object
end

local function corner(object, radius)
	return new("UICorner", {
		CornerRadius = UDim.new(0, radius or 8),
		Parent = object,
	})
end

local function stroke(object, color, transparency, thickness)
	return new("UIStroke", {
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = color or white,
		Transparency = transparency or 0.9,
		Thickness = thickness or 1,
		Parent = object,
	})
end

local function shadow(object, blur, transparency, offset)
	local built = pcall(function()
		local shade = Instance.new("UIShadow")
		shade.BlurRadius = blur or 18
		shade.Transparency = transparency or 0.5
		shade.Offset = offset or Vector2.new(0, 6)
		shade.Color = Color3.new(0, 0, 0)
		shade.Parent = object
	end)
	if built then
		return
	end
	if object.Parent then
		new("ImageLabel", {
			Name = "shade",
			BackgroundTransparency = 1,
			Image = "rbxassetid://5554236805",
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(23, 23, 277, 277),
			ImageColor3 = Color3.new(0, 0, 0),
			ImageTransparency = (transparency or 0.5) - 0.05,
			Position = UDim2.fromOffset(-12, -10),
			Size = UDim2.new(1, 24, 1, 26),
			ZIndex = math.max(object.ZIndex - 1, 0),
			Parent = object.Parent,
		})
	end
end

local function tween(object, time, props, style, direction)
	local names = {}
	for name in pairs(props) do
		names[#names + 1] = name
	end
	table.sort(names)
	local id = table.concat(names, ",")
	local bucket = running[object]
	if not bucket then
		bucket = {}
		running[object] = bucket
	end
	if bucket[id] then
		bucket[id]:Cancel()
	end
	local spin = tws:Create(object, TweenInfo.new(time or 0.2, style or Enum.EasingStyle.Quint, direction or Enum.EasingDirection.Out), props)
	bucket[id] = spin
	spin:Play()
	return spin
end

local function paint(fn)
	painters[#painters + 1] = fn
	fn()
end

local function glow(row, edge)
	local function on()
		tween(row, 0.16, { BackgroundColor3 = theme.hover })
		tween(edge, 0.16, { Transparency = 0.85 })
	end
	local function off()
		tween(row, 0.22, { BackgroundColor3 = theme.card })
		tween(edge, 0.22, { Transparency = 0.93 })
	end
	row.MouseEnter:Connect(on)
	row.MouseLeave:Connect(off)
	row.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then
			on()
		end
	end)
	row.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then
			off()
		end
	end)
end

-- invisible glass that closes whatever is open
local overlay = new("TextButton", {
	Name = "overlay",
	BackgroundTransparency = 1,
	Text = "",
	AutoButtonColor = false,
	Size = UDim2.fromScale(1, 1),
	Visible = false,
	ZIndex = 500,
	Parent = gui,
})

local popoverOpen = nil

local function dismiss()
	local closer = popoverOpen
	popoverOpen = nil
	if overlay.Parent then
		overlay.Visible = false
	end
	if closer then
		closer()
	end
end

overlay.Activated:Connect(dismiss)

local notes = new("Frame", {
	Name = "notifications",
	BackgroundTransparency = 1,
	AnchorPoint = Vector2.new(1, 1),
	Position = UDim2.new(1, -18, 1, -18),
	Size = UDim2.fromOffset(286, 0),
	AutomaticSize = Enum.AutomaticSize.Y,
	ZIndex = 900,
	Parent = gui,
})

new("UIListLayout", {
	Padding = UDim.new(0, 8),
	SortOrder = Enum.SortOrder.LayoutOrder,
	HorizontalAlignment = Enum.HorizontalAlignment.Right,
	VerticalAlignment = Enum.VerticalAlignment.Bottom,
	Parent = notes,
})

local noted = 0

local function notify(title, body, duration, kind)
	noted = noted + 1
	duration = duration or 3.5
	local tint = theme.accent
	if kind == "good" then
		tint = theme.good
	elseif kind == "warn" then
		tint = theme.warn
	elseif kind == "bad" then
		tint = theme.bad
	end

	local wrap = new("Frame", {
		Name = "note",
		BackgroundTransparency = 1,
		LayoutOrder = noted,
		Size = UDim2.new(1, 0, 0, 68),
		Parent = notes,
	})

	local face = new("Frame", {
		Name = "face",
		BackgroundColor3 = theme.card,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(0, 10),
		Size = UDim2.fromScale(1, 1),
		Parent = wrap,
	})
	corner(face, 10)
	local edge = stroke(face, white, 1)
	shadow(face, 16, 0.55, Vector2.new(0, 5))

	local tinted = new("Frame", {
		BackgroundColor3 = tint,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(14, 21),
		Size = UDim2.fromOffset(6, 6),
		BackgroundTransparency = 1,
		Parent = face,
	})
	corner(tinted, 3)

	local heading = new("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(28, 12),
		Size = UDim2.new(1, -44, 0, 16),
		Font = bold,
		Text = title or "Notification",
		TextColor3 = theme.text,
		TextSize = 12,
		TextTransparency = 1,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = face,
	})

	local caption = new("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(28, 30),
		Size = UDim2.new(1, -44, 0, 16),
		Font = font,
		Text = body or "",
		TextColor3 = theme.sub,
		TextSize = 11,
		TextTransparency = 1,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = face,
	})

	local rail = new("Frame", {
		BackgroundColor3 = white,
		BackgroundTransparency = 0.88,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 14, 1, -10),
		Size = UDim2.new(1, -28, 0, 2),
		Parent = face,
	})
	corner(rail, 1)

	local line = new("Frame", {
		BackgroundColor3 = tint,
		BackgroundTransparency = 0.25,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1),
		Parent = rail,
	})
	corner(line, 1)

	local closed = false
	local function close()
		if closed then
			return
		end
		closed = true
		tween(face, 0.2, { BackgroundTransparency = 1, Position = UDim2.fromOffset(0, 8) })
		tween(edge, 0.2, { Transparency = 1 })
		tween(heading, 0.18, { TextTransparency = 1 })
		tween(caption, 0.18, { TextTransparency = 1 })
		tween(tinted, 0.18, { BackgroundTransparency = 1 })
		tween(line, 0.18, { BackgroundTransparency = 1 })
		tween(rail, 0.18, { BackgroundTransparency = 1 })
		task.delay(0.22, function()
			wrap:Destroy()
		end)
	end

	local hit = new("TextButton", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = "",
		AutoButtonColor = false,
		Parent = face,
	})
	hit.Activated:Connect(close)

	tween(face, 0.3, { BackgroundTransparency = 0, Position = UDim2.fromOffset(0, 0) })
	tween(edge, 0.3, { Transparency = 0.9 })
	tween(heading, 0.3, { TextTransparency = 0 })
	tween(caption, 0.3, { TextTransparency = 0 })
	tween(tinted, 0.3, { BackgroundTransparency = 0 })
	tween(line, duration, { Size = UDim2.fromScale(0, 1) }, Enum.EasingStyle.Linear, Enum.EasingDirection.In)
	task.delay(duration, close)

	return close
end

local Library = {}
Library.Theme = theme
Library.Version = "2.0"

function Library:Notify(title, body, duration, kind)
	return notify(title, body, duration, kind)
end

function Library:SetAccent(color)
	theme.accent = color
	theme.accent2 = color:Lerp(white, 0.3)
	for _, painter in ipairs(painters) do
		pcall(painter)
	end
end

function Library:Destroy()
	for _, window in ipairs(windows) do
		if window.Parent then
			window:Destroy()
		end
	end
	gui:Destroy()
end

local topZ = 10
local slot = 0

-- new windows line up like they're waiting for the bus
local function spot(width)
	local vp = viewport()
	local perRow = math.max(1, math.floor((vp.X - 48) / (width + 12)))
	local index = slot
	slot = slot + 1
	local col = index % perRow
	local row = math.floor(index / perRow)
	return UDim2.fromOffset(24 + col * (width + 12), 44 + row * 52)
end

function Library:Window(title)
	local w = {}
	local width = small and 244 or 276
	local header = 42
	local open = true
	local order = 0
	local links = {}
	local made = {}
	local maxHeight = math.floor(viewport().Y * 0.62)

	local root = new("Frame", {
		Name = "Window",
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(width, header + 90),
		Position = spot(width),
		ZIndex = topZ,
		Parent = gui,
	})
	windows[#windows + 1] = root

	local body = new("Frame", {
		Name = "body",
		BackgroundColor3 = theme.bg,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Size = UDim2.fromScale(1, 1),
		ZIndex = 2,
		Parent = root,
	})
	corner(body, 12)
	shadow(body, 22, 0.5, Vector2.new(0, 8))
	local frameEdge = stroke(body, white, 0.9)
	new("UIGradient", {
		Rotation = 90,
		Color = ColorSequence.new(theme.top, theme.bg),
		Parent = body,
	})

	local head = new("Frame", {
		Name = "head",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, header),
		ZIndex = 3,
		Parent = body,
	})

	local dot = new("Frame", {
		BackgroundColor3 = theme.accent,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(15, 18),
		Size = UDim2.fromOffset(6, 6),
		ZIndex = 4,
		Parent = head,
	})
	corner(dot, 3)

	local caption = new("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(28, 0),
		Size = UDim2.new(1, -108, 1, 0),
		Font = bold,
		Text = title or "Window",
		TextColor3 = theme.text,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
		ZIndex = 4,
		Parent = head,
	})

	new("Frame", {
		BackgroundColor3 = white,
		BackgroundTransparency = 0.93,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 1, -1),
		Size = UDim2.new(1, 0, 0, 1),
		ZIndex = 4,
		Parent = head,
	})

	local foldBtn = new("TextButton", {
		Name = "fold",
		BackgroundColor3 = white,
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Position = UDim2.new(1, -66, 0.5, -14),
		Size = UDim2.fromOffset(28, 28),
		Text = "",
		ZIndex = 5,
		Parent = head,
	})
	corner(foldBtn, 8)

	local foldBarH = new("Frame", {
		BackgroundColor3 = theme.sub,
		BorderSizePixel = 0,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(10, 1.5),
		ZIndex = 6,
		Parent = foldBtn,
	})
	corner(foldBarH, 1)

	local foldBarV = new("Frame", {
		BackgroundColor3 = theme.sub,
		BorderSizePixel = 0,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(1.5, 10),
		ZIndex = 6,
		Parent = foldBtn,
	})
	corner(foldBarV, 1)

	local shut = new("TextButton", {
		Name = "shut",
		BackgroundColor3 = white,
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Position = UDim2.new(1, -34, 0.5, -14),
		Size = UDim2.fromOffset(28, 28),
		Text = "",
		ZIndex = 5,
		Parent = head,
	})
	corner(shut, 8)

	for _, angle in ipairs({ 45, -45 }) do
		local bar = new("Frame", {
			BackgroundColor3 = theme.sub,
			BorderSizePixel = 0,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Rotation = angle,
			Size = UDim2.fromOffset(10, 1.5),
			ZIndex = 6,
			Parent = shut,
		})
		corner(bar, 1)
	end

	for _, button in ipairs({ foldBtn, shut }) do
		button.MouseEnter:Connect(function()
			tween(button, 0.15, { BackgroundTransparency = 0.92 })
		end)
		button.MouseLeave:Connect(function()
			tween(button, 0.2, { BackgroundTransparency = 1 })
		end)
	end
	shut.MouseEnter:Connect(function()
		for _, child in ipairs(shut:GetChildren()) do
			if child:IsA("Frame") then
				tween(child, 0.15, { BackgroundColor3 = theme.bad })
			end
		end
	end)
	shut.MouseLeave:Connect(function()
		for _, child in ipairs(shut:GetChildren()) do
			if child:IsA("Frame") then
				tween(child, 0.2, { BackgroundColor3 = theme.sub })
			end
		end
	end)

	local grab = new("Frame", {
		BackgroundTransparency = 1,
		Active = true,
		Size = UDim2.new(1, -74, 1, 0),
		ZIndex = 4,
		Parent = head,
	})

	local scroll = new("ScrollingFrame", {
		Name = "content",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(0, header),
		Size = UDim2.new(1, 0, 0, 80),
		CanvasSize = UDim2.new(),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		ScrollBarThickness = 3,
		ScrollBarImageColor3 = theme.sub,
		ScrollBarImageTransparency = 0.6,
		VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
		ZIndex = 3,
		Parent = body,
	})

	new("UIPadding", {
		PaddingTop = UDim.new(0, 2),
		PaddingBottom = UDim.new(0, 10),
		PaddingLeft = UDim.new(0, 8),
		PaddingRight = UDim.new(0, 8),
		Parent = scroll,
	})

	local list = new("UIListLayout", {
		Padding = UDim.new(0, 6),
		SortOrder = Enum.SortOrder.LayoutOrder,
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		Parent = scroll,
	})

	local function link(signal, fn)
		local held = signal:Connect(fn)
		links[#links + 1] = held
		return held
	end

	local function fit(animate)
		local content = list.AbsoluteContentSize.Y + 14
		local cap = math.max(80, maxHeight)
		local height = math.clamp(content, 48, cap)
		scroll.Size = UDim2.new(1, 0, 0, height)
		local total = header + (open and height or 0)
		if animate then
			tween(root, 0.3, { Size = UDim2.fromOffset(width, total) })
			if open then
				scroll.Visible = true
			else
				task.delay(0.3, function()
					if root.Parent and not open then
						scroll.Visible = false
					end
				end)
			end
		else
			scroll.Visible = open
			root.Size = UDim2.fromOffset(width, total)
		end
	end

	local function front()
		topZ = 10 + (topZ - 10 + 1) % 400
		root.ZIndex = topZ
	end

	local function fold()
		open = not open
		if open then
			scroll.Visible = true
			tween(foldBarV, 0.24, { Size = UDim2.fromOffset(1.5, 10) }, Enum.EasingStyle.Back)
		else
			dismiss()
			tween(foldBarV, 0.2, { Size = UDim2.fromOffset(1.5, 0) })
		end
		fit(true)
	end

	foldBtn.Activated:Connect(fold)

	local pulse = tws:Create(dot, TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
		BackgroundTransparency = 0.55,
	})
	pulse:Play()
	paint(function()
		dot.BackgroundColor3 = theme.accent
	end)

	list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		fit(false)
	end)

	root.InputBegan:Connect(front)
	grab.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end
		front()
		dismiss()
		local origin = input.Position
		local start = root.Position
		local dragging = true

		local move
		local release
		move = uis.InputChanged:Connect(function(change)
			if not dragging then
				return
			end
			if change.UserInputType ~= Enum.UserInputType.MouseMovement and change.UserInputType ~= Enum.UserInputType.Touch then
				return
			end
			local delta = change.Position - origin
			local vp = viewport()
			local x = math.clamp(start.X.Offset + delta.X, -width + 90, vp.X - 90)
			local y = math.clamp(start.Y.Offset + delta.Y, 0, vp.Y - header - 6)
			root.Position = UDim2.fromOffset(x, y)
		end)
		release = uis.InputEnded:Connect(function(ending)
			if ending.UserInputType == Enum.UserInputType.MouseButton1 or ending.UserInputType == Enum.UserInputType.Touch then
				dragging = false
				move:Disconnect()
				release:Disconnect()
			end
		end)
	end)

	shut.Activated:Connect(function()
		dismiss()
		root:Destroy()
	end)

	local grip = new("TextButton", {
		Name = "grip",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 1),
		Position = UDim2.new(1, -4, 1, -4),
		Size = UDim2.fromOffset(20, 20),
		Text = "",
		AutoButtonColor = false,
		ZIndex = 7,
		Parent = root,
	})

	for index, spot2 in ipairs({ { 12, 6 }, { 7, 11 }, { 12, 12 } }) do
		local pip = new("Frame", {
			BackgroundColor3 = theme.sub,
			BackgroundTransparency = 0.65,
			BorderSizePixel = 0,
			Position = UDim2.fromOffset(spot2[1] - 6, spot2[2] - 6),
			Size = UDim2.fromOffset(2, 2),
			ZIndex = 7,
			Parent = grip,
		})
		corner(pip, 1)
		pip.Name = "pip" .. index
	end

	-- resize math, please do not breathe on it
	grip.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end
		front()
		dismiss()
		local origin = input.Position
		local startW = width
		local startH = maxHeight
		local resizing = true

		local move
		local release
		move = uis.InputChanged:Connect(function(change)
			if not resizing then
				return
			end
			if change.UserInputType ~= Enum.UserInputType.MouseMovement and change.UserInputType ~= Enum.UserInputType.Touch then
				return
			end
			local delta = change.Position - origin
			width = math.clamp(startW + delta.X, 216, 420)
			maxHeight = math.clamp(startH + delta.Y, 90, viewport().Y - header - 80)
			root.Size = UDim2.fromOffset(width, root.Size.Y.Offset)
			fit(false)
		end)
		release = uis.InputEnded:Connect(function(ending)
			if ending.UserInputType == Enum.UserInputType.MouseButton1 or ending.UserInputType == Enum.UserInputType.Touch then
				resizing = false
				move:Disconnect()
				release:Disconnect()
			end
		end)
	end)

	local function card(height)
		order = order + 1
		local row = new("Frame", {
			Name = "row",
			Active = true,
			BackgroundColor3 = theme.card,
			BorderSizePixel = 0,
			LayoutOrder = order,
			Size = UDim2.new(1, 0, 0, height or 36),
			Parent = scroll,
		})
		corner(row, 9)
		local edge = stroke(row, white, 0.93)
		return row, edge
	end

	scroll:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
		if popoverOpen then
			dismiss()
		end
	end)

	link(root.Destroying, function()
		dismiss()
		for _, held in ipairs(links) do
			held:Disconnect()
		end
		for _, panel in ipairs(made) do
			panel:Destroy()
		end
	end)

	function w:button(text, callback)
		local row, edge = card(36)
		glow(row, edge)
		local press = new("UIScale", { Parent = row })
		local button = new("TextButton", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			AutoButtonColor = false,
			Font = font,
			Text = text or "Button",
			TextColor3 = theme.text,
			TextSize = 12,
			Parent = row,
		})
		row.MouseEnter:Connect(function()
			tween(button, 0.15, { TextColor3 = white })
		end)
		row.MouseLeave:Connect(function()
			tween(button, 0.2, { TextColor3 = theme.text })
		end)
		button.Activated:Connect(function()
			press.Scale = 0.97
			tween(press, 0.3, { Scale = 1 }, Enum.EasingStyle.Back)
			if callback then
				callback()
			end
		end)
		return button
	end

	function w:section(text)
		order = order + 1
		local row = new("Frame", {
			BackgroundTransparency = 1,
			LayoutOrder = order,
			Size = UDim2.new(1, 0, 0, 26),
			Parent = scroll,
		})
		local bar = new("Frame", {
			BackgroundColor3 = theme.accent,
			BorderSizePixel = 0,
			Position = UDim2.new(0, 2, 0.5, -6),
			Size = UDim2.fromOffset(3, 12),
			Parent = row,
		})
		corner(bar, 2)
		paint(function()
			bar.BackgroundColor3 = theme.accent
		end)
		local label = new("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(12, 0),
			Size = UDim2.new(1, -12, 1, 0),
			Font = bold,
			Text = text or "Section",
			TextColor3 = theme.text,
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			Parent = row,
		})
		return label
	end

	function w:separator()
		order = order + 1
		new("Frame", {
			BackgroundColor3 = white,
			BackgroundTransparency = 0.93,
			BorderSizePixel = 0,
			LayoutOrder = order,
			Size = UDim2.new(1, 0, 0, 1),
			Parent = scroll,
		})
	end

	function w:label(text)
		order = order + 1
		local row = new("Frame", {
			BackgroundTransparency = 1,
			LayoutOrder = order,
			AutomaticSize = Enum.AutomaticSize.Y,
			Size = UDim2.new(1, 0, 0, 0),
			Parent = scroll,
		})
		new("UIPadding", {
			PaddingTop = UDim.new(0, 2),
			PaddingBottom = UDim.new(0, 2),
			PaddingLeft = UDim.new(0, 2),
			PaddingRight = UDim.new(0, 8),
			Parent = row,
		})
		local label = new("TextLabel", {
			BackgroundTransparency = 1,
			AutomaticSize = Enum.AutomaticSize.Y,
			Size = UDim2.new(1, 0, 0, 0),
			Font = font,
			Text = text or "",
			TextColor3 = theme.sub,
			TextSize = 11,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			Parent = row,
		})
		return label
	end

	function w:toggle(text, a, b)
		local default, callback = false, a
		if type(a) == "boolean" then
			default = a
			callback = b
		end
		local row, edge = card(38)
		glow(row, edge)
		local state = default and true or false

		new("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(10, 0),
			Size = UDim2.new(1, -70, 1, 0),
			Font = font,
			Text = text or "Toggle",
			TextColor3 = theme.text,
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			ZIndex = 2,
			Parent = row,
		})

		local track = new("Frame", {
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundColor3 = state and theme.accent or theme.track,
			BorderSizePixel = 0,
			Position = UDim2.new(1, -10, 0.5, 0),
			Size = UDim2.fromOffset(40, 22),
			ZIndex = 2,
			Parent = row,
		})
		corner(track, 11)
		stroke(track, white, 0.9)
		local trackScale = new("UIScale", { Parent = track })

		local knob = new("Frame", {
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = white,
			BorderSizePixel = 0,
			Position = state and UDim2.new(1, -19, 0.5, 0) or UDim2.new(0, 3, 0.5, 0),
			Size = UDim2.fromOffset(16, 16),
			ZIndex = 3,
			Parent = track,
		})
		corner(knob, 8)
		shadow(knob, 5, 0.7, Vector2.new(0, 1))

		local hit = new("TextButton", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			Text = "",
			AutoButtonColor = false,
			ZIndex = 4,
			Parent = row,
		})

		local function set(on, silent)
			state = on
			tween(track, 0.22, { BackgroundColor3 = on and theme.accent or theme.track })
			tween(knob, 0.26, { Position = on and UDim2.new(1, -19, 0.5, 0) or UDim2.new(0, 3, 0.5, 0) })
			if not silent and callback then
				callback(state)
			end
		end

		row.MouseEnter:Connect(function()
			tween(trackScale, 0.18, { Scale = 1.05 })
		end)
		row.MouseLeave:Connect(function()
			tween(trackScale, 0.22, { Scale = 1 })
		end)
		hit.Activated:Connect(function()
			set(not state)
		end)
		paint(function()
			if state then
				track.BackgroundColor3 = theme.accent
			end
		end)

		return {
			Set = function(_, value)
				set(value and true or false, true)
			end,
			Get = function()
				return state
			end,
		}
	end

	function w:slider(text, min, max, default, callback, step)
		if type(default) == "function" then
			callback = default
			default = nil
		end
		min = min or 0
		max = max or 100
		local value = math.clamp(default or min, min, max)
		local places = (step and step < 1) and 2 or 0

		local row, edge = card(46)
		glow(row, edge)

		new("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(10, 7),
			Size = UDim2.new(1, -90, 0, 14),
			Font = font,
			Text = text or "Slider",
			TextColor3 = theme.text,
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			Parent = row,
		})

		local readout = new("TextLabel", {
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.new(1, -10, 0, 7),
			Size = UDim2.fromOffset(70, 14),
			Font = font,
			Text = "",
			TextColor3 = theme.sub,
			TextSize = 11,
			TextXAlignment = Enum.TextXAlignment.Right,
			Parent = row,
		})

		local track = new("Frame", {
			Active = true,
			BackgroundColor3 = theme.track,
			BorderSizePixel = 0,
			Position = UDim2.fromOffset(17, 32),
			Size = UDim2.new(1, -34, 0, 5),
			Parent = row,
		})
		corner(track, 3)

		local fill = new("Frame", {
			BackgroundColor3 = theme.accent,
			BorderSizePixel = 0,
			Size = UDim2.new(0, 0, 1, 0),
			Parent = track,
		})
		corner(fill, 3)
		local gradient = new("UIGradient", { Parent = fill })

		local thumb = new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = white,
			BorderSizePixel = 0,
			Position = UDim2.new(0, 0, 0.5, 0),
			Size = UDim2.fromOffset(14, 14),
			ZIndex = 3,
			Parent = track,
		})
		corner(thumb, 7)
		shadow(thumb, 6, 0.65, Vector2.new(0, 1))
		local thumbScale = new("UIScale", { Parent = thumb })

		local function format(number)
			if places > 0 then
				return string.format("%." .. places .. "f", number)
			end
			return tostring(math.floor(number + 0.5))
		end

		local function draw()
			local span = max - min
			local ratio = span == 0 and 0 or (value - min) / span
			ratio = math.clamp(ratio, 0, 1)
			fill.Size = UDim2.new(ratio, 0, 1, 0)
			thumb.Position = UDim2.new(ratio, 0, 0.5, 0)
			readout.Text = format(value)
		end

		local dragging = false
		local function drag(input)
			local ratio = (input.Position.X - track.AbsolutePosition.X) / math.max(track.AbsoluteSize.X, 1)
			local picked = min + math.clamp(ratio, 0, 1) * (max - min)
			if step and step > 0 then
				picked = math.floor(picked / step + 0.5) * step
			end
			picked = math.clamp(picked, min, max)
			if picked ~= value then
				value = picked
				draw()
				if callback then
					callback(value)
				end
			end
		end

		draw()

		track.InputBegan:Connect(function(input)
			if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
				return
			end
			dragging = true
			drag(input)
			tween(thumbScale, 0.16, { Scale = 1.35 })
			tween(readout, 0.16, { TextColor3 = theme.accent })
		end)

		link(uis.InputChanged, function(input)
			if not dragging then
				return
			end
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				drag(input)
			end
		end)

		link(uis.InputEnded, function(input)
			if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
				return
			end
			if dragging then
				dragging = false
				tween(thumbScale, 0.24, { Scale = 1 })
				tween(readout, 0.24, { TextColor3 = theme.sub })
			end
		end)

		row.MouseEnter:Connect(function()
			if not dragging then
				tween(thumbScale, 0.18, { Scale = 1.15 })
			end
		end)
		row.MouseLeave:Connect(function()
			if not dragging then
				tween(thumbScale, 0.2, { Scale = 1 })
			end
		end)

		local function repaint()
			gradient.Color = ColorSequence.new(theme.accent, theme.accent2)
		end
		repaint()
		paint(repaint)

		return {
			Set = function(_, number)
				value = math.clamp(number, min, max)
				draw()
				if callback then
					callback(value)
				end
			end,
			Get = function()
				return value
			end,
		}
	end

	-- the component everyone judges first
	function w:dropdown(text, options, callback, multi)
		local list = options or {}
		local selected = {}
		local single = nil
		local openList = false
		local built = {}
		local panelW = 200

		local row, edge = card(38)
		glow(row, edge)

		new("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(10, 0),
			Size = UDim2.new(0.5, -14, 1, 0),
			Font = font,
			Text = text or "Dropdown",
			TextColor3 = theme.text,
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			ZIndex = 2,
			Parent = row,
		})

		local readout = new("TextLabel", {
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.new(1, -30, 0, 0),
			Size = UDim2.new(0.5, -40, 1, 0),
			Font = font,
			Text = "Select",
			TextColor3 = theme.sub,
			TextSize = 11,
			TextXAlignment = Enum.TextXAlignment.Right,
			TextTruncate = Enum.TextTruncate.AtEnd,
			ZIndex = 2,
			Parent = row,
		})

		local arrow = new("TextLabel", {
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(1, -17, 0.5, 0),
			Size = UDim2.fromOffset(16, 16),
			Font = font,
			Text = "›",
			TextColor3 = theme.sub,
			TextSize = 18,
			Rotation = 90,
			ZIndex = 2,
			Parent = row,
		})

		local panel = new("Frame", {
			Name = "dropdown",
			BackgroundColor3 = theme.top,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			Size = UDim2.fromOffset(200, 0),
			Visible = false,
			ZIndex = 501,
			Parent = gui,
		})
		corner(panel, 10)
		stroke(panel, white, 0.88)
		shadow(panel, 24, 0.42, Vector2.new(0, 8))
		made[#made + 1] = panel

		local items = new("ScrollingFrame", {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.fromOffset(4, 4),
			Size = UDim2.new(1, -8, 1, -8),
			CanvasSize = UDim2.new(),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			ScrollingDirection = Enum.ScrollingDirection.Y,
			ScrollBarThickness = 3,
			ScrollBarImageColor3 = theme.sub,
			ScrollBarImageTransparency = 0.4,
			VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
			ZIndex = 502,
			Parent = panel,
		})

		new("UIListLayout", {
			Padding = UDim.new(0, 2),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Parent = items,
		})

		local hit = new("TextButton", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			Text = "",
			AutoButtonColor = false,
			ZIndex = 3,
			Parent = row,
		})

		local function target()
			return math.min(math.max(#list, 1) * 30 + 10, 200)
		end

		local function count()
			local total = 0
			for _, on in pairs(selected) do
				if on then
					total = total + 1
				end
			end
			return total
		end

		local function sync()
			for option, entry in pairs(built) do
				local on = multi and selected[option] or single == option
				entry.text.TextColor3 = on and theme.accent or theme.sub
				entry.mark.BackgroundColor3 = theme.accent
				entry.mark.Visible = on
				entry.item.BackgroundTransparency = 1
			end
			if multi then
				local total = count()
				if total == 0 then
					readout.Text = "Select"
				elseif total == 1 then
					readout.Text = next(selected) or "Select"
				else
					readout.Text = total .. " selected"
				end
			else
				readout.Text = single or "Select"
			end
			local picked = multi and count() > 0 or (not multi and single ~= nil)
			readout.TextColor3 = picked and theme.text or theme.sub
		end

		local function value()
			if not multi then
				return single
			end
			local out = {}
			for option, on in pairs(selected) do
				if on then
					out[#out + 1] = option
				end
			end
			table.sort(out)
			return out
		end

		local function setOpen(state)
			if openList == state or not panel.Parent then
				return
			end
			openList = state
			if state then
				dismiss()
				popoverOpen = function()
					setOpen(false)
				end
				overlay.Visible = true
				local vp = viewport()
				local pos = row.AbsolutePosition
				local size = row.AbsoluteSize
				panelW = math.min(math.max(size.X, 180), vp.X - 16)
				local height = target()
				local x = math.clamp(pos.X, 8, math.max(8, vp.X - panelW - 8))
				local y = pos.Y + size.Y + 6
				if y + height > vp.Y - 8 then
					y = pos.Y - height - 6
				end
				y = math.clamp(y, 8, math.max(8, vp.Y - height - 8))
				panel.Position = UDim2.fromOffset(x, y)
				panel.Size = UDim2.fromOffset(panelW, 0)
				panel.Visible = true
				tween(panel, 0.26, { Size = UDim2.fromOffset(panelW, height) })
				tween(arrow, 0.26, { Rotation = -90, TextColor3 = theme.accent })
			else
				popoverOpen = nil
				overlay.Visible = false
				tween(panel, 0.16, { Size = UDim2.fromOffset(panelW, 0) })
				tween(arrow, 0.24, { Rotation = 90, TextColor3 = theme.sub })
				task.delay(0.18, function()
					if panel.Parent and not openList then
						panel.Visible = false
					end
				end)
			end
		end

		local function render()
			for _, child in ipairs(items:GetChildren()) do
				if child:IsA("TextButton") then
					child:Destroy()
				end
			end
			built = {}
			for index, option in ipairs(list) do
				local item = new("TextButton", {
					BackgroundColor3 = theme.hover,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					AutoButtonColor = false,
					LayoutOrder = index,
					Size = UDim2.new(1, 0, 0, 28),
					Text = "",
					ZIndex = 503,
					Parent = items,
				})
				corner(item, 6)

				local mark = new("Frame", {
					BackgroundColor3 = theme.accent,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 0, 0.5, -6),
					Size = UDim2.fromOffset(3, 12),
					Visible = false,
					ZIndex = 504,
					Parent = item,
				})
				corner(mark, 2)

				local label = new("TextLabel", {
					BackgroundTransparency = 1,
					Position = UDim2.fromOffset(12, 0),
					Size = UDim2.new(1, -16, 1, 0),
					Font = font,
					Text = option,
					TextColor3 = theme.sub,
					TextSize = 11,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextTruncate = Enum.TextTruncate.AtEnd,
					ZIndex = 504,
					Parent = item,
				})

				item.MouseEnter:Connect(function()
					tween(item, 0.14, { BackgroundTransparency = 0.2 })
					tween(label, 0.14, { TextColor3 = white })
				end)
				item.MouseLeave:Connect(function()
					tween(item, 0.18, { BackgroundTransparency = 1 })
					sync()
				end)

				item.Activated:Connect(function()
					if multi then
						selected[option] = not selected[option] or nil
						sync()
						if callback then
							callback(value())
						end
					else
						single = option
						sync()
						setOpen(false)
						if callback then
							callback(option)
						end
					end
				end)

				built[option] = { item = item, text = label, mark = mark }
			end
			sync()
		end

		hit.Activated:Connect(function()
			setOpen(not openList)
		end)

		paint(sync)
		render()

		return {
			Set = function(_, value2)
				if multi then
					selected = {}
					if type(value2) == "table" then
						for _, option in ipairs(value2) do
							selected[option] = true
						end
					end
				else
					single = value2
				end
				sync()
			end,
			Get = function()
				return value()
			end,
			SetList = function(_, fresh)
				list = fresh or {}
				render()
				if openList then
					tween(panel, 0.2, { Size = UDim2.fromOffset(panelW, target()) })
				end
			end,
			Open = function(_, state)
				setOpen(state and true or false)
			end,
		}
	end

	function w:colorpicker(text, default, callback)
		if type(default) == "function" then
			callback = default
			default = nil
		end
		local color = default or theme.accent
		local hue, sat, val = color:ToHSV()
		local openPick = false

		local row, edge = card(38)
		glow(row, edge)

		new("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(10, 0),
			Size = UDim2.new(1, -80, 1, 0),
			Font = font,
			Text = text or "Color",
			TextColor3 = theme.text,
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			ZIndex = 2,
			Parent = row,
		})

		local swatch = new("Frame", {
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundColor3 = color,
			BorderSizePixel = 0,
			Position = UDim2.new(1, -10, 0.5, 0),
			Size = UDim2.fromOffset(38, 20),
			ZIndex = 2,
			Parent = row,
		})
		corner(swatch, 6)
		local swatchEdge = stroke(swatch, white, 0.82)

		local hit = new("TextButton", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			Text = "",
			AutoButtonColor = false,
			ZIndex = 3,
			Parent = row,
		})

		local panel = new("Frame", {
			Name = "colorpicker",
			BackgroundColor3 = theme.top,
			BorderSizePixel = 0,
			Size = UDim2.fromOffset(240, 206),
			Visible = false,
			ZIndex = 501,
			Parent = gui,
		})
		corner(panel, 12)
		stroke(panel, white, 0.88)
		shadow(panel, 26, 0.4, Vector2.new(0, 10))
		made[#made + 1] = panel
		local panelScale = new("UIScale", { Parent = panel })

		local canvas = new("CanvasGroup", {
			Name = "canvas",
			Active = true,
			BackgroundColor3 = Color3.fromHSV(hue, 1, 1),
			BorderSizePixel = 0,
			Position = UDim2.fromOffset(10, 10),
			Size = UDim2.fromOffset(220, 118),
			Parent = panel,
		})
		corner(canvas, 8)

		local wash = new("Frame", {
			Name = "wash",
			BackgroundColor3 = white,
			BorderSizePixel = 0,
			Size = UDim2.fromScale(1, 1),
			Parent = canvas,
		})
		new("UIGradient", {
			Transparency = NumberSequence.new(0, 1),
			Parent = wash,
		})

		local shade = new("Frame", {
			Name = "shade",
			BackgroundColor3 = Color3.new(0, 0, 0),
			BorderSizePixel = 0,
			Size = UDim2.fromScale(1, 1),
			Parent = canvas,
		})
		new("UIGradient", {
			Rotation = 90,
			Transparency = NumberSequence.new(1, 0),
			Parent = shade,
		})

		local cursor = new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(sat, 1 - val),
			Size = UDim2.fromOffset(12, 12),
			ZIndex = 2,
			Parent = canvas,
		})
		corner(cursor, 6)
		stroke(cursor, white, 0.1, 2)

		local bar = new("Frame", {
			Active = true,
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderSizePixel = 0,
			Position = UDim2.fromOffset(10, 136),
			Size = UDim2.fromOffset(220, 14),
			Parent = panel,
		})
		corner(bar, 7)
		local stops = {}
		for index = 0, 6 do
			stops[#stops + 1] = ColorSequenceKeypoint.new(index / 6, Color3.fromHSV(index / 6 % 1, 1, 1))
		end
		new("UIGradient", {
			Color = ColorSequence.new(stops),
			Parent = bar,
		})

		local hueKnob = new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = white,
			BorderSizePixel = 0,
			Position = UDim2.new(hue, 0, 0.5, 0),
			Size = UDim2.fromOffset(18, 18),
			ZIndex = 2,
			Parent = bar,
		})
		corner(hueKnob, 9)
		shadow(hueKnob, 5, 0.6, Vector2.new(0, 1))

		local preview = new("Frame", {
			BackgroundColor3 = color,
			BorderSizePixel = 0,
			Position = UDim2.fromOffset(10, 160),
			Size = UDim2.fromOffset(36, 36),
			Parent = panel,
		})
		corner(preview, 9)
		stroke(preview, white, 0.84)

		local hex = new("TextBox", {
			BackgroundColor3 = theme.inset,
			BorderSizePixel = 0,
			ClearTextOnFocus = false,
			Font = font,
			PlaceholderColor3 = theme.sub,
			PlaceholderText = "#FFFFFF",
			Position = UDim2.fromOffset(54, 160),
			Size = UDim2.fromOffset(176, 36),
			Text = "",
			TextColor3 = theme.text,
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = panel,
		})
		corner(hex, 9)
		local hexEdge = stroke(hex, white, 0.92)
		new("UIPadding", {
			PaddingLeft = UDim.new(0, 10),
			PaddingRight = UDim.new(0, 10),
			Parent = hex,
		})

		local function paintSwatch()
			swatch.BackgroundColor3 = color
			preview.BackgroundColor3 = color
			hex.Text = string.format("#%02X%02X%02X", math.floor(color.R * 255 + 0.5), math.floor(color.G * 255 + 0.5), math.floor(color.B * 255 + 0.5))
		end

		local function apply(live)
			color = Color3.fromHSV(hue, sat, val)
			canvas.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
			cursor.Position = UDim2.fromScale(sat, 1 - val)
			hueKnob.Position = UDim2.new(hue, 0, 0.5, 0)
			paintSwatch()
			if live and callback then
				callback(color)
			end
		end

		local function setOpen(state)
			if openPick == state or not panel.Parent then
				return
			end
			openPick = state
			if state then
				dismiss()
				popoverOpen = function()
					setOpen(false)
				end
				overlay.Visible = true
				local vp = viewport()
				local pos = row.AbsolutePosition
				local size = row.AbsoluteSize
				local x = math.clamp(pos.X + size.X - 240, 8, math.max(8, vp.X - 248))
				local y = pos.Y + size.Y + 6
				if y + 206 > vp.Y - 8 then
					y = pos.Y - 212
				end
				y = math.clamp(y, 8, math.max(8, vp.Y - 214))
				panel.Position = UDim2.fromOffset(x, y)
				panel.Visible = true
				panelScale.Scale = 0.94
				tween(panelScale, 0.26, { Scale = 1 }, Enum.EasingStyle.Back)
			else
				popoverOpen = nil
				overlay.Visible = false
				tween(panelScale, 0.14, { Scale = 0.96 })
				task.delay(0.15, function()
					if panel.Parent and not openPick then
						panel.Visible = false
					end
				end)
			end
		end

		canvas.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				local function move(input2)
					if not panel.Parent then
						return
					end
					local rx = (input2.Position.X - canvas.AbsolutePosition.X) / math.max(canvas.AbsoluteSize.X, 1)
					local ry = (input2.Position.Y - canvas.AbsolutePosition.Y) / math.max(canvas.AbsoluteSize.Y, 1)
					sat = math.clamp(rx, 0, 1)
					val = math.clamp(1 - ry, 0, 1)
					apply(true)
				end
				move(input)
				local step
				step = uis.InputChanged:Connect(function(change)
					if change.UserInputType == Enum.UserInputType.MouseMovement or change.UserInputType == Enum.UserInputType.Touch then
						move(change)
					end
				end)
				local stop
				stop = uis.InputEnded:Connect(function(ending)
					if ending.UserInputType == Enum.UserInputType.MouseButton1 or ending.UserInputType == Enum.UserInputType.Touch then
						step:Disconnect()
						stop:Disconnect()
					end
				end)
			end
		end)

		bar.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				local function move(input2)
					if not panel.Parent then
						return
					end
					hue = math.clamp((input2.Position.X - bar.AbsolutePosition.X) / math.max(bar.AbsoluteSize.X, 1), 0, 1)
					apply(true)
				end
				move(input)
				local step
				step = uis.InputChanged:Connect(function(change)
					if change.UserInputType == Enum.UserInputType.MouseMovement or change.UserInputType == Enum.UserInputType.Touch then
						move(change)
					end
				end)
				local stop
				stop = uis.InputEnded:Connect(function(ending)
					if ending.UserInputType == Enum.UserInputType.MouseButton1 or ending.UserInputType == Enum.UserInputType.Touch then
						step:Disconnect()
						stop:Disconnect()
					end
				end)
			end
		end)

		hex.Focused:Connect(function()
			tween(hexEdge, 0.15, { Color = theme.accent, Transparency = 0.35 })
		end)

		hex.FocusLost:Connect(function(enter)
			tween(hexEdge, 0.2, { Color = white, Transparency = 0.92 })
			if not enter then
				return
			end
			local raw = hex.Text:gsub("#", ""):gsub("%s", "")
			if #raw == 3 then
				raw = raw:sub(1, 1):rep(2) .. raw:sub(2, 2):rep(2) .. raw:sub(3, 3):rep(2)
			end
			if #raw ~= 6 then
				paintSwatch()
				return
			end
			local ok, parsed = pcall(Color3.fromHex, raw)
			if not ok then
				paintSwatch()
				return
			end
			hue, sat, val = parsed:ToHSV()
			apply(true)
		end)

		hit.Activated:Connect(function()
			setOpen(not openPick)
		end)

		row.MouseEnter:Connect(function()
			tween(swatchEdge, 0.15, { Transparency = 0.5 })
		end)
		row.MouseLeave:Connect(function()
			tween(swatchEdge, 0.2, { Transparency = 0.82 })
		end)

		apply(false)

		return {
			Set = function(_, value)
				hue, sat, val = value:ToHSV()
				apply(false)
			end,
			Get = function()
				return color
			end,
		}
	end

	function w:textbox(text, placeholder, callback)
		if type(placeholder) == "function" then
			callback = placeholder
			placeholder = nil
		end
		local row, edge = card(58)
		glow(row, edge)

		new("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(10, 7),
			Size = UDim2.new(1, -20, 0, 14),
			Font = font,
			Text = text or "Input",
			TextColor3 = theme.text,
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			Parent = row,
		})

		local input = new("TextBox", {
			BackgroundColor3 = theme.inset,
			BorderSizePixel = 0,
			ClearTextOnFocus = false,
			Font = font,
			Position = UDim2.fromOffset(10, 25),
			Size = UDim2.new(1, -20, 0, 27),
			PlaceholderColor3 = theme.sub,
			PlaceholderText = placeholder or "Type here",
			Text = "",
			TextColor3 = theme.text,
			TextSize = 11,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			Parent = row,
		})
		corner(input, 7)
		local inputEdge = stroke(input, white, 0.92)
		new("UIPadding", {
			PaddingLeft = UDim.new(0, 9),
			PaddingRight = UDim.new(0, 9),
			Parent = input,
		})

		row.InputBegan:Connect(function(click)
			if click.UserInputType == Enum.UserInputType.MouseButton1 or click.UserInputType == Enum.UserInputType.Touch then
				if not input:IsFocused() then
					input:CaptureFocus()
				end
			end
		end)

		input.Focused:Connect(function()
			tween(inputEdge, 0.16, { Color = theme.accent, Transparency = 0.4 })
			tween(input, 0.16, { BackgroundColor3 = theme.hover })
		end)

		input.FocusLost:Connect(function(enter)
			tween(inputEdge, 0.22, { Color = white, Transparency = 0.92 })
			tween(input, 0.22, { BackgroundColor3 = theme.inset })
			if enter and callback then
				callback(input.Text)
			end
		end)

		return {
			Set = function(_, value)
				input.Text = value
			end,
			Get = function()
				return input.Text
			end,
			Focus = function()
				input:CaptureFocus()
			end,
		}
	end

	function w:keybind(text, default, callback)
		if type(default) == "function" then
			callback = default
			default = nil
		end
		local key = default or "None"
		local listening = false
		local row, edge = card(38)
		glow(row, edge)

		new("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(10, 0),
			Size = UDim2.new(1, -110, 1, 0),
			Font = font,
			Text = text or "Keybind",
			TextColor3 = theme.text,
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			Parent = row,
		})

		local pill = new("TextButton", {
			BackgroundColor3 = theme.inset,
			BackgroundTransparency = 0.15,
			BorderSizePixel = 0,
			AnchorPoint = Vector2.new(1, 0.5),
			AutoButtonColor = false,
			Font = font,
			Position = UDim2.new(1, -10, 0.5, 0),
			Size = UDim2.fromOffset(86, 22),
			Text = key,
			TextColor3 = theme.sub,
			TextSize = 11,
			Parent = row,
		})
		corner(pill, 6)
		local pillEdge = stroke(pill, white, 0.9)

		local function draw()
			pill.Text = listening and "press a key" or key
			pill.TextSize = listening and 10 or 11
			tween(pill, 0.16, { BackgroundTransparency = listening and 0.05 or 0.15 })
			tween(pillEdge, 0.16, {
				Color = listening and theme.accent or white,
				Transparency = listening and 0.35 or 0.9,
			})
		end

		pill.Activated:Connect(function()
			listening = not listening
			draw()
		end)

		link(uis.InputBegan, function(input, busy)
			if listening then
				if input.KeyCode == Enum.KeyCode.Escape then
					listening = false
					draw()
					return
				end
				if input.KeyCode == Enum.KeyCode.Backspace then
					key = "None"
				elseif input.KeyCode ~= Enum.KeyCode.Unknown then
					key = input.KeyCode.Name
				else
					return
				end
				listening = false
				draw()
				return
			end
			if not busy and key ~= "None" and input.KeyCode.Name == key and callback then
				callback(key, true)
			end
		end)

		link(uis.InputEnded, function(input)
			if key ~= "None" and input.KeyCode.Name == key and callback then
				callback(key, false)
			end
		end)

		draw()

		return {
			Set = function(_, value)
				key = value or "None"
				draw()
			end,
			Get = function()
				return key
			end,
		}
	end

	function w:SetTitle(value)
		caption.Text = value or ""
	end

	function w:Destroy()
		root:Destroy()
	end

	function w:Toggle(state)
		local want = state ~= false
		if open ~= want then
			fold()
		end
	end

	fit(false)
	return w
end

return Library
