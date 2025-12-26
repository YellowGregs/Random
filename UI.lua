-- this is pretty gay

local AF_UI = {}
AF_UI.__index = AF_UI

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Colors = {
    Primary = Color3.fromRGB(45, 125, 255),
    Secondary = Color3.fromRGB(100, 100, 255),
    Success = Color3.fromRGB(46, 204, 113),
    Danger = Color3.fromRGB(231, 76, 60),
    Warning = Color3.fromRGB(241, 196, 15),
    Dark = Color3.fromRGB(30, 30, 40),
    Darker = Color3.fromRGB(20, 20, 30),
    Light = Color3.fromRGB(240, 240, 245),
    Lighter = Color3.fromRGB(250, 250, 255)
}

local function Create(class, properties)
    local obj = Instance.new(class)
    for prop, value in pairs(properties) do
        if prop ~= "Parent" then
            obj[prop] = value
        end
    end
    return obj
end

local function Tween(object, properties, duration, easingStyle, easingDirection)
    local tweenInfo = TweenInfo.new(duration or 0.2, easingStyle or Enum.EasingStyle.Quad, easingDirection or Enum.EasingDirection.Out)
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

function AF_UI.new(options)
    options = options or {}
    
    local self = setmetatable({}, AF_UI)
    
    self.Enabled = false
    self.Theme = options.Theme or "Dark"
    self.AccentColor = options.AccentColor or Colors.Primary
    self.Transparency = options.Transparency or 0
    self.Blur = options.Blur or false
    
    self.ScreenGui = Create("ScreenGui", {
        Name = "AF_UIV3",
        DisplayOrder = 99,
        ResetOnSpawn = false
    })
    
    if options.Parent then
        self.ScreenGui.Parent = options.Parent
    else
        self.ScreenGui.Parent = game:GetService("CoreGui") or game.Players.LocalPlayer:WaitForChild("PlayerGui")
    end
    
    if self.Blur then
        self.BlurEffect = Create("BlurEffect", {
            Name = "AF_UIBlur",
            Size = 8,
            Parent = game:GetService("Lighting")
        })
    end
    
    return self
end

