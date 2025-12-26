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
	local biggest = 0
	local ok = nil
	for i, v in pairs(UiLib:GetChildren()) do
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

local Library = {}

function Library:Window(title)
	local Top = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local ContainerScroll = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local Title = Instance.new("TextLabel")
	local Minimize = Instance.new("ImageButton")
	local Shadow = Instance.new("ImageLabel")
	local Background = Instance.new("Frame")
	local UICornerBG = Instance.new("UICorner")

	Top.Name = "Top"
	Top.Parent = UiLib
	Top.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
	Top.BorderSizePixel = 0
	Top.Position = UDim2.new(0, getNextWindowPos(), 0.01, 0)
	Top.Size = UDim2.new(0, 280, 0, 40)
	Top.Active = true
	Top.Draggable = true

	UICorner.CornerRadius = UDim.new(0, 10)
	UICorner.Parent = Top

	Background.Name = "Background"
	Background.Parent = Top
	Background.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
	Background.BorderSizePixel = 0
	Background.Size = UDim2.new(1, 0, 1, 400)
	Background.ZIndex = -1
	
	UICornerBG.CornerRadius = UDim.new(0, 10)
	UICornerBG.Parent = Background

	Shadow.Name = "Shadow"
	Shadow.Parent = Top
	Shadow.BackgroundTransparency = 1.000
	Shadow.Position = UDim2.new(0, -20, 0, -20)
	Shadow.Size = UDim2.new(1, 40, 1, 440)
	Shadow.Image = "rbxassetid://5554236805"
	Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	Shadow.ImageTransparency = 0.85
	Shadow.ScaleType = Enum.ScaleType.Slice
	Shadow.SliceCenter = Rect.new(23, 23, 277, 277)
	Shadow.ZIndex = -1

	ContainerScroll.Name = "ContainerScroll"
	ContainerScroll.Parent = Top
	ContainerScroll.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
	ContainerScroll.BackgroundTransparency = 1
	ContainerScroll.ClipsDescendants = true
	ContainerScroll.Position = UDim2.new(0, 0, 1, 0)
	ContainerScroll.Size = UDim2.new(1, 0, 0, 400)
	ContainerScroll.ZIndex = 2
	ContainerScroll.ScrollBarThickness = 4
	ContainerScroll.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
	ContainerScroll.ScrollBarImageTransparency = 0.5
	ContainerScroll.CanvasSize = UDim2.new(0, 0, 0, 0)

	UIListLayout.Parent = ContainerScroll
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 10)
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top

	Title.Name = "Title"
	Title.Parent = Top
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.Position = UDim2.new(0.05, 0, 0, 0)
	Title.Size = UDim2.new(0.7, 0, 1, 0)
	Title.Font = Enum.Font.GothamSemibold
	Title.Text = title
	Title.TextColor3 = Color3.fromRGB(240, 240, 240)
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
	Minimize.ImageColor3 = Color3.fromRGB(240, 240, 240)

	local function UZVNGAL_fake_script()
		local script = Instance.new('Script', Minimize)

		script.Parent.MouseButton1Click:Connect(function()
			if script.Parent.Parent.ContainerScroll.Size == UDim2.new(1, 0, 0, 400) then 
				game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 180}):Play()
				game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.3), {ImageColor3 = Color3.fromRGB(150, 150, 150)}):Play()
				script.Parent.Parent.ContainerScroll:TweenSize(UDim2.new(1, 0, 0, 0), "Out", "Quad", 0.3, true)
				game:GetService("TweenService"):Create(Background, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 1, 0)}):Play()
				game:GetService("TweenService"):Create(Shadow, TweenInfo.new(0.3), {Size = UDim2.new(1, 40, 1, 40)}):Play()
			else
				game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0}):Play()
				game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.3), {ImageColor3 = Color3.fromRGB(240, 240, 240)}):Play()
				script.Parent.Parent.ContainerScroll:TweenSize(UDim2.new(1, 0, 0, 400), "Out", "Quad", 0.3, true)
				game:GetService("TweenService"):Create(Background, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 1, 400)}):Play()
				game:GetService("TweenService"):Create(Shadow, TweenInfo.new(0.3), {Size = UDim2.new(1, 40, 1, 440)}):Play()
			end
		end)
	end
	coroutine.wrap(UZVNGAL_fake_script)()
	
	UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		ContainerScroll.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 20)
	end)
	
	local Lib = {}
	
	function Lib:Button(name, callback)
		local ButtonContainer = Instance.new("Frame")
		local UICorner_btn = Instance.new("UICorner")
		local Button = Instance.new("TextButton")
		local ButtonName = Instance.new("TextLabel")
		local ButtonHover = Instance.new("Frame")
		
		ButtonContainer.Name = "ButtonContainer"
		ButtonContainer.Parent = ContainerScroll
		ButtonContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
		ButtonContainer.BorderSizePixel = 0
		ButtonContainer.Size = UDim2.new(0.9, 0, 0, 40)
		
		UICorner_btn.CornerRadius = UDim.new(0, 8)
		UICorner_btn.Parent = ButtonContainer
		
		ButtonHover.Name = "ButtonHover"
		ButtonHover.Parent = ButtonContainer
		ButtonHover.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ButtonHover.BackgroundTransparency = 0.95
		ButtonHover.Size = UDim2.new(1, 0, 1, 0)
		ButtonHover.Visible = false
		
		local UICorner_hover = Instance.new("UICorner")
		UICorner_hover.CornerRadius = UDim.new(0, 8)
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
		ButtonName.Font = Enum.Font.GothamSemibold
		ButtonName.Text = name
		ButtonName.TextColor3 = Color3.fromRGB(240, 240, 240)
		ButtonName.TextSize = 14
		
		Button.MouseEnter:Connect(function()
			ButtonHover.Visible = true
			game:GetService("TweenService"):Create(ButtonContainer, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
		end)
		
		Button.MouseLeave:Connect(function()
			ButtonHover.Visible = false
			game:GetService("TweenService"):Create(ButtonContainer, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
		end)
		
		Button.MouseButton1Click:Connect(function()
			game:GetService("TweenService"):Create(ButtonContainer, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
			wait(0.1)
			game:GetService("TweenService"):Create(ButtonContainer, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
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
		ToggleContainer.Parent = ContainerScroll
		ToggleContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
		ToggleContainer.BorderSizePixel = 0
		ToggleContainer.Size = UDim2.new(0.9, 0, 0, 40)
		
		UICorner_toggle.CornerRadius = UDim.new(0, 8)
		UICorner_toggle.Parent = ToggleContainer
		
		ToggleName.Name = "ToggleName"
		ToggleName.Parent = ToggleContainer
		ToggleName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ToggleName.BackgroundTransparency = 1.000
		ToggleName.Position = UDim2.new(0.05, 0, 0, 0)
		ToggleName.Size = UDim2.new(0.65, 0, 1, 0)
		ToggleName.Font = Enum.Font.GothamSemibold
		ToggleName.Text = name
		ToggleName.TextColor3 = Color3.fromRGB(240, 240, 240)
		ToggleName.TextSize = 14
		ToggleName.TextXAlignment = Enum.TextXAlignment.Left
		
		Toggle.Name = "Toggle"
		Toggle.Parent = ToggleContainer
		Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		Toggle.BorderColor3 = Color3.fromRGB(27, 42, 53)
		Toggle.Position = UDim2.new(0.78, 0, 0.25, 0)
		Toggle.Size = UDim2.new(0, 44, 0, 22)
		Toggle.AutoButtonColor = false
		Toggle.Font = Enum.Font.SourceSans
		Toggle.Text = ""
		Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
		Toggle.TextSize = 14.000
		
		UICorner_3.CornerRadius = UDim.new(1, 0)
		UICorner_3.Parent = Toggle
		
		ToggleIndicator.Name = "ToggleIndicator"
		ToggleIndicator.Parent = Toggle
		ToggleIndicator.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
		ToggleIndicator.BorderSizePixel = 0
		ToggleIndicator.Position = UDim2.new(0.05, 0, 0.136, 0)
		ToggleIndicator.Size = UDim2.new(0, 16, 0, 16)
		
		UICorner_indicator.CornerRadius = UDim.new(1, 0)
		UICorner_indicator.Parent = ToggleIndicator
		
		local Toggled = false
		Toggle.MouseButton1Click:Connect(function()
			Toggled = not Toggled
			if Toggled then
				game:GetService("TweenService"):Create(ToggleIndicator, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = UDim2.new(0.55, 0, 0.136, 0), BackgroundColor3 = Color3.fromRGB(0, 200, 255)}):Play()
				game:GetService("TweenService"):Create(Toggle, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(0, 120, 180)}):Play()
			else
				game:GetService("TweenService"):Create(ToggleIndicator, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = UDim2.new(0.05, 0, 0.136, 0), BackgroundColor3 = Color3.fromRGB(100, 100, 100)}):Play()
				game:GetService("TweenService"):Create(Toggle, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
			end
			callback(Toggled)
		end)
		
		Toggle.MouseEnter:Connect(function()
			game:GetService("TweenService"):Create(ToggleContainer, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
		end)
		
		Toggle.MouseLeave:Connect(function()
			game:GetService("TweenService"):Create(ToggleContainer, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
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
		SliderContainer.Parent = ContainerScroll
		SliderContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
		SliderContainer.BorderSizePixel = 0
		SliderContainer.Size = UDim2.new(0.9, 0, 0, 60)
		
		UICorner_slider.CornerRadius = UDim.new(0, 8)
		UICorner_slider.Parent = SliderContainer
		
		SliderName.Name = "SliderName"
		SliderName.Parent = SliderContainer
		SliderName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SliderName.BackgroundTransparency = 1.000
		SliderName.Position = UDim2.new(0.05, 0, 0, 0)
		SliderName.Size = UDim2.new(0.6, 0, 0, 25)
		SliderName.Font = Enum.Font.GothamSemibold
		SliderName.Text = name
		SliderName.TextColor3 = Color3.fromRGB(240, 240, 240)
		SliderName.TextSize = 14
		SliderName.TextXAlignment = Enum.TextXAlignment.Left
		
		SliderValue.Name = "SliderValue"
		SliderValue.Parent = SliderContainer
		SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SliderValue.BackgroundTransparency = 1.000
		SliderValue.Position = UDim2.new(0.7, 0, 0, 0)
		SliderValue.Size = UDim2.new(0.25, 0, 0, 25)
		SliderValue.Font = Enum.Font.GothamSemibold
		SliderValue.Text = tostring(default)
		SliderValue.TextColor3 = Color3.fromRGB(200, 200, 200)
		SliderValue.TextSize = 14
		SliderValue.TextXAlignment = Enum.TextXAlignment.Right
		
		SliderTrack.Name = "SliderTrack"
		SliderTrack.Parent = SliderContainer
		SliderTrack.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		SliderTrack.BorderSizePixel = 0
		SliderTrack.Position = UDim2.new(0.05, 0, 0.5, 0)
		SliderTrack.Size = UDim2.new(0.9, 0, 0, 6)
		
		UICorner_track.CornerRadius = UDim.new(1, 0)
		UICorner_track.Parent = SliderTrack
		
		SliderFill.Name = "SliderFill"
		SliderFill.Parent = SliderTrack
		SliderFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
		SliderFill.BorderSizePixel = 0
		SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
		
		UICorner_fill.CornerRadius = UDim.new(1, 0)
		UICorner_fill.Parent = SliderFill
		
		SliderButton.Name = "SliderButton"
		SliderButton.Parent = SliderTrack
		SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SliderButton.BorderSizePixel = 0
		SliderButton.Position = UDim2.new((default - min) / (max - min), -10, 0, -7)
		SliderButton.Size = UDim2.new(0, 20, 0, 20)
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
			SliderButton.Position = UDim2.new(pos.X.Scale, -10, 0, -7)
			SliderValue.Text = tostring(value)
			
			if value ~= currentValue then
				currentValue = value
				callback(value)
			end
		end
		
		SliderButton.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = true
				game:GetService("TweenService"):Create(SliderButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 24, 0, 24)}):Play()
			end
		end)
		
		SliderButton.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = false
				game:GetService("TweenService"):Create(SliderButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 20, 0, 20)}):Play()
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
				game:GetService("TweenService"):Create(SliderButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 24, 0, 24)}):Play()
			end
		end)
		
		SliderTrack.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = false
				game:GetService("TweenService"):Create(SliderButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 20, 0, 20)}):Play()
			end
		end)
		
		SliderContainer.MouseEnter:Connect(function()
			game:GetService("TweenService"):Create(SliderContainer, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
		end)
		
		SliderContainer.MouseLeave:Connect(function()
			game:GetService("TweenService"):Create(SliderContainer, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
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
		DropdownContainer.Parent = ContainerScroll
		DropdownContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
		DropdownContainer.BorderSizePixel = 0
		DropdownContainer.Size = UDim2.new(0.9, 0, 0, 40)
		DropdownContainer.ClipsDescendants = false
		
		UICorner_dropdown.CornerRadius = UDim.new(0, 8)
		UICorner_dropdown.Parent = DropdownContainer
		
		DropdownName.Name = "DropdownName"
		DropdownName.Parent = DropdownContainer
		DropdownName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		DropdownName.BackgroundTransparency = 1.000
		DropdownName.Position = UDim2.new(0.05, 0, 0, 0)
		DropdownName.Size = UDim2.new(0.65, 0, 1, 0)
		DropdownName.Font = Enum.Font.GothamSemibold
		DropdownName.Text = name
		DropdownName.TextColor3 = Color3.fromRGB(240, 240, 240)
		DropdownName.TextSize = 14
		DropdownName.TextXAlignment = Enum.TextXAlignment.Left
		
		DropdownButton.Name = "DropdownButton"
		DropdownButton.Parent = DropdownContainer
		DropdownButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		DropdownButton.BackgroundTransparency = 0
		DropdownButton.Position = UDim2.new(0.7, 0, 0.2, 0)
		DropdownButton.Size = UDim2.new(0.25, 0, 0, 24)
		DropdownButton.Font = Enum.Font.SourceSans
		DropdownButton.Text = ""
		DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		DropdownButton.TextSize = 12.000
		DropdownButton.AutoButtonColor = false
		
		local UICorner_btn = Instance.new("UICorner")
		UICorner_btn.CornerRadius = UDim.new(0, 6)
		UICorner_btn.Parent = DropdownButton
		
		DropdownSelected.Name = "DropdownSelected"
		DropdownSelected.Parent = DropdownButton
		DropdownSelected.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		DropdownSelected.BackgroundTransparency = 1.000
		DropdownSelected.Position = UDim2.new(0.05, 0, 0, 0)
		DropdownSelected.Size = UDim2.new(0.7, 0, 1, 0)
		DropdownSelected.Font = Enum.Font.Gotham
		DropdownSelected.Text = "Select"
		DropdownSelected.TextColor3 = Color3.fromRGB(220, 220, 220)
		DropdownSelected.TextSize = 12
		DropdownSelected.TextXAlignment = Enum.TextXAlignment.Left
		
		DropdownArrow.Name = "DropdownArrow"
		DropdownArrow.Parent = DropdownButton
		DropdownArrow.BackgroundTransparency = 1
		DropdownArrow.Position = UDim2.new(0.8, 0, 0.15, 0)
		DropdownArrow.Size = UDim2.new(0, 14, 0, 14)
		DropdownArrow.Image = "rbxassetid://6031094678"
		DropdownArrow.ImageColor3 = Color3.fromRGB(220, 220, 220)
		DropdownArrow.Rotation = 0
		
		local DropdownList = Instance.new("Frame")
		local DropdownScroll = Instance.new("ScrollingFrame")
		local UIListLayout_list = Instance.new("UIListLayout")
		
		DropdownList.Name = "DropdownList"
		DropdownList.Parent = UiLib
		DropdownList.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		DropdownList.BackgroundTransparency = 0.05
		DropdownList.BorderSizePixel = 0
		DropdownList.Size = UDim2.new(0, DropdownButton.AbsoluteSize.X, 0, 0)
		DropdownList.Visible = false
		DropdownList.ZIndex = 20
		DropdownList.ClipsDescendants = true
		
		local DropdownShadow = Instance.new("ImageLabel")
		DropdownShadow.Name = "DropdownShadow"
		DropdownShadow.Parent = DropdownList
		DropdownShadow.BackgroundTransparency = 1
		DropdownShadow.Size = UDim2.new(1, 24, 1, 24)
		DropdownShadow.Position = UDim2.new(0, -12, 0, -12)
		DropdownShadow.Image = "rbxassetid://5554236805"
		DropdownShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
		DropdownShadow.ImageTransparency = 0.8
		DropdownShadow.ScaleType = Enum.ScaleType.Slice
		DropdownShadow.SliceCenter = Rect.new(23, 23, 277, 277)
		DropdownShadow.ZIndex = 19
		
		local UICorner_list = Instance.new("UICorner")
		UICorner_list.CornerRadius = UDim.new(0, 8)
		UICorner_list.Parent = DropdownList
		
		DropdownScroll.Name = "DropdownScroll"
		DropdownScroll.Parent = DropdownList
		DropdownScroll.Active = true
		DropdownScroll.BackgroundTransparency = 1
		DropdownScroll.BorderSizePixel = 0
		DropdownScroll.Size = UDim2.new(1, -8, 1, -8)
		DropdownScroll.Position = UDim2.new(0, 4, 0, 4)
		DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
		DropdownScroll.ScrollBarThickness = 4
		DropdownScroll.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
		DropdownScroll.ScrollBarImageTransparency = 0.3
		DropdownScroll.VerticalScrollBarInset = Enum.ScrollBarInset.Always
		DropdownScroll.ZIndex = 21
		
		UIListLayout_list.Parent = DropdownScroll
		UIListLayout_list.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_list.Padding = UDim.new(0, 4)
		
		local isOpen = false
		local selectedOption = nil
		
		local function updateListHeight()
			local itemCount = #options
			local height = math.min(itemCount * 32 + 8, 160)
			DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, itemCount * 32)
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
				game:GetService("TweenService"):Create(DropdownArrow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Rotation = 180}):Play()
				game:GetService("TweenService"):Create(DropdownButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
				DropdownList:TweenSize(
					UDim2.new(0, DropdownButton.AbsoluteSize.X, 0, updateListHeight()),
					"Out", "Quad", 0.3, true
				)
			else
				game:GetService("TweenService"):Create(DropdownArrow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Rotation = 0}):Play()
				game:GetService("TweenService"):Create(DropdownButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
				DropdownList:TweenSize(
					UDim2.new(0, DropdownButton.AbsoluteSize.X, 0, 0),
					"Out", "Quad", 0.3, true,
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
			OptionButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			OptionButton.BorderSizePixel = 0
			OptionButton.Size = UDim2.new(1, 0, 0, 30)
			OptionButton.Font = Enum.Font.SourceSans
			OptionButton.Text = ""
			OptionButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			OptionButton.TextSize = 14
			OptionButton.AutoButtonColor = false
			OptionButton.ZIndex = 22
			
			local UICorner_option = Instance.new("UICorner")
			UICorner_option.CornerRadius = UDim.new(0, 6)
			UICorner_option.Parent = OptionButton
			
			OptionHover.Name = "OptionHover"
			OptionHover.Parent = OptionButton
			OptionHover.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			OptionHover.BackgroundTransparency = 0.95
			OptionHover.Size = UDim2.new(1, 0, 1, 0)
			OptionHover.Visible = false
			OptionHover.ZIndex = 23
			
			local UICorner_hover = Instance.new("UICorner")
			UICorner_hover.CornerRadius = UDim.new(0, 6)
			UICorner_hover.Parent = OptionHover
			
			OptionText.Name = "OptionText"
			OptionText.Parent = OptionButton
			OptionText.BackgroundTransparency = 1
			OptionText.Size = UDim2.new(1, -10, 1, 0)
			OptionText.Position = UDim2.new(0, 5, 0, 0)
			OptionText.Font = Enum.Font.Gotham
			OptionText.Text = option
			OptionText.TextColor3 = Color3.fromRGB(220, 220, 220)
			OptionText.TextSize = 12
			OptionText.TextXAlignment = Enum.TextXAlignment.Left
			OptionText.ZIndex = 24
			
			OptionButton.MouseButton1Click:Connect(function()
				selectedOption = option
				DropdownSelected.Text = option
				toggleDropdown()
				callback(option)
			end)
			
			OptionButton.MouseEnter:Connect(function()
				OptionHover.Visible = true
				game:GetService("TweenService"):Create(OptionButton, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
			end)
			
			OptionButton.MouseLeave:Connect(function()
				OptionHover.Visible = false
				game:GetService("TweenService"):Create(OptionButton, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
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
		
		DropdownContainer.MouseEnter:Connect(function()
			game:GetService("TweenService"):Create(DropdownContainer, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
		end)
		
		DropdownContainer.MouseLeave:Connect(function()
			game:GetService("TweenService"):Create(DropdownContainer, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
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
		ColorpickerContainer.Parent = ContainerScroll
		ColorpickerContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
		ColorpickerContainer.BorderSizePixel = 0
		ColorpickerContainer.Size = UDim2.new(0.9, 0, 0, 40)
		
		UICorner_color.CornerRadius = UDim.new(0, 8)
		UICorner_color.Parent = ColorpickerContainer
		
		ColorpickerName.Name = "ColorpickerName"
		ColorpickerName.Parent = ColorpickerContainer
		ColorpickerName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ColorpickerName.BackgroundTransparency = 1.000
		ColorpickerName.Position = UDim2.new(0.05, 0, 0, 0)
		ColorpickerName.Size = UDim2.new(0.65, 0, 1, 0)
		ColorpickerName.Font = Enum.Font.GothamSemibold
		ColorpickerName.Text = name
		ColorpickerName.TextColor3 = Color3.fromRGB(240, 240, 240)
		ColorpickerName.TextSize = 14
		ColorpickerName.TextXAlignment = Enum.TextXAlignment.Left
		
		ColorButton.Name = "ColorButton"
		ColorButton.Parent = ColorpickerContainer
		ColorButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		ColorButton.BackgroundTransparency = 0
		ColorButton.Position = UDim2.new(0.7, 0, 0.2, 0)
		ColorButton.Size = UDim2.new(0.25, 0, 0, 24)
		ColorButton.Font = Enum.Font.SourceSans
		ColorButton.Text = ""
		ColorButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		ColorButton.TextSize = 14.000
		ColorButton.AutoButtonColor = false
		
		local UICorner_btn = Instance.new("UICorner")
		UICorner_btn.CornerRadius = UDim.new(0, 6)
		UICorner_btn.Parent = ColorButton
		
		ColorPreview.Name = "ColorPreview"
		ColorPreview.Parent = ColorButton
		ColorPreview.BackgroundColor3 = defaultColor or Color3.fromRGB(0, 200, 255)
		ColorPreview.BorderSizePixel = 0
		ColorPreview.Position = UDim2.new(0.1, 0, 0.1, 0)
		ColorPreview.Size = UDim2.new(0.8, 0, 0, 20)
		
		UICorner_preview.CornerRadius = UDim.new(0, 4)
		UICorner_preview.Parent = ColorPreview
		
		local colorPickerFrame = nil
		
		local function showColorPicker()
			if colorPickerFrame then
				colorPickerFrame:Destroy()
				colorPickerFrame = nil
				return
			end
			
			colorPickerFrame = Instance.new("Frame")
			local UICorner_frame = Instance.new("UICorner")
			local ColorDisplay = Instance.new("Frame")
			local UICorner_display = Instance.new("UICorner")
			local RSlider = Instance.new("Frame")
			local RName = Instance.new("TextLabel")
			local RTrack = Instance.new("Frame")
			local RFill = Instance.new("Frame")
			local RButton = Instance.new("TextButton")
			local RValue = Instance.new("TextLabel")
			local GSlider = Instance.new("Frame")
			local GName = Instance.new("TextLabel")
			local GTrack = Instance.new("Frame")
			local GFill = Instance.new("Frame")
			local GButton = Instance.new("TextButton")
			local GValue = Instance.new("TextLabel")
			local BSlider = Instance.new("Frame")
			local BName = Instance.new("TextLabel")
			local BTrack = Instance.new("Frame")
			local BFill = Instance.new("Frame")
			local BButton = Instance.new("TextButton")
			local BValue = Instance.new("TextLabel")
			local HexBox = Instance.new("TextBox")
			local ApplyButton = Instance.new("TextButton")
			
			local currentColor = ColorPreview.BackgroundColor3
			local r, g, b = math.floor(currentColor.r * 255), math.floor(currentColor.g * 255), math.floor(currentColor.b * 255)
			
			colorPickerFrame.Name = "ColorPickerFrame"
			colorPickerFrame.Parent = Top
			colorPickerFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			colorPickerFrame.BorderSizePixel = 0
			colorPickerFrame.Position = UDim2.new(0, 0, 1.1, 0)
			colorPickerFrame.Size = UDim2.new(1, 0, 0, 0)
			colorPickerFrame.ZIndex = 10
			colorPickerFrame.ClipsDescendants = true
			
			UICorner_frame.CornerRadius = UDim.new(0, 10)
			UICorner_frame.Parent = colorPickerFrame
			
			ColorDisplay.Name = "ColorDisplay"
			ColorDisplay.Parent = colorPickerFrame
			ColorDisplay.BackgroundColor3 = currentColor
			ColorDisplay.BorderSizePixel = 0
			ColorDisplay.Position = UDim2.new(0.05, 0, 0.05, 0)
			ColorDisplay.Size = UDim2.new(0.4, 0, 0, 60)
			
			UICorner_display.CornerRadius = UDim.new(0, 8)
			UICorner_display.Parent = ColorDisplay
			
			local function createRGBSlider(name, yPos, value, color)
				local slider = Instance.new("Frame")
				local nameLabel = Instance.new("TextLabel")
				local track = Instance.new("Frame")
				local fill = Instance.new("Frame")
				local button = Instance.new("TextButton")
				local valueLabel = Instance.new("TextLabel")
				
				slider.Name = name .. "Slider"
				slider.Parent = colorPickerFrame
				slider.BackgroundTransparency = 1
				slider.Position = UDim2.new(0.05, 0, yPos, 0)
				slider.Size = UDim2.new(0.9, 0, 0, 40)
				
				nameLabel.Name = name .. "Name"
				nameLabel.Parent = slider
				nameLabel.BackgroundTransparency = 1
				nameLabel.Position = UDim2.new(0, 0, 0, 0)
				nameLabel.Size = UDim2.new(0.2, 0, 0, 20)
				nameLabel.Font = Enum.Font.GothamSemibold
				nameLabel.Text = name .. ":"
				nameLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
				nameLabel.TextSize = 12
				nameLabel.TextXAlignment = Enum.TextXAlignment.Left
				
				track.Name = name .. "Track"
				track.Parent = slider
				track.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
				track.BorderSizePixel = 0
				track.Position = UDim2.new(0.25, 0, 0.5, 0)
				track.Size = UDim2.new(0.5, 0, 0, 6)
				
				local trackCorner = Instance.new("UICorner")
				trackCorner.CornerRadius = UDim.new(1, 0)
				trackCorner.Parent = track
				
				fill.Name = name .. "Fill"
				fill.Parent = track
				fill.BackgroundColor3 = color
				fill.BorderSizePixel = 0
				fill.Size = UDim2.new(value / 255, 0, 1, 0)
				
				local fillCorner = Instance.new("UICorner")
				fillCorner.CornerRadius = UDim.new(1, 0)
				fillCorner.Parent = fill
				
				button.Name = name .. "Button"
				button.Parent = track
				button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				button.BorderSizePixel = 0
				button.Position = UDim2.new(value / 255, -8, 0, -7)
				button.Size = UDim2.new(0, 20, 0, 20)
				button.Font = Enum.Font.SourceSans
				button.Text = ""
				button.TextColor3 = Color3.fromRGB(0, 0, 0)
				button.TextSize = 14
				button.AutoButtonColor = false
				
				local buttonCorner = Instance.new("UICorner")
				buttonCorner.CornerRadius = UDim.new(1, 0)
				buttonCorner.Parent = button
				
				valueLabel.Name = name .. "Value"
				valueLabel.Parent = slider
				valueLabel.BackgroundTransparency = 1
				valueLabel.Position = UDim2.new(0.8, 0, 0, 0)
				valueLabel.Size = UDim2.new(0.2, 0, 0, 20)
				valueLabel.Font = Enum.Font.GothamSemibold
				valueLabel.Text = tostring(value)
				valueLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
				valueLabel.TextSize = 12
				valueLabel.TextXAlignment = Enum.TextXAlignment.Right
				
				return {slider = slider, track = track, fill = fill, button = button, value = valueLabel}
			end
			
			local rData = createRGBSlider("R", 0.2, r, Color3.fromRGB(255, 0, 0))
			local gData = createRGBSlider("G", 0.35, g, Color3.fromRGB(0, 255, 0))
			local bData = createRGBSlider("B", 0.5, b, Color3.fromRGB(0, 0, 255))
			
			HexBox.Name = "HexBox"
			HexBox.Parent = colorPickerFrame
			HexBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			HexBox.BorderSizePixel = 0
			HexBox.Position = UDim2.new(0.5, 0, 0.05, 0)
			HexBox.Size = UDim2.new(0.4, 0, 0, 30)
			HexBox.Font = Enum.Font.Gotham
			HexBox.PlaceholderText = "Hex Color"
			HexBox.Text = string.format("#%02X%02X%02X", r, g, b)
			HexBox.TextColor3 = Color3.fromRGB(220, 220, 220)
			HexBox.TextSize = 12
			HexBox.ClearTextOnFocus = false
			
			local hexCorner = Instance.new("UICorner")
			hexCorner.CornerRadius = UDim.new(0, 6)
			hexCorner.Parent = HexBox
			
			ApplyButton.Name = "ApplyButton"
			ApplyButton.Parent = colorPickerFrame
			ApplyButton.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
			ApplyButton.BorderSizePixel = 0
			ApplyButton.Position = UDim2.new(0.5, 0, 0.2, 0)
			ApplyButton.Size = UDim2.new(0.4, 0, 0, 30)
			ApplyButton.Font = Enum.Font.GothamSemibold
			ApplyButton.Text = "Apply"
			ApplyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			ApplyButton.TextSize = 14
			ApplyButton.AutoButtonColor = false
			
			local applyCorner = Instance.new("UICorner")
			applyCorner.CornerRadius = UDim.new(0, 6)
			applyCorner.Parent = ApplyButton
			
			local function updateColor()
				currentColor = Color3.fromRGB(r, g, b)
				ColorDisplay.BackgroundColor3 = currentColor
				HexBox.Text = string.format("#%02X%02X%02X", r, g, b)
			end
			
			local function createSliderLogic(data, color, isR, isG, isB)
				local dragging = false
				
				local function updateSlider(input)
					local pos = UDim2.new(
						math.clamp((input.Position.X - data.track.AbsolutePosition.X) / data.track.AbsoluteSize.X, 0, 1),
						0,
						0, 0
					)
					local value = math.floor(pos.X.Scale * 255)
					
					data.fill.Size = UDim2.new(pos.X.Scale, 0, 1, 0)
					data.button.Position = UDim2.new(pos.X.Scale, -8, 0, -7)
					data.value.Text = tostring(value)
					
					if isR then r = value
					elseif isG then g = value
					elseif isB then b = value end
					
					updateColor()
				end
				
				data.button.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = true
						game:GetService("TweenService"):Create(data.button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 24, 0, 24)}):Play()
					end
				end)
				
				data.button.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = false
						game:GetService("TweenService"):Create(data.button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 20, 0, 20)}):Play()
					end
				end)
				
				data.track.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						updateSlider(input)
						dragging = true
						game:GetService("TweenService"):Create(data.button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 24, 0, 24)}):Play()
					end
				end)
				
				data.track.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = false
						game:GetService("TweenService"):Create(data.button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 20, 0, 20)}):Play()
					end
				end)
				
				game:GetService("UserInputService").InputChanged:Connect(function(input)
					if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						updateSlider(input)
					end
				end)
			end
			
			createSliderLogic(rData, Color3.fromRGB(255, 0, 0), true, false, false)
			createSliderLogic(gData, Color3.fromRGB(0, 255, 0), false, true, false)
			createSliderLogic(bData, Color3.fromRGB(0, 0, 255), false, false, true)
			
			HexBox.FocusLost:Connect(function(enterPressed)
				if enterPressed then
					local hex = HexBox.Text:gsub("#", "")
					if #hex == 6 then
						local hr = tonumber("0x" .. hex:sub(1, 2)) or 0
						local hg = tonumber("0x" .. hex:sub(3, 4)) or 0
						local hb = tonumber("0x" .. hex:sub(5, 6)) or 0
						
						r = math.clamp(hr, 0, 255)
						g = math.clamp(hg, 0, 255)
						b = math.clamp(hb, 0, 255)
						
						rData.fill.Size = UDim2.new(r / 255, 0, 1, 0)
						rData.button.Position = UDim2.new(r / 255, -8, 0, -7)
						rData.value.Text = tostring(r)
						
						gData.fill.Size = UDim2.new(g / 255, 0, 1, 0)
						gData.button.Position = UDim2.new(g / 255, -8, 0, -7)
						gData.value.Text = tostring(g)
						
						bData.fill.Size = UDim2.new(b / 255, 0, 1, 0)
						bData.button.Position = UDim2.new(b / 255, -8, 0, -7)
						bData.value.Text = tostring(b)
						
						updateColor()
					end
				end
			end)
			
			ApplyButton.MouseButton1Click:Connect(function()
				callback(currentColor)
				ColorPreview.BackgroundColor3 = currentColor
				colorPickerFrame:TweenSize(UDim2.new(1, 0, 0, 0), "Out", "Quad", 0.3, true, function()
					colorPickerFrame:Destroy()
					colorPickerFrame = nil
				end)
			end)
			
			ApplyButton.MouseEnter:Connect(function()
				game:GetService("TweenService"):Create(ApplyButton, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(0, 180, 235)}):Play()
			end)
			
			ApplyButton.MouseLeave:Connect(function()
				game:GetService("TweenService"):Create(ApplyButton, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(0, 200, 255)}):Play()
			end)
			
			colorPickerFrame:TweenSize(UDim2.new(1, 0, 0, 200), "Out", "Quad", 0.3, true)
			
			local closeConnection
			closeConnection = game:GetService("UserInputService").InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 and colorPickerFrame then
					local mousePos = game:GetService("UserInputService"):GetMouseLocation()
					local framePos = colorPickerFrame.AbsolutePosition
					local frameSize = colorPickerFrame.AbsoluteSize
					
					if not (mousePos.X >= framePos.X and mousePos.X <= framePos.X + frameSize.X and
						   mousePos.Y >= framePos.Y and mousePos.Y <= framePos.Y + frameSize.Y) then
						colorPickerFrame:TweenSize(UDim2.new(1, 0, 0, 0), "Out", "Quad", 0.3, true, function()
							colorPickerFrame:Destroy()
							colorPickerFrame = nil
							if closeConnection then
								closeConnection:Disconnect()
							end
						end)
					end
				end
			end)
		end
		
		ColorButton.MouseButton1Click:Connect(showColorPicker)
		
		ColorpickerContainer.MouseEnter:Connect(function()
			game:GetService("TweenService"):Create(ColorpickerContainer, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
		end)
		
		ColorpickerContainer.MouseLeave:Connect(function()
			game:GetService("TweenService"):Create(ColorpickerContainer, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
		end)
	end
	
	function Lib:Textbox(name, placeholder, callback)
		local TextboxContainer = Instance.new("Frame")
		local UICorner_textbox = Instance.new("UICorner")
		local TextboxName = Instance.new("TextLabel")
		local TextboxInput = Instance.new("TextBox")
		local UICorner_input = Instance.new("UICorner")
		local TextboxHover = Instance.new("Frame")
		
		TextboxContainer.Name = "TextboxContainer"
		TextboxContainer.Parent = ContainerScroll
		TextboxContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
		TextboxContainer.BorderSizePixel = 0
		TextboxContainer.Size = UDim2.new(0.9, 0, 0, 60)
		
		UICorner_textbox.CornerRadius = UDim.new(0, 8)
		UICorner_textbox.Parent = TextboxContainer
		
		TextboxName.Name = "TextboxName"
		TextboxName.Parent = TextboxContainer
		TextboxName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextboxName.BackgroundTransparency = 1.000
		TextboxName.Position = UDim2.new(0.05, 0, 0, 0)
		TextboxName.Size = UDim2.new(0.9, 0, 0, 25)
		TextboxName.Font = Enum.Font.GothamSemibold
		TextboxName.Text = name
		TextboxName.TextColor3 = Color3.fromRGB(240, 240, 240)
		TextboxName.TextSize = 14
		TextboxName.TextXAlignment = Enum.TextXAlignment.Left
		
		TextboxInput.Name = "TextboxInput"
		TextboxInput.Parent = TextboxContainer
		TextboxInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		TextboxInput.BorderSizePixel = 0
		TextboxInput.Position = UDim2.new(0.05, 0, 0.5, 0)
		TextboxInput.Size = UDim2.new(0.9, 0, 0, 30)
		TextboxInput.Font = Enum.Font.Gotham
		TextboxInput.PlaceholderText = placeholder or "Enter text..."
		TextboxInput.Text = ""
		TextboxInput.TextColor3 = Color3.fromRGB(220, 220, 220)
		TextboxInput.TextSize = 12
		TextboxInput.ClearTextOnFocus = false
		
		UICorner_input.CornerRadius = UDim.new(0, 6)
		UICorner_input.Parent = TextboxInput
		
		TextboxHover.Name = "TextboxHover"
		TextboxHover.Parent = TextboxInput
		TextboxHover.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextboxHover.BackgroundTransparency = 0.95
		TextboxHover.Size = UDim2.new(1, 0, 1, 0)
		TextboxHover.Visible = false
		
		local UICorner_hover = Instance.new("UICorner")
		UICorner_hover.CornerRadius = UDim.new(0, 6)
		UICorner_hover.Parent = TextboxHover
		
		TextboxInput.Focused:Connect(function()
			TextboxHover.Visible = true
			game:GetService("TweenService"):Create(TextboxInput, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
		end)
		
		TextboxInput.FocusLost:Connect(function(enterPressed)
			TextboxHover.Visible = false
			game:GetService("TweenService"):Create(TextboxInput, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
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
		
		TextboxContainer.MouseEnter:Connect(function()
			game:GetService("TweenService"):Create(TextboxContainer, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
		end)
		
		TextboxContainer.MouseLeave:Connect(function()
			game:GetService("TweenService"):Create(TextboxContainer, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
		end)
	end
	
	function Lib:Label(text)
		local LabelContainer = Instance.new("Frame")
		local UICorner_label = Instance.new("UICorner")
		local LabelText = Instance.new("TextLabel")
		
		LabelContainer.Name = "LabelContainer"
		LabelContainer.Parent = ContainerScroll
		LabelContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
		LabelContainer.BackgroundTransparency = 0
		LabelContainer.Size = UDim2.new(0.9, 0, 0, 35)
		
		UICorner_label.CornerRadius = UDim.new(0, 8)
		UICorner_label.Parent = LabelContainer
		
		LabelText.Name = "LabelText"
		LabelText.Parent = LabelContainer
		LabelText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		LabelText.BackgroundTransparency = 1.000
		LabelText.Size = UDim2.new(1, -10, 1, 0)
		LabelText.Position = UDim2.new(0, 5, 0, 0)
		LabelText.Font = Enum.Font.Gotham
		LabelText.Text = text
		LabelText.TextColor3 = Color3.fromRGB(200, 200, 200)
		LabelText.TextSize = 12
		LabelText.TextWrapped = true
	end
	
	function Lib:Separator()
		local SeparatorContainer = Instance.new("Frame")
		local SeparatorLine = Instance.new("Frame")
		
		SeparatorContainer.Name = "SeparatorContainer"
		SeparatorContainer.Parent = ContainerScroll
		SeparatorContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
		SeparatorContainer.BackgroundTransparency = 0.000
		SeparatorContainer.Size = UDim2.new(0.9, 0, 0, 15)
		
		SeparatorLine.Name = "SeparatorLine"
		SeparatorLine.Parent = SeparatorContainer
		SeparatorLine.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		SeparatorLine.BorderSizePixel = 0
		SeparatorLine.Position = UDim2.new(0.1, 0, 0.5, 0)
		SeparatorLine.Size = UDim2.new(0.8, 0, 0, 1)
	end
	
	return Lib
	
end

return Library
