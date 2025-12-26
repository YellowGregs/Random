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
	local MainWindow = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local Container = Instance.new("Frame")
	local UIListLayout_2 = Instance.new("UIListLayout")
	local TopBar = Instance.new("Frame")
	local Title = Instance.new("TextLabel")
	local CollapseButton = Instance.new("ImageButton")
	local Shadow = Instance.new("ImageLabel")
	local Background = Instance.new("Frame")
	local UICornerBG = Instance.new("UICorner")
	local TabBar = Instance.new("Frame")
	local TabContainer = Instance.new("Frame")
	local TabsContent = Instance.new("Frame")
	local UIListLayout_Tabs = Instance.new("UIListLayout")

	MainWindow.Name = "MainWindow"
	MainWindow.Parent = UiLib
	MainWindow.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	MainWindow.BorderSizePixel = 0
	MainWindow.Position = UDim2.new(0, getNextWindowPos(), 0.01, 0)
	MainWindow.Size = UDim2.new(0, 280, 0, 36)
	MainWindow.Active = true
	MainWindow.Draggable = true

	UICorner.CornerRadius = UDim.new(0, 8)
	UICorner.Parent = MainWindow

	Background.Name = "Background"
	Background.Parent = MainWindow
	Background.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	Background.BorderSizePixel = 0
	Background.Size = UDim2.new(1, 0, 1, 450)
	Background.ZIndex = -1
	
	UICornerBG.CornerRadius = UDim.new(0, 8)
	UICornerBG.Parent = Background

	Shadow.Name = "Shadow"
	Shadow.Parent = MainWindow
	Shadow.BackgroundTransparency = 1.000
	Shadow.Position = UDim2.new(0, -15, 0, -15)
	Shadow.Size = UDim2.new(1, 30, 1, 480)
	Shadow.Image = "rbxassetid://5554236805"
	Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	Shadow.ImageTransparency = 0.9
	Shadow.ScaleType = Enum.ScaleType.Slice
	Shadow.SliceCenter = Rect.new(23, 23, 277, 277)
	Shadow.ZIndex = -1

	TopBar.Name = "TopBar"
	TopBar.Parent = MainWindow
	TopBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	TopBar.BackgroundTransparency = 1.000
	TopBar.BorderSizePixel = 0
	TopBar.Size = UDim2.new(1, 0, 0, 36)

	Title.Name = "Title"
	Title.Parent = TopBar
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

	CollapseButton.Name = "CollapseButton"
	CollapseButton.Parent = TopBar
	CollapseButton.BackgroundTransparency = 1.000
	CollapseButton.Position = UDim2.new(0.85, 0, 0.2, 0)
	CollapseButton.Rotation = 0
	CollapseButton.Size = UDim2.new(0, 24, 0, 24)
	CollapseButton.ZIndex = 2
	CollapseButton.Image = "rbxassetid://6031094678"
	CollapseButton.ImageColor3 = Color3.fromRGB(220, 220, 220)

	TabBar.Name = "TabBar"
	TabBar.Parent = MainWindow
	TabBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	TabBar.BackgroundTransparency = 1.000
	TabBar.BorderSizePixel = 0
	TabBar.Position = UDim2.new(0, 0, 1, 0)
	TabBar.Size = UDim2.new(1, 0, 0, 40)

	TabContainer.Name = "TabContainer"
	TabContainer.Parent = TabBar
	TabContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	TabContainer.BackgroundTransparency = 1.000
	TabContainer.BorderSizePixel = 0
	TabContainer.Position = UDim2.new(0.05, 0, 0, 0)
	TabContainer.Size = UDim2.new(0.9, 0, 1, 0)

	UIListLayout_Tabs.Parent = TabContainer
	UIListLayout_Tabs.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout_Tabs.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_Tabs.Padding = UDim.new(0, 5)

	TabsContent.Name = "TabsContent"
	TabsContent.Parent = MainWindow
	TabsContent.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	TabsContent.BackgroundTransparency = 0
	TabsContent.ClipsDescendants = true
	TabsContent.Position = UDim2.new(0, 0, 1, 40)
	TabsContent.Size = UDim2.new(1, 0, 0, 410)
	TabsContent.ZIndex = 2

	Container.Name = "Container"
	Container.Parent = MainWindow
	Container.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	Container.BackgroundTransparency = 0
	Container.ClipsDescendants = true
	Container.Position = UDim2.new(0, 0, 1, 0)
	Container.Size = UDim2.new(1, 0, 0, 450)
	Container.ZIndex = 2

	UIListLayout_2.Parent = Container
	UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_2.Padding = UDim.new(0, 8)
	UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Top

	local isCollapsed = false
	local function toggleCollapse()
		isCollapsed = not isCollapsed
		if isCollapsed then
			-- Collapse
			game:GetService("TweenService"):Create(CollapseButton, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 180}):Play();
			game:GetService("TweenService"):Create(CollapseButton, TweenInfo.new(0.25), {ImageColor3 = Color3.fromRGB(150, 150, 150)}):Play()
			Container:TweenSize(UDim2.new(1, 0, 0, 0), "InOut", "Sine", 0.25, true)
			TabBar:TweenSize(UDim2.new(1, 0, 0, 0), "InOut", "Sine", 0.25, true)
			TabsContent:TweenSize(UDim2.new(1, 0, 0, 0), "InOut", "Sine", 0.25, true)
			game:GetService("TweenService"):Create(Background, TweenInfo.new(0.25), {Size = UDim2.new(1, 0, 1, 0)}):Play()
			game:GetService("TweenService"):Create(Shadow, TweenInfo.new(0.25), {Size = UDim2.new(1, 30, 1, 30)}):Play()
		else
			-- Expand
			game:GetService("TweenService"):Create(CollapseButton, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0}):Play();
			game:GetService("TweenService"):Create(CollapseButton, TweenInfo.new(0.25), {ImageColor3 = Color3.fromRGB(220, 220, 220)}):Play()
			Container:TweenSize(UDim2.new(1, 0, 0, 450), "InOut", "Sine", 0.2, true)
			TabBar:TweenSize(UDim2.new(1, 0, 0, 40), "InOut", "Sine", 0.2, true)
			TabsContent:TweenSize(UDim2.new(1, 0, 0, 410), "InOut", "Sine", 0.2, true)
			game:GetService("TweenService"):Create(Background, TweenInfo.new(0.25), {Size = UDim2.new(1, 0, 1, 450)}):Play()
			game:GetService("TweenService"):Create(Shadow, TweenInfo.new(0.25), {Size = UDim2.new(1, 30, 1, 480)}):Play()
		end
	end

	CollapseButton.MouseButton1Click:Connect(toggleCollapse)
	
	local Lib = {}
	local currentTab = nil
	local tabContents = {}
	local tabButtons = {}
	
	function Lib:Tab(tabName)
		local tabContent = Instance.new("ScrollingFrame")
		local UIListLayout_TabContent = Instance.new("UIListLayout")
		local tabButton = Instance.new("TextButton")
		local tabButtonText = Instance.new("TextLabel")
		
		tabButton.Name = "TabButton_" .. tabName
		tabButton.Parent = TabContainer
		tabButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
		tabButton.BackgroundTransparency = 0
		tabButton.BorderSizePixel = 0
		tabButton.Size = UDim2.new(0, 70, 0, 30)
		tabButton.Font = Enum.Font.SourceSans
		tabButton.Text = ""
		tabButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		tabButton.TextSize = 14.000
		tabButton.AutoButtonColor = false
		
		local UICorner_tab = Instance.new("UICorner")
		UICorner_tab.CornerRadius = UDim.new(0, 6)
		UICorner_tab.Parent = tabButton
		
		tabButtonText.Name = "TabButtonText"
		tabButtonText.Parent = tabButton
		tabButtonText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		tabButtonText.BackgroundTransparency = 1.000
		tabButtonText.Size = UDim2.new(1, 0, 1, 0)
		tabButtonText.Font = Enum.Font.GothamMedium
		tabButtonText.Text = tabName
		tabButtonText.TextColor3 = Color3.fromRGB(180, 180, 180)
		tabButtonText.TextSize = 12
		
		tabContent.Name = "TabContent_" .. tabName
		tabContent.Parent = TabsContent
		tabContent.Active = true
		tabContent.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
		tabContent.BackgroundTransparency = 1.000
		tabContent.BorderSizePixel = 0
		tabContent.Size = UDim2.new(1, 0, 1, 0)
		tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
		tabContent.ScrollBarThickness = 3
		tabContent.ScrollBarImageColor3 = Color3.fromRGB(40, 40, 40)
		tabContent.Visible = false
		
		UIListLayout_TabContent.Parent = tabContent
		UIListLayout_TabContent.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout_TabContent.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_TabContent.Padding = UDim.new(0, 8)
		UIListLayout_TabContent.VerticalAlignment = Enum.VerticalAlignment.Top
		
		tabContents[tabName] = tabContent
		tabButtons[tabName] = {button = tabButton, text = tabButtonText}
		
		if not currentTab then
			currentTab = tabName
			tabContent.Visible = true
			tabButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
			tabButtonText.TextColor3 = Color3.fromRGB(255, 255, 255)
		end
		
		tabButton.MouseButton1Click:Connect(function()
			if currentTab ~= tabName then
				if currentTab then
					tabContents[currentTab].Visible = false
					tabButtons[currentTab].button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
					tabButtons[currentTab].text.TextColor3 = Color3.fromRGB(180, 180, 180)
				end
				
				currentTab = tabName
				tabContent.Visible = true
				tabButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
				tabButtonText.TextColor3 = Color3.fromRGB(255, 255, 255)
			end
		end)
		
		tabButton.MouseEnter:Connect(function()
			if currentTab ~= tabName then
				game:GetService("TweenService"):Create(tabButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
			end
		end)
		
		tabButton.MouseLeave:Connect(function()
			if currentTab ~= tabName then
				game:GetService("TweenService"):Create(tabButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
			end
		end)
		
		local TabLib = {}
		
		function TabLib:Folder(folderName)
			local FolderContainer = Instance.new("Frame")
			local UICorner_folder = Instance.new("UICorner")
			local FolderHeader = Instance.new("Frame")
			local FolderName = Instance.new("TextLabel")
			local FolderToggle = Instance.new("ImageButton")
			local FolderContent = Instance.new("Frame")
			local UIListLayout_Folder = Instance.new("UIListLayout")
			
			FolderContainer.Name = "FolderContainer_" .. folderName
			FolderContainer.Parent = tabContent
			FolderContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			FolderContainer.BorderSizePixel = 0
			FolderContainer.Size = UDim2.new(0.92, 0, 0, 40)
			FolderContainer.ClipsDescendants = true
			
			UICorner_folder.CornerRadius = UDim.new(0, 6)
			UICorner_folder.Parent = FolderContainer
			
			FolderHeader.Name = "FolderHeader"
			FolderHeader.Parent = FolderContainer
			FolderHeader.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			FolderHeader.BackgroundTransparency = 1.000
			FolderHeader.BorderSizePixel = 0
			FolderHeader.Size = UDim2.new(1, 0, 0, 40)
			
			FolderName.Name = "FolderName"
			FolderName.Parent = FolderHeader
			FolderName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			FolderName.BackgroundTransparency = 1.000
			FolderName.Position = UDim2.new(0.05, 0, 0, 0)
			FolderName.Size = UDim2.new(0.8, 0, 1, 0)
			FolderName.Font = Enum.Font.GothamMedium
			FolderName.Text = folderName
			FolderName.TextColor3 = Color3.fromRGB(220, 220, 220)
			FolderName.TextSize = 14
			FolderName.TextXAlignment = Enum.TextXAlignment.Left
			
			FolderToggle.Name = "FolderToggle"
			FolderToggle.Parent = FolderHeader
			FolderToggle.BackgroundTransparency = 1.000
			FolderToggle.Position = UDim2.new(0.85, 0, 0.25, 0)
			FolderToggle.Rotation = 0
			FolderToggle.Size = UDim2.new(0, 20, 0, 20)
			FolderToggle.Image = "rbxassetid://6031094678"
			FolderToggle.ImageColor3 = Color3.fromRGB(150, 150, 150)
			
			FolderContent.Name = "FolderContent"
			FolderContent.Parent = FolderContainer
			FolderContent.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			FolderContent.BackgroundTransparency = 1.000
			FolderContent.BorderSizePixel = 0
			FolderContent.Position = UDim2.new(0, 0, 1, 0)
			FolderContent.Size = UDim2.new(1, 0, 0, 0)
			
			UIListLayout_Folder.Parent = FolderContent
			UIListLayout_Folder.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout_Folder.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_Folder.Padding = UDim.new(0, 5)
			UIListLayout_Folder.VerticalAlignment = Enum.VerticalAlignment.Top
			
			local isFolderOpen = true
			local folderElements = {}
			local function toggleFolder()
				isFolderOpen = not isFolderOpen
				if isFolderOpen then
					game:GetService("TweenService"):Create(FolderToggle, TweenInfo.new(0.2), {Rotation = 0}):Play()
					FolderContent:TweenSize(UDim2.new(1, 0, 0, #folderElements * 45), "Out", "Sine", 0.2)
					wait(0.2)
					FolderContainer:TweenSize(UDim2.new(0.92, 0, 0, 40 + #folderElements * 45), "Out", "Sine", 0.2)
				else
					game:GetService("TweenService"):Create(FolderToggle, TweenInfo.new(0.2), {Rotation = -90}):Play()
					FolderContent:TweenSize(UDim2.new(1, 0, 0, 0), "Out", "Sine", 0.2)
					wait(0.2)
					FolderContainer:TweenSize(UDim2.new(0.92, 0, 0, 40), "Out", "Sine", 0.2)
				end
			end
			
			FolderToggle.MouseButton1Click:Connect(toggleFolder)
			FolderHeader.MouseButton1Click:Connect(toggleFolder)
			
			local FolderLib = {}
			
			function FolderLib:Button(name, callback)
				local ButtonContainer = Instance.new("Frame")
				local UICorner_btn = Instance.new("UICorner")
				local Button = Instance.new("TextButton")
				local ButtonName = Instance.new("TextLabel")
				local ButtonHover = Instance.new("Frame")
				
				ButtonContainer.Name = "ButtonContainer"
				ButtonContainer.Parent = FolderContent
				ButtonContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				ButtonContainer.BorderSizePixel = 0
				ButtonContainer.Size = UDim2.new(0.9, 0, 0, 36)
				
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
					game:GetService("TweenService"):Create(ButtonContainer, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
				end)
				
				Button.MouseLeave:Connect(function()
					ButtonHover.Visible = false
					game:GetService("TweenService"):Create(ButtonContainer, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
				end)
				
				Button.MouseButton1Click:Connect(function()
					game:GetService("TweenService"):Create(ButtonContainer, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(0, 170, 255)}):Play()
					wait(0.1)
					game:GetService("TweenService"):Create(ButtonContainer, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
					callback()
				end)
				
				table.insert(folderElements, ButtonContainer)
			end
			
			function FolderLib:Toggle(name, callback)
				local ToggleContainer = Instance.new("Frame")
				local UICorner_toggle = Instance.new("UICorner")
				local ToggleName = Instance.new("TextLabel")
				local Toggle = Instance.new("TextButton")
				local UICorner_3 = Instance.new("UICorner")
				local ToggleIndicator = Instance.new("Frame")
				local UICorner_indicator = Instance.new("UICorner")
				
				ToggleContainer.Name = "ToggleContainer"
				ToggleContainer.Parent = FolderContent
				ToggleContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
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
				ToggleName.Font = Enum.Font.GothamMedium
				ToggleName.Text = name
				ToggleName.TextColor3 = Color3.fromRGB(220, 220, 220)
				ToggleName.TextSize = 14
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
						game:GetService("TweenService"):Create(Toggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
					end
					callback(Toggled)
				end)
				
				table.insert(folderElements, ToggleContainer)
			end
			
			function FolderLib:Slider(name, min, max, default, callback)
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
				SliderContainer.Parent = FolderContent
				SliderContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				SliderContainer.BorderSizePixel = 0
				SliderContainer.Size = UDim2.new(0.9, 0, 0, 50)
				
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
				SliderTrack.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
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
				
				table.insert(folderElements, SliderContainer)
			end
			
			function FolderLib:Dropdown(name, options, callback)
				local DropdownContainer = Instance.new("Frame")
				local UICorner_dropdown = Instance.new("UICorner")
				local DropdownName = Instance.new("TextLabel")
				local DropdownButton = Instance.new("TextButton")
				local DropdownArrow = Instance.new("ImageLabel")
				local DropdownSelected = Instance.new("TextLabel")
				
				DropdownContainer.Name = "DropdownContainer"
				DropdownContainer.Parent = FolderContent
				DropdownContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
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
				DropdownName.Font = Enum.Font.GothamMedium
				DropdownName.Text = name
				DropdownName.TextColor3 = Color3.fromRGB(220, 220, 220)
				DropdownName.TextSize = 14
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
				DropdownList.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
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
						game:GetService("TweenService"):Create(DropdownButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
						DropdownList:TweenSize(UDim2.new(0, DropdownButton.AbsoluteSize.X, 0, updateListHeight()), "Out", "Sine", 0.2)
					else
						game:GetService("TweenService"):Create(DropdownArrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
						game:GetService("TweenService"):Create(DropdownButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
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
					OptionButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
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
						game:GetService("TweenService"):Create(OptionButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
					end)
					
					OptionButton.MouseLeave:Connect(function()
						game:GetService("TweenService"):Create(OptionButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
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
				
				table.insert(folderElements, DropdownContainer)
			end
			
			function FolderLib:Colorpicker(name, defaultColor, callback)
				local ColorpickerContainer = Instance.new("Frame")
				local UICorner_color = Instance.new("UICorner")
				local ColorpickerName = Instance.new("TextLabel")
				local ColorButton = Instance.new("TextButton")
				local ColorPreview = Instance.new("Frame")
				local UICorner_preview = Instance.new("UICorner")
				
				ColorpickerContainer.Name = "ColorpickerContainer"
				ColorpickerContainer.Parent = FolderContent
				ColorpickerContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
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
				ColorpickerName.Font = Enum.Font.GothamMedium
				ColorpickerName.Text = name
				ColorpickerName.TextColor3 = Color3.fromRGB(220, 220, 220)
				ColorpickerName.TextSize = 14
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
					colorPickerFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
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
					RGBInputs.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
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
					RBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
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
					GBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
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
					BBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
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
					CloseButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
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
				
				table.insert(folderElements, ColorpickerContainer)
			end
			
			function FolderLib:Bind(name, defaultKey, callback)
				local BindContainer = Instance.new("Frame")
				local UICorner_bind = Instance.new("UICorner")
				local BindName = Instance.new("TextLabel")
				local BindButton = Instance.new("TextButton")
				local BindKeyText = Instance.new("TextLabel")
				
				BindContainer.Name = "BindContainer"
				BindContainer.Parent = FolderContent
				BindContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				BindContainer.BorderSizePixel = 0
				BindContainer.Size = UDim2.new(0.9, 0, 0, 36)
				
				UICorner_bind.CornerRadius = UDim.new(0, 6)
				UICorner_bind.Parent = BindContainer
				
				BindName.Name = "BindName"
				BindName.Parent = BindContainer
				BindName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				BindName.BackgroundTransparency = 1.000
				BindName.Position = UDim2.new(0.05, 0, 0, 0)
				BindName.Size = UDim2.new(0.65, 0, 1, 0)
				BindName.Font = Enum.Font.GothamMedium
				BindName.Text = name
				BindName.TextColor3 = Color3.fromRGB(220, 220, 220)
				BindName.TextSize = 14
				BindName.TextXAlignment = Enum.TextXAlignment.Left
				
				BindButton.Name = "BindButton"
				BindButton.Parent = BindContainer
				BindButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				BindButton.BackgroundTransparency = 0
				BindButton.Position = UDim2.new(0.7, 0, 0.22, 0)
				BindButton.Size = UDim2.new(0.25, 0, 0, 20)
				BindButton.Font = Enum.Font.Gotham
				BindButton.Text = ""
				BindButton.TextColor3 = Color3.fromRGB(220, 220, 220)
				BindButton.TextSize = 12
				BindButton.AutoButtonColor = false
				
				local UICorner_btn = Instance.new("UICorner")
				UICorner_btn.CornerRadius = UDim.new(0, 4)
				UICorner_btn.Parent = BindButton
				
				BindKeyText.Name = "BindKeyText"
				BindKeyText.Parent = BindButton
				BindKeyText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				BindKeyText.BackgroundTransparency = 1.000
				BindKeyText.Size = UDim2.new(1, 0, 1, 0)
				BindKeyText.Font = Enum.Font.Gotham
				BindKeyText.Text = tostring(defaultKey)
				BindKeyText.TextColor3 = Color3.fromRGB(200, 200, 200)
				BindKeyText.TextSize = 12
				
				local listening = false
				local currentKey = defaultKey
				
				local function updateBind(key)
					currentKey = key
					BindKeyText.Text = tostring(key)
					callback(key)
				end
				
				BindButton.MouseButton1Click:Connect(function()
					if not listening then
						listening = true
						BindKeyText.Text = "..."
						BindButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
						
						local connection
						connection = game:GetService("UserInputService").InputBegan:Connect(function(input)
							if listening and input.UserInputType == Enum.UserInputType.Keyboard then
								updateBind(input.KeyCode.Name)
								listening = false
								BindButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
								connection:Disconnect()
							end
						end)
						
						local cancelConnection
						cancelConnection = game:GetService("UserInputService").InputBegan:Connect(function(input)
							if listening and input.UserInputType == Enum.UserInputType.MouseButton1 then
								local mousePos = game:GetService("UserInputService"):GetMouseLocation()
								local buttonPos = BindButton.AbsolutePosition
								local buttonSize = BindButton.AbsoluteSize
								
								if not (mousePos.X >= buttonPos.X and mousePos.X <= buttonPos.X + buttonSize.X and
									   mousePos.Y >= buttonPos.Y and mousePos.Y <= buttonPos.Y + buttonSize.Y) then
									listening = false
									BindButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
									BindKeyText.Text = tostring(currentKey)
									connection:Disconnect()
									cancelConnection:Disconnect()
								end
							end
						end)
					end
				end)
				
				updateBind(defaultKey)
				
				table.insert(folderElements, BindContainer)
			end
			
			function FolderLib:Box(name, placeholder, callback)
				local BoxContainer = Instance.new("Frame")
				local UICorner_box = Instance.new("UICorner")
				local BoxName = Instance.new("TextLabel")
				local TextBox = Instance.new("TextBox")
				
				BoxContainer.Name = "BoxContainer"
				BoxContainer.Parent = FolderContent
				BoxContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				BoxContainer.BorderSizePixel = 0
				BoxContainer.Size = UDim2.new(0.9, 0, 0, 36)
				
				UICorner_box.CornerRadius = UDim.new(0, 6)
				UICorner_box.Parent = BoxContainer
				
				BoxName.Name = "BoxName"
				BoxName.Parent = BoxContainer
				BoxName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				BoxName.BackgroundTransparency = 1.000
				BoxName.Position = UDim2.new(0.05, 0, 0, 0)
				BoxName.Size = UDim2.new(0.65, 0, 1, 0)
				BoxName.Font = Enum.Font.GothamMedium
				BoxName.Text = name
				BoxName.TextColor3 = Color3.fromRGB(220, 220, 220)
				BoxName.TextSize = 14
				BoxName.TextXAlignment = Enum.TextXAlignment.Left
				
				TextBox.Name = "TextBox"
				TextBox.Parent = BoxContainer
				TextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				TextBox.BackgroundTransparency = 0
				TextBox.BorderSizePixel = 0
				TextBox.Position = UDim2.new(0.7, 0, 0.22, 0)
				TextBox.Size = UDim2.new(0.25, 0, 0, 20)
				TextBox.Font = Enum.Font.Gotham
				TextBox.PlaceholderText = placeholder or "Enter text..."
				TextBox.Text = ""
				TextBox.TextColor3 = Color3.fromRGB(220, 220, 220)
				TextBox.TextSize = 12
				TextBox.ClearTextOnFocus = false
				
				local UICorner_textbox = Instance.new("UICorner")
				UICorner_textbox.CornerRadius = UDim.new(0, 4)
				UICorner_textbox.Parent = TextBox
				
				TextBox.FocusLost:Connect(function()
					callback(TextBox.Text)
				end)
				
				table.insert(folderElements, BoxContainer)
			end
			
			function FolderLib:Label(text)
				local LabelContainer = Instance.new("Frame")
				local UICorner_label = Instance.new("UICorner")
				local LabelText = Instance.new("TextLabel")
				
				LabelContainer.Name = "LabelContainer"
				LabelContainer.Parent = FolderContent
				LabelContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				LabelContainer.BorderSizePixel = 0
				LabelContainer.Size = UDim2.new(0.9, 0, 0, 30)
				
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
				
				table.insert(folderElements, LabelContainer)
			end
			
			function FolderLib:Separator()
				local SeparatorContainer = Instance.new("Frame")
				local SeparatorLine = Instance.new("Frame")
				
				SeparatorContainer.Name = "SeparatorContainer"
				SeparatorContainer.Parent = FolderContent
				SeparatorContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				SeparatorContainer.BorderSizePixel = 0
				SeparatorContainer.Size = UDim2.new(0.9, 0, 0, 10)
				
				SeparatorLine.Name = "SeparatorLine"
				SeparatorLine.Parent = SeparatorContainer
				SeparatorLine.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
				SeparatorLine.BorderSizePixel = 0
				SeparatorLine.Position = UDim2.new(0.1, 0, 0.5, 0)
				SeparatorLine.Size = UDim2.new(0.8, 0, 0, 1)
				
				table.insert(folderElements, SeparatorContainer)
			end
			
			function FolderLib:DestroyGui()
				local ButtonContainer = Instance.new("Frame")
				local UICorner_btn = Instance.new("UICorner")
				local Button = Instance.new("TextButton")
				local ButtonName = Instance.new("TextLabel")
				local ButtonHover = Instance.new("Frame")
				
				ButtonContainer.Name = "ButtonContainer"
				ButtonContainer.Parent = FolderContent
				ButtonContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				ButtonContainer.BorderSizePixel = 0
				ButtonContainer.Size = UDim2.new(0.9, 0, 0, 36)
				
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
				ButtonName.Text = "Destroy UI"
				ButtonName.TextColor3 = Color3.fromRGB(255, 100, 100)
				ButtonName.TextSize = 14
				
				Button.MouseEnter:Connect(function()
					ButtonHover.Visible = true
					game:GetService("TweenService"):Create(ButtonContainer, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 25, 25)}):Play()
				end)
				
				Button.MouseLeave:Connect(function()
					ButtonHover.Visible = false
					game:GetService("TweenService"):Create(ButtonContainer, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
				end)
				
				Button.MouseButton1Click:Connect(function()
					game:GetService("TweenService"):Create(ButtonContainer, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(255, 50, 50)}):Play()
					wait(0.1)
					game:GetService("TweenService"):Create(ButtonContainer, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
					MainWindow:Destroy()
				end)
				
				table.insert(folderElements, ButtonContainer)
			end
			
			return FolderLib
		end
		
		return TabLib
	end
	
	return Lib
	
end

return Library
