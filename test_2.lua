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
		
		ButtonName.Name = "Button"
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
		
		local DropdownList = Instance.new("ScrollingFrame")
		local UIListLayout_list = Instance.new("UIListLayout")
		
		DropdownList.Name = "DropdownList"
		DropdownList.Parent = UiLib
		DropdownList.Active = true
		DropdownList.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
		DropdownList.BorderSizePixel = 0
		DropdownList.Size = UDim2.new(0, DropdownButton.AbsoluteSize.X, 0, 0)
		DropdownList.CanvasSize = UDim2.new(0, 0, 0, 0)
		DropdownList.ScrollBarThickness = 3
		DropdownList.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
		DropdownList.Visible = false
		DropdownList.ZIndex = 10
		DropdownList.ClipsDescendants = true
		
		local UICorner_list = Instance.new("UICorner")
		UICorner_list.CornerRadius = UDim.new(0, 6)
		UICorner_list.Parent = DropdownList
		
		UIListLayout_list.Parent = DropdownList
		UIListLayout_list.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_list.Padding = UDim.new(0, 2)
		
		local isOpen = false
		local selectedOption = nil
		
		local function updateListHeight()
			local itemCount = #options
			local height = math.min(itemCount * 30, 150)
			DropdownList.CanvasSize = UDim2.new(0, 0, 0, itemCount * 30)
			return height
		end
		
		local function toggleDropdown()
			isOpen = not isOpen
			if isOpen then
				DropdownList.Visible = true
				DropdownList.Position = UDim2.new(0, DropdownButton.AbsolutePosition.X, 0, DropdownButton.AbsolutePosition.Y + DropdownButton.AbsoluteSize.Y)
				DropdownList.Size = UDim2.new(0, DropdownButton.AbsoluteSize.X, 0, 0)
				game:GetService("TweenService"):Create(DropdownArrow, TweenInfo.new(0.2), {Rotation = 180}):Play()
				game:GetService("TweenService"):Create(DropdownButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
				DropdownList:TweenSize(UDim2.new(0, DropdownButton.AbsoluteSize.X, 0, updateListHeight()), "Out", "Sine", 0.2)
			else
				game:GetService("TweenService"):Create(DropdownArrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
				game:GetService("TweenService"):Create(DropdownButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
				DropdownList:TweenSize(UDim2.new(0, DropdownButton.AbsoluteSize.X, 0, 0), "Out", "Sine", 0.2, true, function()
					DropdownList.Visible = false
				end)
			end
		end
		
		DropdownButton.MouseButton1Click:Connect(toggleDropdown)
		
		for i, option in ipairs(options) do
			local OptionButton = Instance.new("TextButton")
			OptionButton.Name = "Option_" .. option
			OptionButton.Parent = DropdownList
			OptionButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			OptionButton.BorderSizePixel = 0
			OptionButton.Size = UDim2.new(1, -10, 0, 30)
			OptionButton.Position = UDim2.new(0.05, 0, 0, (i-1)*30)
			OptionButton.Font = Enum.Font.Gotham
			OptionButton.Text = option
			OptionButton.TextColor3 = Color3.fromRGB(200, 200, 200)
			OptionButton.TextSize = 12
			OptionButton.AutoButtonColor = false
			OptionButton.ZIndex = 11
			
			local UICorner_option = Instance.new("UICorner")
			UICorner_option.CornerRadius = UDim.new(0, 4)
			UICorner_option.Parent = OptionButton
			
			OptionButton.MouseButton1Click:Connect(function()
				selectedOption = option
				DropdownSelected.Text = option
				toggleDropdown()
				callback(option)
			end)
			
			OptionButton.MouseEnter:Connect(function()
				game:GetService("TweenService"):Create(OptionButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
			end)
			
			OptionButton.MouseLeave:Connect(function()
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
		
		local function showColorPicker()
			if colorPickerFrame then
				colorPickerFrame:Destroy()
			end
			
			colorPickerFrame = Instance.new("Frame")
			local UICorner_frame = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local SaturationValuePicker = Instance.new("Frame")
			local SaturationValueImage = Instance.new("ImageLabel")
			local SVSelector = Instance.new("Frame")
			local UICorner_selector = Instance.new("UICorner")
			local HueSlider = Instance.new("Frame")
			local UICorner_hue = Instance.new("UICorner")
			local HueButton = Instance.new("TextButton")
			local UICorner_huebtn = Instance.new("UICorner")
			local RGBInputs = Instance.new("Frame")
			local RLabel = Instance.new("TextLabel")
			local RBox = Instance.new("TextBox")
			local GLabel = Instance.new("TextLabel")
			local GBox = Instance.new("TextBox")
			local BLabel = Instance.new("TextLabel")
			local BBox = Instance.new("TextBox")
			local ApplyButton = Instance.new("TextButton")
			local ApplyText = Instance.new("TextLabel")
			local CloseButton = Instance.new("TextButton")
			local CloseText = Instance.new("TextLabel")
			
			local currentColor = ColorPreview.BackgroundColor3
			local h, s, v = currentColor:ToHSV()
			
			colorPickerFrame.Name = "ColorPickerFrame"
			colorPickerFrame.Parent = UiLib
			colorPickerFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			colorPickerFrame.BorderSizePixel = 0
			colorPickerFrame.Position = UDim2.new(0.4, 0, 0.4, 0)
			colorPickerFrame.Size = UDim2.new(0, 300, 0, 250)
			colorPickerFrame.Active = true
			colorPickerFrame.Draggable = true
			
			UICorner_frame.CornerRadius = UDim.new(0, 8)
			UICorner_frame.Parent = colorPickerFrame
			
			Title.Name = "Title"
			Title.Parent = colorPickerFrame
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.Position = UDim2.new(0.05, 0, 0.02, 0)
			Title.Size = UDim2.new(0.9, 0, 0, 25)
			Title.Font = Enum.Font.GothamMedium
			Title.Text = "Color Picker"
			Title.TextColor3 = Color3.fromRGB(220, 220, 220)
			Title.TextSize = 16
			
			SaturationValuePicker.Name = "SaturationValuePicker"
			SaturationValuePicker.Parent = colorPickerFrame
			SaturationValuePicker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SaturationValuePicker.BorderSizePixel = 0
			SaturationValuePicker.Position = UDim2.new(0.05, 0, 0.15, 0)
			SaturationValuePicker.Size = UDim2.new(0, 200, 0, 120)
			
			local hueColor = Color3.fromHSV(h, 1, 1)
			SaturationValueImage.Name = "SaturationValueImage"
			SaturationValueImage.Parent = SaturationValuePicker
			SaturationValueImage.BackgroundColor3 = hueColor
			SaturationValueImage.Size = UDim2.new(1, 0, 1, 0)
			SaturationValueImage.Image = "rbxassetid://4155801252"
			
			SVSelector.Name = "SVSelector"
			SVSelector.Parent = SaturationValuePicker
			SVSelector.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SVSelector.BorderSizePixel = 2
			SVSelector.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SVSelector.Position = UDim2.new(s, -5, 1-v, -5)
			SVSelector.Size = UDim2.new(0, 10, 0, 10)
			SVSelector.ZIndex = 2
			
			UICorner_selector.CornerRadius = UDim.new(1, 0)
			UICorner_selector.Parent = SVSelector
			
			HueSlider.Name = "HueSlider"
			HueSlider.Parent = colorPickerFrame
			HueSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			HueSlider.BorderSizePixel = 0
			HueSlider.Position = UDim2.new(0.75, 0, 0.15, 0)
			HueSlider.Size = UDim2.new(0, 20, 0, 120)
			
			UICorner_hue.CornerRadius = UDim.new(0, 4)
			UICorner_hue.Parent = HueSlider
			
			local hueGradient = Instance.new("UIGradient")
			hueGradient.Parent = HueSlider
			hueGradient.Color = ColorSequence.new{
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
			HueButton.Position = UDim2.new(0, -3, 1-h, -5)
			HueButton.Size = UDim2.new(0, 26, 0, 10)
			HueButton.Font = Enum.Font.SourceSans
			HueButton.Text = ""
			HueButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			HueButton.TextSize = 14.000
			HueButton.AutoButtonColor = false
			
			UICorner_huebtn.CornerRadius = UDim.new(0, 2)
			UICorner_huebtn.Parent = HueButton
			
			RGBInputs.Name = "RGBInputs"
			RGBInputs.Parent = colorPickerFrame
			RGBInputs.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			RGBInputs.BackgroundTransparency = 1
			RGBInputs.Position = UDim2.new(0.05, 0, 0.7, 0)
			RGBInputs.Size = UDim2.new(0, 200, 0, 60)
			
			RLabel.Name = "RLabel"
			RLabel.Parent = RGBInputs
			RLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			RLabel.BackgroundTransparency = 1
			RLabel.Position = UDim2.new(0, 0, 0, 0)
			RLabel.Size = UDim2.new(0, 20, 0, 20)
			RLabel.Font = Enum.Font.GothamMedium
			RLabel.Text = "R:"
			RLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
			RLabel.TextSize = 14
			RLabel.TextXAlignment = Enum.TextXAlignment.Left
			
			RBox.Name = "RBox"
			RBox.Parent = RGBInputs
			RBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			RBox.BorderSizePixel = 0
			RBox.Position = UDim2.new(0.15, 0, 0, 0)
			RBox.Size = UDim2.new(0, 50, 0, 20)
			RBox.Font = Enum.Font.Gotham
			RBox.Text = tostring(math.floor(currentColor.r * 255))
			RBox.TextColor3 = Color3.fromRGB(220, 220, 220)
			RBox.TextSize = 14
			RBox.ClearTextOnFocus = false
			
			local UICorner_r = Instance.new("UICorner")
			UICorner_r.CornerRadius = UDim.new(0, 4)
			UICorner_r.Parent = RBox
			
			GLabel.Name = "GLabel"
			GLabel.Parent = RGBInputs
			GLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			GLabel.BackgroundTransparency = 1
			GLabel.Position = UDim2.new(0.5, 0, 0, 0)
			GLabel.Size = UDim2.new(0, 20, 0, 20)
			GLabel.Font = Enum.Font.GothamMedium
			GLabel.Text = "G:"
			GLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
			GLabel.TextSize = 14
			GLabel.TextXAlignment = Enum.TextXAlignment.Left
			
			GBox.Name = "GBox"
			GBox.Parent = RGBInputs
			GBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			GBox.BorderSizePixel = 0
			GBox.Position = UDim2.new(0.65, 0, 0, 0)
			GBox.Size = UDim2.new(0, 50, 0, 20)
			GBox.Font = Enum.Font.Gotham
			GBox.Text = tostring(math.floor(currentColor.g * 255))
			GBox.TextColor3 = Color3.fromRGB(220, 220, 220)
			GBox.TextSize = 14
			GBox.ClearTextOnFocus = false
			
			local UICorner_g = Instance.new("UICorner")
			UICorner_g.CornerRadius = UDim.new(0, 4)
			UICorner_g.Parent = GBox
			
			BLabel.Name = "BLabel"
			BLabel.Parent = RGBInputs
			BLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			BLabel.BackgroundTransparency = 1
			BLabel.Position = UDim2.new(0, 0, 0.5, 0)
			BLabel.Size = UDim2.new(0, 20, 0, 20)
			BLabel.Font = Enum.Font.GothamMedium
			BLabel.Text = "B:"
			BLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
			BLabel.TextSize = 14
			BLabel.TextXAlignment = Enum.TextXAlignment.Left
			
			BBox.Name = "BBox"
			BBox.Parent = RGBInputs
			BBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			BBox.BorderSizePixel = 0
			BBox.Position = UDim2.new(0.15, 0, 0.5, 0)
			BBox.Size = UDim2.new(0, 50, 0, 20)
			BBox.Font = Enum.Font.Gotham
			BBox.Text = tostring(math.floor(currentColor.b * 255))
			BBox.TextColor3 = Color3.fromRGB(220, 220, 220)
			BBox.TextSize = 14
			BBox.ClearTextOnFocus = false
			
			local UICorner_b = Instance.new("UICorner")
			UICorner_b.CornerRadius = UDim.new(0, 4)
			UICorner_b.Parent = BBox
			
			ApplyButton.Name = "ApplyButton"
			ApplyButton.Parent = colorPickerFrame
			ApplyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
			ApplyButton.BorderSizePixel = 0
			ApplyButton.Position = UDim2.new(0.75, 0, 0.7, 0)
			ApplyButton.Size = UDim2.new(0, 60, 0, 25)
			ApplyButton.Font = Enum.Font.GothamMedium
			ApplyButton.Text = ""
			ApplyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			ApplyButton.TextSize = 14
			
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
			
			CloseButton.Name = "CloseButton"
			CloseButton.Parent = colorPickerFrame
			CloseButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			CloseButton.BorderSizePixel = 0
			CloseButton.Position = UDim2.new(0.75, 0, 0.85, 0)
			CloseButton.Size = UDim2.new(0, 60, 0, 25)
			CloseButton.Font = Enum.Font.GothamMedium
			CloseButton.Text = ""
			CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			CloseButton.TextSize = 14
			
			local UICorner_close = Instance.new("UICorner")
			UICorner_close.CornerRadius = UDim.new(0, 4)
			UICorner_close.Parent = CloseButton
			
			CloseText.Name = "CloseText"
			CloseText.Parent = CloseButton
			CloseText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			CloseText.BackgroundTransparency = 1.000
			CloseText.Size = UDim2.new(1, 0, 1, 0)
			CloseText.Font = Enum.Font.GothamMedium
			CloseText.Text = "Close"
			CloseText.TextColor3 = Color3.fromRGB(220, 220, 220)
			CloseText.TextSize = 14
			
			local draggingHue = false
			local draggingSV = false
			
			local function updateColorFromHSV()
				currentColor = Color3.fromHSV(h, s, v)
				ColorPreview.BackgroundColor3 = currentColor
				SaturationValueImage.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
				
				RBox.Text = tostring(math.floor(currentColor.r * 255))
				GBox.Text = tostring(math.floor(currentColor.g * 255))
				BBox.Text = tostring(math.floor(currentColor.b * 255))
			end
			
			local function updateColorFromRGB()
				local r = math.clamp(tonumber(RBox.Text) or 0, 0, 255) / 255
				local g = math.clamp(tonumber(GBox.Text) or 0, 0, 255) / 255
				local b = math.clamp(tonumber(BBox.Text) or 0, 0, 255) / 255
				
				currentColor = Color3.new(r, g, b)
				h, s, v = currentColor:ToHSV()
				
				HueButton.Position = UDim2.new(0, -3, 1-h, -5)
				SVSelector.Position = UDim2.new(s, -5, 1-v, -5)
				SaturationValueImage.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
				ColorPreview.BackgroundColor3 = currentColor
			end
			
			local function updateHue(input)
				local pos = math.clamp((input.Position.Y - HueSlider.AbsolutePosition.Y) / HueSlider.AbsoluteSize.Y, 0, 1)
				h = 1 - pos
				HueButton.Position = UDim2.new(0, -3, pos, -5)
				updateColorFromHSV()
			end
			
			local function updateSaturationValue(input)
				local x = math.clamp((input.Position.X - SaturationValuePicker.AbsolutePosition.X) / SaturationValuePicker.AbsoluteSize.X, 0, 1)
				local y = math.clamp((input.Position.Y - SaturationValuePicker.AbsolutePosition.Y) / SaturationValuePicker.AbsoluteSize.Y, 0, 1)
				s = x
				v = 1 - y
				SVSelector.Position = UDim2.new(x, -5, y, -5)
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
			
			SVSelector.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					draggingSV = true
				end
			end)
			
			SVSelector.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					draggingSV = false
				end
			end)
			
			SaturationValuePicker.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					updateSaturationValue(input)
					draggingSV = true
				end
			end)
			
			SaturationValuePicker.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					draggingSV = false
				end
			end)
			
			game:GetService("UserInputService").InputChanged:Connect(function(input)
				if draggingHue and input.UserInputType == Enum.UserInputType.MouseMovement then
					updateHue(input)
				elseif draggingSV and input.UserInputType == Enum.UserInputType.MouseMovement then
					updateSaturationValue(input)
				end
			end)
			
			RBox.FocusLost:Connect(function()
				updateColorFromRGB()
			end)
			
			GBox.FocusLost:Connect(function()
				updateColorFromRGB()
			end)
			
			BBox.FocusLost:Connect(function()
				updateColorFromRGB()
			end)
			
			ApplyButton.MouseButton1Click:Connect(function()
				callback(currentColor)
				colorPickerFrame:Destroy()
				colorPickerFrame = nil
			end)
			
			CloseButton.MouseButton1Click:Connect(function()
				colorPickerFrame:Destroy()
				colorPickerFrame = nil
			end)
			
			updateColorFromHSV()
		end
		
		ColorButton.MouseButton1Click:Connect(showColorPicker)
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
