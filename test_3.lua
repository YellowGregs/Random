for i,v in pairs(game.CoreGui:GetChildren()) do
	if v.Name == "UiLib" then
		v:Destroy()
	end
end

local UiLib = Instance.new("ScreenGui")
UiLib.Name = "UiLib"
UiLib.Parent = game.CoreGui
UiLib.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
UiLib.ResetOnSpawn = false

local function getNextWindowPos()
	local biggest = 0;
	local ok = nil;
	for i, v in pairs(UiLib:GetChildren()) do
		if v.Position.X.Offset > biggest then
			biggest = v.Position.X.Offset
			ok = v;
		end
	end
	if biggest == 0 then
		biggest = biggest + 15;
	else
		biggest = biggest + ok.Size.X.Offset + 10;
	end
	
	return biggest;
end

local Library = {}

function Library:Window(title)
	local Top = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local Container = Instance.new("Frame")
	local UIListLayout_2 = Instance.new("UIListLayout")
	local Title = Instance.new("TextLabel")
	local Minimize = Instance.new("ImageButton")
	local Shadow = Instance.new("ImageLabel")
	local Background = Instance.new("Frame")
	local UICornerBG = Instance.new("UICorner")

	Top.Name = "Top"
	Top.Parent = UiLib
	Top.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	Top.BorderSizePixel = 0
	Top.Position = UDim2.new(0, getNextWindowPos(), 0.01, 0)
	Top.Size = UDim2.new(0, 260, 0, 36)
	Top.Active = true
	Top.Draggable = true

	UICorner.CornerRadius = UDim.new(0, 8)
	UICorner.Parent = Top

	Background.Name = "Background"
	Background.Parent = Top
	Background.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	Background.BorderSizePixel = 0
	Background.Size = UDim2.new(1, 0, 1, 400)
	Background.ZIndex = -1
	
	UICornerBG.CornerRadius = UDim.new(0, 8)
	UICornerBG.Parent = Background

	Shadow.Name = "Shadow"
	Shadow.Parent = Top
	Shadow.BackgroundTransparency = 1.000
	Shadow.Position = UDim2.new(0, -15, 0, -15)
	Shadow.Size = UDim2.new(1, 30, 1, 430)
	Shadow.Image = "rbxassetid://5554236805"
	Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	Shadow.ImageTransparency = 0.9
	Shadow.ScaleType = Enum.ScaleType.Slice
	Shadow.SliceCenter = Rect.new(23, 23, 277, 277)
	Shadow.ZIndex = -1

	Container.Name = "Container"
	Container.Parent = Top
	Container.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	Container.BackgroundTransparency = 0
	Container.ClipsDescendants = true
	Container.Position = UDim2.new(0, 0, 1, 0)
	Container.Size = UDim2.new(1, 0, 0, 400)
	Container.ZIndex = 2

	UIListLayout_2.Parent = Container
	UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_2.Padding = UDim.new(0, 8)
	UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Top

	Title.Name = "Title"
	Title.Parent = Top
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.Position = UDim2.new(0.05, 0, 0, 0)
	Title.Size = UDim2.new(0.7, 0, 1, 0)
	Title.Font = Enum.Font.GothamMedium
	Title.Text = title
	Title.TextColor3 = Color3.fromRGB(220, 220, 220)
	Title.TextSize = 16
	Title.TextWrapped = true
	Title.TextXAlignment = Enum.TextXAlignment.Left

	Minimize.Name = "Minimize"
	Minimize.Parent = Top
	Minimize.BackgroundTransparency = 1.000
	Minimize.Position = UDim2.new(0.85, 0, 0.2, 0)
	Minimize.Rotation = 0
	Minimize.Size = UDim2.new(0, 24, 0, 24)
	Minimize.ZIndex = 2
	Minimize.Image = "rbxassetid://6031094678"
	Minimize.ImageColor3 = Color3.fromRGB(220, 220, 220)

	local function UZVNGAL_fake_script()
		local script = Instance.new('Script', Minimize)

		script.Parent.MouseButton1Click:Connect(function()
			if script.Parent.Parent.Container.Size == UDim2.new(1, 0, 0, 400) then 
				game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 180}):Play();
				game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.25), {ImageColor3 = Color3.fromRGB(150, 150, 150)}):Play()
				script.Parent.Parent.Container:TweenSize(UDim2.new(1, 0, 0, 0), "InOut", "Sine", 0.25, true)
				game:GetService("TweenService"):Create(Background, TweenInfo.new(0.25), {Size = UDim2.new(1, 0, 1, 0)}):Play()
				game:GetService("TweenService"):Create(Shadow, TweenInfo.new(0.25), {Size = UDim2.new(1, 30, 1, 30)}):Play()
			else
				game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0}):Play();
				game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.25), {ImageColor3 = Color3.fromRGB(220, 220, 220)}):Play()
				script.Parent.Parent.Container:TweenSize(UDim2.new(1, 0, 0, 400), "InOut", "Sine", 0.2, true)
				game:GetService("TweenService"):Create(Background, TweenInfo.new(0.25), {Size = UDim2.new(1, 0, 1, 400)}):Play()
				game:GetService("TweenService"):Create(Shadow, TweenInfo.new(0.25), {Size = UDim2.new(1, 30, 1, 430)}):Play()
			end
		end)
	end
	coroutine.wrap(UZVNGAL_fake_script)()
	
	local Lib = {}
	
	function Lib:Button(name, callback)
		local ButtonContainer = Instance.new("Frame")
		local UICorner_btn = Instance.new("UICorner")
		local Button = Instance.new("TextButton")
		local ButtonName = Instance.new("TextLabel")
		local ButtonHover = Instance.new("Frame")
		
		ButtonContainer.Name = "ButtonContainer"
		ButtonContainer.Parent = Container
		ButtonContainer.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
		ButtonContainer.BorderSizePixel = 0
		ButtonContainer.Size = UDim2.new(0.92, 0, 0, 36)
		
		UICorner_btn.CornerRadius = UDim.new(0, 6)
		UICorner_btn.Parent = ButtonContainer
		
		ButtonHover.Name = "ButtonHover"
		ButtonHover.Parent = ButtonContainer
		ButtonHover.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ButtonHover.BackgroundTransparency = 0.9
		ButtonHover.Size = UDim2.new(1, 0, 1, 0)
		ButtonHover.Visible = false
		
		local UICorner_hover = Instance.new("UICorner")
		UICorner_hover.CornerRadius = UDim.new(0, 6)
		UICorner_hover.Parent = ButtonHover
		
		Button.Name = "Button"
		Button.Parent = ButtonContainer
		Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Button.BackgroundTransparency = 1
		Button.Size = UDim2.new(1, 0, 1, 0)
		Button.Font = Enum.Font.SourceSans
		Button.Text = ""
		Button.TextColor3 = Color3.fromRGB(0, 0, 0)
		Button.TextSize = 14.000
		Button.AutoButtonColor = false
		
		ButtonName.Name = "ButtonName"
		ButtonName.Parent = ButtonContainer
		ButtonName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ButtonName.BackgroundTransparency = 1.000
		ButtonName.Size = UDim2.new(1, 0, 1, 0)
		ButtonName.Font = Enum.Font.GothamMedium
		ButtonName.Text = name
		ButtonName.TextColor3 = Color3.fromRGB(220, 220, 220)
		ButtonName.TextSize = 14
		
		Button.MouseEnter:Connect(function()
			ButtonHover.Visible = true
			game:GetService("TweenService"):Create(ButtonContainer, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
		end)
		
		Button.MouseLeave:Connect(function()
			ButtonHover.Visible = false
			game:GetService("TweenService"):Create(ButtonContainer, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(22, 22, 22)}):Play()
		end)
		
		Button.MouseButton1Click:Connect(function()
			game:GetService("TweenService"):Create(ButtonContainer, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
			wait(0.1)
			game:GetService("TweenService"):Create(ButtonContainer, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(22, 22, 22)}):Play()
			callback()
		end)
	end
	
	function Lib:Toggle(name, callback)
		local ToggleContainer = Instance.new("Frame")
		local UICorner_toggle = Instance.new("UICorner")
		local ToggleName = Instance.new("TextLabel")
		local Toggle = Instance.new("TextButton")
		local UICorner_3 = Instance.new("UICorner")
		local ToggleIndicator = Instance.new("Frame")
		local UICorner_indicator = Instance.new("UICorner")
		
		ToggleContainer.Name = "ToggleContainer"
		ToggleContainer.Parent = Container
		ToggleContainer.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
		ToggleContainer.BorderSizePixel = 0
		ToggleContainer.Size = UDim2.new(0.92, 0, 0, 36)
		
		UICorner_toggle.CornerRadius = UDim.new(0, 6)
		UICorner_toggle.Parent = ToggleContainer
		
		ToggleName.Name = "ToggleName"
		ToggleName.Parent = ToggleContainer
		ToggleName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ToggleName.BackgroundTransparency = 1.000
		ToggleName.Position = UDim2.new(0.05, 0, 0, 0)
		ToggleName.Size = UDim2.new(0.65, 0, 1, 0)
		ToggleName.Font = Enum.Font.GothamMedium
		ToggleName.Text = name
		ToggleName.TextColor3 = Color3.fromRGB(220, 220, 220)
		ToggleName.TextSize = 14
		ToggleName.TextXAlignment = Enum.TextXAlignment.Left
		
		Toggle.Name = "Toggle"
		Toggle.Parent = ToggleContainer
		Toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		Toggle.BorderColor3 = Color3.fromRGB(27, 42, 53)
		Toggle.Position = UDim2.new(0.78, 0, 0.22, 0)
		Toggle.Size = UDim2.new(0, 40, 0, 20)
		Toggle.AutoButtonColor = false
		Toggle.Font = Enum.Font.SourceSans
		Toggle.Text = ""
		Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
		Toggle.TextSize = 14.000
		
		UICorner_3.CornerRadius = UDim.new(1, 0)
		UICorner_3.Parent = Toggle
		
		ToggleIndicator.Name = "ToggleIndicator"
		ToggleIndicator.Parent = Toggle
		ToggleIndicator.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
		ToggleIndicator.BorderSizePixel = 0
		ToggleIndicator.Position = UDim2.new(0.05, 0, 0.1, 0)
		ToggleIndicator.Size = UDim2.new(0, 16, 0, 16)
		
		UICorner_indicator.CornerRadius = UDim.new(1, 0)
		UICorner_indicator.Parent = ToggleIndicator
		
		local Toggled = false
		Toggle.MouseButton1Click:Connect(function()
			Toggled = not Toggled
			if Toggled then
				game:GetService("TweenService"):Create(ToggleIndicator, TweenInfo.new(0.2), {Position = UDim2.new(0.55, 0, 0.1, 0)}):Play()
				game:GetService("TweenService"):Create(ToggleIndicator, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 170, 255)}):Play()
				game:GetService("TweenService"):Create(Toggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 100, 150)}):Play()
			else
				game:GetService("TweenService"):Create(ToggleIndicator, TweenInfo.new(0.2), {Position = UDim2.new(0.05, 0, 0.1, 0)}):Play()
				game:GetService("TweenService"):Create(ToggleIndicator, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play()
				game:GetService("TweenService"):Create(Toggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
			end
			callback(Toggled)
		end)
	end
	
	function Lib:Slider(name, min, max, default, callback)
		local SliderContainer = Instance.new("Frame")
		local UICorner_slider = Instance.new("UICorner")
		local SliderName = Instance.new("TextLabel")
		local SliderValue = Instance.new("TextLabel")
		local SliderTrack = Instance.new("Frame")
		local UICorner_track = Instance.new("UICorner")
		local SliderFill = Instance.new("Frame")
		local UICorner_fill = Instance.new("UICorner")
		local SliderButton = Instance.new("TextButton")
		
		SliderContainer.Name = "SliderContainer"
		SliderContainer.Parent = Container
		SliderContainer.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
		SliderContainer.BorderSizePixel = 0
		SliderContainer.Size = UDim2.new(0.92, 0, 0, 50)
		
		UICorner_slider.CornerRadius = UDim.new(0, 6)
		UICorner_slider.Parent = SliderContainer
		
		SliderName.Name = "SliderName"
		SliderName.Parent = SliderContainer
		SliderName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SliderName.BackgroundTransparency = 1.000
		SliderName.Position = UDim2.new(0.05, 0, 0, 0)
		SliderName.Size = UDim2.new(0.6, 0, 0, 20)
		SliderName.Font = Enum.Font.GothamMedium
		SliderName.Text = name
		SliderName.TextColor3 = Color3.fromRGB(220, 220, 220)
		SliderName.TextSize = 14
		SliderName.TextXAlignment = Enum.TextXAlignment.Left
		
		SliderValue.Name = "SliderValue"
		SliderValue.Parent = SliderContainer
		SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SliderValue.BackgroundTransparency = 1.000
		SliderValue.Position = UDim2.new(0.7, 0, 0, 0)
		SliderValue.Size = UDim2.new(0.25, 0, 0, 20)
		SliderValue.Font = Enum.Font.GothamMedium
		SliderValue.Text = tostring(default)
		SliderValue.TextColor3 = Color3.fromRGB(180, 180, 180)
		SliderValue.TextSize = 14
		SliderValue.TextXAlignment = Enum.TextXAlignment.Right
		
		SliderTrack.Name = "SliderTrack"
		SliderTrack.Parent = SliderContainer
		SliderTrack.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		SliderTrack.BorderSizePixel = 0
		SliderTrack.Position = UDim2.new(0.05, 0, 0.6, 0)
		SliderTrack.Size = UDim2.new(0.9, 0, 0, 4)
		
		UICorner_track.CornerRadius = UDim.new(1, 0)
		UICorner_track.Parent = SliderTrack
		
		SliderFill.Name = "SliderFill"
		SliderFill.Parent = SliderTrack
		SliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
		SliderFill.BorderSizePixel = 0
		SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
		
		UICorner_fill.CornerRadius = UDim.new(1, 0)
		UICorner_fill.Parent = SliderFill
		
		SliderButton.Name = "SliderButton"
		SliderButton.Parent = SliderTrack
		SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SliderButton.BorderSizePixel = 0
		SliderButton.Position = UDim2.new((default - min) / (max - min), -8, 0, -6)
		SliderButton.Size = UDim2.new(0, 16, 0, 16)
		SliderButton.Font = Enum.Font.SourceSans
		SliderButton.Text = ""
		SliderButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		SliderButton.TextSize = 14.000
		SliderButton.AutoButtonColor = false
		
		local UICorner_button = Instance.new("UICorner")
		UICorner_button.CornerRadius = UDim.new(1, 0)
		UICorner_button.Parent = SliderButton
		
		local dragging = false
		local currentValue = default
		
		local function updateSlider(input)
			local pos = UDim2.new(
				math.clamp((input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1),
				0,
				0, 0
			)
			local value = math.floor(min + (pos.X.Scale * (max - min)))
			
			SliderFill.Size = UDim2.new(pos.X.Scale, 0, 1, 0)
			SliderButton.Position = UDim2.new(pos.X.Scale, -8, 0, -6)
			SliderValue.Text = tostring(value)
			
			if value ~= currentValue then
				currentValue = value
				callback(value)
			end
		end
		
		SliderButton.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = true
			end
		end)
		
		SliderButton.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = false
			end
		end)
		
		game:GetService("UserInputService").InputChanged:Connect(function(input)
			if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
				updateSlider(input)
			end
		end)
		
		SliderTrack.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				updateSlider(input)
				dragging = true
			end
		end)
		
		SliderTrack.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = false
			end
		end)
	end
	
	function Lib:Dropdown(name, options, callback)
		local DropdownContainer = Instance.new("Frame")
		local UICorner_dropdown = Instance.new("UICorner")
		local DropdownName = Instance.new("TextLabel")
		local DropdownButton = Instance.new("TextButton")
		local DropdownArrow = Instance.new("ImageLabel")
		local DropdownSelected = Instance.new("TextLabel")
		
		DropdownContainer.Name = "DropdownContainer"
		DropdownContainer.Parent = Container
		DropdownContainer.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
		DropdownContainer.BorderSizePixel = 0
		DropdownContainer.Size = UDim2.new(0.92, 0, 0, 36)
		DropdownContainer.ClipsDescendants = false
		
		UICorner_dropdown.CornerRadius = UDim.new(0, 6)
		UICorner_dropdown.Parent = DropdownContainer
		
		DropdownName.Name = "DropdownName"
		DropdownName.Parent = DropdownContainer
		DropdownName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		DropdownName.BackgroundTransparency = 1.000
		DropdownName.Position = UDim2.new(0.05, 0, 0, 0)
		DropdownName.Size = UDim2.new(0.65, 0, 1, 0)
		DropdownName.Font = Enum.Font.GothamMedium
		DropdownName.Text = name
		DropdownName.TextColor3 = Color3.fromRGB(220, 220, 220)
		DropdownName.TextSize = 14
		DropdownName.TextXAlignment = Enum.TextXAlignment.Left
		
		DropdownButton.Name = "DropdownButton"
		DropdownButton.Parent = DropdownContainer
		DropdownButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		DropdownButton.BackgroundTransparency = 0
		DropdownButton.Position = UDim2.new(0.7, 0, 0.22, 0)
		DropdownButton.Size = UDim2.new(0.25, 0, 0, 20)
		DropdownButton.Font = Enum.Font.SourceSans
		DropdownButton.Text = ""
		DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		DropdownButton.TextSize = 12.000
		DropdownButton.AutoButtonColor = false
		
		local UICorner_btn = Instance.new("UICorner")
		UICorner_btn.CornerRadius = UDim.new(0, 4)
		UICorner_btn.Parent = DropdownButton
		
		DropdownSelected.Name = "DropdownSelected"
		DropdownSelected.Parent = DropdownButton
		DropdownSelected.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		DropdownSelected.BackgroundTransparency = 1.000
		DropdownSelected.Position = UDim2.new(0.05, 0, 0, 0)
		DropdownSelected.Size = UDim2.new(0.7, 0, 1, 0)
		DropdownSelected.Font = Enum.Font.Gotham
		DropdownSelected.Text = "Select"
		DropdownSelected.TextColor3 = Color3.fromRGB(200, 200, 200)
		DropdownSelected.TextSize = 12
		DropdownSelected.TextXAlignment = Enum.TextXAlignment.Left
		
		DropdownArrow.Name = "DropdownArrow"
		DropdownArrow.Parent = DropdownButton
		DropdownArrow.BackgroundTransparency = 1
		DropdownArrow.Position = UDim2.new(0.8, 0, 0.15, 0)
		DropdownArrow.Size = UDim2.new(0, 12, 0, 12)
		DropdownArrow.Image = "rbxassetid://6031094678"
		DropdownArrow.ImageColor3 = Color3.fromRGB(200, 200, 200)
		DropdownArrow.Rotation = 0
		
		local DropdownList = Instance.new("Frame")
		local UIListLayout_list = Instance.new("UIListLayout")
		local DropdownScroll = Instance.new("ScrollingFrame")
		
		DropdownList.Name = "DropdownList"
		DropdownList.Parent = UiLib
		DropdownList.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
		DropdownList.BackgroundTransparency = 0.05
		DropdownList.BorderSizePixel = 0
		DropdownList.Size = UDim2.new(0, DropdownButton.AbsoluteSize.X, 0, 0)
		DropdownList.Visible = false
		DropdownList.ZIndex = 15
		DropdownList.ClipsDescendants = true
		
		local DropdownShadow = Instance.new("ImageLabel")
		DropdownShadow.Name = "DropdownShadow"
		DropdownShadow.Parent = DropdownList
		DropdownShadow.BackgroundTransparency = 1
		DropdownShadow.Size = UDim2.new(1, 20, 1, 20)
		DropdownShadow.Position = UDim2.new(0, -10, 0, -10)
		DropdownShadow.Image = "rbxassetid://5554236805"
		DropdownShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
		DropdownShadow.ImageTransparency = 0.8
		DropdownShadow.ScaleType = Enum.ScaleType.Slice
		DropdownShadow.SliceCenter = Rect.new(23, 23, 277, 277)
		DropdownShadow.ZIndex = 14
		
		local UICorner_list = Instance.new("UICorner")
		UICorner_list.CornerRadius = UDim.new(0, 6)
		UICorner_list.Parent = DropdownList
		
		DropdownScroll.Name = "DropdownScroll"
		DropdownScroll.Parent = DropdownList
		DropdownScroll.Active = true
		DropdownScroll.BackgroundTransparency = 1
		DropdownScroll.BorderSizePixel = 0
		DropdownScroll.Size = UDim2.new(1, -10, 1, -10)
		DropdownScroll.Position = UDim2.new(0, 5, 0, 5)
		DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
		DropdownScroll.ScrollBarThickness = 4
		DropdownScroll.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
		DropdownScroll.ScrollBarImageTransparency = 0.3
		DropdownScroll.VerticalScrollBarInset = Enum.ScrollBarInset.Always
		
		UIListLayout_list.Parent = DropdownScroll
		UIListLayout_list.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_list.Padding = UDim.new(0, 3)
		
		local isOpen = false
		local selectedOption = nil
		
		local function updateListHeight()
			local itemCount = #options
			local height = math.min(itemCount * 28 + 10, 150)
			DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, itemCount * 28)
			return height
		end
		
		local function toggleDropdown()
			isOpen = not isOpen
			if isOpen then
				DropdownList.Visible = true
				DropdownList.Position = UDim2.new(
					0, DropdownButton.AbsolutePosition.X,
					0, DropdownButton.AbsolutePosition.Y + DropdownButton.AbsoluteSize.Y + 5
				)
				DropdownList.Size = UDim2.new(0, DropdownButton.AbsoluteSize.X, 0, 0)
				game:GetService("TweenService"):Create(DropdownArrow, TweenInfo.new(0.2), {Rotation = 180}):Play()
				game:GetService("TweenService"):Create(DropdownButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
				DropdownList:TweenSize(
					UDim2.new(0, DropdownButton.AbsoluteSize.X, 0, updateListHeight()),
					"Out", "Quad", 0.2, true
				)
			else
				game:GetService("TweenService"):Create(DropdownArrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
				game:GetService("TweenService"):Create(DropdownButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
				DropdownList:TweenSize(
					UDim2.new(0, DropdownButton.AbsoluteSize.X, 0, 0),
					"Out", "Quad", 0.2, true,
					function()
						DropdownList.Visible = false
					end
				)
			end
		end
		
		DropdownButton.MouseButton1Click:Connect(toggleDropdown)
		
		for i, option in ipairs(options) do
			local OptionButton = Instance.new("TextButton")
			local OptionText = Instance.new("TextLabel")
			local OptionHover = Instance.new("Frame")
			
			OptionButton.Name = "Option_" .. option
			OptionButton.Parent = DropdownScroll
			OptionButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			OptionButton.BorderSizePixel = 0
			OptionButton.Size = UDim2.new(1, 0, 0, 28)
			OptionButton.Font = Enum.Font.SourceSans
			OptionButton.Text = ""
			OptionButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			OptionButton.TextSize = 14
			OptionButton.AutoButtonColor = false
			OptionButton.ZIndex = 16
			
			local UICorner_option = Instance.new("UICorner")
			UICorner_option.CornerRadius = UDim.new(0, 4)
			UICorner_option.Parent = OptionButton
			
			OptionHover.Name = "OptionHover"
			OptionHover.Parent = OptionButton
			OptionHover.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			OptionHover.BackgroundTransparency = 0.95
			OptionHover.Size = UDim2.new(1, 0, 1, 0)
			OptionHover.Visible = false
			OptionHover.ZIndex = 17
			
			local UICorner_hover = Instance.new("UICorner")
			UICorner_hover.CornerRadius = UDim.new(0, 4)
			UICorner_hover.Parent = OptionHover
			
			OptionText.Name = "OptionText"
			OptionText.Parent = OptionButton
			OptionText.BackgroundTransparency = 1
			OptionText.Size = UDim2.new(1, -10, 1, 0)
			OptionText.Position = UDim2.new(0, 5, 0, 0)
			OptionText.Font = Enum.Font.Gotham
			OptionText.Text = option
			OptionText.TextColor3 = Color3.fromRGB(200, 200, 200)
			OptionText.TextSize = 12
			OptionText.TextXAlignment = Enum.TextXAlignment.Left
			OptionText.ZIndex = 18
			
			OptionButton.MouseButton1Click:Connect(function()
				selectedOption = option
				DropdownSelected.Text = option
				toggleDropdown()
				callback(option)
			end)
			
			OptionButton.MouseEnter:Connect(function()
				OptionHover.Visible = true
				game:GetService("TweenService"):Create(OptionButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
			end)
			
			OptionButton.MouseLeave:Connect(function()
				OptionHover.Visible = false
				game:GetService("TweenService"):Create(OptionButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
			end)
		end
		
		updateListHeight()
		
		local connection
		connection = game:GetService("UserInputService").InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 and isOpen then
				local mousePos = game:GetService("UserInputService"):GetMouseLocation()
				local dropdownPos = DropdownList.AbsolutePosition
				local dropdownSize = DropdownList.AbsoluteSize
				
				if not (mousePos.X >= dropdownPos.X and mousePos.X <= dropdownPos.X + dropdownSize.X and
					   mousePos.Y >= dropdownPos.Y and mousePos.Y <= dropdownPos.Y + dropdownSize.Y) then
					if isOpen then
						toggleDropdown()
					end
				end
			end
		end)
		
		Top.Destroying:Connect(function()
			if connection then
				connection:Disconnect()
			end
		end)
	end
	
	function Lib:Colorpicker(name, defaultColor, callback)
		local ColorpickerContainer = Instance.new("Frame")
		local UICorner_color = Instance.new("UICorner")
		local ColorpickerName = Instance.new("TextLabel")
		local ColorButton = Instance.new("TextButton")
		local ColorPreview = Instance.new("Frame")
		local UICorner_preview = Instance.new("UICorner")
		
		ColorpickerContainer.Name = "ColorpickerContainer"
		ColorpickerContainer.Parent = Container
		ColorpickerContainer.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
		ColorpickerContainer.BorderSizePixel = 0
		ColorpickerContainer.Size = UDim2.new(0.92, 0, 0, 36)
		
		UICorner_color.CornerRadius = UDim.new(0, 6)
		UICorner_color.Parent = ColorpickerContainer
		
		ColorpickerName.Name = "ColorpickerName"
		ColorpickerName.Parent = ColorpickerContainer
		ColorpickerName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ColorpickerName.BackgroundTransparency = 1.000
		ColorpickerName.Position = UDim2.new(0.05, 0, 0, 0)
		ColorpickerName.Size = UDim2.new(0.65, 0, 1, 0)
		ColorpickerName.Font = Enum.Font.GothamMedium
		ColorpickerName.Text = name
		ColorpickerName.TextColor3 = Color3.fromRGB(220, 220, 220)
		ColorpickerName.TextSize = 14
		ColorpickerName.TextXAlignment = Enum.TextXAlignment.Left
		
		ColorButton.Name = "ColorButton"
		ColorButton.Parent = ColorpickerContainer
		ColorButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		ColorButton.BackgroundTransparency = 0
		ColorButton.Position = UDim2.new(0.7, 0, 0.22, 0)
		ColorButton.Size = UDim2.new(0.25, 0, 0, 20)
		ColorButton.Font = Enum.Font.SourceSans
		ColorButton.Text = ""
		ColorButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		ColorButton.TextSize = 14.000
		ColorButton.AutoButtonColor = false
		
		local UICorner_btn = Instance.new("UICorner")
		UICorner_btn.CornerRadius = UDim.new(0, 4)
		UICorner_btn.Parent = ColorButton
		
		ColorPreview.Name = "ColorPreview"
		ColorPreview.Parent = ColorButton
		ColorPreview.BackgroundColor3 = defaultColor or Color3.fromRGB(0, 170, 255)
		ColorPreview.BorderSizePixel = 0
		ColorPreview.Position = UDim2.new(0.1, 0, 0.1, 0)
		ColorPreview.Size = UDim2.new(0.8, 0, 0, 16)
		
		UICorner_preview.CornerRadius = UDim.new(0, 4)
		UICorner_preview.Parent = ColorPreview
		
		local colorPickerFrame = nil
		local colorPickerConnection = nil
		
		local function showColorPicker()
			if colorPickerFrame then
				colorPickerFrame:Destroy()
				if colorPickerConnection then
					colorPickerConnection:Disconnect()
				end
				return
			end
			
			colorPickerFrame = Instance.new("Frame")
			local UICorner_frame = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local ColorPreviewBig = Instance.new("Frame")
			local UICorner_previewBig = Instance.new("UICorner")
			local HueSlider = Instance.new("Frame")
			local HueGradient = Instance.new("UIGradient")
			local HueButton = Instance.new("TextButton")
			local UICorner_huebtn = Instance.new("UICorner")
			local SatValPicker = Instance.new("ImageButton")
			local SatValCursor = Instance.new("Frame")
			local UICorner_cursor = Instance.new("UICorner")
			local RGBInputs = Instance.new("Frame")
			local RBox = Instance.new("TextBox")
			local GBox = Instance.new("TextBox")
			local BBox = Instance.new("TextBox")
			local HexBox = Instance.new("TextBox")
			local ApplyButton = Instance.new("TextButton")
			local ApplyText = Instance.new("TextLabel")
			
			local currentColor = ColorPreview.BackgroundColor3
			local h, s, v = currentColor:ToHSV()
			
			colorPickerFrame.Name = "ColorPickerFrame"
			colorPickerFrame.Parent = Container
			colorPickerFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			colorPickerFrame.BorderSizePixel = 0
			colorPickerFrame.Position = UDim2.new(0, 0, 0, 0)
			colorPickerFrame.Size = UDim2.new(1, 0, 0, 180)
			colorPickerFrame.ZIndex = 10
			colorPickerFrame.ClipsDescendants = true
			
			UICorner_frame.CornerRadius = UDim.new(0, 8)
			UICorner_frame.Parent = colorPickerFrame
						
			ColorPreviewBig.Name = "ColorPreviewBig"
			ColorPreviewBig.Parent = colorPickerFrame
			ColorPreviewBig.BackgroundColor3 = currentColor
			ColorPreviewBig.BorderSizePixel = 0
			ColorPreviewBig.Position = UDim2.new(0.05, 0, 0.1, 0)
			ColorPreviewBig.Size = UDim2.new(0, 50, 0, 50)
			
			UICorner_previewBig.CornerRadius = UDim.new(0, 4)
			UICorner_previewBig.Parent = ColorPreviewBig
			
			HueSlider.Name = "HueSlider"
			HueSlider.Parent = colorPickerFrame
			HueSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			HueSlider.BorderSizePixel = 0
			HueSlider.Position = UDim2.new(0.25, 0, 0.1, 0)
			HueSlider.Size = UDim2.new(0, 150, 0, 10)
			
			HueGradient.Rotation = 0
			HueGradient.Parent = HueSlider
			HueGradient.Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
				ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
				ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
				ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
				ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
				ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
			}
			
			HueButton.Name = "HueButton"
			HueButton.Parent = HueSlider
			HueButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			HueButton.BorderSizePixel = 2
			HueButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			HueButton.Position = UDim2.new(h, -8, 0, -3)
			HueButton.Size = UDim2.new(0, 16, 0, 16)
			HueButton.Font = Enum.Font.SourceSans
			HueButton.Text = ""
			HueButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			HueButton.TextSize = 14.000
			HueButton.AutoButtonColor = false
			HueButton.ZIndex = 11
			
			UICorner_huebtn.CornerRadius = UDim.new(1, 0)
			UICorner_huebtn.Parent = HueButton
			
			SatValPicker.Name = "SatValPicker"
			SatValPicker.Parent = colorPickerFrame
			SatValPicker.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
			SatValPicker.BorderSizePixel = 0
			SatValPicker.Position = UDim2.new(0.25, 0, 0.3, 0)
			SatValPicker.Size = UDim2.new(0, 150, 0, 80)
			SatValPicker.Image = "rbxassetid://4155801252"
			SatValPicker.AutoButtonColor = false
			
			SatValCursor.Name = "SatValCursor"
			SatValCursor.Parent = SatValPicker
			SatValCursor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SatValCursor.BorderSizePixel = 2
			SatValCursor.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SatValCursor.Position = UDim2.new(s, -4, 1-v, -4)
			SatValCursor.Size = UDim2.new(0, 8, 0, 8)
			SatValCursor.ZIndex = 11
			
			UICorner_cursor.CornerRadius = UDim.new(1, 0)
			UICorner_cursor.Parent = SatValCursor
			
			RGBInputs.Name = "RGBInputs"
			RGBInputs.Parent = colorPickerFrame
			RGBInputs.BackgroundTransparency = 1
			RGBInputs.Position = UDim2.new(0.05, 0, 0.7, 0)
			RGBInputs.Size = UDim2.new(0.9, 0, 0, 80)
			
			local function createColorInput(name, position, defaultValue)
				local container = Instance.new("Frame")
				local label = Instance.new("TextLabel")
				local box = Instance.new("TextBox")
				local UICorner_box = Instance.new("UICorner")
				
				container.Name = name .. "Container"
				container.Parent = RGBInputs
				container.BackgroundTransparency = 1
				container.Position = position
				container.Size = UDim2.new(0.45, 0, 0, 30)
				
				label.Name = name .. "Label"
				label.Parent = container
				label.BackgroundTransparency = 1
				label.Position = UDim2.new(0, 0, 0, 0)
				label.Size = UDim2.new(0.3, 0, 1, 0)
				label.Font = Enum.Font.Gotham
				label.Text = name .. ":"
				label.TextColor3 = Color3.fromRGB(200, 200, 200)
				label.TextSize = 12
				label.TextXAlignment = Enum.TextXAlignment.Left
				
				box.Name = name .. "Box"
				box.Parent = container
				box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				box.BorderSizePixel = 0
				box.Position = UDim2.new(0.3, 0, 0, 0)
				box.Size = UDim2.new(0.7, 0, 1, 0)
				box.Font = Enum.Font.Gotham
				box.Text = tostring(defaultValue)
				box.TextColor3 = Color3.fromRGB(220, 220, 220)
				box.TextSize = 12
				box.ClearTextOnFocus = false
				
				UICorner_box.CornerRadius = UDim.new(0, 4)
				UICorner_box.Parent = box
				
				return box
			end
			
			RBox = createColorInput("R", UDim2.new(0, 0, 0, 0), math.floor(currentColor.r * 255))
			GBox = createColorInput("G", UDim2.new(0.5, 0, 0, 0), math.floor(currentColor.g * 255))
			BBox = createColorInput("B", UDim2.new(0, 0, 0.5, 0), math.floor(currentColor.b * 255))
			
			local hexContainer = Instance.new("Frame")
			hexContainer.Name = "HexContainer"
			hexContainer.Parent = RGBInputs
			hexContainer.BackgroundTransparency = 1
			hexContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
			hexContainer.Size = UDim2.new(0.45, 0, 0, 30)
			
			local hexLabel = Instance.new("TextLabel")
			hexLabel.Name = "HexLabel"
			hexLabel.Parent = hexContainer
			hexLabel.BackgroundTransparency = 1
			hexLabel.Position = UDim2.new(0, 0, 0, 0)
			hexLabel.Size = UDim2.new(0.3, 0, 1, 0)
			hexLabel.Font = Enum.Font.Gotham
			hexLabel.Text = "Hex:"
			hexLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
			hexLabel.TextSize = 12
			hexLabel.TextXAlignment = Enum.TextXAlignment.Left
			
			HexBox = Instance.new("TextBox")
			HexBox.Name = "HexBox"
			HexBox.Parent = hexContainer
			HexBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			HexBox.BorderSizePixel = 0
			HexBox.Position = UDim2.new(0.3, 0, 0, 0)
			HexBox.Size = UDim2.new(0.7, 0, 1, 0)
			HexBox.Font = Enum.Font.Gotham
			HexBox.Text = string.format("#%02X%02X%02X", 
				math.floor(currentColor.r * 255), 
				math.floor(currentColor.g * 255), 
				math.floor(currentColor.b * 255))
			HexBox.TextColor3 = Color3.fromRGB(220, 220, 220)
			HexBox.TextSize = 12
			HexBox.ClearTextOnFocus = false
			
			local UICorner_hex = Instance.new("UICorner")
			UICorner_hex.CornerRadius = UDim.new(0, 4)
			UICorner_hex.Parent = HexBox
			
			ApplyButton.Name = "ApplyButton"
			ApplyButton.Parent = colorPickerFrame
			ApplyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
			ApplyButton.BorderSizePixel = 0
			ApplyButton.Position = UDim2.new(0.7, 0, 0.1, 0)
			ApplyButton.Size = UDim2.new(0.25, 0, 0, 50)
			ApplyButton.Font = Enum.Font.GothamMedium
			ApplyButton.Text = ""
			ApplyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			ApplyButton.TextSize = 14
			ApplyButton.AutoButtonColor = false
			
			local UICorner_apply = Instance.new("UICorner")
			UICorner_apply.CornerRadius = UDim.new(0, 4)
			UICorner_apply.Parent = ApplyButton
			
			ApplyText.Name = "ApplyText"
			ApplyText.Parent = ApplyButton
			ApplyText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ApplyText.BackgroundTransparency = 1.000
			ApplyText.Size = UDim2.new(1, 0, 1, 0)
			ApplyText.Font = Enum.Font.GothamMedium
			ApplyText.Text = "Apply"
			ApplyText.TextColor3 = Color3.fromRGB(255, 255, 255)
			ApplyText.TextSize = 14
			
			local draggingHue = false
			local draggingSV = false
			
			local function updateColorFromHSV()
				currentColor = Color3.fromHSV(h, s, v)
				ColorPreviewBig.BackgroundColor3 = currentColor
				SatValPicker.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
				
				RBox.Text = tostring(math.floor(currentColor.r * 255))
				GBox.Text = tostring(math.floor(currentColor.g * 255))
				BBox.Text = tostring(math.floor(currentColor.b * 255))
				HexBox.Text = string.format("#%02X%02X%02X", 
					math.floor(currentColor.r * 255), 
					math.floor(currentColor.g * 255), 
					math.floor(currentColor.b * 255))
			end
			
			local function updateColorFromRGB()
				local r = math.clamp(tonumber(RBox.Text) or 0, 0, 255) / 255
				local g = math.clamp(tonumber(GBox.Text) or 0, 0, 255) / 255
				local b = math.clamp(tonumber(BBox.Text) or 0, 0, 255) / 255
				
				currentColor = Color3.new(r, g, b)
				h, s, v = currentColor:ToHSV()
				
				HueButton.Position = UDim2.new(h, -8, 0, -3)
				SatValCursor.Position = UDim2.new(s, -4, 1-v, -4)
				SatValPicker.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
				ColorPreviewBig.BackgroundColor3 = currentColor
				HexBox.Text = string.format("#%02X%02X%02X", 
					math.floor(currentColor.r * 255), 
					math.floor(currentColor.g * 255), 
					math.floor(currentColor.b * 255))
			end
			
			local function updateColorFromHex()
				local hex = HexBox.Text:gsub("#", "")
				if #hex == 6 then
					local r = tonumber("0x" .. hex:sub(1, 2)) or 0
					local g = tonumber("0x" .. hex:sub(3, 4)) or 0
					local b = tonumber("0x" .. hex:sub(5, 6)) or 0
					
					currentColor = Color3.fromRGB(r, g, b)
					h, s, v = currentColor:ToHSV()
					
					HueButton.Position = UDim2.new(h, -8, 0, -3)
					SatValCursor.Position = UDim2.new(s, -4, 1-v, -4)
					SatValPicker.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
					ColorPreviewBig.BackgroundColor3 = currentColor
					RBox.Text = tostring(r)
					GBox.Text = tostring(g)
					BBox.Text = tostring(b)
				end
			end
			
			local function updateHue(input)
				local pos = math.clamp((input.Position.X - HueSlider.AbsolutePosition.X) / HueSlider.AbsoluteSize.X, 0, 1)
				h = pos
				HueButton.Position = UDim2.new(pos, -8, 0, -3)
				updateColorFromHSV()
			end
			
			local function updateSaturationValue(input)
				local x = math.clamp((input.Position.X - SatValPicker.AbsolutePosition.X) / SatValPicker.AbsoluteSize.X, 0, 1)
				local y = math.clamp((input.Position.Y - SatValPicker.AbsolutePosition.Y) / SatValPicker.AbsoluteSize.Y, 0, 1)
				s = x
				v = 1 - y
				SatValCursor.Position = UDim2.new(x, -4, y, -4)
				updateColorFromHSV()
			end
			
			HueButton.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					draggingHue = true
				end
			end)
			
			HueButton.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					draggingHue = false
				end
			end)
			
			HueSlider.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					updateHue(input)
					draggingHue = true
				end
			end)
			
			HueSlider.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					draggingHue = false
				end
			end)
			
			SatValCursor.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					draggingSV = true
				end
			end)
			
			SatValCursor.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					draggingSV = false
				end
			end)
			
			SatValPicker.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					updateSaturationValue(input)
					draggingSV = true
				end
			end)
			
			SatValPicker.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					draggingSV = false
				end
			end)
			
			local function handleInputChanged(input)
				if draggingHue and input.UserInputType == Enum.UserInputType.MouseMovement then
					updateHue(input)
				elseif draggingSV and input.UserInputType == Enum.UserInputType.MouseMovement then
					updateSaturationValue(input)
				end
			end
			
			colorPickerConnection = game:GetService("UserInputService").InputChanged:Connect(handleInputChanged)
			
			RBox.FocusLost:Connect(function()
				updateColorFromRGB()
			end)
			
			GBox.FocusLost:Connect(function()
				updateColorFromRGB()
			end)
			
			BBox.FocusLost:Connect(function()
				updateColorFromRGB()
			end)
			
			HexBox.FocusLost:Connect(function()
				updateColorFromHex()
			end)
			
			ApplyButton.MouseButton1Click:Connect(function()
				callback(currentColor)
				ColorPreview.BackgroundColor3 = currentColor
				colorPickerFrame:Destroy()
				if colorPickerConnection then
					colorPickerConnection:Disconnect()
				end
				colorPickerFrame = nil
			end)
			
			ApplyButton.MouseEnter:Connect(function()
				game:GetService("TweenService"):Create(ApplyButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 140, 225)}):Play()
			end)
			
			ApplyButton.MouseLeave:Connect(function()
				game:GetService("TweenService"):Create(ApplyButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 170, 255)}):Play()
			end)
			
			local closeConnection
			closeConnection = game:GetService("UserInputService").InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 and colorPickerFrame then
					local mousePos = game:GetService("UserInputService"):GetMouseLocation()
					local framePos = colorPickerFrame.AbsolutePosition
					local frameSize = colorPickerFrame.AbsoluteSize
					
					if not (mousePos.X >= framePos.X and mousePos.X <= framePos.X + frameSize.X and
						   mousePos.Y >= framePos.Y and mousePos.Y <= framePos.Y + frameSize.Y) then
						colorPickerFrame:Destroy()
						if colorPickerConnection then
							colorPickerConnection:Disconnect()
						end
						if closeConnection then
							closeConnection:Disconnect()
						end
						colorPickerFrame = nil
					end
				end
			end)
			
			updateColorFromHSV()
			
			colorPickerFrame.Size = UDim2.new(1, 0, 0, 0)
			colorPickerFrame:TweenSize(UDim2.new(1, 0, 0, 180), "Out", "Quad", 0.2, true)
		end
		
		ColorButton.MouseButton1Click:Connect(showColorPicker)
	end
	
	function Lib:Textbox(name, placeholder, callback)
		local TextboxContainer = Instance.new("Frame")
		local UICorner_textbox = Instance.new("UICorner")
		local TextboxName = Instance.new("TextLabel")
		local TextboxInput = Instance.new("TextBox")
		local UICorner_input = Instance.new("UICorner")
		local TextboxHover = Instance.new("Frame")
		
		TextboxContainer.Name = "TextboxContainer"
		TextboxContainer.Parent = Container
		TextboxContainer.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
		TextboxContainer.BorderSizePixel = 0
		TextboxContainer.Size = UDim2.new(0.92, 0, 0, 50)
		
		UICorner_textbox.CornerRadius = UDim.new(0, 6)
		UICorner_textbox.Parent = TextboxContainer
		
		TextboxName.Name = "TextboxName"
		TextboxName.Parent = TextboxContainer
		TextboxName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextboxName.BackgroundTransparency = 1.000
		TextboxName.Position = UDim2.new(0.05, 0, 0, 0)
		TextboxName.Size = UDim2.new(0.9, 0, 0, 20)
		TextboxName.Font = Enum.Font.GothamMedium
		TextboxName.Text = name
		TextboxName.TextColor3 = Color3.fromRGB(220, 220, 220)
		TextboxName.TextSize = 14
		TextboxName.TextXAlignment = Enum.TextXAlignment.Left
		
		TextboxInput.Name = "TextboxInput"
		TextboxInput.Parent = TextboxContainer
		TextboxInput.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		TextboxInput.BorderSizePixel = 0
		TextboxInput.Position = UDim2.new(0.05, 0, 0.5, 0)
		TextboxInput.Size = UDim2.new(0.9, 0, 0, 25)
		TextboxInput.Font = Enum.Font.Gotham
		TextboxInput.PlaceholderText = placeholder or "Enter text..."
		TextboxInput.Text = ""
		TextboxInput.TextColor3 = Color3.fromRGB(220, 220, 220)
		TextboxInput.TextSize = 12
		TextboxInput.ClearTextOnFocus = false
		
		UICorner_input.CornerRadius = UDim.new(0, 4)
		UICorner_input.Parent = TextboxInput
		
		TextboxHover.Name = "TextboxHover"
		TextboxHover.Parent = TextboxInput
		TextboxHover.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextboxHover.BackgroundTransparency = 0.95
		TextboxHover.Size = UDim2.new(1, 0, 1, 0)
		TextboxHover.Visible = false
		
		local UICorner_hover = Instance.new("UICorner")
		UICorner_hover.CornerRadius = UDim.new(0, 4)
		UICorner_hover.Parent = TextboxHover
		
		TextboxInput.Focused:Connect(function()
			TextboxHover.Visible = true
			game:GetService("TweenService"):Create(TextboxInput, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
		end)
		
		TextboxInput.FocusLost:Connect(function(enterPressed)
			TextboxHover.Visible = false
			game:GetService("TweenService"):Create(TextboxInput, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
			if enterPressed then
				callback(TextboxInput.Text)
			end
		end)
		
		TextboxInput.MouseEnter:Connect(function()
			if not TextboxInput:IsFocused() then
				TextboxHover.Visible = true
			end
		end)
		
		TextboxInput.MouseLeave:Connect(function()
			if not TextboxInput:IsFocused() then
				TextboxHover.Visible = false
			end
		end)
	end
	
	function Lib:Label(text)
		local LabelContainer = Instance.new("Frame")
		local UICorner_label = Instance.new("UICorner")
		local LabelText = Instance.new("TextLabel")
		
		LabelContainer.Name = "LabelContainer"
		LabelContainer.Parent = Container
		LabelContainer.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
		LabelContainer.BackgroundTransparency = 0
		LabelContainer.Size = UDim2.new(0.92, 0, 0, 30)
		
		UICorner_label.CornerRadius = UDim.new(0, 6)
		UICorner_label.Parent = LabelContainer
		
		LabelText.Name = "LabelText"
		LabelText.Parent = LabelContainer
		LabelText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		LabelText.BackgroundTransparency = 1.000
		LabelText.Size = UDim2.new(1, 0, 1, 0)
		LabelText.Font = Enum.Font.Gotham
		LabelText.Text = text
		LabelText.TextColor3 = Color3.fromRGB(180, 180, 180)
		LabelText.TextSize = 12
		LabelText.TextWrapped = true
	end
	
	function Lib:Separator()
		local SeparatorContainer = Instance.new("Frame")
		local SeparatorLine = Instance.new("Frame")
		
		SeparatorContainer.Name = "SeparatorContainer"
		SeparatorContainer.Parent = Container
		SeparatorContainer.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
		SeparatorContainer.BackgroundTransparency = 0.000
		SeparatorContainer.Size = UDim2.new(0.92, 0, 0, 10)
		
		SeparatorLine.Name = "SeparatorLine"
		SeparatorLine.Parent = SeparatorContainer
		SeparatorLine.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		SeparatorLine.BorderSizePixel = 0
		SeparatorLine.Position = UDim2.new(0.1, 0, 0.5, 0)
		SeparatorLine.Size = UDim2.new(0.8, 0, 0, 1)
	end
	
	return Lib
	
end

return Library