function AF_UI:Window(options)
    options = options or {}
    
    local Window = {}
    Window.Title = options.Title or "AF UI V3"
    Window.Size = options.Size or UDim2.new(0, 500, 0, 400)
    Window.Position = options.Position or UDim2.new(0.5, -250, 0.5, -200)
    Window.Visible = options.Visible or false
    
    local MainFrame = Create("Frame", {
        Name = "MainWindow",
        Size = Window.Size,
        Position = Window.Position,
        BackgroundColor3 = self.Theme == "Dark" and Colors.Dark or Colors.Light,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Visible = Window.Visible
    })
    
    local TopBar = Create("Frame", {
        Name = "TopBar",
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = self.Theme == "Dark" and Colors.Darker or Colors.Lighter,
        BorderSizePixel = 0,
        Parent = MainFrame
    })
    
    local Title = Create("TextLabel", {
        Name = "Title",
        Size = UDim2.new(0.8, 0, 1, 0),
        Position = UDim2.new(0.1, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = Window.Title,
        TextColor3 = self.Theme == "Dark" and Colors.Light or Colors.Dark,
        TextSize = 16,
        Font = Enum.Font.GothamSemibold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = TopBar
    })
    
    local CloseButton = Create("TextButton", {
        Name = "CloseButton",
        Size = UDim2.new(0, 40, 0, 40),
        Position = UDim2.new(1, -40, 0, 0),
        BackgroundTransparency = 1,
        Text = "×",
        TextColor3 = self.Theme == "Dark" and Colors.Light or Colors.Dark,
        TextSize = 20,
        Font = Enum.Font.GothamBold,
        Parent = TopBar
    })
    
    local TabContainer = Create("Frame", {
        Name = "TabContainer",
        Size = UDim2.new(0, 120, 1, -40),
        Position = UDim2.new(0, 0, 0, 40),
        BackgroundColor3 = self.Theme == "Dark" and Colors.Darker or Colors.Lighter,
        BorderSizePixel = 0,
        Parent = MainFrame
    })
    
    local TabListLayout = Create("UIListLayout", {
        Name = "TabListLayout",
        Padding = UDim.new(0, 5),
        Parent = TabContainer
    })
    
    local TabPadding = Create("UIPadding", {
        Name = "TabPadding",
        PaddingTop = UDim.new(0, 10),
        PaddingLeft = UDim.new(0, 5),
        Parent = TabContainer
    })
    
    local ContentContainer = Create("ScrollingFrame", {
        Name = "ContentContainer",
        Size = UDim2.new(1, -120, 1, -40),
        Position = UDim2.new(0, 120, 0, 40),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = self.AccentColor,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        Parent = MainFrame
    })
    
    local ContentLayout = Create("UIListLayout", {
        Name = "ContentLayout",
        Padding = UDim.new(0, 10),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = ContentContainer
    })
    
    local ContentPadding = Create("UIPadding", {
        Name = "ContentPadding",
        PaddingTop = UDim.new(0, 15),
        PaddingLeft = UDim.new(0, 15),
        PaddingRight = UDim.new(0, 15),
        PaddingBottom = UDim.new(0, 15),
        Parent = ContentContainer
    })
    
    MainFrame.Parent = self.ScreenGui
    
    local dragging
    local dragInput
    local dragStart
    local startPos
    
    local function UpdateInput(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    TopBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            UpdateInput(input)
        end
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        self:Toggle()
    end)
    
    CloseButton.MouseEnter:Connect(function()
        Tween(CloseButton, {TextColor3 = Colors.Danger})
    end)
    
    CloseButton.MouseLeave:Connect(function()
        Tween(CloseButton, {TextColor3 = self.Theme == "Dark" and Colors.Light or Colors.Dark})
    end)
    
    function Window:Toggle()
        self.Visible = not self.Visible
        MainFrame.Visible = self.Visible
        
        if self.Blur then
            if self.Visible then
                Tween(self.BlurEffect, {Size = 8})
            else
                Tween(self.BlurEffect, {Size = 0})
            end
        end
    end
    
    function Window:Tab(name, icon)
        local Tab = {}
        local TabButton = Create("TextButton", {
            Name = name .. "Tab",
            Size = UDim2.new(1, -10, 0, 35),
            BackgroundColor3 = self.Theme == "Dark" and Colors.Dark or Colors.Light,
            BorderSizePixel = 0,
            Text = "  " .. name,
            TextColor3 = self.Theme == "Dark" and Colors.Light or Colors.Dark,
            TextSize = 14,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = #TabContainer:GetChildren(),
            Parent = TabContainer
        })
        
        local TabContent = Create("Frame", {
            Name = name .. "Content",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Visible = false,
            Parent = ContentContainer
        })
        
        local TabContentLayout = Create("UIListLayout", {
            Name = "TabContentLayout",
            Padding = UDim.new(0, 10),
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = TabContent
        })
        
        local TabContentPadding = Create("UIPadding", {
            Name = "TabContentPadding",
            PaddingTop = UDim.new(0, 0),
            Parent = TabContent
        })
        
        if #TabContainer:GetChildren() == 1 then
            TabButton.BackgroundColor3 = self.AccentColor
            TabButton.TextColor3 = Colors.Lighter
            TabContent.Visible = true
        end
        
        TabButton.MouseButton1Click:Connect(function()
            for _, child in pairs(TabContainer:GetChildren()) do
                if child:IsA("TextButton") then
                    Tween(child, {BackgroundColor3 = self.Theme == "Dark" and Colors.Dark or Colors.Light})
                    Tween(child, {TextColor3 = self.Theme == "Dark" and Colors.Light or Colors.Dark})
                end
            end
            
            for _, child in pairs(ContentContainer:GetChildren()) do
                if child:IsA("Frame") and child.Name:match("Content$") then
                    child.Visible = false
                end
            end
            
            Tween(TabButton, {BackgroundColor3 = self.AccentColor})
            Tween(TabButton, {TextColor3 = Colors.Lighter})
            TabContent.Visible = true
        end)
        
        TabButton.MouseEnter:Connect(function()
            if TabButton.BackgroundColor3 ~= self.AccentColor then
                Tween(TabButton, {BackgroundColor3 = self.Theme == "Dark" and Color3.fromRGB(40, 40, 50) or Color3.fromRGB(230, 230, 235)})
            end
        end)
        
        TabButton.MouseLeave:Connect(function()
            if TabButton.BackgroundColor3 ~= self.AccentColor then
                Tween(TabButton, {BackgroundColor3 = self.Theme == "Dark" and Colors.Dark or Colors.Light})
            end
        end)
        
        function Tab:Section(name)
            local Section = {}
            
            local SectionFrame = Create("Frame", {
                Name = name .. "Section",
                Size = UDim2.new(1, 0, 0, 40),
                BackgroundTransparency = 1,
                LayoutOrder = #TabContent:GetChildren(),
                Parent = TabContent
            })
            
            local SectionTitle = Create("TextLabel", {
                Name = "SectionTitle",
                Size = UDim2.new(1, 0, 0, 25),
                BackgroundTransparency = 1,
                Text = string.upper(name),
                TextColor3 = self.AccentColor,
                TextSize = 12,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = SectionFrame
            })
            
            local SectionLine = Create("Frame", {
                Name = "SectionLine",
                Size = UDim2.new(1, 0, 0, 1),
                Position = UDim2.new(0, 0, 0, 25),
                BackgroundColor3 = self.AccentColor,
                BorderSizePixel = 0,
                Parent = SectionFrame
            })
            
            local SectionContainer = Create("Frame", {
                Name = "SectionContainer",
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 0, 30),
                BackgroundTransparency = 1,
                Parent = SectionFrame
            })
            
            local SectionLayout = Create("UIListLayout", {
                Name = "SectionLayout",
                Padding = UDim.new(0, 8),
                SortOrder = Enum.SortOrder.LayoutOrder,
                Parent = SectionContainer
            })
            
            function Section:UpdateSize()
                local totalHeight = 0
                for _, child in pairs(SectionContainer:GetChildren()) do
                    if child:IsA("Frame") then
                        totalHeight = totalHeight + child.Size.Y.Offset + SectionLayout.Padding.Offset
                    end
                end
                SectionContainer.Size = UDim2.new(1, 0, 0, totalHeight)
                SectionFrame.Size = UDim2.new(1, 0, 0, totalHeight + 30)
            end
            
            function Section:Button(options)
                options = options or {}
                local Button = {}
                
                local ButtonFrame = Create("Frame", {
                    Name = options.Text .. "Button",
                    Size = UDim2.new(1, 0, 0, 35),
                    BackgroundColor3 = self.Theme == "Dark" and Color3.fromRGB(40, 40, 50) or Color3.fromRGB(230, 230, 235),
                    BorderSizePixel = 0,
                    LayoutOrder = #SectionContainer:GetChildren(),
                    Parent = SectionContainer
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(0, 6),
                    Parent = ButtonFrame
                })
                
                local ButtonText = Create("TextLabel", {
                    Name = "ButtonText",
                    Size = UDim2.new(0.7, 0, 1, 0),
                    Position = UDim2.new(0.1, 0, 0, 0),
                    BackgroundTransparency = 1,
                    Text = options.Text or "Button",
                    TextColor3 = self.Theme == "Dark" and Colors.Light or Colors.Dark,
                    TextSize = 14,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = ButtonFrame
                })
                
                local ButtonButton = Create("TextButton", {
                    Name = "Button",
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = "",
                    Parent = ButtonFrame
                })
                
                ButtonButton.MouseButton1Click:Connect(function()
                    if options.Callback then
                        options.Callback()
                    end
                    Tween(ButtonFrame, {BackgroundColor3 = self.AccentColor})
                    wait(0.1)
                    Tween(ButtonFrame, {BackgroundColor3 = self.Theme == "Dark" and Color3.fromRGB(40, 40, 50) or Color3.fromRGB(230, 230, 235)})
                end)
                
                ButtonButton.MouseEnter:Connect(function()
                    Tween(ButtonFrame, {BackgroundColor3 = Color3.fromRGB(50, 50, 60)})
                end)
                
                ButtonButton.MouseLeave:Connect(function()
                    Tween(ButtonFrame, {BackgroundColor3 = self.Theme == "Dark" and Color3.fromRGB(40, 40, 50) or Color3.fromRGB(230, 230, 235)})
                end)
                
                Section:UpdateSize()
                return Button
            end
            
            function Section:Toggle(options)
                options = options or {}
                local Toggle = {}
                Toggle.Value = options.Default or false
                
                local ToggleFrame = Create("Frame", {
                    Name = options.Text .. "Toggle",
                    Size = UDim2.new(1, 0, 0, 35),
                    BackgroundTransparency = 1,
                    LayoutOrder = #SectionContainer:GetChildren(),
                    Parent = SectionContainer
                })
                
                local ToggleText = Create("TextLabel", {
                    Name = "ToggleText",
                    Size = UDim2.new(0.7, 0, 1, 0),
                    Position = UDim2.new(0, 0, 0, 0),
                    BackgroundTransparency = 1,
                    Text = options.Text or "Toggle",
                    TextColor3 = self.Theme == "Dark" and Colors.Light or Colors.Dark,
                    TextSize = 14,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = ToggleFrame
                })
                
                local ToggleButton = Create("TextButton", {
                    Name = "ToggleButton",
                    Size = UDim2.new(0, 50, 0, 25),
                    Position = UDim2.new(1, -50, 0.5, -12.5),
                    BackgroundColor3 = self.Theme == "Dark" and Color3.fromRGB(60, 60, 70) or Color3.fromRGB(200, 200, 210),
                    BorderSizePixel = 0,
                    Text = "",
                    Parent = ToggleFrame
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(1, 0),
                    Parent = ToggleButton
                })
                
                local ToggleIndicator = Create("Frame", {
                    Name = "ToggleIndicator",
                    Size = UDim2.new(0, 21, 0, 21),
                    Position = UDim2.new(0, 2, 0.5, -10.5),
                    BackgroundColor3 = self.Theme == "Dark" and Colors.Light or Colors.Lighter,
                    BorderSizePixel = 0,
                    Parent = ToggleButton
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(1, 0),
                    Parent = ToggleIndicator
                })
                
                local function UpdateToggle()
                    if Toggle.Value then
                        Tween(ToggleButton, {BackgroundColor3 = self.AccentColor})
                        Tween(ToggleIndicator, {Position = UDim2.new(0, 27, 0.5, -10.5)})
                    else
                        Tween(ToggleButton, {BackgroundColor3 = self.Theme == "Dark" and Color3.fromRGB(60, 60, 70) or Color3.fromRGB(200, 200, 210)})
                        Tween(ToggleIndicator, {Position = UDim2.new(0, 2, 0.5, -10.5)})
                    end
                end
                
                ToggleButton.MouseButton1Click:Connect(function()
                    Toggle.Value = not Toggle.Value
                    UpdateToggle()
                    if options.Callback then
                        options.Callback(Toggle.Value)
                    end
                end)
                
                UpdateToggle()
                Section:UpdateSize()
                
                function Toggle:Set(value)
                    Toggle.Value = value
                    UpdateToggle()
                end
                
                return Toggle
            end
            
            function Section:Slider(options)
                options = options or {}
                local Slider = {}
                Slider.Value = options.Default or options.Min or 0
                
                local SliderFrame = Create("Frame", {
                    Name = options.Text .. "Slider",
                    Size = UDim2.new(1, 0, 0, 60),
                    BackgroundTransparency = 1,
                    LayoutOrder = #SectionContainer:GetChildren(),
                    Parent = SectionContainer
                })
                
                local SliderText = Create("TextLabel", {
                    Name = "SliderText",
                    Size = UDim2.new(1, 0, 0, 20),
                    BackgroundTransparency = 1,
                    Text = options.Text or "Slider",
                    TextColor3 = self.Theme == "Dark" and Colors.Light or Colors.Dark,
                    TextSize = 14,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = SliderFrame
                })
                
                local SliderValue = Create("TextLabel", {
                    Name = "SliderValue",
                    Size = UDim2.new(0, 50, 0, 20),
                    Position = UDim2.new(1, -50, 0, 0),
                    BackgroundTransparency = 1,
                    Text = tostring(Slider.Value),
                    TextColor3 = self.AccentColor,
                    TextSize = 14,
                    Font = Enum.Font.GothamBold,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    Parent = SliderFrame
                })
                
                local SliderTrack = Create("Frame", {
                    Name = "SliderTrack",
                    Size = UDim2.new(1, 0, 0, 6),
                    Position = UDim2.new(0, 0, 0, 30),
                    BackgroundColor3 = self.Theme == "Dark" and Color3.fromRGB(50, 50, 60) or Color3.fromRGB(210, 210, 220),
                    BorderSizePixel = 0,
                    Parent = SliderFrame
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(1, 0),
                    Parent = SliderTrack
                })
                
                local SliderFill = Create("Frame", {
                    Name = "SliderFill",
                    Size = UDim2.new(0, 0, 1, 0),
                    BackgroundColor3 = self.AccentColor,
                    BorderSizePixel = 0,
                    Parent = SliderTrack
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(1, 0),
                    Parent = SliderFill
                })
                
                local SliderButton = Create("TextButton", {
                    Name = "SliderButton",
                    Size = UDim2.new(0, 20, 0, 20),
                    Position = UDim2.new(0, -10, 0.5, -10),
                    BackgroundColor3 = Colors.Lighter,
                    BorderSizePixel = 0,
                    Text = "",
                    Parent = SliderTrack
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(1, 0),
                    Parent = SliderButton
                })
                
                Create("UIStroke", {
                    Color = self.AccentColor,
                    Thickness = 2,
                    Parent = SliderButton
                })
                
                local min = options.Min or 0
                local max = options.Max or 100
                local dragging = false
                
                local function UpdateSlider(value)
                    value = math.clamp(value, min, max)
                    Slider.Value = value
                    SliderValue.Text = options.Precise and string.format("%.2f", value) or tostring(math.floor(value))
                    
                    local percentage = (value - min) / (max - min)
                    SliderFill.Size = UDim2.new(percentage, 0, 1, 0)
                    SliderButton.Position = UDim2.new(percentage, -10, 0.5, -10)
                    
                    if options.Callback then
                        options.Callback(value)
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
                
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        local mousePos = UserInputService:GetMouseLocation()
                        local trackAbsPos = SliderTrack.AbsolutePosition
                        local trackAbsSize = SliderTrack.AbsoluteSize
                        
                        local relativeX = (mousePos.X - trackAbsPos.X) / trackAbsSize.X
                        relativeX = math.clamp(relativeX, 0, 1)
                        
                        local value = min + (relativeX * (max - min))
                        UpdateSlider(value)
                    end
                end)
                
                UpdateSlider(Slider.Value)
                Section:UpdateSize()
                
                function Slider:Set(value)
                    UpdateSlider(value)
                end
                
                return Slider
            end
            
            function Section:Dropdown(options)
                options = options or {}
                local Dropdown = {}
                Dropdown.Value = options.Default or options.List and options.List[1] or nil
                Dropdown.Open = false
                
                local DropdownFrame = Create("Frame", {
                    Name = options.Text .. "Dropdown",
                    Size = UDim2.new(1, 0, 0, 35),
                    BackgroundTransparency = 1,
                    LayoutOrder = #SectionContainer:GetChildren(),
                    Parent = SectionContainer
                })
                
                local DropdownButton = Create("TextButton", {
                    Name = "DropdownButton",
                    Size = UDim2.new(1, 0, 0, 35),
                    BackgroundColor3 = self.Theme == "Dark" and Color3.fromRGB(40, 40, 50) or Color3.fromRGB(230, 230, 235),
                    BorderSizePixel = 0,
                    Text = "",
                    Parent = DropdownFrame
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(0, 6),
                    Parent = DropdownButton
                })
                
                local DropdownText = Create("TextLabel", {
                    Name = "DropdownText",
                    Size = UDim2.new(0.8, 0, 1, 0),
                    Position = UDim2.new(0.05, 0, 0, 0),
                    BackgroundTransparency = 1,
                    Text = Dropdown.Value or options.Text or "Select...",
                    TextColor3 = self.Theme == "Dark" and Colors.Light or Colors.Dark,
                    TextSize = 14,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = DropdownButton
                })
                
                local DropdownArrow = Create("ImageLabel", {
                    Name = "DropdownArrow",
                    Size = UDim2.new(0, 20, 0, 20),
                    Position = UDim2.new(0.95, -20, 0.5, -10),
                    BackgroundTransparency = 1,
                    Image = "rbxassetid://6031091003",
                    ImageColor3 = self.Theme == "Dark" and Colors.Light or Colors.Dark,
                    Rotation = 180,
                    Parent = DropdownButton
                })
                
                local DropdownList = Create("ScrollingFrame", {
                    Name = "DropdownList",
                    Size = UDim2.new(1, 0, 0, 0),
                    Position = UDim2.new(0, 0, 1, 5),
                    BackgroundColor3 = self.Theme == "Dark" and Colors.Darker or Colors.Light,
                    BorderSizePixel = 0,
                    ScrollBarThickness = 0,
                    CanvasSize = UDim2.new(0, 0, 0, 0),
                    Visible = false,
                    ClipsDescendants = true,
                    Parent = DropdownFrame
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(0, 6),
                    Parent = DropdownList
                })
                
                local DropdownListLayout = Create("UIListLayout", {
                    Name = "DropdownListLayout",
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Parent = DropdownList
                })
                
                local function UpdateDropdownHeight()
                    local itemCount = #DropdownList:GetChildren() - 1
                    DropdownList.Size = UDim2.new(1, 0, 0, math.min(itemCount * 30, 150))
                    DropdownList.CanvasSize = UDim2.new(0, 0, 0, itemCount * 30)
                end
                
                local function ToggleDropdown()
                    Dropdown.Open = not Dropdown.Open
                    
                    if Dropdown.Open then
                        Tween(DropdownList, {Size = UDim2.new(1, 0, 0, math.min(#options.List * 30, 150))})
                        Tween(DropdownArrow, {Rotation = 0})
                        DropdownList.Visible = true
                    else
                        Tween(DropdownList, {Size = UDim2.new(1, 0, 0, 0)})
                        Tween(DropdownArrow, {Rotation = 180})
                        wait(0.2)
                        DropdownList.Visible = false
                    end
                end
                
                DropdownButton.MouseButton1Click:Connect(function()
                    ToggleDropdown()
                end)
                
                if options.List then
                    for _, item in pairs(options.List) do
                        local ItemButton = Create("TextButton", {
                            Name = item .. "Option",
                            Size = UDim2.new(1, 0, 0, 30),
                            BackgroundTransparency = 1,
                            Text = item,
                            TextColor3 = self.Theme == "Dark" and Colors.Light or Colors.Dark,
                            TextSize = 14,
                            Font = Enum.Font.Gotham,
                            Parent = DropdownList
                        })
                        
                        ItemButton.MouseButton1Click:Connect(function()
                            Dropdown.Value = item
                            DropdownText.Text = item
                            ToggleDropdown()
                            
                            if options.Callback then
                                options.Callback(item)
                            end
                        end)
                        
                        ItemButton.MouseEnter:Connect(function()
                            Tween(ItemButton, {BackgroundColor3 = self.Theme == "Dark" and Color3.fromRGB(50, 50, 60) or Color3.fromRGB(220, 220, 230)})
                        end)
                        
                        ItemButton.MouseLeave:Connect(function()
                            Tween(ItemButton, {BackgroundTransparency = 1})
                        end)
                    end
                end
                
                UpdateDropdownHeight()
                Section:UpdateSize()
                
                function Dropdown:Refresh(list)
                    options.List = list
                    for _, child in pairs(DropdownList:GetChildren()) do
                        if child:IsA("TextButton") then
                            child:Destroy()
                        end
                    end
                    
                    if list then
                        for _, item in pairs(list) do
                            local ItemButton = Create("TextButton", {
                                Name = item .. "Option",
                                Size = UDim2.new(1, 0, 0, 30),
                                BackgroundTransparency = 1,
                                Text = item,
                                TextColor3 = self.Theme == "Dark" and Colors.Light or Colors.Dark,
                                TextSize = 14,
                                Font = Enum.Font.Gotham,
                                Parent = DropdownList
                            })
                            
                            ItemButton.MouseButton1Click:Connect(function()
                                Dropdown.Value = item
                                DropdownText.Text = item
                                ToggleDropdown()
                                
                                if options.Callback then
                                    options.Callback(item)
                                end
                            end)
                        end
                    end
                    
                    UpdateDropdownHeight()
                end
                
                return Dropdown
            end
            
            function Section:Label(options)
                options = options or {}
                local Label = {}
                
                local LabelFrame = Create("Frame", {
                    Name = "LabelFrame",
                    Size = UDim2.new(1, 0, 0, options.Height or 25),
                    BackgroundTransparency = 1,
                    LayoutOrder = #SectionContainer:GetChildren(),
                    Parent = SectionContainer
                })
                
                local LabelText = Create("TextLabel", {
                    Name = "LabelText",
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = options.Text or "Label",
                    TextColor3 = options.Color or (self.Theme == "Dark" and Colors.Light or Colors.Dark),
                    TextSize = options.Size or 14,
                    Font = options.Font or Enum.Font.Gotham,
                    TextXAlignment = options.Align or Enum.TextXAlignment.Left,
                    Parent = LabelFrame
                })
                
                Section:UpdateSize()
                
                function Label:Set(text)
                    LabelText.Text = text
                end
                
                return Label
            end
            
            Section:UpdateSize()
            return Section
        end
        
        RunService.Heartbeat:Connect(function()
            local totalHeight = 0
            for _, child in pairs(TabContent:GetChildren()) do
                if child:IsA("Frame") then
                    totalHeight = totalHeight + child.Size.Y.Offset + TabContentLayout.Padding.Offset
                end
            end
            ContentContainer.CanvasSize = UDim2.new(0, 0, 0, totalHeight + 30)
        end)
        
        return Tab
    end
    
    function Window:SetPosition(position)
        MainFrame.Position = position
    end
    
    function Window:SetSize(size)
        MainFrame.Size = size
    end
    
    function Window:Destroy()
        MainFrame:Destroy()
        if self.BlurEffect then
            self.BlurEffect:Destroy()
        end
    end
    
    return Window
end

function AF_UI:Toggle()
    self.Enabled = not self.Enabled
    self.ScreenGui.Enabled = self.Enabled
    
    if self.BlurEffect then
        if self.Enabled then
            Tween(self.BlurEffect, {Size = 8})
        else
            Tween(self.BlurEffect, {Size = 0})
        end
    end
end

function AF_UI:Destroy()
    self.ScreenGui:Destroy()
    if self.BlurEffect then
        self.BlurEffect:Destroy()
    end
end

function AF_UI:Notify(options)
    options = options or {}
    
    local Notification = Create("Frame", {
        Name = "Notification",
        Size = UDim2.new(0, 300, 0, 80),
        Position = UDim2.new(1, 320, 1, -100),
        BackgroundColor3 = self.Theme == "Dark" and Colors.Darker or Colors.Light,
        BorderSizePixel = 0,
        Parent = self.ScreenGui
    })
    
    Create("UICorner", {
        CornerRadius = UDim.new(0, 8),
        Parent = Notification
    })
    
    Create("UIStroke", {
        Color = self.AccentColor,
        Thickness = 2,
        Parent = Notification
    })
    
    local Title = Create("TextLabel", {
        Name = "Title",
        Size = UDim2.new(1, -20, 0, 25),
        Position = UDim2.new(0, 10, 0, 10),
        BackgroundTransparency = 1,
        Text = options.Title or "Notification",
        TextColor3 = self.Theme == "Dark" and Colors.Light or Colors.Dark,
        TextSize = 16,
        Font = Enum.Font.GothamSemibold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = Notification
    })
    
    local Message = Create("TextLabel", {
        Name = "Message",
        Size = UDim2.new(1, -20, 1, -45),
        Position = UDim2.new(0, 10, 0, 35),
        BackgroundTransparency = 1,
        Text = options.Message or "",
        TextColor3 = self.Theme == "Dark" and Color3.fromRGB(200, 200, 200) or Color3.fromRGB(80, 80, 80),
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = Notification
    })
    
    Tween(Notification, {Position = UDim2.new(1, -310, 1, -100)})
    
    local duration = options.Duration or 5
    task.spawn(function()
        wait(duration)
        Tween(Notification, {Position = UDim2.new(1, 320, 1, -100)})
        wait(0.3)
        Notification:Destroy()
    end)
    
    Notification.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Tween(Notification, {Position = UDim2.new(1, 320, 1, -100)})
            wait(0.3)
            Notification:Destroy()
        end
    end)
end

function AF_UI:Keybind(options)
    options = options or {}
    local Keybind = {}
    Keybind.Key = options.Key or Enum.KeyCode.F
    Keybind.Mode = options.Mode or "Toggle" -- "Toggle", "Hold", "Press"
    
    local connection
    local toggled = false
    
    function Keybind:SetCallback(callback)
        if connection then
            connection:Disconnect()
        end
        
        connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            
            if input.KeyCode == Keybind.Key then
                if Keybind.Mode == "Toggle" then
                    toggled = not toggled
                    callback(toggled)
                elseif Keybind.Mode == "Hold" then
                    callback(true)
                    
                    local endConnection
                    endConnection = UserInputService.InputEnded:Connect(function(endInput)
                        if endInput.KeyCode == Keybind.Key then
                            callback(false)
                            endConnection:Disconnect()
                        end
                    end)
                elseif Keybind.Mode == "Press" then
                    callback()
                end
            end
        end)
    end
    
    function Keybind:SetKey(key)
        Keybind.Key = key
    end
    
    function Keybind:Destroy()
        if connection then
            connection:Disconnect()
        end
    end
    
    return Keybind
end

function AF_UI:Watermark(text)
    text = text or "AF UI V3"
    
    local Watermark = {}
    
    local WatermarkFrame = Create("Frame", {
        Name = "Watermark",
        Size = UDim2.new(0, 200, 0, 30),
        Position = UDim2.new(0, 10, 0, 10),
        BackgroundColor3 = Colors.Darker,
        Parent = self.ScreenGui
    })
    
    Create("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = WatermarkFrame
    })
    
    Create("UIStroke", {
        Color = self.AccentColor,
        Thickness = 2,
        Parent = WatermarkFrame
    })
    
    local WatermarkText = Create("TextLabel", {
        Name = "WatermarkText",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = Colors.Light,
        TextSize = 14,
        Font = Enum.Font.GothamSemibold,
        Parent = WatermarkFrame
    })
    
    local dragging
    local dragInput
    local dragStart
    local startPos
    
    local function UpdateWatermarkInput(input)
        local delta = input.Position - dragStart
        WatermarkFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    WatermarkFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = WatermarkFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    WatermarkFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            UpdateWatermarkInput(input)
        end
    end)
    
    function Watermark:UpdateText(newText)
        WatermarkText.Text = newText
    end
    
    function Watermark:Destroy()
        WatermarkFrame:Destroy()
    end
    
    function Watermark:GetFrame()
        return WatermarkFrame
    end
    
    function Watermark:SetVisible(visible)
        WatermarkFrame.Visible = visible
    end
    
    function Watermark:IsVisible()
        return WatermarkFrame.Visible
    end
    
    return Watermark
end

return AF_UI
