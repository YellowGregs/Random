for i,v in pairs(game.CoreGui:GetChildren()) do
	if v.Name == "UiLib" then
		v:Destroy()
	end
end

local UiLib = Instance.new("ScreenGui")
UiLib.Name = "UiLib"
UiLib.Parent = game.CoreGui
UiLib.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

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
	local Line = Instance.new("Frame")
	local Title = Instance.new("TextLabel")
	local Minimize = Instance.new("ImageButton")

	Top.Name = "Top"
	Top.Parent = UiLib
	Top.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	Top.BorderSizePixel = 0
	Top.Position = UDim2.new(0, getNextWindowPos(), 0.01, 0)
	Top.Size = UDim2.new(0, 240, 0, 32)
	Top.Active = true
	Top.Draggable = true

	UICorner.CornerRadius = UDim.new(0, 6)
	UICorner.Parent = Top

	Container.Name = "Container"
	Container.Parent = Top
	Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Container.BackgroundTransparency = 1.000
	Container.ClipsDescendants = true
	Container.Position = UDim2.new(0, 0, 1, 0)
	Container.Size = UDim2.new(0, 240, 0, 400)

	UIListLayout_2.Parent = Container
	UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_2.Padding = UDim.new(0, 5)

	Line.Name = "Line"
	Line.Parent = Top
	Line.BackgroundColor3 = Color3.fromRGB(0, 255, 102)
	Line.BorderSizePixel = 0
	Line.Position = UDim2.new(0, 0, 0.9, 0)
	Line.Size = UDim2.new(0, 240, 0, 2)

	Title.Name = "Title"
	Title.Parent = Top
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.Position = UDim2.new(0.05, 0, 0.1, 0)
	Title.Size = UDim2.new(0, 200, 0, 24)
	Title.Font = Enum.Font.GothamSemibold
	Title.Text = title
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextScaled = true
	Title.TextSize = 14.000
	Title.TextWrapped = true
	Title.TextXAlignment = Enum.TextXAlignment.Left

	Minimize.Name = "Minimize"
	Minimize.Parent = Top
	Minimize.BackgroundTransparency = 1.000
	Minimize.Position = UDim2.new(0.85, 0, 0.1, 0)
	Minimize.Rotation = 90.000
	Minimize.Size = UDim2.new(0, 24, 0, 24)
	Minimize.ZIndex = 2
	Minimize.Image = "rbxassetid://3926307971"
	Minimize.ImageColor3 = Color3.fromRGB(0, 255, 102)
	Minimize.ImageRectOffset = Vector2.new(764, 244)
	Minimize.ImageRectSize = Vector2.new(36, 36)

	local function UZVNGAL_fake_script()
		local script = Instance.new('Script', Minimize)

		script.Parent.MouseButton1Click:Connect(function()
			if script.Parent.Parent.Container.Size == UDim2.new(0, 240, 0, 400) then 
				game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 180}):Play();
				game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.25), {ImageColor3 = Color3.fromRGB(255, 50, 50)}):Play()
				script.Parent.Parent.Container:TweenSize(UDim2.new(0, 240, 0, 0), "InOut", "Sine", 0.25, true)
				wait(0.25)
				script.Parent.Parent.Line.Visible = false
			else
				game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 90}):Play();
				game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.25), {ImageColor3 = Color3.fromRGB(0, 255, 102)}):Play()
				script.Parent.Parent.Container:TweenSize(UDim2.new(0, 240, 0, 400), "InOut", "Sine", 0.2, true)
				script.Parent.Parent.Line.Visible = true
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
		
		ButtonContainer.Name = "ButtonContainer"
		ButtonContainer.Parent = Container
		ButtonContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		ButtonContainer.BorderSizePixel = 0
		ButtonContainer.Size = UDim2.new(0, 220, 0, 32)
		
		UICorner_btn.CornerRadius = UDim.new(0, 4)
		UICorner_btn.Parent = ButtonContainer
		
		Button.Name = "Button"
		Button.Parent = ButtonContainer
		Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		Button.BackgroundTransparency = 0.5
		Button.Size = UDim2.new(0, 220, 0, 32)
		Button.Font = Enum.Font.SourceSans
		Button.Text = ""
		Button.TextColor3 = Color3.fromRGB(0, 0, 0)
		Button.TextSize = 14.000
		Button.AutoButtonColor = false
		
		local UICorner_btn2 = Instance.new("UICorner")
		UICorner_btn2.CornerRadius = UDim.new(0, 4)
		UICorner_btn2.Parent = Button
		
		ButtonName.Name = "ButtonName"
		ButtonName.Parent = Button
		ButtonName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ButtonName.BackgroundTransparency = 1.000
		ButtonName.Size = UDim2.new(0, 220, 0, 32)
		ButtonName.ZIndex = 3
		ButtonName.Font = Enum.Font.GothamSemibold
		ButtonName.Text = name
		ButtonName.TextColor3 = Color3.fromRGB(255, 255, 255)
		ButtonName.TextSize = 14.000
		
		Button.MouseButton1Click:Connect(function()
			game:GetService("TweenService"):Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(0, 255, 102)}):Play()
			wait(0.1)
			game:GetService("TweenService"):Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
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
		ToggleContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		ToggleContainer.BorderSizePixel = 0
		ToggleContainer.Size = UDim2.new(0, 220, 0, 32)
		
		UICorner_toggle.CornerRadius = UDim.new(0, 4)
		UICorner_toggle.Parent = ToggleContainer
		
		ToggleName.Name = "ToggleName"
		ToggleName.Parent = ToggleContainer
		ToggleName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ToggleName.BackgroundTransparency = 1.000
		ToggleName.Position = UDim2.new(0.05, 0, 0, 0)
		ToggleName.Size = UDim2.new(0, 140, 0, 32)
		ToggleName.Font = Enum.Font.GothamSemibold
		ToggleName.Text = name
		ToggleName.TextColor3 = Color3.fromRGB(255, 255, 255)
		ToggleName.TextSize = 14.000
		ToggleName.TextXAlignment = Enum.TextXAlignment.Left
		
		Toggle.Name = "Toggle"
		Toggle.Parent = ToggleContainer
		Toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		Toggle.BorderColor3 = Color3.fromRGB(27, 42, 53)
		Toggle.Position = UDim2.new(0.75, 0, 0.2, 0)
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
		ToggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
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
				game:GetService("TweenService"):Create(ToggleIndicator, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 255, 102)}):Play()
			else
				game:GetService("TweenService"):Create(ToggleIndicator, TweenInfo.new(0.2), {Position = UDim2.new(0.05, 0, 0.1, 0)}):Play()
				game:GetService("TweenService"):Create(ToggleIndicator, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 50, 50)}):Play()
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
		SliderContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		SliderContainer.BorderSizePixel = 0
		SliderContainer.Size = UDim2.new(0, 220, 0, 50)
		
		UICorner_slider.CornerRadius = UDim.new(0, 4)
		UICorner_slider.Parent = SliderContainer
		
		SliderName.Name = "SliderName"
		SliderName.Parent = SliderContainer
		SliderName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SliderName.BackgroundTransparency = 1.000
		SliderName.Position = UDim2.new(0.05, 0, 0, 0)
		SliderName.Size = UDim2.new(0, 140, 0, 20)
		SliderName.Font = Enum.Font.GothamSemibold
		SliderName.Text = name
		SliderName.TextColor3 = Color3.fromRGB(255, 255, 255)
		SliderName.TextSize = 14.000
		SliderName.TextXAlignment = Enum.TextXAlignment.Left
		
		SliderValue.Name = "SliderValue"
		SliderValue.Parent = SliderContainer
		SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SliderValue.BackgroundTransparency = 1.000
		SliderValue.Position = UDim2.new(0.7, 0, 0, 0)
		SliderValue.Size = UDim2.new(0, 50, 0, 20)
		SliderValue.Font = Enum.Font.GothamSemibold
		SliderValue.Text = tostring(default)
		SliderValue.TextColor3 = Color3.fromRGB(200, 200, 200)
		SliderValue.TextSize = 14.000
		SliderValue.TextXAlignment = Enum.TextXAlignment.Right
		
		SliderTrack.Name = "SliderTrack"
		SliderTrack.Parent = SliderContainer
		SliderTrack.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		SliderTrack.BorderSizePixel = 0
		SliderTrack.Position = UDim2.new(0.05, 0, 0.6, 0)
		SliderTrack.Size = UDim2.new(0, 200, 0, 6)
		
		UICorner_track.CornerRadius = UDim.new(1, 0)
		UICorner_track.Parent = SliderTrack
		
		SliderFill.Name = "SliderFill"
		SliderFill.Parent = SliderTrack
		SliderFill.BackgroundColor3 = Color3.fromRGB(0, 255, 102)
		SliderFill.BorderSizePixel = 0
		SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
		
		UICorner_fill.CornerRadius = UDim.new(1, 0)
		UICorner_fill.Parent = SliderFill
		
		SliderButton.Name = "SliderButton"
		SliderButton.Parent = SliderTrack
		SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SliderButton.BorderSizePixel = 0
		SliderButton.Position = UDim2.new((default - min) / (max - min), -8, 0, -4)
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
			SliderButton.Position = UDim2.new(pos.X.Scale, -8, 0, -4)
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
		local DropdownList = Instance.new("ScrollingFrame")
		local UIListLayout_list = Instance.new("UIListLayout")
		
		DropdownContainer.Name = "DropdownContainer"
		DropdownContainer.Parent = Container
		DropdownContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		DropdownContainer.BorderSizePixel = 0
		DropdownContainer.Size = UDim2.new(0, 220, 0, 32)
		DropdownContainer.ClipsDescendants = true
		
		UICorner_dropdown.CornerRadius = UDim.new(0, 4)
		UICorner_dropdown.Parent = DropdownContainer
		
		DropdownName.Name = "DropdownName"
		DropdownName.Parent = DropdownContainer
		DropdownName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		DropdownName.BackgroundTransparency = 1.000
		DropdownName.Position = UDim2.new(0.05, 0, 0, 0)
		DropdownName.Size = UDim2.new(0, 140, 0, 32)
		DropdownName.Font = Enum.Font.GothamSemibold
		DropdownName.Text = name
		DropdownName.TextColor3 = Color3.fromRGB(255, 255, 255)
		DropdownName.TextSize = 14.000
		DropdownName.TextXAlignment = Enum.TextXAlignment.Left
		
		DropdownButton.Name = "DropdownButton"
		DropdownButton.Parent = DropdownContainer
		DropdownButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		DropdownButton.BackgroundTransparency = 1
		DropdownButton.Position = UDim2.new(0.7, 0, 0.2, 0)
		DropdownButton.Size = UDim2.new(0, 60, 0, 20)
		DropdownButton.Font = Enum.Font.GothamSemibold
		DropdownButton.Text = "Select"
		DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		DropdownButton.TextSize = 12.000
		DropdownButton.AutoButtonColor = false
		
		local UICorner_btn = Instance.new("UICorner")
		UICorner_btn.CornerRadius = UDim.new(0, 4)
		UICorner_btn.Parent = DropdownButton
		
		DropdownArrow.Name = "DropdownArrow"
		DropdownArrow.Parent = DropdownButton
		DropdownArrow.BackgroundTransparency = 1
		DropdownArrow.Position = UDim2.new(0.8, 0, 0.2, 0)
		DropdownArrow.Size = UDim2.new(0, 12, 0, 12)
		DropdownArrow.Image = "rbxassetid://6031091003"
		DropdownArrow.ImageColor3 = Color3.fromRGB(200, 200, 200)
		
		DropdownList.Name = "DropdownList"
		DropdownList.Parent = DropdownContainer
		DropdownList.Active = true
		DropdownList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		DropdownList.BorderSizePixel = 0
		DropdownList.Position = UDim2.new(0.05, 0, 1, 5)
		DropdownList.Size = UDim2.new(0, 200, 0, 0)
		DropdownList.CanvasSize = UDim2.new(0, 0, 0, 0)
		DropdownList.ScrollBarThickness = 3
		DropdownList.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 102)
		DropdownList.Visible = false
		
		local UICorner_list = Instance.new("UICorner")
		UICorner_list.CornerRadius = UDim.new(0, 4)
		UICorner_list.Parent = DropdownList
		
		UIListLayout_list.Parent = DropdownList
		UIListLayout_list.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_list.Padding = UDim.new(0, 2)
		
		local isOpen = false
		local selectedOption = nil
		
		local function updateListHeight()
			local itemCount = #DropdownList:GetChildren() - 1
			local height = math.min(itemCount * 25, 125)
			DropdownList.CanvasSize = UDim2.new(0, 0, 0, itemCount * 25)
			return height
		end
		
		local function toggleDropdown()
			isOpen = not isOpen
			if isOpen then
				DropdownList.Visible = true
				game:GetService("TweenService"):Create(DropdownArrow, TweenInfo.new(0.2), {Rotation = 180}):Play()
				DropdownList:TweenSize(UDim2.new(0, 200, 0, updateListHeight()), "Out", "Sine", 0.2)
			else
				game:GetService("TweenService"):Create(DropdownArrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
				DropdownList:TweenSize(UDim2.new(0, 200, 0, 0), "Out", "Sine", 0.2, true, function()
					DropdownList.Visible = false
				end)
			end
		end
		
		DropdownButton.MouseButton1Click:Connect(toggleDropdown)
		
		for i, option in ipairs(options) do
			local OptionButton = Instance.new("TextButton")
			OptionButton.Name = "Option_" .. option
			OptionButton.Parent = DropdownList
			OptionButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			OptionButton.BorderSizePixel = 0
			OptionButton.Size = UDim2.new(0, 200, 0, 25)
			OptionButton.Font = Enum.Font.Gotham
			OptionButton.Text = option
			OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			OptionButton.TextSize = 12.000
			OptionButton.AutoButtonColor = false
			
			local UICorner_option = Instance.new("UICorner")
			UICorner_option.CornerRadius = UDim.new(0, 4)
			UICorner_option.Parent = OptionButton
			
			OptionButton.MouseButton1Click:Connect(function()
				selectedOption = option
				DropdownButton.Text = option
				toggleDropdown()
				callback(option)
			end)
			
			OptionButton.MouseEnter:Connect(function()
				game:GetService("TweenService"):Create(OptionButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
			end)
			
			OptionButton.MouseLeave:Connect(function()
				game:GetService("TweenService"):Create(OptionButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
			end)
		end
		
		updateListHeight()
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
		ColorpickerContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		ColorpickerContainer.BorderSizePixel = 0
		ColorpickerContainer.Size = UDim2.new(0, 220, 0, 32)
		
		UICorner_color.CornerRadius = UDim.new(0, 4)
		UICorner_color.Parent = ColorpickerContainer
		
		ColorpickerName.Name = "ColorpickerName"
		ColorpickerName.Parent = ColorpickerContainer
		ColorpickerName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ColorpickerName.BackgroundTransparency = 1.000
		ColorpickerName.Position = UDim2.new(0.05, 0, 0, 0)
		ColorpickerName.Size = UDim2.new(0, 140, 0, 32)
		ColorpickerName.Font = Enum.Font.GothamSemibold
		ColorpickerName.Text = name
		ColorpickerName.TextColor3 = Color3.fromRGB(255, 255, 255)
		ColorpickerName.TextSize = 14.000
		ColorpickerName.TextXAlignment = Enum.TextXAlignment.Left
		
		ColorButton.Name = "ColorButton"
		ColorButton.Parent = ColorpickerContainer
		ColorButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		ColorButton.BackgroundTransparency = 0
		ColorButton.Position = UDim2.new(0.7, 0, 0.2, 0)
		ColorButton.Size = UDim2.new(0, 60, 0, 20)
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
		ColorPreview.BackgroundColor3 = defaultColor or Color3.fromRGB(255, 0, 0)
		ColorPreview.BorderSizePixel = 0
		ColorPreview.Position = UDim2.new(0.1, 0, 0.1, 0)
		ColorPreview.Size = UDim2.new(0, 48, 0, 16)
		
		UICorner_preview.CornerRadius = UDim.new(0, 4)
		UICorner_preview.Parent = ColorPreview
		
		ColorButton.MouseButton1Click:Connect(function()
			local ColorPickerPopup = Instance.new("Frame")
			local UICorner_popup = Instance.new("UICorner")
			local HueSlider = Instance.new("Frame")
			local UICorner_hue = Instance.new("UICorner")
			local HueButton = Instance.new("TextButton")
			local UICorner_huebtn = Instance.new("UICorner")
			local CloseButton = Instance.new("TextButton")
			local CloseText = Instance.new("TextLabel")
			
			ColorPickerPopup.Name = "ColorPickerPopup"
			ColorPickerPopup.Parent = UiLib
			ColorPickerPopup.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			ColorPickerPopup.BorderSizePixel = 0
			ColorPickerPopup.Position = UDim2.new(0.5, -100, 0.5, -75)
			ColorPickerPopup.Size = UDim2.new(0, 200, 0, 150)
			ColorPickerPopup.Active = true
			ColorPickerPopup.Draggable = true
			
			UICorner_popup.CornerRadius = UDim.new(0, 6)
			UICorner_popup.Parent = ColorPickerPopup
			
			HueSlider.Name = "HueSlider"
			HueSlider.Parent = ColorPickerPopup
			HueSlider.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
			HueSlider.BorderSizePixel = 0
			HueSlider.Position = UDim2.new(0.1, 0, 0.2, 0)
			HueSlider.Size = UDim2.new(0, 160, 0, 20)
			
			UICorner_hue.CornerRadius = UDim.new(0, 4)
			UICorner_hue.Parent = HueSlider
			
			HueButton.Name = "HueButton"
			HueButton.Parent = HueSlider
			HueButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			HueButton.BorderSizePixel = 0
			HueButton.Position = UDim2.new(0.5, -5, 0, -5)
			HueButton.Size = UDim2.new(0, 10, 0, 30)
			HueButton.Font = Enum.Font.SourceSans
			HueButton.Text = ""
			HueButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			HueButton.TextSize = 14.000
			HueButton.AutoButtonColor = false
			
			UICorner_huebtn.CornerRadius = UDim.new(1, 0)
			UICorner_huebtn.Parent = HueButton
			
			CloseButton.Name = "CloseButton"
			CloseButton.Parent = ColorPickerPopup
			CloseButton.BackgroundColor3 = Color3.fromRGB(0, 255, 102)
			CloseButton.BorderSizePixel = 0
			CloseButton.Position = UDim2.new(0.3, 0, 0.75, 0)
			CloseButton.Size = UDim2.new(0, 80, 0, 25)
			CloseButton.Font = Enum.Font.GothamSemibold
			CloseButton.Text = ""
			CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			CloseButton.TextSize = 14.000
			
			local UICorner_close = Instance.new("UICorner")
			UICorner_close.CornerRadius = UDim.new(0, 4)
			UICorner_close.Parent = CloseButton
			
			CloseText.Name = "CloseText"
			CloseText.Parent = CloseButton
			CloseText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			CloseText.BackgroundTransparency = 1.000
			CloseText.Size = UDim2.new(0, 80, 0, 25)
			CloseText.Font = Enum.Font.GothamSemibold
			CloseText.Text = "Apply"
			CloseText.TextColor3 = Color3.fromRGB(255, 255, 255)
			CloseText.TextSize = 14.000
			
			local dragging = false
			local currentColor = ColorPreview.BackgroundColor3
			
			local function updateColor(hue)
				local r, g, b
				local h = hue * 6
				local i = math.floor(h)
				local f = h - i
				local p = 0
				local q = 1 - f
				local t = f
				
				if i == 0 then r, g, b = 1, t, p
				elseif i == 1 then r, g, b = q, 1, p
				elseif i == 2 then r, g, b = p, 1, t
				elseif i == 3 then r, g, b = p, q, 1
				elseif i == 4 then r, g, b = t, p, 1
				else r, g, b = 1, p, q
				end
				
				currentColor = Color3.new(r, g, b)
				HueSlider.BackgroundColor3 = currentColor
				ColorPreview.BackgroundColor3 = currentColor
			end
			
			local function updateHueSlider(input)
				local pos = math.clamp((input.Position.X - HueSlider.AbsolutePosition.X) / HueSlider.AbsoluteSize.X, 0, 1)
				HueButton.Position = UDim2.new(pos, -5, 0, -5)
				updateColor(pos)
			end
			
			HueButton.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = true
				end
			end)
			
			HueButton.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = false
				end
			end)
			
			game:GetService("UserInputService").InputChanged:Connect(function(input)
				if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
					updateHueSlider(input)
				end
			end)
			
			HueSlider.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					updateHueSlider(input)
					dragging = true
				end
			end)
			
			HueSlider.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = false
				end
			end)
			
			CloseButton.MouseButton1Click:Connect(function()
				callback(currentColor)
				ColorPickerPopup:Destroy()
			end)
		end)
	end
	
	function Lib:Label(text)
		local LabelContainer = Instance.new("Frame")
		local UICorner_label = Instance.new("UICorner")
		local LabelText = Instance.new("TextLabel")
		
		LabelContainer.Name = "LabelContainer"
		LabelContainer.Parent = Container
		LabelContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		LabelContainer.BorderSizePixel = 0
		LabelContainer.Size = UDim2.new(0, 220, 0, 25)
		
		UICorner_label.CornerRadius = UDim.new(0, 4)
		UICorner_label.Parent = LabelContainer
		
		LabelText.Name = "LabelText"
		LabelText.Parent = LabelContainer
		LabelText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		LabelText.BackgroundTransparency = 1.000
		LabelText.Size = UDim2.new(0, 220, 0, 25)
		LabelText.Font = Enum.Font.Gotham
		LabelText.Text = text
		LabelText.TextColor3 = Color3.fromRGB(200, 200, 200)
		LabelText.TextSize = 12.000
		LabelText.TextWrapped = true
	end
	
	function Lib:Separator()
		local SeparatorContainer = Instance.new("Frame")
		local SeparatorLine = Instance.new("Frame")
		
		SeparatorContainer.Name = "SeparatorContainer"
		SeparatorContainer.Parent = Container
		SeparatorContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		SeparatorContainer.BackgroundTransparency = 1.000
		SeparatorContainer.Size = UDim2.new(0, 220, 0, 10)
		
		SeparatorLine.Name = "SeparatorLine"
		SeparatorLine.Parent = SeparatorContainer
		SeparatorLine.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		SeparatorLine.BorderSizePixel = 0
		SeparatorLine.Position = UDim2.new(0.1, 0, 0.5, 0)
		SeparatorLine.Size = UDim2.new(0, 180, 0, 1)
	end
	
	return Lib
	
end

return Library
