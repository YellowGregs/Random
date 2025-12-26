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

local Background = Instance.new("Frame")
Background.Name = "Background"
Background.Parent = UiLib
Background.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Background.BackgroundTransparency = 0.1
Background.BorderSizePixel = 0
Background.Size = UDim2.new(1, 0, 1, 0)
Background.Visible = false

local function getNextWindowPos()
	local biggest = 0;
	local ok = nil;
	for i, v in pairs(UiLib:GetChildren()) do
		if v:IsA("Frame") and v.Name == "Top" and v.Position.X.Offset > biggest then
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
	
	local DropShadow = Instance.new("ImageLabel")
	DropShadow.Name = "DropShadow"
	DropShadow.Parent = Top
	DropShadow.BackgroundTransparency = 1
	DropShadow.BorderSizePixel = 0
	DropShadow.Size = UDim2.new(1, 12, 1, 12)
	DropShadow.Position = UDim2.new(0, -6, 0, -6)
	DropShadow.Image = "rbxassetid://6015897843"
	DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	DropShadow.ImageTransparency = 0.5
	DropShadow.ScaleType = Enum.ScaleType.Slice
	DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)
	DropShadow.ZIndex = -1

	Top.Name = "Top"
	Top.Parent = UiLib
	Top.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	Top.BorderSizePixel = 0
	Top.Position = UDim2.new(0, getNextWindowPos(), 0.01, 0)
	Top.Size = UDim2.new(0, 250, 0, 35)
	Top.Active = true
	Top.Draggable = true

	UICorner.CornerRadius = UDim.new(0, 8)
	UICorner.Parent = Top

	Container.Name = "Container"
	Container.Parent = Top
	Container.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Container.BackgroundTransparency = 0
	Container.ClipsDescendants = true
	Container.Position = UDim2.new(0, 0, 1, 2)
	Container.Size = UDim2.new(0, 250, 0, 0)
	Container.ZIndex = 2

	local ContainerCorner = Instance.new("UICorner")
	ContainerCorner.CornerRadius = UDim.new(0, 6)
	ContainerCorner.Parent = Container

	UIListLayout_2.Parent = Container
	UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_2.Padding = UDim.new(0, 8)

	Line.Name = "Line"
	Line.Parent = Top
	Line.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
	Line.BorderSizePixel = 0
	Line.Position = UDim2.new(0, 0, 0.94, 0)
	Line.Size = UDim2.new(0, 250, 0, 1)

	Title.Name = "Title"
	Title.Parent = Top
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.Position = UDim2.new(0.04, 0, 0, 0)
	Title.Size = UDim2.new(0, 200, 0, 35)
	Title.Font = Enum.Font.GothamMedium
	Title.Text = title
	Title.TextColor3 = Color3.fromRGB(220, 220, 220)
	Title.TextSize = 14.000
	Title.TextXAlignment = Enum.TextXAlignment.Left

	Minimize.Name = "Minimize"
	Minimize.Parent = Top
	Minimize.BackgroundTransparency = 1.000
	Minimize.Position = UDim2.new(0.88, 0, 0.15, 0)
	Minimize.Rotation = 0
	Minimize.Size = UDim2.new(0, 20, 0, 20)
	Minimize.ZIndex = 2
	Minimize.Image = "rbxassetid://6031094665"
	Minimize.ImageColor3 = Color3.fromRGB(150, 150, 150)

	local function UZVNGAL_fake_script()
		local script = Instance.new('Script', Minimize)

		script.Parent.MouseButton1Click:Connect(function()
			if Container.Size == UDim2.new(0, 250, 0, 0) then 
				game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.2), {Rotation = 0}):Play()
				game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(150, 150, 150)}):Play()
				Container:TweenSize(UDim2.new(0, 250, 0, 350), "Out", "Sine", 0.3, true)
				Background.Visible = true
			else
				game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.2), {Rotation = 180}):Play()
				game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(100, 100, 100)}):Play()
				Container:TweenSize(UDim2.new(0, 250, 0, 0), "Out", "Sine", 0.3, true)
				
				local anyOpen = false
				for i, child in pairs(UiLib:GetChildren()) do
					if child:IsA("Frame") and child.Name == "Container" and child.Size.Y.Offset > 0 then
						anyOpen = true
						break
					end
				end
				if not anyOpen then
					Background.Visible = false
				end
			end
		end)
	end
	coroutine.wrap(UZVNGAL_fake_script)()
	
	Background.Visible = true
	
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
		ButtonContainer.Size = UDim2.new(0, 230, 0, 32)
		
		UICorner_btn.CornerRadius = UDim.new(0, 6)
		UICorner_btn.Parent = ButtonContainer
		
		Button.Name = "Button"
		Button.Parent = ButtonContainer
		Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		Button.BackgroundTransparency = 0
		Button.Size = UDim2.new(0, 230, 0, 32)
		Button.Font = Enum.Font.SourceSans
		Button.Text = ""
		Button.TextColor3 = Color3.fromRGB(0, 0, 0)
		Button.TextSize = 14.000
		Button.AutoButtonColor = false
		
		local UICorner_btn2 = Instance.new("UICorner")
		UICorner_btn2.CornerRadius = UDim.new(0, 6)
		UICorner_btn2.Parent = Button
		
		ButtonName.Name = "ButtonName"
		ButtonName.Parent = Button
		ButtonName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ButtonName.BackgroundTransparency = 1.000
		ButtonName.Size = UDim2.new(0, 230, 0, 32)
		ButtonName.Font = Enum.Font.GothamMedium
		ButtonName.Text = name
		ButtonName.TextColor3 = Color3.fromRGB(220, 220, 220)
		ButtonName.TextSize = 13.000
		
		Button.MouseButton1Click:Connect(function()
			game:GetService("TweenService"):Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
			wait(0.1)
			game:GetService("TweenService"):Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
			callback()
		end)
		
		Button.MouseEnter:Connect(function()
			game:GetService("TweenService"):Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
		end)
		
		Button.MouseLeave:Connect(function()
			game:GetService("TweenService"):Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
		end)
	end
	
	function Lib:Toggle(name, callback)
		local ToggleContainer = Instance.new("Frame")
		local UICorner_toggle = Instance.new("UICorner")
		local ToggleName = Instance.new("TextLabel")
		local Toggle = Instance.new("TextButton")
		local ToggleIndicator = Instance.new("Frame")
		local UICorner_indicator = Instance.new("UICorner")
		
		ToggleContainer.Name = "ToggleContainer"
		ToggleContainer.Parent = Container
		ToggleContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		ToggleContainer.BorderSizePixel = 0
		ToggleContainer.Size = UDim2.new(0, 230, 0, 32)
		
		UICorner_toggle.CornerRadius = UDim.new(0, 6)
		UICorner_toggle.Parent = ToggleContainer
		
		ToggleName.Name = "ToggleName"
		ToggleName.Parent = ToggleContainer
		ToggleName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ToggleName.BackgroundTransparency = 1.000
		ToggleName.Position = UDim2.new(0.04, 0, 0, 0)
		ToggleName.Size = UDim2.new(0, 160, 0, 32)
		ToggleName.Font = Enum.Font.GothamMedium
		ToggleName.Text = name
		ToggleName.TextColor3 = Color3.fromRGB(220, 220, 220)
		ToggleName.TextSize = 13.000
		ToggleName.TextXAlignment = Enum.TextXAlignment.Left
		
		Toggle.Name = "Toggle"
		Toggle.Parent = ToggleContainer
		Toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		Toggle.BorderColor3 = Color3.fromRGB(27, 42, 53)
		Toggle.Position = UDim2.new(0.8, 0, 0.2, 0)
		Toggle.Size = UDim2.new(0, 36, 0, 18)
		Toggle.AutoButtonColor = false
		Toggle.Font = Enum.Font.SourceSans
		Toggle.Text = ""
		Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
		Toggle.TextSize = 14.000
		
		local UICorner_3 = Instance.new("UICorner")
		UICorner_3.CornerRadius = UDim.new(1, 0)
		UICorner_3.Parent = Toggle
		
		ToggleIndicator.Name = "ToggleIndicator"
		ToggleIndicator.Parent = Toggle
		ToggleIndicator.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
		ToggleIndicator.BorderSizePixel = 0
		ToggleIndicator.Position = UDim2.new(0.05, 0, 0.15, 0)
		ToggleIndicator.Size = UDim2.new(0, 14, 0, 14)
		
		UICorner_indicator.CornerRadius = UDim.new(1, 0)
		UICorner_indicator.Parent = ToggleIndicator
		
		local Toggled = false
		Toggle.MouseButton1Click:Connect(function()
			Toggled = not Toggled
			if Toggled then
				game:GetService("TweenService"):Create(ToggleIndicator, TweenInfo.new(0.2), {Position = UDim2.new(0.55, 0, 0.15, 0)}):Play()
				game:GetService("TweenService"):Create(ToggleIndicator, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 200, 255)}):Play()
				game:GetService("TweenService"):Create(Toggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 70, 100)}):Play()
			else
				game:GetService("TweenService"):Create(ToggleIndicator, TweenInfo.new(0.2), {Position = UDim2.new(0.05, 0, 0.15, 0)}):Play()
				game:GetService("TweenService"):Create(ToggleIndicator, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(120, 120, 120)}):Play()
				game:GetService("TweenService"):Create(Toggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
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
		SliderContainer.Size = UDim2.new(0, 230, 0, 50)
		
		UICorner_slider.CornerRadius = UDim.new(0, 6)
		UICorner_slider.Parent = SliderContainer
		
		SliderName.Name = "SliderName"
		SliderName.Parent = SliderContainer
		SliderName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SliderName.BackgroundTransparency = 1.000
		SliderName.Position = UDim2.new(0.04, 0, 0, 0)
		SliderName.Size = UDim2.new(0, 160, 0, 20)
		SliderName.Font = Enum.Font.GothamMedium
		SliderName.Text = name
		SliderName.TextColor3 = Color3.fromRGB(220, 220, 220)
		SliderName.TextSize = 13.000
		SliderName.TextXAlignment = Enum.TextXAlignment.Left
		
		SliderValue.Name = "SliderValue"
		SliderValue.Parent = SliderContainer
		SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SliderValue.BackgroundTransparency = 1.000
		SliderValue.Position = UDim2.new(0.7, 0, 0, 0)
		SliderValue.Size = UDim2.new(0, 50, 0, 20)
		SliderValue.Font = Enum.Font.GothamMedium
		SliderValue.Text = tostring(default)
		SliderValue.TextColor3 = Color3.fromRGB(180, 180, 180)
		SliderValue.TextSize = 12.000
		SliderValue.TextXAlignment = Enum.TextXAlignment.Right
		
		SliderTrack.Name = "SliderTrack"
		SliderTrack.Parent = SliderContainer
		SliderTrack.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		SliderTrack.BorderSizePixel = 0
		SliderTrack.Position = UDim2.new(0.04, 0, 0.6, 0)
		SliderTrack.Size = UDim2.new(0, 210, 0, 5)
		
		UICorner_track.CornerRadius = UDim.new(1, 0)
		UICorner_track.Parent = SliderTrack
		
		SliderFill.Name = "SliderFill"
		SliderFill.Parent = SliderTrack
		SliderFill.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
		SliderFill.BorderSizePixel = 0
		SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
		
		UICorner_fill.CornerRadius = UDim.new(1, 0)
		UICorner_fill.Parent = SliderFill
		
		SliderButton.Name = "SliderButton"
		SliderButton.Parent = SliderTrack
		SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SliderButton.BorderSizePixel = 0
		SliderButton.Position = UDim2.new((default - min) / (max - min), -6, 0, -4)
		SliderButton.Size = UDim2.new(0, 12, 0, 12)
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
			SliderButton.Position = UDim2.new(pos.X.Scale, -6, 0, -4)
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
		local UIPadding_list = Instance.new("UIPadding")
		
		DropdownContainer.Name = "DropdownContainer"
		DropdownContainer.Parent = Container
		DropdownContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		DropdownContainer.BorderSizePixel = 0
		DropdownContainer.Size = UDim2.new(0, 230, 0, 32)
		DropdownContainer.ClipsDescendants = true
		
		UICorner_dropdown.CornerRadius = UDim.new(0, 6)
		UICorner_dropdown.Parent = DropdownContainer
		
		DropdownName.Name = "DropdownName"
		DropdownName.Parent = DropdownContainer
		DropdownName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		DropdownName.BackgroundTransparency = 1.000
		DropdownName.Position = UDim2.new(0.04, 0, 0, 0)
		DropdownName.Size = UDim2.new(0, 160, 0, 32)
		DropdownName.Font = Enum.Font.GothamMedium
		DropdownName.Text = name
		DropdownName.TextColor3 = Color3.fromRGB(220, 220, 220)
		DropdownName.TextSize = 13.000
		DropdownName.TextXAlignment = Enum.TextXAlignment.Left
		
		DropdownButton.Name = "DropdownButton"
		DropdownButton.Parent = DropdownContainer
		DropdownButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		DropdownButton.BackgroundTransparency = 0
		DropdownButton.Position = UDim2.new(0.7, 0, 0.2, 0)
		DropdownButton.Size = UDim2.new(0, 60, 0, 20)
		DropdownButton.Font = Enum.Font.GothamMedium
		DropdownButton.Text = "Select"
		DropdownButton.TextColor3 = Color3.fromRGB(200, 200, 200)
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
		DropdownArrow.ImageColor3 = Color3.fromRGB(150, 150, 150)
		
		DropdownList.Name = "DropdownList"
		DropdownList.Parent = DropdownContainer
		DropdownList.Active = true
		DropdownList.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		DropdownList.BorderSizePixel = 0
		DropdownList.Position = UDim2.new(0, 0, 1, 5)
		DropdownList.Size = UDim2.new(0, 230, 0, 0)
		DropdownList.CanvasSize = UDim2.new(0, 0, 0, 0)
		DropdownList.ScrollBarThickness = 3
		DropdownList.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
		DropdownList.Visible = false
		DropdownList.ZIndex = 5
		
		local UICorner_list = Instance.new("UICorner")
		UICorner_list.CornerRadius = UDim.new(0, 6)
		UICorner_list.Parent = DropdownList
		
		UIListLayout_list.Parent = DropdownList
		UIListLayout_list.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_list.Padding = UDim.new(0, 2)
		
		UIPadding_list.Parent = DropdownList
		UIPadding_list.PaddingTop = UDim.new(0, 5)
		UIPadding_list.PaddingLeft = UDim.new(0, 5)
		UIPadding_list.PaddingRight = UDim.new(0, 5)
		
		local isOpen = false
		local selectedOption = nil
		
		local function updateListHeight()
			local itemCount = #options
			local height = math.min(itemCount * 30 + 10, 150)
			DropdownList.CanvasSize = UDim2.new(0, 0, 0, itemCount * 30 + 5)
			return height
		end
		
		local function toggleDropdown()
			isOpen = not isOpen
			if isOpen then
				DropdownList.Visible = true
				game:GetService("TweenService"):Create(DropdownArrow, TweenInfo.new(0.2), {Rotation = 180}):Play()
				game:GetService("TweenService"):Create(DropdownButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
				DropdownList:TweenSize(UDim2.new(0, 230, 0, updateListHeight()), "Out", "Sine", 0.2)
			else
				game:GetService("TweenService"):Create(DropdownArrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
				game:GetService("TweenService"):Create(DropdownButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
				DropdownList:TweenSize(UDim2.new(0, 230, 0, 0), "Out", "Sine", 0.2, true, function()
					DropdownList.Visible = false
				end)
			end
		end
		
		DropdownButton.MouseButton1Click:Connect(toggleDropdown)
		
		for i, option in ipairs(options) do
			local OptionButton = Instance.new("TextButton")
			OptionButton.Name = "Option_" .. option
			OptionButton.Parent = DropdownList
			OptionButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			OptionButton.BorderSizePixel = 0
			OptionButton.Size = UDim2.new(0, 220, 0, 25)
			OptionButton.Font = Enum.Font.Gotham
			OptionButton.Text = option
			OptionButton.TextColor3 = Color3.fromRGB(200, 200, 200)
			OptionButton.TextSize = 12.000
			OptionButton.AutoButtonColor = false
			OptionButton.ZIndex = 6
			
			local UICorner_option = Instance.new("UICorner")
			UICorner_option.CornerRadius = UDim.new(0, 4)
			UICorner_option.Parent = OptionButton
			
			OptionButton.MouseButton1Click:Connect(function()
				selectedOption = option
				DropdownButton.Text = string.sub(option, 1, 8) .. (string.len(option) > 8 and "..." or "")
				toggleDropdown()
				callback(option)
			end)
			
			OptionButton.MouseEnter:Connect(function()
				game:GetService("TweenService"):Create(OptionButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}):Play()
			end)
			
			OptionButton.MouseLeave:Connect(function()
				game:GetService("TweenService"):Create(OptionButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
			end)
		end
		
		updateListHeight()
		
		local connection
		connection = game:GetService("UserInputService").InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 and isOpen then
				if not DropdownButton:IsDescendantOf(Container) then return end
				local mousePos = game:GetService("UserInputService"):GetMouseLocation()
				local buttonPos = DropdownButton.AbsolutePosition
				local buttonSize = DropdownButton.AbsoluteSize
				local listPos = DropdownList.AbsolutePosition
				local listSize = DropdownList.AbsoluteSize
				
				local isOverButton = mousePos.X >= buttonPos.X and mousePos.X <= buttonPos.X + buttonSize.X and
									mousePos.Y >= buttonPos.Y and mousePos.Y <= buttonPos.Y + buttonSize.Y
				local isOverList = mousePos.X >= listPos.X and mousePos.X <= listPos.X + listSize.X and
								  mousePos.Y >= listPos.Y and mousePos.Y <= listPos.Y + listSize.Y
				
				if not isOverButton and not isOverList then
					toggleDropdown()
				end
			end
		end)
		
		DropdownContainer.Destroying:Connect(function()
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
		ColorpickerContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		ColorpickerContainer.BorderSizePixel = 0
		ColorpickerContainer.Size = UDim2.new(0, 230, 0, 32)
		
		UICorner_color.CornerRadius = UDim.new(0, 6)
		UICorner_color.Parent = ColorpickerContainer
		
		ColorpickerName.Name = "ColorpickerName"
		ColorpickerName.Parent = ColorpickerContainer
		ColorpickerName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ColorpickerName.BackgroundTransparency = 1.000
		ColorpickerName.Position = UDim2.new(0.04, 0, 0, 0)
		ColorpickerName.Size = UDim2.new(0, 160, 0, 32)
		ColorpickerName.Font = Enum.Font.GothamMedium
		ColorpickerName.Text = name
		ColorpickerName.TextColor3 = Color3.fromRGB(220, 220, 220)
		ColorpickerName.TextSize = 13.000
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
		ColorPreview.BackgroundColor3 = defaultColor or Color3.fromRGB(100, 200, 255)
		ColorPreview.BorderSizePixel = 0
		ColorPreview.Position = UDim2.new(0.1, 0, 0.1, 0)
		ColorPreview.Size = UDim2.new(0, 48, 0, 16)
		
		UICorner_preview.CornerRadius = UDim.new(0, 4)
		UICorner_preview.Parent = ColorPreview
		
		ColorButton.MouseButton1Click:Connect(function()
			local ColorPickerPopup = Instance.new("Frame")
			local UICorner_popup = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local HueSlider = Instance.new("Frame")
			local UICorner_hue = Instance.new("UICorner")
			local HueButton = Instance.new("TextButton")
			local UICorner_huebtn = Instance.new("UICorner")
			local RedSlider = Instance.new("Frame")
			local RedButton = Instance.new("TextButton")
			local GreenSlider = Instance.new("Frame")
			local GreenButton = Instance.new("TextButton")
			local BlueSlider = Instance.new("Frame")
			local BlueButton = Instance.new("TextButton")
			local RedLabel = Instance.new("TextLabel")
			local GreenLabel = Instance.new("TextLabel")
			local BlueLabel = Instance.new("TextLabel")
			local ApplyButton = Instance.new("TextButton")
			local ApplyText = Instance.new("TextLabel")
			local Preview = Instance.new("Frame")
			local UICorner_preview2 = Instance.new("UICorner")
			local HexInput = Instance.new("TextBox")
			
			ColorPickerPopup.Name = "ColorPickerPopup"
			ColorPickerPopup.Parent = UiLib
			ColorPickerPopup.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			ColorPickerPopup.BorderSizePixel = 0
			ColorPickerPopup.Position = UDim2.new(0.5, -125, 0.5, -100)
			ColorPickerPopup.Size = UDim2.new(0, 250, 0, 220)
			ColorPickerPopup.Active = true
			ColorPickerPopup.Draggable = true
			ColorPickerPopup.ZIndex = 10
			
			UICorner_popup.CornerRadius = UDim.new(0, 8)
			UICorner_popup.Parent = ColorPickerPopup
			
			local Shadow = Instance.new("ImageLabel")
			Shadow.Name = "Shadow"
			Shadow.Parent = ColorPickerPopup
			Shadow.BackgroundTransparency = 1
			Shadow.BorderSizePixel = 0
			Shadow.Size = UDim2.new(1, 12, 1, 12)
			Shadow.Position = UDim2.new(0, -6, 0, -6)
			Shadow.Image = "rbxassetid://6015897843"
			Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
			Shadow.ImageTransparency = 0.5
			Shadow.ScaleType = Enum.ScaleType.Slice
			Shadow.SliceCenter = Rect.new(49, 49, 450, 450)
			Shadow.ZIndex = 9
			
			Title.Name = "Title"
			Title.Parent = ColorPickerPopup
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.Position = UDim2.new(0.04, 0, 0.02, 0)
			Title.Size = UDim2.new(0, 200, 0, 25)
			Title.Font = Enum.Font.GothamMedium
			Title.Text = "Color Picker"
			Title.TextColor3 = Color3.fromRGB(220, 220, 220)
			Title.TextSize = 14.000
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.ZIndex = 11
			
			HueSlider.Name = "HueSlider"
			HueSlider.Parent = ColorPickerPopup
			HueSlider.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
			HueSlider.BorderSizePixel = 0
			HueSlider.Position = UDim2.new(0.04, 0, 0.15, 0)
			HueSlider.Size = UDim2.new(0, 200, 0, 20)
			HueSlider.ZIndex = 11
			
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
			HueButton.ZIndex = 12
			
			UICorner_huebtn.CornerRadius = UDim.new(1, 0)
			UICorner_huebtn.Parent = HueButton
			
			local function createRGBSlider(name, yPos, defaultVal, color)
				local container = Instance.new("Frame")
				container.Name = name .. "Container"
				container.Parent = ColorPickerPopup
				container.BackgroundTransparency = 1
				container.Position = UDim2.new(0.04, 0, yPos, 0)
				container.Size = UDim2.new(0, 200, 0, 25)
				container.ZIndex = 11
				
				local label = Instance.new("TextLabel")
				label.Name = name .. "Label"
				label.Parent = container
				label.BackgroundTransparency = 1
				label.Position = UDim2.new(0, 0, 0, 0)
				label.Size = UDim2.new(0, 30, 0, 20)
				label.Font = Enum.Font.GothamMedium
				label.Text = name .. ":"
				label.TextColor3 = color
				label.TextSize = 12
				label.TextXAlignment = Enum.TextXAlignment.Left
				label.ZIndex = 11
				
				local sliderTrack = Instance.new("Frame")
				sliderTrack.Name = name .. "Track"
				sliderTrack.Parent = container
				sliderTrack.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				sliderTrack.BorderSizePixel = 0
				sliderTrack.Position = UDim2.new(0.2, 0, 0.2, 0)
				sliderTrack.Size = UDim2.new(0, 120, 0, 6)
				sliderTrack.ZIndex = 11
				
				local trackCorner = Instance.new("UICorner")
				trackCorner.CornerRadius = UDim.new(1, 0)
				trackCorner.Parent = sliderTrack
				
				local sliderFill = Instance.new("Frame")
				sliderFill.Name = name .. "Fill"
				sliderFill.Parent = sliderTrack
				sliderFill.BackgroundColor3 = color
				sliderFill.BorderSizePixel = 0
				sliderFill.Size = UDim2.new(defaultVal/255, 0, 1, 0)
				sliderFill.ZIndex = 12
				
				local fillCorner = Instance.new("UICorner")
				fillCorner.CornerRadius = UDim.new(1, 0)
				fillCorner.Parent = sliderFill
				
				local sliderButton = Instance.new("TextButton")
				sliderButton.Name = name .. "Button"
				sliderButton.Parent = sliderTrack
				sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				sliderButton.BorderSizePixel = 0
				sliderButton.Position = UDim2.new(defaultVal/255, -6, 0, -4)
				sliderButton.Size = UDim2.new(0, 12, 0, 12)
				sliderButton.Font = Enum.Font.SourceSans
				sliderButton.Text = ""
				sliderButton.TextColor3 = Color3.fromRGB(0, 0, 0)
				sliderButton.TextSize = 14.000
				sliderButton.AutoButtonColor = false
				sliderButton.ZIndex = 13
				
				local buttonCorner = Instance.new("UICorner")
				buttonCorner.CornerRadius = UDim.new(1, 0)
				buttonCorner.Parent = sliderButton
				
				local valueLabel = Instance.new("TextLabel")
				valueLabel.Name = name .. "Value"
				valueLabel.Parent = container
				valueLabel.BackgroundTransparency = 1
				valueLabel.Position = UDim2.new(0.85, 0, 0, 0)
				valueLabel.Size = UDim2.new(0, 25, 0, 20)
				valueLabel.Font = Enum.Font.GothamMedium
				valueLabel.Text = tostring(defaultVal)
				valueLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
				valueLabel.TextSize = 12
				valueLabel.ZIndex = 11
				
				return container, sliderTrack, sliderButton, sliderFill, valueLabel
			end
			
			local currentColor = ColorPreview.BackgroundColor3
			local r, g, b = math.floor(currentColor.R * 255), math.floor(currentColor.G * 255), math.floor(currentColor.B * 255)
			
			local redContainer, redTrack, redButton, redFill, redValue = createRGBSlider("R", 0.35, r, Color3.fromRGB(255, 50, 50))
			local greenContainer, greenTrack, greenButton, greenFill, greenValue = createRGBSlider("G", 0.5, g, Color3.fromRGB(50, 255, 50))
			local blueContainer, blueTrack, blueButton, blueFill, blueValue = createRGBSlider("B", 0.65, b, Color3.fromRGB(50, 50, 255))
			
			Preview.Name = "Preview"
			Preview.Parent = ColorPickerPopup
			Preview.BackgroundColor3 = currentColor
			Preview.BorderSizePixel = 0
			Preview.Position = UDim2.new(0.7, 0, 0.15, 0)
			Preview.Size = UDim2.new(0, 60, 0, 60)
			Preview.ZIndex = 11
			
			UICorner_preview2.CornerRadius = UDim.new(0, 6)
			UICorner_preview2.Parent = Preview
			
			HexInput.Name = "HexInput"
			HexInput.Parent = ColorPickerPopup
			HexInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			HexInput.BorderSizePixel = 0
			HexInput.Position = UDim2.new(0.04, 0, 0.8, 0)
			HexInput.Size = UDim2.new(0, 150, 0, 25)
			HexInput.Font = Enum.Font.Gotham
			HexInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
			HexInput.PlaceholderText = "Hex Color (#RRGGBB)"
			HexInput.Text = "#" .. string.format("%02X%02X%02X", r, g, b)
			HexInput.TextColor3 = Color3.fromRGB(220, 220, 220)
			HexInput.TextSize = 12
			HexInput.ZIndex = 11
			
			local hexCorner = Instance.new("UICorner")
			hexCorner.CornerRadius = UDim.new(0, 4)
			hexCorner.Parent = HexInput
			
			ApplyButton.Name = "ApplyButton"
			ApplyButton.Parent = ColorPickerPopup
			ApplyButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			ApplyButton.BorderSizePixel = 0
			ApplyButton.Position = UDim2.new(0.7, 0, 0.8, 0)
			ApplyButton.Size = UDim2.new(0, 60, 0, 25)
			ApplyButton.Font = Enum.Font.GothamMedium
			ApplyButton.Text = ""
			ApplyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			ApplyButton.TextSize = 14.000
			ApplyButton.ZIndex = 11
			
			local UICorner_apply = Instance.new("UICorner")
			UICorner_apply.CornerRadius = UDim.new(0, 6)
			UICorner_apply.Parent = ApplyButton
			
			ApplyText.Name = "ApplyText"
			ApplyText.Parent = ApplyButton
			ApplyText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ApplyText.BackgroundTransparency = 1.000
			ApplyText.Size = UDim2.new(0, 60, 0, 25)
			ApplyText.Font = Enum.Font.GothamMedium
			ApplyText.Text = "Apply"
			ApplyText.TextColor3 = Color3.fromRGB(220, 220, 220)
			ApplyText.TextSize = 13.000
			ApplyText.ZIndex = 12
			
			local function updateColor()
				currentColor = Color3.fromRGB(r, g, b)
				Preview.BackgroundColor3 = currentColor
				HexInput.Text = "#" .. string.format("%02X%02X%02X", r, g, b)
				
				local h, s, v = Color3.toHSV(currentColor)
				HueSlider.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
			end
			
			local function updateFromRGB()
				redFill.Size = UDim2.new(r/255, 0, 1, 0)
				redButton.Position = UDim2.new(r/255, -6, 0, -4)
				redValue.Text = tostring(r)
				
				greenFill.Size = UDim2.new(g/255, 0, 1, 0)
				greenButton.Position = UDim2.new(g/255, -6, 0, -4)
				greenValue.Text = tostring(g)
				
				blueFill.Size = UDim2.new(b/255, 0, 1, 0)
				blueButton.Position = UDim2.new(b/255, -6, 0, -4)
				blueValue.Text = tostring(b)
				
				updateColor()
			end
			
			local function createSliderLogic(track, button, fill, valueLabel, setter)
				local dragging = false
				
				local function updateSlider(input)
					local pos = UDim2.new(
						math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1),
						0,
						0, 0
					)
					local value = math.floor(pos.X.Scale * 255)
					
					fill.Size = UDim2.new(pos.X.Scale, 0, 1, 0)
					button.Position = UDim2.new(pos.X.Scale, -6, 0, -4)
					valueLabel.Text = tostring(value)
					
					setter(value)
					updateColor()
				end
				
				button.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = true
					end
				end)
				
				button.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = false
					end
				end)
				
				game:GetService("UserInputService").InputChanged:Connect(function(input)
					if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						updateSlider(input)
					end
				end)
				
				track.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						updateSlider(input)
						dragging = true
					end
				end)
				
				track.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = false
					end
				end)
			end
			
			createSliderLogic(redTrack, redButton, redFill, redValue, function(val) r = val end)
			createSliderLogic(greenTrack, greenButton, greenFill, greenValue, function(val) g = val end)
			createSliderLogic(blueTrack, blueButton, blueFill, blueValue, function(val) b = val end)
			
			local hueDragging = false
			local function updateHueSlider(input)
				local pos = math.clamp((input.Position.X - HueSlider.AbsolutePosition.X) / HueSlider.AbsoluteSize.X, 0, 1)
				HueButton.Position = UDim2.new(pos, -5, 0, -5)
				
				local hueColor = Color3.fromHSV(pos, 1, 1)
				r = math.floor(hueColor.R * 255)
				g = math.floor(hueColor.G * 255)
				b = math.floor(hueColor.B * 255)
				updateFromRGB()
			end
			
			HueButton.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					hueDragging = true
				end
			end)
			
			HueButton.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					hueDragging = false
				end
			end)
			
			game:GetService("UserInputService").InputChanged:Connect(function(input)
				if hueDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
					updateHueSlider(input)
				end
			end)
			
			HueSlider.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					updateHueSlider(input)
					hueDragging = true
				end
			end)
			
			HueSlider.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					hueDragging = false
				end
			end)
			
			HexInput.FocusLost:Connect(function()
				local hex = HexInput.Text:gsub("#", "")
				if #hex == 6 then
					local success, result = pcall(function()
						return Color3.fromHex(hex)
					end)
					if success then
						r = math.floor(result.R * 255)
						g = math.floor(result.G * 255)
						b = math.floor(result.B * 255)
						updateFromRGB()
					end
				end
			end)
			
			ApplyButton.MouseButton1Click:Connect(function()
				ColorPreview.BackgroundColor3 = currentColor
				callback(currentColor)
				ColorPickerPopup:Destroy()
			end)
			
			ApplyButton.MouseEnter:Connect(function()
				game:GetService("TweenService"):Create(ApplyButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}):Play()
			end)
			
			ApplyButton.MouseLeave:Connect(function()
				game:GetService("TweenService"):Create(ApplyButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
			end)
		end)
		
		ColorButton.MouseEnter:Connect(function()
			game:GetService("TweenService"):Create(ColorButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
		end)
		
		ColorButton.MouseLeave:Connect(function()
			game:GetService("TweenService"):Create(ColorButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
		end)
	end
	
	function Lib:Label(text)
		local LabelContainer = Instance.new("Frame")
		local LabelText = Instance.new("TextLabel")
		
		LabelContainer.Name = "LabelContainer"
		LabelContainer.Parent = Container
		LabelContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		LabelContainer.BackgroundTransparency = 1
		LabelContainer.BorderSizePixel = 0
		LabelContainer.Size = UDim2.new(0, 230, 0, 20)
		
		LabelText.Name = "LabelText"
		LabelText.Parent = LabelContainer
		LabelText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		LabelText.BackgroundTransparency = 1.000
		LabelText.Size = UDim2.new(0, 230, 0, 20)
		LabelText.Font = Enum.Font.GothamMedium
		LabelText.Text = text
		LabelText.TextColor3 = Color3.fromRGB(150, 150, 150)
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
		SeparatorContainer.Size = UDim2.new(0, 230, 0, 10)
		
		SeparatorLine.Name = "SeparatorLine"
		SeparatorLine.Parent = SeparatorContainer
		SeparatorLine.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		SeparatorLine.BorderSizePixel = 0
		SeparatorLine.Position = UDim2.new(0.1, 0, 0.5, 0)
		SeparatorLine.Size = UDim2.new(0, 185, 0, 1)
	end
	
	return Lib
	
end

return Library
