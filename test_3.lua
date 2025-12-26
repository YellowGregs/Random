for i,v in pairs(game:GetService("CoreGui"):GetChildren()) do
	if v.Name == "uilb" then
		v:Destroy()
	end
end

local uilb = Instance.new("ScreenGui")
uilb.Name = "uilb"
uilb.Parent = game:GetService("CoreGui")
uilb.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
uilb.ResetOnSpawn = false

local function get_next_window_pos()
	local biggest = 0
	local ok = nil
	for i, v in pairs(uilb:GetChildren()) do
		if v.Position.X.Offset > biggest then
			biggest = v.Position.X.Offset
			ok = v
		end
	end
	if biggest == 0 then
		biggest = biggest + 15
	else
		biggest = biggest + ok.Size.X.Offset + 10
	end
	return biggest
end

local library = {}

function library:window(title)
	local top = Instance.new("Frame")
	local uicorner = Instance.new("UICorner")
	local container_scroll = Instance.new("ScrollingFrame")
	local uilistlayout = Instance.new("UIListLayout")
	local title_label = Instance.new("TextLabel")
	local minimize_button = Instance.new("TextButton")
	local shadow = Instance.new("ImageLabel")
	local background = Instance.new("Frame")
	local uicorner_bg = Instance.new("UICorner")

	top.Name = "top"
	top.Parent = uilb
	top.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	top.BorderSizePixel = 0
	top.Position = UDim2.new(0, get_next_window_pos(), 0.01, 0)
	top.Size = UDim2.new(0, 280, 0, 40)
	top.Active = true
	top.Draggable = true

	uicorner.CornerRadius = UDim.new(0, 8)
	uicorner.Parent = top

	background.Name = "background"
	background.Parent = top
	background.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	background.BorderSizePixel = 0
	background.Size = UDim2.new(1, 0, 1, 400)
	background.ZIndex = -1
	
	uicorner_bg.CornerRadius = UDim.new(0, 8)
	uicorner_bg.Parent = background

	shadow.Name = "shadow"
	shadow.Parent = top
	shadow.BackgroundTransparency = 1.000
	shadow.Position = UDim2.new(0, -15, 0, -15)
	shadow.Size = UDim2.new(1, 30, 1, 430)
	shadow.Image = "rbxassetid://5554236805"
	shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	shadow.ImageTransparency = 0.8
	shadow.ScaleType = Enum.ScaleType.Slice
	shadow.SliceCenter = Rect.new(23, 23, 277, 277)
	shadow.ZIndex = -1

	container_scroll.Name = "container_scroll"
	container_scroll.Parent = top
	container_scroll.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	container_scroll.BackgroundTransparency = 1
	container_scroll.ClipsDescendants = true
	container_scroll.Position = UDim2.new(0, 0, 1, 0)
	container_scroll.Size = UDim2.new(1, 0, 0, 400)
	container_scroll.ZIndex = 2
	container_scroll.ScrollBarThickness = 3
	container_scroll.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
	container_scroll.ScrollBarImageTransparency = 0.6
	container_scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
	container_scroll.VerticalScrollBarInset = Enum.ScrollBarInset.Always

	uilistlayout.Parent = container_scroll
	uilistlayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	uilistlayout.SortOrder = Enum.SortOrder.LayoutOrder
	uilistlayout.Padding = UDim.new(0, 8)
	uilistlayout.VerticalAlignment = Enum.VerticalAlignment.Top

	title_label.Name = "title"
	title_label.Parent = top
	title_label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title_label.BackgroundTransparency = 1.000
	title_label.Position = UDim2.new(0.05, 0, 0, 0)
	title_label.Size = UDim2.new(0.7, 0, 1, 0)
	title_label.Font = Enum.Font.GothamSemibold
	title_label.Text = title
	title_label.TextColor3 = Color3.fromRGB(240, 240, 240)
	title_label.TextSize = 15
	title_label.TextWrapped = true
	title_label.TextXAlignment = Enum.TextXAlignment.Left

	minimize_button.Name = "minimize_button"
	minimize_button.Parent = top
	minimize_button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	minimize_button.BorderSizePixel = 0
	minimize_button.Position = UDim2.new(0.85, 0, 0.2, 0)
	minimize_button.Size = UDim2.new(0, 24, 0, 24)
	minimize_button.ZIndex = 2
	minimize_button.Font = Enum.Font.GothamSemibold
	minimize_button.Text = "X"
	minimize_button.TextColor3 = Color3.fromRGB(200, 200, 200)
	minimize_button.TextSize = 14
	minimize_button.AutoButtonColor = false

	local function minimize_script()
		local is_open = true
		
		minimize_button.MouseButton1Click:Connect(function()
			if is_open then
				game:GetService("TweenService"):Create(minimize_button, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					TextColor3 = Color3.fromRGB(150, 150, 150),
					Text = "-"
				}):Play()
				container_scroll:TweenPosition(UDim2.new(0, 0, 0, 40), "Out", "Quad", 0.25, true, function()
					container_scroll.Visible = false
				end)
				is_open = false
			else
				container_scroll.Visible = true
				game:GetService("TweenService"):Create(minimize_button, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					TextColor3 = Color3.fromRGB(200, 200, 200),
					Text = "X"
				}):Play()
				container_scroll:TweenPosition(UDim2.new(0, 0, 1, 0), "Out", "Quad", 0.25, true)
				is_open = true
			end
		end)
		
		minimize_button.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Touch then
				if is_open then
					game:GetService("TweenService"):Create(minimize_button, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						TextColor3 = Color3.fromRGB(150, 150, 150),
						Text = "-"
					}):Play()
					container_scroll:TweenPosition(UDim2.new(0, 0, 0, 40), "Out", "Quad", 0.25, true, function()
						container_scroll.Visible = false
					end)
					is_open = false
				else
					container_scroll.Visible = true
					game:GetService("TweenService"):Create(minimize_button, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						TextColor3 = Color3.fromRGB(200, 200, 200),
						Text = "X"
					}):Play()
					container_scroll:TweenPosition(UDim2.new(0, 0, 1, 0), "Out", "Quad", 0.25, true)
					is_open = true
				end
			end
		end)
	end
	minimize_script()
	
	uilistlayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		container_scroll.CanvasSize = UDim2.new(0, 0, 0, uilistlayout.AbsoluteContentSize.Y + 10)
	end)
	
	local lib = {}
	
	function lib:button(name, callback)
		local button_container = Instance.new("Frame")
		local uicorner_btn = Instance.new("UICorner")
		local button = Instance.new("TextButton")
		local button_name_label = Instance.new("TextLabel")
		
		button_container.Name = "button_container"
		button_container.Parent = container_scroll
		button_container.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		button_container.BorderSizePixel = 0
		button_container.Size = UDim2.new(0.9, 0, 0, 36)
		
		uicorner_btn.CornerRadius = UDim.new(0, 6)
		uicorner_btn.Parent = button_container
		
		button.Name = "button"
		button.Parent = button_container
		button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		button.BackgroundTransparency = 1
		button.Size = UDim2.new(1, 0, 1, 0)
		button.Font = Enum.Font.SourceSans
		button.Text = ""
		button.TextColor3 = Color3.fromRGB(0, 0, 0)
		button.TextSize = 14.000
		button.AutoButtonColor = false
		
		button_name_label.Name = "button_name"
		button_name_label.Parent = button_container
		button_name_label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		button_name_label.BackgroundTransparency = 1.000
		button_name_label.Size = UDim2.new(1, 0, 1, 0)
		button_name_label.Font = Enum.Font.Gotham
		button_name_label.Text = name
		button_name_label.TextColor3 = Color3.fromRGB(220, 220, 220)
		button_name_label.TextSize = 13
		
		button.MouseEnter:Connect(function()
			game:GetService("TweenService"):Create(button_container, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
		end)
		
		button.MouseLeave:Connect(function()
			game:GetService("TweenService"):Create(button_container, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
		end)
		
		local function click_action()
			game:GetService("TweenService"):Create(button_container, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
			wait(0.1)
			game:GetService("TweenService"):Create(button_container, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
			callback()
		end
		
		button.MouseButton1Click:Connect(click_action)
		button.TouchTap:Connect(click_action)
		
		button.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Touch then
				click_action()
			end
		end)
	end
	
	function lib:toggle(name, callback)
		local toggle_container = Instance.new("Frame")
		local uicorner_toggle = Instance.new("UICorner")
		local toggle_name_label = Instance.new("TextLabel")
		local toggle_button = Instance.new("TextButton")
		local uicorner_toggle_bg = Instance.new("UICorner")
		local toggle_indicator = Instance.new("Frame")
		local uicorner_indicator = Instance.new("UICorner")
		
		toggle_container.Name = "toggle_container"
		toggle_container.Parent = container_scroll
		toggle_container.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		toggle_container.BorderSizePixel = 0
		toggle_container.Size = UDim2.new(0.9, 0, 0, 36)
		
		uicorner_toggle.CornerRadius = UDim.new(0, 6)
		uicorner_toggle.Parent = toggle_container
		
		toggle_name_label.Name = "toggle_name"
		toggle_name_label.Parent = toggle_container
		toggle_name_label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		toggle_name_label.BackgroundTransparency = 1.000
		toggle_name_label.Position = UDim2.new(0.05, 0, 0, 0)
		toggle_name_label.Size = UDim2.new(0.65, 0, 1, 0)
		toggle_name_label.Font = Enum.Font.Gotham
		toggle_name_label.Text = name
		toggle_name_label.TextColor3 = Color3.fromRGB(220, 220, 220)
		toggle_name_label.TextSize = 13
		toggle_name_label.TextXAlignment = Enum.TextXAlignment.Left
		
		toggle_button.Name = "toggle"
		toggle_button.Parent = toggle_container
		toggle_button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		toggle_button.BorderColor3 = Color3.fromRGB(27, 42, 53)
		toggle_button.Position = UDim2.new(0.78, 0, 0.22, 0)
		toggle_button.Size = UDim2.new(0, 40, 0, 20)
		toggle_button.AutoButtonColor = false
		toggle_button.Font = Enum.Font.SourceSans
		toggle_button.Text = ""
		toggle_button.TextColor3 = Color3.fromRGB(0, 0, 0)
		toggle_button.TextSize = 14.000
		
		uicorner_toggle_bg.CornerRadius = UDim.new(1, 0)
		uicorner_toggle_bg.Parent = toggle_button
		
		toggle_indicator.Name = "toggle_indicator"
		toggle_indicator.Parent = toggle_button
		toggle_indicator.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
		toggle_indicator.BorderSizePixel = 0
		toggle_indicator.Position = UDim2.new(0.05, 0, 0.1, 0)
		toggle_indicator.Size = UDim2.new(0, 16, 0, 16)
		
		uicorner_indicator.CornerRadius = UDim.new(1, 0)
		uicorner_indicator.Parent = toggle_indicator
		
		local toggled = false
		
		local function toggle_state()
			toggled = not toggled
			if toggled then
				game:GetService("TweenService"):Create(toggle_indicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Position = UDim2.new(0.55, 0, 0.1, 0), BackgroundColor3 = Color3.fromRGB(0, 180, 255)}):Play()
				game:GetService("TweenService"):Create(toggle_button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(0, 100, 150)}):Play()
			else
				game:GetService("TweenService"):Create(toggle_indicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Position = UDim2.new(0.05, 0, 0.1, 0), BackgroundColor3 = Color3.fromRGB(100, 100, 100)}):Play()
				game:GetService("TweenService"):Create(toggle_button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
			end
			callback(toggled)
		end
		
		toggle_button.MouseButton1Click:Connect(toggle_state)
		toggle_button.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Touch then
				toggle_state()
			end
		end)
		
		toggle_container.MouseEnter:Connect(function()
			game:GetService("TweenService"):Create(toggle_container, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
		end)
		
		toggle_container.MouseLeave:Connect(function()
			game:GetService("TweenService"):Create(toggle_container, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
		end)
	end
	
	function lib:slider(name, min, max, default, callback)
		local slider_container = Instance.new("Frame")
		local uicorner_slider = Instance.new("UICorner")
		local slider_name_label = Instance.new("TextLabel")
		local slider_value_label = Instance.new("TextLabel")
		local slider_track = Instance.new("Frame")
		local uicorner_track = Instance.new("UICorner")
		local slider_fill = Instance.new("Frame")
		local uicorner_fill = Instance.new("UICorner")
		local slider_button = Instance.new("TextButton")
		
		slider_container.Name = "slider_container"
		slider_container.Parent = container_scroll
		slider_container.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		slider_container.BorderSizePixel = 0
		slider_container.Size = UDim2.new(0.9, 0, 0, 48)
		
		uicorner_slider.CornerRadius = UDim.new(0, 6)
		uicorner_slider.Parent = slider_container
		
		slider_name_label.Name = "slider_name"
		slider_name_label.Parent = slider_container
		slider_name_label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		slider_name_label.BackgroundTransparency = 1.000
		slider_name_label.Position = UDim2.new(0.05, 0, 0, 0)
		slider_name_label.Size = UDim2.new(0.6, 0, 0, 20)
		slider_name_label.Font = Enum.Font.Gotham
		slider_name_label.Text = name
		slider_name_label.TextColor3 = Color3.fromRGB(220, 220, 220)
		slider_name_label.TextSize = 13
		slider_name_label.TextXAlignment = Enum.TextXAlignment.Left
		
		slider_value_label.Name = "slider_value"
		slider_value_label.Parent = slider_container
		slider_value_label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		slider_value_label.BackgroundTransparency = 1.000
		slider_value_label.Position = UDim2.new(0.7, 0, 0, 0)
		slider_value_label.Size = UDim2.new(0.25, 0, 0, 20)
		slider_value_label.Font = Enum.Font.Gotham
		slider_value_label.Text = tostring(default)
		slider_value_label.TextColor3 = Color3.fromRGB(180, 180, 180)
		slider_value_label.TextSize = 13
		slider_value_label.TextXAlignment = Enum.TextXAlignment.Right
		
		slider_track.Name = "slider_track"
		slider_track.Parent = slider_container
		slider_track.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		slider_track.BorderSizePixel = 0
		slider_track.Position = UDim2.new(0.05, 0, 0.6, 0)
		slider_track.Size = UDim2.new(0.9, 0, 0, 4)
		
		uicorner_track.CornerRadius = UDim.new(1, 0)
		uicorner_track.Parent = slider_track
		
		slider_fill.Name = "slider_fill"
		slider_fill.Parent = slider_track
		slider_fill.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
		slider_fill.BorderSizePixel = 0
		slider_fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
		
		uicorner_fill.CornerRadius = UDim.new(1, 0)
		uicorner_fill.Parent = slider_fill
		
		slider_button.Name = "slider_button"
		slider_button.Parent = slider_track
		slider_button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		slider_button.BorderSizePixel = 0
		slider_button.Position = UDim2.new((default - min) / (max - min), -8, 0, -6)
		slider_button.Size = UDim2.new(0, 16, 0, 16)
		slider_button.Font = Enum.Font.SourceSans
		slider_button.Text = ""
		slider_button.TextColor3 = Color3.fromRGB(0, 0, 0)
		slider_button.TextSize = 14.000
		slider_button.AutoButtonColor = false
		
		local uicorner_slider_button = Instance.new("UICorner")
		uicorner_slider_button.CornerRadius = UDim.new(1, 0)
		uicorner_slider_button.Parent = slider_button
		
		local dragging = false
		local current_value = default
		
		local function update_slider(input)
			local pos = UDim2.new(
				math.clamp((input.Position.X - slider_track.AbsolutePosition.X) / slider_track.AbsoluteSize.X, 0, 1),
				0,
				0, 0
			)
			local value = math.floor(min + (pos.X.Scale * (max - min)))
			
			slider_fill.Size = UDim2.new(pos.X.Scale, 0, 1, 0)
			slider_button.Position = UDim2.new(pos.X.Scale, -8, 0, -6)
			slider_value_label.Text = tostring(value)
			
			if value ~= current_value then
				current_value = value
				callback(value)
			end
		end
		
		local function start_dragging(input)
			dragging = true
			game:GetService("TweenService"):Create(slider_button, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 20, 0, 20)}):Play()
		end
		
		local function stop_dragging()
			dragging = false
			game:GetService("TweenService"):Create(slider_button, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 16, 0, 16)}):Play()
		end
		
		slider_button.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				start_dragging(input)
			end
		end)
		
		slider_button.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				stop_dragging()
			end
		end)
		
		game:GetService("UserInputService").InputChanged:Connect(function(input)
			if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
				update_slider(input)
			end
		end)
		
		slider_track.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				update_slider(input)
				start_dragging(input)
			end
		end)
		
		slider_track.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				stop_dragging()
			end
		end)
		
		slider_container.MouseEnter:Connect(function()
			game:GetService("TweenService"):Create(slider_container, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
		end)
		
		slider_container.MouseLeave:Connect(function()
			game:GetService("TweenService"):Create(slider_container, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
		end)
	end
	
	function lib:dropdown(name, options, callback)
		local dropdown_container = Instance.new("Frame")
		local uicorner_dropdown = Instance.new("UICorner")
		local dropdown_name_label = Instance.new("TextLabel")
		local dropdown_button = Instance.new("TextButton")
		local dropdown_arrow = Instance.new("ImageLabel")
		local dropdown_selected = Instance.new("TextLabel")
		
		dropdown_container.Name = "dropdown_container"
		dropdown_container.Parent = container_scroll
		dropdown_container.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		dropdown_container.BorderSizePixel = 0
		dropdown_container.Size = UDim2.new(0.9, 0, 0, 36)
		dropdown_container.ClipsDescendants = false
		
		uicorner_dropdown.CornerRadius = UDim.new(0, 6)
		uicorner_dropdown.Parent = dropdown_container
		
		dropdown_name_label.Name = "dropdown_name"
		dropdown_name_label.Parent = dropdown_container
		dropdown_name_label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		dropdown_name_label.BackgroundTransparency = 1.000
		dropdown_name_label.Position = UDim2.new(0.05, 0, 0, 0)
		dropdown_name_label.Size = UDim2.new(0.65, 0, 1, 0)
		dropdown_name_label.Font = Enum.Font.Gotham
		dropdown_name_label.Text = name
		dropdown_name_label.TextColor3 = Color3.fromRGB(220, 220, 220)
		dropdown_name_label.TextSize = 13
		dropdown_name_label.TextXAlignment = Enum.TextXAlignment.Left
		
		dropdown_button.Name = "dropdown_button"
		dropdown_button.Parent = dropdown_container
		dropdown_button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		dropdown_button.BackgroundTransparency = 0
		dropdown_button.Position = UDim2.new(0.7, 0, 0.22, 0)
		dropdown_button.Size = UDim2.new(0.25, 0, 0, 20)
		dropdown_button.Font = Enum.Font.SourceSans
		dropdown_button.Text = ""
		dropdown_button.TextColor3 = Color3.fromRGB(255, 255, 255)
		dropdown_button.TextSize = 12.000
		dropdown_button.AutoButtonColor = false
		
		local uicorner_dropdown_button = Instance.new("UICorner")
		uicorner_dropdown_button.CornerRadius = UDim.new(0, 4)
		uicorner_dropdown_button.Parent = dropdown_button
		
		dropdown_selected.Name = "dropdown_selected"
		dropdown_selected.Parent = dropdown_button
		dropdown_selected.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		dropdown_selected.BackgroundTransparency = 1.000
		dropdown_selected.Position = UDim2.new(0.05, 0, 0, 0)
		dropdown_selected.Size = UDim2.new(0.7, 0, 1, 0)
		dropdown_selected.Font = Enum.Font.Gotham
		dropdown_selected.Text = "select"
		dropdown_selected.TextColor3 = Color3.fromRGB(200, 200, 200)
		dropdown_selected.TextSize = 11
		dropdown_selected.TextXAlignment = Enum.TextXAlignment.Left
		
		dropdown_arrow.Name = "dropdown_arrow"
		dropdown_arrow.Parent = dropdown_button
		dropdown_arrow.BackgroundTransparency = 1
		dropdown_arrow.Position = UDim2.new(0.8, 0, 0.15, 0)
		dropdown_arrow.Size = UDim2.new(0, 12, 0, 12)
		dropdown_arrow.Image = "rbxassetid://4726772334"
		dropdown_arrow.ImageColor3 = Color3.fromRGB(200, 200, 200)
		dropdown_arrow.Rotation = 90
		
		local dropdown_list = Instance.new("Frame")
		local dropdown_scroll = Instance.new("ScrollingFrame")
		local uilistlayout_list = Instance.new("UIListLayout")
		
		dropdown_list.Name = "dropdown_list"
		dropdown_list.Parent = uilb
		dropdown_list.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		dropdown_list.BorderSizePixel = 0
		dropdown_list.Size = UDim2.new(0, dropdown_button.AbsoluteSize.X, 0, 0)
		dropdown_list.Visible = false
		dropdown_list.ZIndex = 20
		dropdown_list.ClipsDescendants = true
		
		local dropdown_shadow = Instance.new("ImageLabel")
		dropdown_shadow.Name = "dropdown_shadow"
		dropdown_shadow.Parent = dropdown_list
		dropdown_shadow.BackgroundTransparency = 1
		dropdown_shadow.Size = UDim2.new(1, 15, 1, 15)
		dropdown_shadow.Position = UDim2.new(0, -8, 0, -8)
		dropdown_shadow.Image = "rbxassetid://5554236805"
		dropdown_shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
		dropdown_shadow.ImageTransparency = 0.8
		dropdown_shadow.ScaleType = Enum.ScaleType.Slice
		dropdown_shadow.SliceCenter = Rect.new(23, 23, 277, 277)
		dropdown_shadow.ZIndex = 19
		
		local uicorner_list = Instance.new("UICorner")
		uicorner_list.CornerRadius = UDim.new(0, 6)
		uicorner_list.Parent = dropdown_list
		
		dropdown_scroll.Name = "dropdown_scroll"
		dropdown_scroll.Parent = dropdown_list
		dropdown_scroll.Active = true
		dropdown_scroll.BackgroundTransparency = 1
		dropdown_scroll.BorderSizePixel = 0
		dropdown_scroll.Size = UDim2.new(1, -6, 1, -6)
		dropdown_scroll.Position = UDim2.new(0, 3, 0, 3)
		dropdown_scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
		dropdown_scroll.ScrollBarThickness = 3
		dropdown_scroll.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
		dropdown_scroll.ScrollBarImageTransparency = 0.3
		dropdown_scroll.VerticalScrollBarInset = Enum.ScrollBarInset.Always
		dropdown_scroll.ZIndex = 21
		
		uilistlayout_list.Parent = dropdown_scroll
		uilistlayout_list.SortOrder = Enum.SortOrder.LayoutOrder
		uilistlayout_list.Padding = UDim.new(0, 3)
		
		local is_open = false
		local selected_option = nil
		
		local function update_list_height()
			local item_count = #options
			local height = math.min(item_count * 28 + 6, 140)
			dropdown_scroll.CanvasSize = UDim2.new(0, 0, 0, item_count * 28)
			return height
		end
		
		local function toggle_dropdown()
			is_open = not is_open
			if is_open then
				dropdown_list.Visible = true
				dropdown_list.Position = UDim2.new(
					0, dropdown_button.AbsolutePosition.X,
					0, dropdown_button.AbsolutePosition.Y + dropdown_button.AbsoluteSize.Y + 4
				)
				dropdown_list.Size = UDim2.new(0, dropdown_button.AbsoluteSize.X, 0, 0)
				game:GetService("TweenService"):Create(dropdown_arrow, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Rotation = 270}):Play()
				game:GetService("TweenService"):Create(dropdown_button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
				dropdown_list:TweenPosition(
					UDim2.new(
						0, dropdown_button.AbsolutePosition.X,
						0, dropdown_button.AbsolutePosition.Y + dropdown_button.AbsoluteSize.Y + 4
					),
					"Out", "Quad", 0.2, true
				)
				dropdown_list:TweenSize(
					UDim2.new(0, dropdown_button.AbsoluteSize.X, 0, update_list_height()),
					"Out", "Quad", 0.2, true
				)
			else
				game:GetService("TweenService"):Create(dropdown_arrow, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Rotation = 90}):Play()
				game:GetService("TweenService"):Create(dropdown_button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
				dropdown_list:TweenSize(
					UDim2.new(0, dropdown_button.AbsoluteSize.X, 0, 0),
					"Out", "Quad", 0.2, true,
					function()
						dropdown_list.Visible = false
					end
				)
			end
		end
		
		dropdown_button.MouseButton1Click:Connect(toggle_dropdown)
		dropdown_button.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Touch then
				toggle_dropdown()
			end
		end)
		
		for i, option in ipairs(options) do
			local option_button = Instance.new("TextButton")
			local option_text = Instance.new("TextLabel")
			
			option_button.Name = "option_" .. option
			option_button.Parent = dropdown_scroll
			option_button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			option_button.BorderSizePixel = 0
			option_button.Size = UDim2.new(1, 0, 0, 26)
			option_button.Font = Enum.Font.SourceSans
			option_button.Text = ""
			option_button.TextColor3 = Color3.fromRGB(0, 0, 0)
			option_button.TextSize = 14
			option_button.AutoButtonColor = false
			option_button.ZIndex = 22
			
			local uicorner_option = Instance.new("UICorner")
			uicorner_option.CornerRadius = UDim.new(0, 4)
			uicorner_option.Parent = option_button
			
			option_text.Name = "option_text"
			option_text.Parent = option_button
			option_text.BackgroundTransparency = 1
			option_text.Size = UDim2.new(1, -8, 1, 0)
			option_text.Position = UDim2.new(0, 4, 0, 0)
			option_text.Font = Enum.Font.Gotham
			option_text.Text = option
			option_text.TextColor3 = Color3.fromRGB(220, 220, 220)
			option_text.TextSize = 11
			option_text.TextXAlignment = Enum.TextXAlignment.Left
			option_text.ZIndex = 24
			
			option_button.MouseButton1Click:Connect(function()
				selected_option = option
				dropdown_selected.Text = option
				toggle_dropdown()
				callback(option)
			end)
			
			option_button.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.Touch then
					selected_option = option
					dropdown_selected.Text = option
					toggle_dropdown()
					callback(option)
				end
			end)
			
			option_button.MouseEnter:Connect(function()
				game:GetService("TweenService"):Create(option_button, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
			end)
			
			option_button.MouseLeave:Connect(function()
				game:GetService("TweenService"):Create(option_button, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
			end)
		end
		
		update_list_height()
		
		local connection
		connection = game:GetService("UserInputService").InputBegan:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and is_open then
				local mouse_pos = game:GetService("UserInputService"):GetMouseLocation()
				local dropdown_pos = dropdown_list.AbsolutePosition
				local dropdown_size = dropdown_list.AbsoluteSize
				
				if not (mouse_pos.X >= dropdown_pos.X and mouse_pos.X <= dropdown_pos.X + dropdown_size.X and
					   mouse_pos.Y >= dropdown_pos.Y and mouse_pos.Y <= dropdown_pos.Y + dropdown_size.Y) then
					if is_open then
						toggle_dropdown()
					end
				end
			end
		end)
		
		top.Destroying:Connect(function()
			if connection then
				connection:Disconnect()
			end
		end)
		
		dropdown_container.MouseEnter:Connect(function()
			game:GetService("TweenService"):Create(dropdown_container, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
		end)
		
		dropdown_container.MouseLeave:Connect(function()
			game:GetService("TweenService"):Create(dropdown_container, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
		end)
	end
	
	function lib:colorpicker(name, default_color, callback)
		local colorpicker_container = Instance.new("Frame")
		local uicorner_color = Instance.new("UICorner")
		local colorpicker_name_label = Instance.new("TextLabel")
		local color_button = Instance.new("TextButton")
		local color_preview = Instance.new("Frame")
		local uicorner_preview = Instance.new("UICorner")
		
		colorpicker_container.Name = "colorpicker_container"
		colorpicker_container.Parent = container_scroll
		colorpicker_container.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		colorpicker_container.BorderSizePixel = 0
		colorpicker_container.Size = UDim2.new(0.9, 0, 0, 36)
		
		uicorner_color.CornerRadius = UDim.new(0, 6)
		uicorner_color.Parent = colorpicker_container
		
		colorpicker_name_label.Name = "colorpicker_name"
		colorpicker_name_label.Parent = colorpicker_container
		colorpicker_name_label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		colorpicker_name_label.BackgroundTransparency = 1.000
		colorpicker_name_label.Position = UDim2.new(0.05, 0, 0, 0)
		colorpicker_name_label.Size = UDim2.new(0.65, 0, 1, 0)
		colorpicker_name_label.Font = Enum.Font.Gotham
		colorpicker_name_label.Text = name
		colorpicker_name_label.TextColor3 = Color3.fromRGB(220, 220, 220)
		colorpicker_name_label.TextSize = 13
		colorpicker_name_label.TextXAlignment = Enum.TextXAlignment.Left
		
		color_button.Name = "color_button"
		color_button.Parent = colorpicker_container
		color_button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		color_button.BackgroundTransparency = 0
		color_button.Position = UDim2.new(0.7, 0, 0.22, 0)
		color_button.Size = UDim2.new(0.25, 0, 0, 20)
		color_button.Font = Enum.Font.SourceSans
		color_button.Text = ""
		color_button.TextColor3 = Color3.fromRGB(0, 0, 0)
		color_button.TextSize = 14.000
		color_button.AutoButtonColor = false
		
		local uicorner_color_button = Instance.new("UICorner")
		uicorner_color_button.CornerRadius = UDim.new(0, 4)
		uicorner_color_button.Parent = color_button
		
		color_preview.Name = "color_preview"
		color_preview.Parent = color_button
		color_preview.BackgroundColor3 = default_color or Color3.fromRGB(0, 180, 255)
		color_preview.BorderSizePixel = 0
		color_preview.Position = UDim2.new(0.1, 0, 0.1, 0)
		color_preview.Size = UDim2.new(0.8, 0, 0, 16)
		
		uicorner_preview.CornerRadius = UDim.new(0, 3)
		uicorner_preview.Parent = color_preview
		
		local color_picker_frame = nil
		
		local function show_color_picker()
			if color_picker_frame then
				color_picker_frame:Destroy()
				color_picker_frame = nil
				return
			end
			
			color_picker_frame = Instance.new("Frame")
			local uicorner_frame = Instance.new("UICorner")
			local color_display = Instance.new("Frame")
			local uicorner_display = Instance.new("UICorner")
			
			local current_color = color_preview.BackgroundColor3
			local r, g, b = math.floor(current_color.r * 255), math.floor(current_color.g * 255), math.floor(current_color.b * 255)
			
			color_picker_frame.Name = "color_picker_frame"
			color_picker_frame.Parent = uilb
			color_picker_frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			color_picker_frame.BorderSizePixel = 0
			color_picker_frame.Position = UDim2.new(0, 0, 0, 0)
			color_picker_frame.Size = UDim2.new(0, 200, 0, 0)
			color_picker_frame.ZIndex = 30
			color_picker_frame.ClipsDescendants = true
			
			uicorner_frame.CornerRadius = UDim.new(0, 8)
			uicorner_frame.Parent = color_picker_frame
			
			local color_picker_shadow = Instance.new("ImageLabel")
			color_picker_shadow.Name = "color_picker_shadow"
			color_picker_shadow.Parent = color_picker_frame
			color_picker_shadow.BackgroundTransparency = 1
			color_picker_shadow.Size = UDim2.new(1, 20, 1, 20)
			color_picker_shadow.Position = UDim2.new(0, -10, 0, -10)
			color_picker_shadow.Image = "rbxassetid://5554236805"
			color_picker_shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
			color_picker_shadow.ImageTransparency = 0.8
			color_picker_shadow.ScaleType = Enum.ScaleType.Slice
			color_picker_shadow.SliceCenter = Rect.new(23, 23, 277, 277)
			color_picker_shadow.ZIndex = 29
			
			color_display.Name = "color_display"
			color_display.Parent = color_picker_frame
			color_display.BackgroundColor3 = current_color
			color_display.BorderSizePixel = 0
			color_display.Position = UDim2.new(0.05, 0, 0.05, 0)
			color_display.Size = UDim2.new(0.9, 0, 0, 40)
			
			uicorner_display.CornerRadius = UDim.new(0, 6)
			uicorner_display.Parent = color_display
			
			local function create_rgb_slider(name, y_pos, value, color_val)
				local container = Instance.new("Frame")
				local label = Instance.new("TextLabel")
				local slider = Instance.new("Frame")
				local fill = Instance.new("Frame")
				local button = Instance.new("TextButton")
				local value_label = Instance.new("TextLabel")
				
				container.Name = name .. "_container"
				container.Parent = color_picker_frame
				container.BackgroundTransparency = 1
				container.Position = UDim2.new(0.05, 0, y_pos, 0)
				container.Size = UDim2.new(0.9, 0, 0, 30)
				
				label.Name = name .. "_label"
				label.Parent = container
				label.BackgroundTransparency = 1
				label.Position = UDim2.new(0, 0, 0, 0)
				label.Size = UDim2.new(0.2, 0, 1, 0)
				label.Font = Enum.Font.Gotham
				label.Text = name
				label.TextColor3 = Color3.fromRGB(200, 200, 200)
				label.TextSize = 12
				label.TextXAlignment = Enum.TextXAlignment.Left
				
				slider.Name = name .. "_slider"
				slider.Parent = container
				slider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
				slider.BorderSizePixel = 0
				slider.Position = UDim2.new(0.25, 0, 0.5, 0)
				slider.Size = UDim2.new(0.5, 0, 0, 4)
				
				local slider_corner = Instance.new("UICorner")
				slider_corner.CornerRadius = UDim.new(1, 0)
				slider_corner.Parent = slider
				
				fill.Name = name .. "_fill"
				fill.Parent = slider
				fill.BackgroundColor3 = color_val
				fill.BorderSizePixel = 0
				fill.Size = UDim2.new(value / 255, 0, 1, 0)
				
				local fill_corner = Instance.new("UICorner")
				fill_corner.CornerRadius = UDim.new(1, 0)
				fill_corner.Parent = fill
				
				button.Name = name .. "_button"
				button.Parent = slider
				button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				button.BorderSizePixel = 0
				button.Position = UDim2.new(value / 255, -6, 0, -5)
				button.Size = UDim2.new(0, 14, 0, 14)
				button.Font = Enum.Font.SourceSans
				button.Text = ""
				button.TextColor3 = Color3.fromRGB(0, 0, 0)
				button.TextSize = 14
				button.AutoButtonColor = false
				
				local button_corner = Instance.new("UICorner")
				button_corner.CornerRadius = UDim.new(1, 0)
				button_corner.Parent = button
				
				value_label.Name = name .. "_value"
				value_label.Parent = container
				value_label.BackgroundTransparency = 1
				value_label.Position = UDim2.new(0.8, 0, 0, 0)
				value_label.Size = UDim2.new(0.2, 0, 1, 0)
				value_label.Font = Enum.Font.Gotham
				value_label.Text = tostring(value)
				value_label.TextColor3 = Color3.fromRGB(180, 180, 180)
				value_label.TextSize = 12
				value_label.TextXAlignment = Enum.TextXAlignment.Right
				
				return {container = container, slider = slider, fill = fill, button = button, value = value_label}
			end
			
			local r_data = create_rgb_slider("r", 0.25, r, Color3.fromRGB(255, 50, 50))
			local g_data = create_rgb_slider("g", 0.4, g, Color3.fromRGB(50, 255, 50))
			local b_data = create_rgb_slider("b", 0.55, b, Color3.fromRGB(50, 50, 255))
			
			local apply_button = Instance.new("TextButton")
			apply_button.Name = "apply_button"
			apply_button.Parent = color_picker_frame
			apply_button.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
			apply_button.BorderSizePixel = 0
			apply_button.Position = UDim2.new(0.05, 0, 0.75, 0)
			apply_button.Size = UDim2.new(0.9, 0, 0, 30)
			apply_button.Font = Enum.Font.GothamSemibold
			apply_button.Text = "apply"
			apply_button.TextColor3 = Color3.fromRGB(255, 255, 255)
			apply_button.TextSize = 13
			apply_button.AutoButtonColor = false
			
			local apply_corner = Instance.new("UICorner")
			apply_corner.CornerRadius = UDim.new(0, 6)
			apply_corner.Parent = apply_button
			
			local function update_color()
				current_color = Color3.fromRGB(r, g, b)
				color_display.BackgroundColor3 = current_color
			end
			
			local function create_slider_logic(data, is_r, is_g, is_b)
				local dragging = false
				
				local function update_slider(input)
					local pos = UDim2.new(
						math.clamp((input.Position.X - data.slider.AbsolutePosition.X) / data.slider.AbsoluteSize.X, 0, 1),
						0,
						0, 0
					)
					local value = math.floor(pos.X.Scale * 255)
					
					data.fill.Size = UDim2.new(pos.X.Scale, 0, 1, 0)
					data.button.Position = UDim2.new(pos.X.Scale, -6, 0, -5)
					data.value.Text = tostring(value)
					
					if is_r then r = value
					elseif is_g then g = value
					elseif is_b then b = value end
					
					update_color()
				end
				
				local function start_dragging(input)
					dragging = true
					game:GetService("TweenService"):Create(data.button, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 18, 0, 18)}):Play()
				end
				
				local function stop_dragging()
					dragging = false
					game:GetService("TweenService"):Create(data.button, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 14, 0, 14)}):Play()
				end
				
				data.button.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						start_dragging(input)
					end
				end)
				
				data.button.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						stop_dragging()
					end
				end)
				
				data.slider.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						update_slider(input)
						start_dragging(input)
					end
				end)
				
				data.slider.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						stop_dragging()
					end
				end)
				
				game:GetService("UserInputService").InputChanged:Connect(function(input)
					if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
						update_slider(input)
					end
				end)
			end
			
			create_slider_logic(r_data, true, false, false)
			create_slider_logic(g_data, false, true, false)
			create_slider_logic(b_data, false, false, true)
			
			local function apply_action()
				callback(current_color)
				color_preview.BackgroundColor3 = current_color
				color_picker_frame:TweenSize(UDim2.new(0, 200, 0, 0), "Out", "Quad", 0.2, true, function()
					color_picker_frame:Destroy()
					color_picker_frame = nil
				end)
			end
			
			apply_button.MouseButton1Click:Connect(apply_action)
			apply_button.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.Touch then
					apply_action()
				end
			end)
			
			apply_button.MouseEnter:Connect(function()
				game:GetService("TweenService"):Create(apply_button, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(0, 160, 235)}):Play()
			end)
			
			apply_button.MouseLeave:Connect(function()
				game:GetService("TweenService"):Create(apply_button, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(0, 180, 255)}):Play()
			end)
			
			color_picker_frame:TweenSize(UDim2.new(0, 200, 0, 180), "Out", "Quad", 0.2, true)
			
			local close_connection
			close_connection = game:GetService("UserInputService").InputBegan:Connect(function(input)
				if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and color_picker_frame then
					local mouse_pos = game:GetService("UserInputService"):GetMouseLocation()
					local frame_pos = color_picker_frame.AbsolutePosition
					local frame_size = color_picker_frame.AbsoluteSize
					
					if not (mouse_pos.X >= frame_pos.X and mouse_pos.X <= frame_pos.X + frame_size.X and
						   mouse_pos.Y >= frame_pos.Y and mouse_pos.Y <= frame_pos.Y + frame_size.Y) then
						color_picker_frame:TweenSize(UDim2.new(0, 200, 0, 0), "Out", "Quad", 0.2, true, function()
							color_picker_frame:Destroy()
							color_picker_frame = nil
							if close_connection then
								close_connection:Disconnect()
							end
						end)
					end
				end
			end)
			
			local button_pos = color_button.AbsolutePosition
			local button_size = color_button.AbsoluteSize
			local screen_size = game:GetService("Workspace").CurrentCamera.ViewportSize
			
			local right_space = screen_size.X - (button_pos.X + button_size.X)
			local left_space = button_pos.X
			
			if right_space > 210 then
				color_picker_frame.Position = UDim2.new(0, button_pos.X + button_size.X + 10, 0, button_pos.Y)
			elseif left_space > 210 then
				color_picker_frame.Position = UDim2.new(0, button_pos.X - 210, 0, button_pos.Y)
			else
				color_picker_frame.Position = UDim2.new(0, button_pos.X, 0, button_pos.Y + button_size.Y + 10)
			end
		end
		
		color_button.MouseButton1Click:Connect(show_color_picker)
		color_button.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Touch then
				show_color_picker()
			end
		end)
		
		colorpicker_container.MouseEnter:Connect(function()
			game:GetService("TweenService"):Create(colorpicker_container, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
		end)
		
		colorpicker_container.MouseLeave:Connect(function()
			game:GetService("TweenService"):Create(colorpicker_container, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
		end)
	end
	
	function lib:textbox(name, placeholder, callback)
		local textbox_container = Instance.new("Frame")
		local uicorner_textbox = Instance.new("UICorner")
		local textbox_name_label = Instance.new("TextLabel")
		local textbox_input = Instance.new("TextBox")
		local uicorner_input = Instance.new("UICorner")
		
		textbox_container.Name = "textbox_container"
		textbox_container.Parent = container_scroll
		textbox_container.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		textbox_container.BorderSizePixel = 0
		textbox_container.Size = UDim2.new(0.9, 0, 0, 56)
		
		uicorner_textbox.CornerRadius = UDim.new(0, 6)
		uicorner_textbox.Parent = textbox_container
		
		textbox_name_label.Name = "textbox_name"
		textbox_name_label.Parent = textbox_container
		textbox_name_label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		textbox_name_label.BackgroundTransparency = 1.000
		textbox_name_label.Position = UDim2.new(0.05, 0, 0, 0)
		textbox_name_label.Size = UDim2.new(0.9, 0, 0, 20)
		textbox_name_label.Font = Enum.Font.Gotham
		textbox_name_label.Text = name
		textbox_name_label.TextColor3 = Color3.fromRGB(220, 220, 220)
		textbox_name_label.TextSize = 13
		textbox_name_label.TextXAlignment = Enum.TextXAlignment.Left
		
		textbox_input.Name = "textbox_input"
		textbox_input.Parent = textbox_container
		textbox_input.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		textbox_input.BorderSizePixel = 0
		textbox_input.Position = UDim2.new(0.05, 0, 0.45, 0)
		textbox_input.Size = UDim2.new(0.9, 0, 0, 28)
		textbox_input.Font = Enum.Font.Gotham
		textbox_input.PlaceholderText = placeholder or "enter text..."
		textbox_input.Text = ""
		textbox_input.TextColor3 = Color3.fromRGB(220, 220, 220)
		textbox_input.TextSize = 12
		textbox_input.ClearTextOnFocus = false
		textbox_input.TextTruncate = Enum.TextTruncate.AtEnd
		
		uicorner_input.CornerRadius = UDim.new(0, 4)
		uicorner_input.Parent = textbox_input
		
		local text_padding = Instance.new("UIPadding")
		text_padding.Parent = textbox_input
		text_padding.PaddingLeft = UDim.new(0, 8)
		text_padding.PaddingRight = UDim.new(0, 8)
		
		textbox_input.Focused:Connect(function()
			game:GetService("TweenService"):Create(textbox_input, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
		end)
		
		textbox_input.FocusLost:Connect(function(enter_pressed)
			game:GetService("TweenService"):Create(textbox_input, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
			if enter_pressed then
				callback(textbox_input.Text)
			end
		end)
		
		textbox_container.MouseEnter:Connect(function()
			game:GetService("TweenService"):Create(textbox_container, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
		end)
		
		textbox_container.MouseLeave:Connect(function()
			game:GetService("TweenService"):Create(textbox_container, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
		end)
	end
	
	function lib:label(text)
		local label_container = Instance.new("Frame")
		local uicorner_label = Instance.new("UICorner")
		local label_text = Instance.new("TextLabel")
		
		label_container.Name = "label_container"
		label_container.Parent = container_scroll
		label_container.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		label_container.BackgroundTransparency = 0
		label_container.Size = UDim2.new(0.9, 0, 0, 32)
		
		uicorner_label.CornerRadius = UDim.new(0, 6)
		uicorner_label.Parent = label_container
		
		label_text.Name = "label_text"
		label_text.Parent = label_container
		label_text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		label_text.BackgroundTransparency = 1.000
		label_text.Size = UDim2.new(1, -10, 1, 0)
		label_text.Position = UDim2.new(0, 5, 0, 0)
		label_text.Font = Enum.Font.Gotham
		label_text.Text = text
		label_text.TextColor3 = Color3.fromRGB(180, 180, 180)
		label_text.TextSize = 12
		label_text.TextWrapped = true
	end
	
	function lib:separator()
		local separator_container = Instance.new("Frame")
		local separator_line = Instance.new("Frame")
		
		separator_container.Name = "separator_container"
		separator_container.Parent = container_scroll
		separator_container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		separator_container.BackgroundTransparency = 1
		separator_container.Size = UDim2.new(0.9, 0, 0, 10)
		
		separator_line.Name = "separator_line"
		separator_line.Parent = separator_container
		separator_line.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		separator_line.BorderSizePixel = 0
		separator_line.Position = UDim2.new(0.1, 0, 0.5, 0)
		separator_line.Size = UDim2.new(0.8, 0, 0, 1)
	end
	
	return lib
	
end

return library
