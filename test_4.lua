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
	Top.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	Top.BorderSizePixel = 0
	Top.Position = UDim2.new(0, getNextWindowPos(), 0.01, 0)
	Top.Size = UDim2.new(0, 280, 0, 40)
	Top.Active = true
	Top.Draggable = true

	UICorner.CornerRadius = UDim.new(0, 8)
	UICorner.Parent = Top

	Background.Name = "Background"
	Background.Parent = Top
	Background.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
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
	Shadow.ImageTransparency = 0.8
	Shadow.ScaleType = Enum.ScaleType.Slice
	Shadow.SliceCenter = Rect.new(23, 23, 277, 277)
	Shadow.ZIndex = -1

	ContainerScroll.Name = "ContainerScroll"
	ContainerScroll.Parent = Top
	ContainerScroll.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	ContainerScroll.BackgroundTransparency = 1
	ContainerScroll.ClipsDescendants = true
	ContainerScroll.Position = UDim2.new(0, 0, 1, 0)
	ContainerScroll.Size = UDim2.new(1, 0, 0, 400)
	ContainerScroll.ZIndex = 2
	ContainerScroll.ScrollBarThickness = 3
	ContainerScroll.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
	ContainerScroll.ScrollBarImageTransparency = 0.6
	ContainerScroll.CanvasSize = UDim2.new(0, 0, 0, 0)

	UIListLayout.Parent = ContainerScroll
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 8)
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
	Title.TextSize = 15
	Title.TextWrapped = true
	Title.TextXAlignment = Enum.TextXAlignment.Left

	Minimize.Name = "Minimize"
	Minimize.Parent = Top
	Minimize.BackgroundTransparency = 1.000
	Minimize.Position = UDim2.new(0.85, 0, 0.2, 0)
	Minimize.Rotation = 90
	Minimize.Size = UDim2.new(0, 24, 0, 24)
	Minimize.ZIndex = 2
	Minimize.Image = "rbxassetid://4726772334"
	Minimize.ImageColor3 = Color3.fromRGB(200, 200, 200)

	local function UZVNGAL_fake_script()
		local script = Instance.new('Script', Minimize)

		script.Parent.MouseButton1Click:Connect(function()
			if script.Parent.Parent.ContainerScroll.Size == UDim2.new(1, 0, 0, 400) then 
				game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 270}):Play()
				game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.25), {ImageColor3 = Color3.fromRGB(150, 150, 150)}):Play()
				script.Parent.Parent.ContainerScroll:TweenSize(UDim2.new(1, 0, 0, 0), "Out", "Quad", 0.25, true)
				game:GetService("TweenService"):Create(Background, TweenInfo.new(0.25), {Size = UDim2.new(1, 0, 1, 0)}):Play()
				game:GetService("TweenService"):Create(Shadow, TweenInfo.new(0.25), {Size = UDim2.new(1, 30, 1, 30)}):Play()
			else
				game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 90}):Play()
				game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.25), {ImageColor3 = Color3.fromRGB(200, 200, 200)}):Play()
				script.Parent.Parent.ContainerScroll:TweenSize(UDim2.new(1, 0, 0, 400), "Out", "Quad", 0.25, true)
				game:GetService("TweenService"):Create(Background, TweenInfo.new(0.25), {Size = UDim2.new(1, 0, 1, 400)}):Play()
				game:GetService("TweenService"):Create(Shadow, TweenInfo.new(0.25), {Size = UDim2.new(1, 30, 1, 430)}):Play()
			end
		end)
	end
	coroutine.wrap(UZVNGAL_fake_script)()
	
	UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		ContainerScroll.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
	end)
	
	local Lib = {}
	
	function Lib:Button(name, callback)
		local ButtonContainer = Instance.new("Frame")
		local UICorner_btn = Instance.new("UICorner")
		local Button = Instance.new("TextButton")
		local ButtonName = Instance.new("TextLabel")
		
		ButtonContainer.Name = "ButtonContainer"
		ButtonContainer.Parent = ContainerScroll
		ButtonContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		ButtonContainer.BorderSizePixel = 0
		ButtonContainer.Size = UDim2.new(0.9, 0, 0, 36)
		
		UICorner_btn.CornerRadius = UDim.new(0, 6)
		UICorner_btn.Parent = ButtonContainer
		
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
		ButtonName.Font = Enum.Font.Gotham
		ButtonName.Text = name
		ButtonName.TextColor3 = Color3.fromRGB(220, 220, 220)
		ButtonName.TextSize = 13
		
		Button.MouseEnter:Connect(function()
			game:GetService("TweenService"):Create(ButtonContainer, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
		end)
		
		Button.MouseLeave:Connect(function()
			game:GetService("TweenService"):Create(ButtonContainer, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
		end)
		
		Button.MouseButton1Click:Connect(function()
			game:GetService("TweenService"):Create(ButtonContainer, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
			wait(0.1)
			game:GetService("TweenService"):Create(ButtonContainer, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
			callback()
		end)
		
		Button.TouchTap:Connect(function()
			game:GetService("TweenService"):Create(ButtonContainer, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
			wait(0.1)
			game:GetService("TweenService"):Create(ButtonContainer, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
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
		ToggleContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		ToggleContainer.BorderSizePixel = 0
		ToggleContainer.Size = UDim2.new(0.9, 0, 0, 36)
		
		UICorner_toggle.CornerRadius = UDim.new(0, 6)
		UICorner_toggle.Parent = ToggleContainer
		
		ToggleName.Name = "ToggleName"
		ToggleName.Parent = ToggleContainer
		ToggleName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ToggleName.BackgroundTransparency = 1.000
		ToggleName.Position = UDim2.new(0.05, 0, 0, 0)
		ToggleName.Size = UDim2.new(0.65, 0, 1, 0)
		ToggleName.Font = Enum.Font.Gotham
		ToggleName.Text = name
		ToggleName.TextColor3 = Color3.fromRGB(220, 220, 220)
		ToggleName.TextSize = 13
		ToggleName.TextXAlignment = Enum.TextXAlignment.Left
		
		Toggle.Name = "Toggle"
		Toggle.Parent = ToggleContainer
		Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
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
		ToggleIndicator.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
		ToggleIndicator.BorderSizePixel = 0
		ToggleIndicator.Position = UDim2.new(0.05, 0, 0.1, 0)
		ToggleIndicator.Size = UDim2.new(0, 16, 0, 16)
		
		UICorner_indicator.CornerRadius = UDim.new(1, 0)
		UICorner_indicator.Parent = ToggleIndicator
		
		local Toggled = false
		
		local function toggleState()
			Toggled = not Toggled
			if Toggled then
				game:GetService("TweenService"):Create(ToggleIndicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Position = UDim2.new(0.55, 0, 0.1, 0), BackgroundColor3 = Color3.fromRGB(0, 180, 255)}):Play()
				game:GetService("TweenService"):Create(Toggle, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(0, 100, 150)}):Play()
			else
				game:GetService("TweenService"):Create(ToggleIndicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Position = UDim2.new(0.05, 0, 0.1, 0), BackgroundColor3 = Color3.fromRGB(100, 100, 100)}):Play()
				game:GetService("TweenService"):Create(Toggle, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
			end
			callback(Toggled)
		end
		
		Toggle.MouseButton1Click:Connect(toggleState)
		Toggle.TouchTap:Connect(toggleState)
		
		ToggleContainer.MouseEnter:Connect(function()
			game:GetService("TweenService"):Create(ToggleContainer, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
		end)
		
		ToggleContainer.MouseLeave:Connect(function()
			game:GetService("TweenService"):Create(ToggleContainer, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
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
		SliderContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		SliderContainer.BorderSizePixel = 0
		SliderContainer.Size = UDim2.new(0.9, 0, 0, 48)
		
		UICorner_slider.CornerRadius = UDim.new(0, 6)
		UICorner_slider.Parent = SliderContainer
		
		SliderName.Name = "SliderName"
		SliderName.Parent = SliderContainer
		SliderName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SliderName.BackgroundTransparency = 1.000
		SliderName.Position = UDim2.new(0.05, 0, 0, 0)
		SliderName.Size = UDim2.new(0.6, 0, 0, 20)
		SliderName.Font = Enum.Font.Gotham
		SliderName.Text = name
		SliderName.TextColor3 = Color3.fromRGB(220, 220, 220)
		SliderName.TextSize = 13
		SliderName.TextXAlignment = Enum.TextXAlignment.Left
		
		SliderValue.Name = "SliderValue"
		SliderValue.Parent = SliderContainer
		SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SliderValue.BackgroundTransparency = 1.000
		SliderValue.Position = UDim2.new(0.7, 0, 0, 0)
		SliderValue.Size = UDim2.new(0.25, 0, 0, 20)
		SliderValue.Font = Enum.Font.Gotham
		SliderValue.Text = tostring(default)
		SliderValue.TextColor3 = Color3.fromRGB(180, 180, 180)
		SliderValue.TextSize = 13
		SliderValue.TextXAlignment = Enum.TextXAlignment.Right
		
		SliderTrack.Name = "SliderTrack"
		SliderTrack.Parent = SliderContainer
		SliderTrack.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		SliderTrack.BorderSizePixel = 0
		SliderTrack.Position = UDim2.new(0.05, 0, 0.6, 0)
		SliderTrack.Size = UDim2.new(0.9, 0, 0, 4)
		
		UICorner_track.CornerRadius = UDim.new(1, 0)
		UICorner_track.Parent = SliderTrack
		
		SliderFill.Name = "SliderFill"
		SliderFill.Parent = SliderTrack
		SliderFill.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
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
		
		local function startDragging(input)
			dragging = true
			game:GetService("TweenService"):Create(SliderButton, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 20, 0, 20)}):Play()
		end
		
		local function stopDragging()
			dragging = false
			game:GetService("TweenService"):Create(SliderButton, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 16, 0, 16)}):Play()
		end
		
		SliderButton.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				startDragging(input)
			end
		end)
		
		SliderButton.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				stopDragging()
			end
		end)
		
		game:GetService("UserInputService").InputChanged:Connect(function(input)
			if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
				updateSlider(input)
			end
		end)
		
		SliderTrack.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				updateSlider(input)
				startDragging(input)
			end
		end)
		
		SliderTrack.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				stopDragging()
			end
		end)
		
		SliderContainer.MouseEnter:Connect(function()
			game:GetService("TweenService"):Create(SliderContainer, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
		end)
		
		SliderContainer.MouseLeave:Connect(function()
			game:GetService("TweenService"):Create(SliderContainer, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
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
		DropdownContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		DropdownContainer.BorderSizePixel = 0
		DropdownContainer.Size = UDim2.new(0.9, 0, 0, 36)
		DropdownContainer.ClipsDescendants = false
		
		UICorner_dropdown.CornerRadius = UDim.new(0, 6)
		UICorner_dropdown.Parent = DropdownContainer
		
		DropdownName.Name = "DropdownName"
		DropdownName.Parent = DropdownContainer
		DropdownName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		DropdownName.BackgroundTransparency = 1.000
		DropdownName.Position = UDim2.new(0.05, 0, 0, 0)
		DropdownName.Size = UDim2.new(0.65, 0, 1, 0)
		DropdownName.Font = Enum.Font.Gotham
		DropdownName.Text = name
		DropdownName.TextColor3 = Color3.fromRGB(220, 220, 220)
		DropdownName.TextSize = 13
		DropdownName.TextXAlignment = Enum.TextXAlignment.Left
		
		DropdownButton.Name = "DropdownButton"
		DropdownButton.Parent = DropdownContainer
		DropdownButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
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
		DropdownSelected.TextSize = 11
		DropdownSelected.TextXAlignment = Enum.TextXAlignment.Left
		
		DropdownArrow.Name = "DropdownArrow"
		DropdownArrow.Parent = DropdownButton
		DropdownArrow.BackgroundTransparency = 1
		DropdownArrow.Position = UDim2.new(0.8, 0, 0.15, 0)
		DropdownArrow.Size = UDim2.new(0, 12, 0, 12)
		DropdownArrow.Image = "rbxassetid://153287088"
		DropdownArrow.ImageColor3 = Color3.fromRGB(200, 200, 200)
		DropdownArrow.Rotation = 90
		
		local DropdownList = Instance.new("Frame")
		local DropdownScroll = Instance.new("ScrollingFrame")
		local UIListLayout_list = Instance.new("UIListLayout")
		
		DropdownList.Name = "DropdownList"
		DropdownList.Parent = UiLib
		DropdownList.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		DropdownList.BorderSizePixel = 0
		DropdownList.Size = UDim2.new(0, DropdownButton.AbsoluteSize.X, 0, 0)
		DropdownList.Visible = false
		DropdownList.ZIndex = 20
		DropdownList.ClipsDescendants = true
		
		local DropdownShadow = Instance.new("ImageLabel")
		DropdownShadow.Name = "DropdownShadow"
		DropdownShadow.Parent = DropdownList
		DropdownShadow.BackgroundTransparency = 1
		DropdownShadow.Size = UDim2.new(1, 15, 1, 15)
		DropdownShadow.Position = UDim2.new(0, -8, 0, -8)
		DropdownShadow.Image = "rbxassetid://5554236805"
		DropdownShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
		DropdownShadow.ImageTransparency = 0.8
		DropdownShadow.ScaleType = Enum.ScaleType.Slice
		DropdownShadow.SliceCenter = Rect.new(23, 23, 277, 277)
		DropdownShadow.ZIndex = 19
		
		local UICorner_list = Instance.new("UICorner")
		UICorner_list.CornerRadius = UDim.new(0, 6)
		UICorner_list.Parent = DropdownList
		
		DropdownScroll.Name = "DropdownScroll"
		DropdownScroll.Parent = DropdownList
		DropdownScroll.Active = true
		DropdownScroll.BackgroundTransparency = 1
		DropdownScroll.BorderSizePixel = 0
		DropdownScroll.Size = UDim2.new(1, -6, 1, -6)
		DropdownScroll.Position = UDim2.new(0, 3, 0, 3)
		DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
		DropdownScroll.ScrollBarThickness = 3
		DropdownScroll.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
		DropdownScroll.ScrollBarImageTransparency = 0.3
		DropdownScroll.VerticalScrollBarInset = Enum.ScrollBarInset.Always
		DropdownScroll.ZIndex = 21
		
		UIListLayout_list.Parent = DropdownScroll
		UIListLayout_list.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_list.Padding = UDim.new(0, 3)
		
		local isOpen = false
		local selectedOption = nil
		
		local function updateListHeight()
			local itemCount = #options
			local height = math.min(itemCount * 28 + 6, 140)
			DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, itemCount * 28)
			return height
		end
		
		local function toggleDropdown()
			isOpen = not isOpen
			if isOpen then
				DropdownList.Visible = true
				DropdownList.Position = UDim2.new(
					0, DropdownButton.AbsolutePosition.X,
					0, DropdownButton.AbsolutePosition.Y + DropdownButton.AbsoluteSize.Y + 4
				)
				DropdownList.Size = UDim2.new(0, DropdownButton.AbsoluteSize.X, 0, 0)
				game:GetService("TweenService"):Create(DropdownArrow, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Rotation = 270}):Play()
				game:GetService("TweenService"):Create(DropdownButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
				DropdownList:TweenSize(
					UDim2.new(0, DropdownButton.AbsoluteSize.X, 0, updateListHeight()),
					"Out", "Quad", 0.2, true
				)
			else
				game:GetService("TweenService"):Create(DropdownArrow, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Rotation = 90}):Play()
				game:GetService("TweenService"):Create(DropdownButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
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
		DropdownButton.TouchTap:Connect(toggleDropdown)
		
		for i, option in ipairs(options) do
			local OptionButton = Instance.new("TextButton")
			local OptionText = Instance.new("TextLabel")
			
			OptionButton.Name = "Option_" .. option
			OptionButton.Parent = DropdownScroll
			OptionButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			OptionButton.BorderSizePixel = 0
			OptionButton.Size = UDim2.new(1, 0, 0, 26)
			OptionButton.Font = Enum.Font.SourceSans
			OptionButton.Text = ""
			OptionButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			OptionButton.TextSize = 14
			OptionButton.AutoButtonColor = false
			OptionButton.ZIndex = 22
			
			local UICorner_option = Instance.new("UICorner")
			UICorner_option.CornerRadius = UDim.new(0, 4)
			UICorner_option.Parent = OptionButton
			
			OptionText.Name = "OptionText"
			OptionText.Parent = OptionButton
			OptionText.BackgroundTransparency = 1
			OptionText.Size = UDim2.new(1, -8, 1, 0)
			OptionText.Position = UDim2.new(0, 4, 0, 0)
			OptionText.Font = Enum.Font.Gotham
			OptionText.Text = option
			OptionText.TextColor3 = Color3.fromRGB(220, 220, 220)
			OptionText.TextSize = 11
			OptionText.TextXAlignment = Enum.TextXAlignment.Left
			OptionText.ZIndex = 24
			
			OptionButton.MouseButton1Click:Connect(function()
				selectedOption = option
				DropdownSelected.Text = option
				toggleDropdown()
				callback(option)
			end)
			
			OptionButton.TouchTap:Connect(function()
				selectedOption = option
				DropdownSelected.Text = option
				toggleDropdown()
				callback(option)
			end)
			
			OptionButton.MouseEnter:Connect(function()
				game:GetService("TweenService"):Create(OptionButton, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
			end)
			
			OptionButton.MouseLeave:Connect(function()
				game:GetService("TweenService"):Create(OptionButton, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
			end)
		end
		
		updateListHeight()
		
		local connection
		connection = game:GetService("UserInputService").InputBegan:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and isOpen then
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
			game:GetService("TweenService"):Create(DropdownContainer, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
		end)
		
		DropdownContainer.MouseLeave:Connect(function()
			game:GetService("TweenService"):Create(DropdownContainer, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
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
		ColorpickerContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		ColorpickerContainer.BorderSizePixel = 0
		ColorpickerContainer.Size = UDim2.new(0.9, 0, 0, 36)
		
		UICorner_color.CornerRadius = UDim.new(0, 6)
		UICorner_color.Parent = ColorpickerContainer
		
		ColorpickerName.Name = "ColorpickerName"
		ColorpickerName.Parent = ColorpickerContainer
		ColorpickerName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ColorpickerName.BackgroundTransparency = 1.000
		ColorpickerName.Position = UDim2.new(0.05, 0, 0, 0)
		ColorpickerName.Size = UDim2.new(0.65, 0, 1, 0)
		ColorpickerName.Font = Enum.Font.Gotham
		ColorpickerName.Text = name
		ColorpickerName.TextColor3 = Color3.fromRGB(220, 220, 220)
		ColorpickerName.TextSize = 13
		ColorpickerName.TextXAlignment = Enum.TextXAlignment.Left
		
		ColorButton.Name = "ColorButton"
		ColorButton.Parent = ColorpickerContainer
		ColorButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
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
		ColorPreview.BackgroundColor3 = defaultColor or Color3.fromRGB(0, 180, 255)
		ColorPreview.BorderSizePixel = 0
		ColorPreview.Position = UDim2.new(0.1, 0, 0.1, 0)
		ColorPreview.Size = UDim2.new(0.8, 0, 0, 16)
		
		UICorner_preview.CornerRadius = UDim.new(0, 3)
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
			local RContainer = Instance.new("Frame")
			local RName = Instance.new("TextLabel")
			local RTrack = Instance.new("Frame")
			local RFill = Instance.new("Frame")
			local RButton = Instance.new("TextButton")
			local RValue = Instance.new("TextLabel")
			local GContainer = Instance.new("Frame")
			local GName = Instance.new("TextLabel")
			local GTrack = Instance.new("Frame")
			local GFill = Instance.new("Frame")
			local GButton = Instance.new("TextButton")
			local GValue = Instance.new("TextLabel")
			local BContainer = Instance.new("Frame")
			local BName = Instance.new("TextLabel")
			local BTrack = Instance.new("Frame")
			local BFill = Instance.new("Frame")
			local BButton = Instance.new("TextButton")
			local BValue = Instance.new("TextLabel")
			local ApplyButton = Instance.new("TextButton")
			
			local currentColor = ColorPreview.BackgroundColor3
			local r, g, b = math.floor(currentColor.r * 255), math.floor(currentColor.g * 255), math.floor(currentColor.b * 255)
			
			colorPickerFrame.Name = "ColorPickerFrame"
			colorPickerFrame.Parent = UiLib
			colorPickerFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			colorPickerFrame.BorderSizePixel = 0
			colorPickerFrame.Position = UDim2.new(0, 0, 0, 0)
			colorPickerFrame.Size = UDim2.new(0, 200, 0, 0)
			colorPickerFrame.ZIndex = 30
			colorPickerFrame.ClipsDescendants = true
			
			UICorner_frame.CornerRadius = UDim.new(0, 8)
			UICorner_frame.Parent = colorPickerFrame
			
			local colorPickerShadow = Instance.new("ImageLabel")
			colorPickerShadow.Name = "ColorPickerShadow"
			colorPickerShadow.Parent = colorPickerFrame
			colorPickerShadow.BackgroundTransparency = 1
			colorPickerShadow.Size = UDim2.new(1, 20, 1, 20)
			colorPickerShadow.Position = UDim2.new(0, -10, 0, -10)
			colorPickerShadow.Image = "rbxassetid://5554236805"
			colorPickerShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
			colorPickerShadow.ImageTransparency = 0.8
			colorPickerShadow.ScaleType = Enum.ScaleType.Slice
			colorPickerShadow.SliceCenter = Rect.new(23, 23, 277, 277)
			colorPickerShadow.ZIndex = 29
			
			ColorDisplay.Name = "ColorDisplay"
			ColorDisplay.Parent = colorPickerFrame
			ColorDisplay.BackgroundColor3 = currentColor
			ColorDisplay.BorderSizePixel = 0
			ColorDisplay.Position = UDim2.new(0.05, 0, 0.05, 0)
			ColorDisplay.Size = UDim2.new(0.9, 0, 0, 40)
			
			UICorner_display.CornerRadius = UDim.new(0, 6)
			UICorner_display.Parent = ColorDisplay
			
			local function createRGBSlider(name, yPos, value, color)
				local container = Instance.new("Frame")
				local nameLabel = Instance.new("TextLabel")
				local track = Instance.new("Frame")
				local fill = Instance.new("Frame")
				local button = Instance.new("TextButton")
				local valueLabel = Instance.new("TextLabel")
				
				container.Name = name .. "Container"
				container.Parent = colorPickerFrame
				container.BackgroundTransparency = 1
				container.Position = UDim2.new(0.05, 0, yPos, 0)
				container.Size = UDim2.new(0.9, 0, 0, 30)
				
				nameLabel.Name = name .. "Name"
				nameLabel.Parent = container
				nameLabel.BackgroundTransparency = 1
				nameLabel.Position = UDim2.new(0, 0, 0, 0)
				nameLabel.Size = UDim2.new(0.2, 0, 1, 0)
				nameLabel.Font = Enum.Font.Gotham
				nameLabel.Text = name
				nameLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
				nameLabel.TextSize = 12
				nameLabel.TextXAlignment = Enum.TextXAlignment.Left
				
				track.Name = name .. "Track"
				track.Parent = container
				track.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
				track.BorderSizePixel = 0
				track.Position = UDim2.new(0.25, 0, 0.5, 0)
				track.Size = UDim2.new(0.5, 0, 0, 4)
				
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
				button.Position = UDim2.new(value / 255, -6, 0, -5)
				button.Size = UDim2.new(0, 14, 0, 14)
				button.Font = Enum.Font.SourceSans
				button.Text = ""
				button.TextColor3 = Color3.fromRGB(0, 0, 0)
				button.TextSize = 14
				button.AutoButtonColor = false
				
				local buttonCorner = Instance.new("UICorner")
				buttonCorner.CornerRadius = UDim.new(1, 0)
				buttonCorner.Parent = button
				
				valueLabel.Name = name .. "Value"
				valueLabel.Parent = container
				valueLabel.BackgroundTransparency = 1
				valueLabel.Position = UDim2.new(0.8, 0, 0, 0)
				valueLabel.Size = UDim2.new(0.2, 0, 1, 0)
				valueLabel.Font = Enum.Font.Gotham
				valueLabel.Text = tostring(value)
				valueLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
				valueLabel.TextSize = 12
				valueLabel.TextXAlignment = Enum.TextXAlignment.Right
				
				return {container = container, track = track, fill = fill, button = button, value = valueLabel}
			end
			
			local rData = createRGBSlider("R", 0.25, r, Color3.fromRGB(255, 50, 50))
			local gData = createRGBSlider("G", 0.4, g, Color3.fromRGB(50, 255, 50))
			local bData = createRGBSlider("B", 0.55, b, Color3.fromRGB(50, 50, 255))
			
			ApplyButton.Name = "ApplyButton"
			ApplyButton.Parent = colorPickerFrame
			ApplyButton.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
			ApplyButton.BorderSizePixel = 0
			ApplyButton.Position = UDim2.new(0.05, 0, 0.75, 0)
			ApplyButton.Size = UDim2.new(0.9, 0, 0, 30)
			ApplyButton.Font = Enum.Font.GothamSemibold
			ApplyButton.Text = "Apply"
			ApplyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			ApplyButton.TextSize = 13
			ApplyButton.AutoButtonColor = false
			
			local applyCorner = Instance.new("UICorner")
			applyCorner.CornerRadius = UDim.new(0, 6)
			applyCorner.Parent = ApplyButton
			
			local function updateColor()
				currentColor = Color3.fromRGB(r, g, b)
				ColorDisplay.BackgroundColor3 = currentColor
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
					data.button.Position = UDim2.new(pos.X.Scale, -6, 0, -5)
					data.value.Text = tostring(value)
					
					if isR then r = value
					elseif isG then g = value
					elseif isB then b = value end
					
					updateColor()
				end
				
				local function startDragging(input)
					dragging = true
					game:GetService("TweenService"):Create(data.button, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 18, 0, 18)}):Play()
				end
				
				local function stopDragging()
					dragging = false
					game:GetService("TweenService"):Create(data.button, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 14, 0, 14)}):Play()
				end
				
				data.button.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						startDragging(input)
					end
				end)
				
				data.button.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						stopDragging()
					end
				end)
				
				data.track.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						updateSlider(input)
						startDragging(input)
					end
				end)
				
				data.track.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						stopDragging()
					end
				end)
				
				game:GetService("UserInputService").InputChanged:Connect(function(input)
					if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
						updateSlider(input)
					end
				end)
			end
			
			createSliderLogic(rData, Color3.fromRGB(255, 50, 50), true, false, false)
			createSliderLogic(gData, Color3.fromRGB(50, 255, 50), false, true, false)
			createSliderLogic(bData, Color3.fromRGB(50, 50, 255), false, false, true)
			
			ApplyButton.MouseButton1Click:Connect(function()
				callback(currentColor)
				ColorPreview.BackgroundColor3 = currentColor
				colorPickerFrame:TweenSize(UDim2.new(0, 200, 0, 0), "Out", "Quad", 0.2, true, function()
					colorPickerFrame:Destroy()
					colorPickerFrame = nil
				end)
			end)
			
			ApplyButton.TouchTap:Connect(function()
				callback(currentColor)
				ColorPreview.BackgroundColor3 = currentColor
				colorPickerFrame:TweenSize(UDim2.new(0, 200, 0, 0), "Out", "Quad", 0.2, true, function()
					colorPickerFrame:Destroy()
					colorPickerFrame = nil
				end)
			end)
			
			ApplyButton.MouseEnter:Connect(function()
				game:GetService("TweenService"):Create(ApplyButton, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(0, 160, 235)}):Play()
			end)
			
			ApplyButton.MouseLeave:Connect(function()
				game:GetService("TweenService"):Create(ApplyButton, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(0, 180, 255)}):Play()
			end)
			
			colorPickerFrame:TweenSize(UDim2.new(0, 200, 0, 180), "Out", "Quad", 0.2, true)
			
			local closeConnection
			closeConnection = game:GetService("UserInputService").InputBegan:Connect(function(input)
				if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and colorPickerFrame then
					local mousePos = game:GetService("UserInputService"):GetMouseLocation()
					local framePos = colorPickerFrame.AbsolutePosition
					local frameSize = colorPickerFrame.AbsoluteSize
					
					if not (mousePos.X >= framePos.X and mousePos.X <= framePos.X + frameSize.X and
						   mousePos.Y >= framePos.Y and mousePos.Y <= framePos.Y + frameSize.Y) then
						colorPickerFrame:TweenSize(UDim2.new(0, 200, 0, 0), "Out", "Quad", 0.2, true, function()
							colorPickerFrame:Destroy()
							colorPickerFrame = nil
							if closeConnection then
								closeConnection:Disconnect()
							end
						end)
					end
				end
			end)
			
			local buttonPos = ColorButton.AbsolutePosition
			local buttonSize = ColorButton.AbsoluteSize
			local screenSize = game:GetService("Workspace").CurrentCamera.ViewportSize
			
			local rightSpace = screenSize.X - (buttonPos.X + buttonSize.X)
			local leftSpace = buttonPos.X
			
			if rightSpace > 210 then
				colorPickerFrame.Position = UDim2.new(0, buttonPos.X + buttonSize.X + 10, 0, buttonPos.Y)
			elseif leftSpace > 210 then
				colorPickerFrame.Position = UDim2.new(0, buttonPos.X - 210, 0, buttonPos.Y)
			else
				colorPickerFrame.Position = UDim2.new(0, buttonPos.X, 0, buttonPos.Y + buttonSize.Y + 10)
			end
		end
		
		ColorButton.MouseButton1Click:Connect(showColorPicker)
		ColorButton.TouchTap:Connect(showColorPicker)
		
		ColorpickerContainer.MouseEnter:Connect(function()
			game:GetService("TweenService"):Create(ColorpickerContainer, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
		end)
		
		ColorpickerContainer.MouseLeave:Connect(function()
			game:GetService("TweenService"):Create(ColorpickerContainer, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
		end)
	end
	
	function Lib:Textbox(name, placeholder, callback)
		local TextboxContainer = Instance.new("Frame")
		local UICorner_textbox = Instance.new("UICorner")
		local TextboxName = Instance.new("TextLabel")
		local TextboxInput = Instance.new("TextBox")
		local UICorner_input = Instance.new("UICorner")
		
		TextboxContainer.Name = "TextboxContainer"
		TextboxContainer.Parent = ContainerScroll
		TextboxContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		TextboxContainer.BorderSizePixel = 0
		TextboxContainer.Size = UDim2.new(0.9, 0, 0, 56)
		
		UICorner_textbox.CornerRadius = UDim.new(0, 6)
		UICorner_textbox.Parent = TextboxContainer
		
		TextboxName.Name = "TextboxName"
		TextboxName.Parent = TextboxContainer
		TextboxName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextboxName.BackgroundTransparency = 1.000
		TextboxName.Position = UDim2.new(0.05, 0, 0, 0)
		TextboxName.Size = UDim2.new(0.9, 0, 0, 20)
		TextboxName.Font = Enum.Font.Gotham
		TextboxName.Text = name
		TextboxName.TextColor3 = Color3.fromRGB(220, 220, 220)
		TextboxName.TextSize = 13
		TextboxName.TextXAlignment = Enum.TextXAlignment.Left
		
		TextboxInput.Name = "TextboxInput"
		TextboxInput.Parent = TextboxContainer
		TextboxInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		TextboxInput.BorderSizePixel = 0
		TextboxInput.Position = UDim2.new(0.05, 0, 0.45, 0)
		TextboxInput.Size = UDim2.new(0.9, 0, 0, 28)
		TextboxInput.Font = Enum.Font.Gotham
		TextboxInput.PlaceholderText = placeholder or "Enter text..."
		TextboxInput.Text = ""
		TextboxInput.TextColor3 = Color3.fromRGB(220, 220, 220)
		TextboxInput.TextSize = 12
		TextboxInput.ClearTextOnFocus = false
		TextboxInput.TextTruncate = Enum.TextTruncate.AtEnd
		
		UICorner_input.CornerRadius = UDim.new(0, 4)
		UICorner_input.Parent = TextboxInput
		
		local TextPadding = Instance.new("UIPadding")
		TextPadding.Parent = TextboxInput
		TextPadding.PaddingLeft = UDim.new(0, 8)
		TextPadding.PaddingRight = UDim.new(0, 8)
		
		TextboxInput.Focused:Connect(function()
			game:GetService("TweenService"):Create(TextboxInput, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
		end)
		
		TextboxInput.FocusLost:Connect(function(enterPressed)
			game:GetService("TweenService"):Create(TextboxInput, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
			if enterPressed then
				callback(TextboxInput.Text)
			end
		end)
		
		TextboxContainer.MouseEnter:Connect(function()
			game:GetService("TweenService"):Create(TextboxContainer, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
		end)
		
		TextboxContainer.MouseLeave:Connect(function()
			game:GetService("TweenService"):Create(TextboxContainer, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
		end)
	end
	
	function Lib:Label(text)
		local LabelContainer = Instance.new("Frame")
		local UICorner_label = Instance.new("UICorner")
		local LabelText = Instance.new("TextLabel")
		
		LabelContainer.Name = "LabelContainer"
		LabelContainer.Parent = ContainerScroll
		LabelContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		LabelContainer.BackgroundTransparency = 0
		LabelContainer.Size = UDim2.new(0.9, 0, 0, 32)
		
		UICorner_label.CornerRadius = UDim.new(0, 6)
		UICorner_label.Parent = LabelContainer
		
		LabelText.Name = "LabelText"
		LabelText.Parent = LabelContainer
		LabelText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		LabelText.BackgroundTransparency = 1.000
		LabelText.Size = UDim2.new(1, -10, 1, 0)
		LabelText.Position = UDim2.new(0, 5, 0, 0)
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
		SeparatorContainer.Parent = ContainerScroll
		SeparatorContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SeparatorContainer.BackgroundTransparency = 1
		SeparatorContainer.Size = UDim2.new(0.9, 0, 0, 10)
		
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
