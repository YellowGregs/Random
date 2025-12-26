local Nebula = {}
Nebula.__index = Nebula

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")

local Theme = {
	Background = Color3.fromRGB(30, 30, 35),
	Foreground = Color3.fromRGB(45, 45, 50),
	Accent = Color3.fromRGB(0, 170, 255),
	Text = Color3.fromRGB(240, 240, 240),
	SubText = Color3.fromRGB(180, 180, 180),
	Error = Color3.fromRGB(255, 85, 85),
	Success = Color3.fromRGB(85, 255, 140),
	Border = Color3.fromRGB(60, 60, 65),
	Shadow = Color3.fromRGB(0, 0, 0, 0.5)
}

local function Create(class, props)
	local obj = Instance.new(class)
	
	for prop, value in pairs(props) do
		if prop == "Parent" then
			obj.Parent = value
		elseif prop == "Children" then
			for _, child in ipairs(value) do
				child.Parent = obj
			end
		else
			obj[prop] = value
		end
	end
	
	return obj
end

local function Round(num, decimalPlaces)
	local mult = 10^(decimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

local function Tween(obj, props, duration, style, direction)
	local tweenInfo = TweenInfo.new(
		duration or 0.2,
		style or Enum.EasingStyle.Quad,
		direction or Enum.EasingDirection.Out
	)
	local tween = TweenService:Create(obj, tweenInfo, props)
	tween:Play()
	return tween
end

function Nebula.new(options)
	options = options or {}
	local self = setmetatable({}, Nebula)
	
	self.Visible = false
	self.Windows = {}
	self.ActiveWindow = nil
	self.Theme = options.Theme or Theme
	
	self.ScreenGui = Create("ScreenGui", {
		Name = "NebulaUI",
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Global
	})
	
	if options.Parent then
		self.ScreenGui.Parent = options.Parent
	elseif RunService:IsStudio() then
		self.ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	else
		self.ScreenGui.Parent = game.CoreGui
	end
	
	self.Container = Create("Frame", {
		Name = "Container",
		Parent = self.ScreenGui,
		BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		ClipsDescendants = true
	})
	
	self.Overlay = Create("Frame", {
		Name = "Overlay",
		Parent = self.Container,
		BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = 0.7,
		Size = UDim2.new(1, 0, 1, 0),
		Visible = false
	})
	
	self.InputBegan = UserInputService.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			self:DeselectActive()
		end
	end)
	
	return self
end

-- Window
function Nebula:Window(options)
	options = options or {}
	local window = {}
	
	window.Title = options.Title or "Window"
	window.Size = options.Size or UDim2.new(0, 400, 0, 500)
	window.Position = options.Position or UDim2.new(0.5, -200, 0.5, -250)
	window.MinSize = options.MinSize or Vector2.new(300, 300)
	window.MaxSize = options.MaxSize or Vector2.new(800, 800)
	window.Visible = options.Visible or false
	window.Active = false
	window.Elements = {}
	window.Tabs = {}
	window.ActiveTab = nil
	
	window.Main = Create("Frame", {
		Name = "Window",
		Parent = self.Container,
		BackgroundColor3 = self.Theme.Background,
		BorderColor3 = self.Theme.Border,
		BorderMode = Enum.BorderMode.Inset,
		BorderSizePixel = 2,
		Position = window.Position,
		Size = window.Size,
		Visible = window.Visible,
		ClipsDescendants = true,
		
		Children = {
			Create("UICorner", {
				CornerRadius = UDim.new(0, 8)
			}),
			Create("UIStroke", {
				Color = self.Theme.Border,
				Thickness = 2
			}),
			Create("Frame", {
				Name = "TitleBar",
				BackgroundColor3 = self.Theme.Foreground,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0, 40),
				
				Children = {
					Create("UICorner", {
						CornerRadius = UDim.new(0, 8, 0, 0)
					}),
					Create("TextLabel", {
						Name = "Title",
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 12, 0, 0),
						Size = UDim2.new(1, -40, 1, 0),
						Font = Enum.Font.Gotham,
						Text = window.Title,
						TextColor3 = self.Theme.Text,
						TextSize = 16,
						TextXAlignment = Enum.TextXAlignment.Left
					}),
					Create("TextButton", {
						Name = "Close",
						BackgroundTransparency = 1,
						Position = UDim2.new(1, -32, 0, 8),
						Size = UDim2.new(0, 24, 0, 24),
						Font = Enum.Font.GothamBold,
						Text = "×",
						TextColor3 = self.Theme.SubText,
						TextSize = 20,
						TextWrapped = true
					})
				}
			}),
			Create("Frame", {
				Name = "Content",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 0, 0, 40),
				Size = UDim2.new(1, 0, 1, -40)
			})
		}
	})
	
	local titleBar = window.Main.TitleBar
	local dragging, dragInput, dragStart, startPos
	
	local function Update(input)
		local delta = input.Position - dragStart
		local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, 
								 startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		window.Main.Position = newPos
	end
	
	titleBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = window.Main.Position
			
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	titleBar.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if dragging and input == dragInput then
			Update(input)
		end
	end)
	
	window.Main.TitleBar.Close.MouseButton1Click:Connect(function()
		window:Close()
	end)
	
	function window:SetVisible(state)
		window.Visible = state
		window.Main.Visible = state
		
		if state then
			Tween(window.Main, {Position = window.Position}, 0.3)
			self.ActiveWindow = window
		else
			self.Overlay.Visible = false
			for _, w in pairs(self.Windows) do
				if w.Visible then
					self.Overlay.Visible = true
					break
				end
			end
		end
	end
	
	function window:Open()
		if not window.Visible then
			window:SetVisible(true)
			self.Overlay.Visible = true
		end
	end
	
	function window:Close()
		if window.Visible then
			window:SetVisible(false)
		end
	end
	
	function window:Toggle()
		if window.Visible then
			window:Close()
		else
			window:Open()
		end
	end
	
	function window:Destroy()
		window.Main:Destroy()
		for i, w in pairs(self.Windows) do
			if w == window then
				table.remove(self.Windows, i)
				break
			end
		end
	end
	
	function window:AddTab(name, icon)
		local tab = {}
		tab.Name = name
		tab.Icon = icon
		tab.Visible = false
		
		if not window.Main:FindFirstChild("TabContainer") then
			window.TabContainer = Create("Frame", {
				Name = "TabContainer",
				Parent = window.Main.TitleBar,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 100, 0, 0),
				Size = UDim2.new(1, -140, 1, 0)
			})
			
			window.Main.Content.Position = UDim2.new(0, 0, 0, 70)
			window.Main.Content.Size = UDim2.new(1, 0, 1, -70)
			
			window.TabList = Create("Frame", {
				Name = "TabList",
				Parent = window.Main,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 0, 0, 40),
				Size = UDim2.new(1, 0, 0, 30)
			})
		end
		
		tab.Button = Create("TextButton", {
			Name = name,
			Parent = window.TabList,
			BackgroundColor3 = self.Theme.Foreground,
			BorderSizePixel = 0,
			Size = UDim2.new(0, 100, 1, 0),
			Font = Enum.Font.Gotham,
			Text = name,
			TextColor3 = self.Theme.SubText,
			TextSize = 14
		})
		
		tab.Content = Create("ScrollingFrame", {
			Name = name .. "Content",
			Parent = window.Main.Content,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 1, 0),
			ScrollBarThickness = 4,
			ScrollBarImageColor3 = self.Theme.Border,
			Visible = false,
			
			Children = {
				Create("UIListLayout", {
					Padding = UDim.new(0, 8),
					SortOrder = Enum.SortOrder.LayoutOrder
				}),
				Create("UIPadding", {
					PaddingLeft = UDim.new(0, 12),
					PaddingRight = UDim.new(0, 12),
					PaddingTop = UDim.new(0, 8),
					PaddingBottom = UDim.new(0, 8)
				})
			}
		})
		
		tab.Button.MouseButton1Click:Connect(function()
			window:SwitchTab(tab)
		end)
		
		table.insert(window.Tabs, tab)
		
		if #window.Tabs == 1 then
			window:SwitchTab(tab)
		end
		
		for i, t in ipairs(window.Tabs) do
			t.Button.Position = UDim2.new(0, (i-1) * 100, 0, 0)
		end
		
		return tab
	end
	
	function window:SwitchTab(tab)
		if window.ActiveTab then
			window.ActiveTab.Visible = false
			window.ActiveTab.Content.Visible = false
			Tween(window.ActiveTab.Button, {BackgroundColor3 = self.Theme.Foreground, TextColor3 = self.Theme.SubText}, 0.2)
		end
		
		window.ActiveTab = tab
		tab.Visible = true
		tab.Content.Visible = true
		Tween(tab.Button, {BackgroundColor3 = self.Theme.Accent, TextColor3 = Color3.new(1, 1, 1)}, 0.2)
	end
	
	function window:AddElement(element, tab)
		local targetTab = tab or window.ActiveTab
		if targetTab then
			element.Parent = targetTab.Content
			element.LayoutOrder = #targetTab.Content:GetChildren()
			table.insert(window.Elements, element)
		end
		return element
	end
	
	table.insert(self.Windows, window)
	
	if window.Visible then
		window:Open()
	end
	
	return window
end

-- Button
function Nebula:Button(options)
	options = options or {}
	local button = {}
	
	button.Text = options.Text or "Button"
	button.Callback = options.Callback or function() end
	
	button.Main = Create("TextButton", {
		Name = "Button",
		BackgroundColor3 = self.Theme.Foreground,
		BorderColor3 = self.Theme.Border,
		BorderMode = Enum.BorderMode.Inset,
		BorderSizePixel = 2,
		Size = UDim2.new(1, -24, 0, 36),
		Font = Enum.Font.Gotham,
		Text = button.Text,
		TextColor3 = self.Theme.Text,
		TextSize = 14,
		AutoButtonColor = false,
		
		Children = {
			Create("UICorner", {
				CornerRadius = UDim.new(0, 6)
			}),
			Create("UIStroke", {
				Color = self.Theme.Border,
				Thickness = 1
			})
		}
	})
	
	button.Main.MouseEnter:Connect(function()
		if not button.Disabled then
			Tween(button.Main, {BackgroundColor3 = Color3.fromRGB(55, 55, 60)}, 0.2)
		end
	end)
	
	button.Main.MouseLeave:Connect(function()
		if not button.Disabled then
			Tween(button.Main, {BackgroundColor3 = self.Theme.Foreground}, 0.2)
		end
	end)
	
	button.Main.MouseButton1Click:Connect(function()
		if not button.Disabled then
			Tween(button.Main, {BackgroundColor3 = self.Theme.Accent}, 0.1)
			task.wait(0.1)
			Tween(button.Main, {BackgroundColor3 = self.Theme.Foreground}, 0.1)
			
			pcall(button.Callback)
		end
	end)
	
	function button:SetText(text)
		button.Text = text
		button.Main.Text = text
	end
	
	function button:SetCallback(callback)
		button.Callback = callback
	end
	
	function button:SetDisabled(state)
		button.Disabled = state
		button.Main.TextColor3 = state and self.Theme.SubText or self.Theme.Text
		button.Main.BackgroundColor3 = state and Color3.fromRGB(40, 40, 45) or self.Theme.Foreground
	end
	
	function button:Destroy()
		button.Main:Destroy()
	end
	
	return button
end

-- Toggle
function Nebula:Toggle(options)
	options = options or {}
	local toggle = {}
	
	toggle.Text = options.Text or "Toggle"
	toggle.State = options.State or false
	toggle.Callback = options.Callback or function(state) end
	
	toggle.Main = Create("Frame", {
		Name = "Toggle",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -24, 0, 36),
		
		Children = {
			Create("TextLabel", {
				Name = "Label",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 0, 0, 0),
				Size = UDim2.new(1, -50, 1, 0),
				Font = Enum.Font.Gotham,
				Text = toggle.Text,
				TextColor3 = self.Theme.Text,
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left
			}),
			Create("Frame", {
				Name = "Switch",
				BackgroundColor3 = self.Theme.Foreground,
				BorderColor3 = self.Theme.Border,
				BorderMode = Enum.BorderMode.Inset,
				BorderSizePixel = 2,
				Position = UDim2.new(1, -50, 0.5, -12),
				Size = UDim2.new(0, 44, 0, 24),
				AnchorPoint = Vector2.new(1, 0.5),
				
				Children = {
					Create("UICorner", {
						CornerRadius = UDim.new(1, 0)
					}),
					Create("UIStroke", {
						Color = self.Theme.Border,
						Thickness = 1
					}),
					Create("Frame", {
						Name = "ToggleCircle",
						BackgroundColor3 = self.Theme.Text,
						BorderSizePixel = 0,
						Position = toggle.State and UDim2.new(1, -20, 0.5, -8) or UDim2.new(0, 4, 0.5, -8),
						Size = UDim2.new(0, 16, 0, 16),
						AnchorPoint = Vector2.new(0, 0.5),
						
						Children = {
							Create("UICorner", {
								CornerRadius = UDim.new(1, 0)
							})
						}
					})
				}
			})
		}
	})
	
	toggle.Switch = toggle.Main.Switch
	toggle.Circle = toggle.Switch.ToggleCircle
	
	if toggle.State then
		Tween(toggle.Switch, {BackgroundColor3 = Color3.fromRGB(0, 120, 215)}, 0)
		Tween(toggle.Circle, {Position = UDim2.new(1, -20, 0.5, -8)}, 0)
	end
	
	toggle.Switch.MouseButton1Click:Connect(function()
		toggle.State = not toggle.State
		
		if toggle.State then
			Tween(toggle.Switch, {BackgroundColor3 = Color3.fromRGB(0, 120, 215)}, 0.2)
			Tween(toggle.Circle, {Position = UDim2.new(1, -20, 0.5, -8)}, 0.2)
		else
			Tween(toggle.Switch, {BackgroundColor3 = self.Theme.Foreground}, 0.2)
			Tween(toggle.Circle, {Position = UDim2.new(0, 4, 0.5, -8)}, 0.2)
		end
		
		pcall(toggle.Callback, toggle.State)
	end)
	
	toggle.Switch.MouseEnter:Connect(function()
		Tween(toggle.Switch, {BackgroundColor3 = toggle.State and Color3.fromRGB(0, 140, 235) or Color3.fromRGB(55, 55, 60)}, 0.2)
	end)
	
	toggle.Switch.MouseLeave:Connect(function()
		Tween(toggle.Switch, {BackgroundColor3 = toggle.State and Color3.fromRGB(0, 120, 215) or self.Theme.Foreground}, 0.2)
	end)
	
	function toggle:SetState(state)
		toggle.State = state
		
		if toggle.State then
			Tween(toggle.Switch, {BackgroundColor3 = Color3.fromRGB(0, 120, 215)}, 0.2)
			Tween(toggle.Circle, {Position = UDim2.new(1, -20, 0.5, -8)}, 0.2)
		else
			Tween(toggle.Switch, {BackgroundColor3 = self.Theme.Foreground}, 0.2)
			Tween(toggle.Circle, {Position = UDim2.new(0, 4, 0.5, -8)}, 0.2)
		end
	end
	
	function toggle:GetState()
		return toggle.State
	end
	
	function toggle:SetText(text)
		toggle.Text = text
		toggle.Main.Label.Text = text
	end
	
	function toggle:SetCallback(callback)
		toggle.Callback = callback
	end
	
	function toggle:Destroy()
		toggle.Main:Destroy()
	end
	
	return toggle
end

-- Slider
function Nebula:Slider(options)
	options = options or {}
	local slider = {}
	
	slider.Text = options.Text or "Slider"
	slider.Min = options.Min or 0
	slider.Max = options.Max or 100
	slider.Default = options.Default or slider.Min
	slider.Precision = options.Precision or 0
	slider.Callback = options.Callback or function(value) end
	
	slider.Value = math.clamp(slider.Default, slider.Min, slider.Max)
	
	slider.Main = Create("Frame", {
		Name = "Slider",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -24, 0, 60),
		
		Children = {
			Create("TextLabel", {
				Name = "Label",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 0, 0, 0),
				Size = UDim2.new(1, 0, 0, 20),
				Font = Enum.Font.Gotham,
				Text = slider.Text,
				TextColor3 = self.Theme.Text,
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left
			}),
			Create("TextLabel", {
				Name = "Value",
				BackgroundTransparency = 1,
				Position = UDim2.new(1, 0, 0, 0),
				Size = UDim2.new(0, 60, 0, 20),
				Font = Enum.Font.Gotham,
				Text = tostring(slider.Value),
				TextColor3 = self.Theme.SubText,
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Right,
				AnchorPoint = Vector2.new(1, 0)
			}),
			Create("Frame", {
				Name = "Track",
				BackgroundColor3 = self.Theme.Foreground,
				BorderColor3 = self.Theme.Border,
				BorderMode = Enum.BorderMode.Inset,
				BorderSizePixel = 2,
				Position = UDim2.new(0, 0, 0, 30),
				Size = UDim2.new(1, 0, 0, 8),
				
				Children = {
					Create("UICorner", {
						CornerRadius = UDim.new(1, 0)
					}),
					Create("UIStroke", {
						Color = self.Theme.Border,
						Thickness = 1
					}),
					Create("Frame", {
						Name = "Fill",
						BackgroundColor3 = self.Theme.Accent,
						BorderSizePixel = 0,
						Size = UDim2.new((slider.Value - slider.Min) / (slider.Max - slider.Min), 0, 1, 0),
						
						Children = {
							Create("UICorner", {
								CornerRadius = UDim.new(1, 0)
							})
						}
					}),
					Create("Frame", {
						Name = "Thumb",
						BackgroundColor3 = Color3.new(1, 1, 1),
						BorderSizePixel = 0,
						Position = UDim2.new((slider.Value - slider.Min) / (slider.Max - slider.Min), -8, 0.5, -8),
						Size = UDim2.new(0, 16, 0, 16),
						AnchorPoint = Vector2.new(0.5, 0.5),
						
						Children = {
							Create("UICorner", {
								CornerRadius = UDim.new(1, 0)
							})
						}
					})
				}
			})
		}
	})
	
	slider.Track = slider.Main.Track
	slider.Fill = slider.Track.Fill
	slider.Thumb = slider.Track.Thumb
	
	local function calculateValue(xPosition)
		local relativeX = (xPosition - slider.Track.AbsolutePosition.X) / slider.Track.AbsoluteSize.X
		local value = slider.Min + (relativeX * (slider.Max - slider.Min))
		value = math.clamp(value, slider.Min, slider.Max)
		
		if slider.Precision > 0 then
			value = Round(value, slider.Precision)
		else
			value = math.floor(value)
		end
		
		return value
	end
	
	local function updateSlider(value, instant)
		slider.Value = value
		local percent = (value - slider.Min) / (slider.Max - slider.Min)
		
		slider.Main.Value.Text = tostring(value)
		
		if instant then
			slider.Fill.Size = UDim2.new(percent, 0, 1, 0)
			slider.Thumb.Position = UDim2.new(percent, -8, 0.5, -8)
		else
			Tween(slider.Fill, {Size = UDim2.new(percent, 0, 1, 0)}, 0.1)
			Tween(slider.Thumb, {Position = UDim2.new(percent, -8, 0.5, -8)}, 0.1)
		end
		
		pcall(slider.Callback, value)
	end
	
	-- Mouse interaction
	local dragging = false
	
	slider.Track.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			
			local value = calculateValue(input.Position.X)
			updateSlider(value, true)
		end
	end)
	
	slider.Track.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local value = calculateValue(input.Position.X)
			updateSlider(value, false)
		end
	end)
	
	function slider:SetValue(value)
		value = math.clamp(value, slider.Min, slider.Max)
		if slider.Precision > 0 then
			value = Round(value, slider.Precision)
		end
		updateSlider(value, false)
	end
	
	function slider:GetValue()
		return slider.Value
	end
	
	function slider:SetRange(min, max)
		slider.Min = min
		slider.Max = max
		slider:SetValue(slider.Value)
	end
	
	function slider:SetText(text)
		slider.Text = text
		slider.Main.Label.Text = text
	end
	
	function slider:SetCallback(callback)
		slider.Callback = callback
	end
	
	function slider:Destroy()
		slider.Main:Destroy()
	end
	
	return slider
end

-- Dropdown
function Nebula:Dropdown(options)
	options = options or {}
	local dropdown = {}
	
	dropdown.Text = options.Text or "Dropdown"
	dropdown.Options = options.Options or {"Option 1", "Option 2", "Option 3"}
	dropdown.Default = options.Default or 1
	dropdown.Callback = options.Callback or function(option, index) end
	
	dropdown.Selected = dropdown.Options[dropdown.Default] or dropdown.Options[1]
	dropdown.Open = false
	
	dropdown.Main = Create("Frame", {
		Name = "Dropdown",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -24, 0, 36),
		
		Children = {
			Create("TextLabel", {
				Name = "Label",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 0, 0, 0),
				Size = UDim2.new(1, 0, 0, 20),
				Font = Enum.Font.Gotham,
				Text = dropdown.Text,
				TextColor3 = self.Theme.Text,
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left
			}),
			Create("TextButton", {
				Name = "Selector",
				BackgroundColor3 = self.Theme.Foreground,
				BorderColor3 = self.Theme.Border,
				BorderMode = Enum.BorderMode.Inset,
				BorderSizePixel = 2,
				Position = UDim2.new(0, 0, 0, 20),
				Size = UDim2.new(1, 0, 0, 36),
				Font = Enum.Font.Gotham,
				Text = dropdown.Selected,
				TextColor3 = self.Theme.Text,
				TextSize = 14,
				AutoButtonColor = false,
				
				Children = {
					Create("UICorner", {
						CornerRadius = UDim.new(0, 6)
					}),
					Create("UIStroke", {
						Color = self.Theme.Border,
						Thickness = 1
					}),
					Create("ImageLabel", {
						Name = "Arrow",
						BackgroundTransparency = 1,
						Position = UDim2.new(1, -30, 0.5, -8),
						Size = UDim2.new(0, 16, 0, 16),
						Image = "rbxassetid://6031091004",
						ImageColor3 = self.Theme.SubText,
						AnchorPoint = Vector2.new(1, 0.5)
					})
				}
			}),
			Create("ScrollingFrame", {
				Name = "Options",
				BackgroundColor3 = self.Theme.Background,
				BorderColor3 = self.Theme.Border,
				BorderMode = Enum.BorderMode.Inset,
				BorderSizePixel = 2,
				Position = UDim2.new(0, 0, 0, 58),
				Size = UDim2.new(1, 0, 0, 0),
				Visible = false,
				ScrollBarThickness = 4,
				ScrollBarImageColor3 = self.Theme.Border,
				
				Children = {
					Create("UICorner", {
						CornerRadius = UDim.new(0, 6)
					}),
					Create("UIStroke", {
						Color = self.Theme.Border,
						Thickness = 1
					}),
					Create("UIListLayout", {
						SortOrder = Enum.SortOrder.LayoutOrder
					})
				}
			})
		}
	})
	
	dropdown.Selector = dropdown.Main.Selector
	dropdown.OptionsFrame = dropdown.Main.Options
	dropdown.Arrow = dropdown.Selector.Arrow
	
	local function createOptions()
		for _, option in ipairs(dropdown.Options) do
			local optionButton = Create("TextButton", {
				Name = option,
				BackgroundColor3 = self.Theme.Foreground,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0, 32),
				Font = Enum.Font.Gotham,
				Text = option,
				TextColor3 = self.Theme.Text,
				TextSize = 14,
				AutoButtonColor = false
			})
			
			optionButton.MouseEnter:Connect(function()
				if optionButton.Text ~= dropdown.Selected then
					Tween(optionButton, {BackgroundTransparency = 0.8}, 0.2)
				end
			end)
			
			optionButton.MouseLeave:Connect(function()
				if optionButton.Text ~= dropdown.Selected then
					Tween(optionButton, {BackgroundTransparency = 1}, 0.2)
				end
			end)
			
			optionButton.MouseButton1Click:Connect(function()
				dropdown.Selected = option
				dropdown.Selector.Text = option
				dropdown:Close()
				
				for _, child in ipairs(dropdown.OptionsFrame:GetChildren()) do
					if child:IsA("TextButton") then
						if child.Text == option then
							Tween(child, {BackgroundTransparency = 0.5, TextColor3 = self.Theme.Accent}, 0.2)
						else
							Tween(child, {BackgroundTransparency = 1, TextColor3 = self.Theme.Text}, 0.2)
						end
					end
				end
				
				pcall(dropdown.Callback, option, table.find(dropdown.Options, option))
			end)
			
			optionButton.Parent = dropdown.OptionsFrame
		end
	end
	
	createOptions()
	
	for _, child in ipairs(dropdown.OptionsFrame:GetChildren()) do
		if child:IsA("TextButton") and child.Text == dropdown.Selected then
			child.BackgroundTransparency = 0.5
			child.TextColor3 = self.Theme.Accent
		end
	end
	
	dropdown.Selector.MouseButton1Click:Connect(function()
		if dropdown.Open then
			dropdown:Close()
		else
			dropdown:Open()
		end
	end)
	
	function dropdown:Open()
		if not dropdown.Open then
			dropdown.Open = true
			dropdown.OptionsFrame.Visible = true
			
			local totalHeight = math.min(#dropdown.Options * 32, 160)
			Tween(dropdown.OptionsFrame, {Size = UDim2.new(1, 0, 0, totalHeight)}, 0.2)
			Tween(dropdown.Arrow, {Rotation = 180}, 0.2)
			
			self:DeselectActive()
		end
	end
	
	function dropdown:Close()
		if dropdown.Open then
			dropdown.Open = false
			Tween(dropdown.OptionsFrame, {Size = UDim2.new(1, 0, 0, 0)}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
			Tween(dropdown.Arrow, {Rotation = 0}, 0.2)
			
			task.wait(0.2)
			if not dropdown.Open then
				dropdown.OptionsFrame.Visible = false
			end
		end
	end
	
	function dropdown:SetOptions(options)
		dropdown.Options = options
		
		for _, child in ipairs(dropdown.OptionsFrame:GetChildren()) do
			if child:IsA("TextButton") then
				child:Destroy()
			end
		end
		
		createOptions()
		
		dropdown.Selected = options[1] or ""
		dropdown.Selector.Text = dropdown.Selected
	end
	
	function dropdown:Select(option)
		for _, child in ipairs(dropdown.OptionsFrame:GetChildren()) do
			if child:IsA("TextButton") and child.Text == option then
				child:MouseButton1Click()
				break
			end
		end
	end
	
	function dropdown:GetSelected()
		return dropdown.Selected, table.find(dropdown.Options, dropdown.Selected)
	end
	
	function dropdown:SetText(text)
		dropdown.Text = text
		dropdown.Main.Label.Text = text
	end
	
	function dropdown:SetCallback(callback)
		dropdown.Callback = callback
	end
	
	function dropdown:Destroy()
		dropdown.Main:Destroy()
	end
	
	return dropdown
end

-- TextBox
function Nebula:TextBox(options)
	options = options or {}
	local textbox = {}
	
	textbox.Text = options.Text or "Text Box"
	textbox.Placeholder = options.Placeholder or "Enter text..."
	textbox.Default = options.Default or ""
	textbox.ClearTextOnFocus = options.ClearTextOnFocus or false
	textbox.Callback = options.Callback or function(text) end
	
	textbox.Value = textbox.Default
	
	textbox.Main = Create("Frame", {
		Name = "TextBox",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -24, 0, 60),
		
		Children = {
			Create("TextLabel", {
				Name = "Label",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 0, 0, 0),
				Size = UDim2.new(1, 0, 0, 20),
				Font = Enum.Font.Gotham,
				Text = textbox.Text,
				TextColor3 = self.Theme.Text,
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left
			}),
			Create("TextBox", {
				Name = "Input",
				BackgroundColor3 = self.Theme.Foreground,
				BorderColor3 = self.Theme.Border,
				BorderMode = Enum.BorderMode.Inset,
				BorderSizePixel = 2,
				Position = UDim2.new(0, 0, 0, 20),
				Size = UDim2.new(1, 0, 0, 36),
				Font = Enum.Font.Gotham,
				PlaceholderText = textbox.Placeholder,
				Text = textbox.Default,
				TextColor3 = self.Theme.Text,
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left,
				ClearTextOnFocus = textbox.ClearTextOnFocus,
				
				Children = {
					Create("UICorner", {
						CornerRadius = UDim.new(0, 6)
					}),
					Create("UIStroke", {
						Color = self.Theme.Border,
						Thickness = 1
					}),
					Create("UIPadding", {
						PaddingLeft = UDim.new(0, 8),
						PaddingRight = UDim.new(0, 8)
					})
				}
			})
		}
	})
	
	textbox.Input = textbox.Main.Input
	
	textbox.Input.Focused:Connect(function()
		Tween(textbox.Input, {BorderColor3 = self.Theme.Accent}, 0.2)
	end)
	
	textbox.Input.FocusLost:Connect(function()
		Tween(textbox.Input, {BorderColor3 = self.Theme.Border}, 0.2)
		
		textbox.Value = textbox.Input.Text
		pcall(textbox.Callback, textbox.Value)
	end)
	
	textbox.Input.MouseEnter:Connect(function()
		if not textbox.Input:IsFocused() then
			Tween(textbox.Input, {BackgroundColor3 = Color3.fromRGB(55, 55, 60)}, 0.2)
		end
	end)
	
	textbox.Input.MouseLeave:Connect(function()
		if not textbox.Input:IsFocused() then
			Tween(textbox.Input, {BackgroundColor3 = self.Theme.Foreground}, 0.2)
		end
	end)
	
	function textbox:SetText(text)
		textbox.Input.Text = text
		textbox.Value = text
	end
	
	function textbox:GetText()
		return textbox.Value
	end
	
	function textbox:SetPlaceholder(text)
		textbox.Placeholder = text
		textbox.Input.PlaceholderText = text
	end
	
	function textbox:SetCallback(callback)
		textbox.Callback = callback
	end
	
	function textbox:Destroy()
		textbox.Main:Destroy()
	end
	
	return textbox
end

-- Label
function Nebula:Label(options)
	options = options or {}
	local label = {}
	
	label.Text = options.Text or "Label"
	label.Size = options.Size or UDim2.new(1, -24, 0, 20)
	label.TextColor = options.TextColor or self.Theme.Text
	label.TextSize = options.TextSize or 14
	label.Centered = options.Centered or false
	
	label.Main = Create("TextLabel", {
		Name = "Label",
		BackgroundTransparency = 1,
		Size = label.Size,
		Font = Enum.Font.Gotham,
		Text = label.Text,
		TextColor3 = label.TextColor,
		TextSize = label.TextSize,
		TextXAlignment = label.Centered and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left,
		TextWrapped = true
	})
	
	-- Methods
	function label:SetText(text)
		label.Text = text
		label.Main.Text = text
	end
	
	function label:SetColor(color)
		label.TextColor = color
		label.Main.TextColor3 = color
	end
	
	function label:SetSize(size)
		label.Size = size
		label.Main.Size = size
	end
	
	function label:Destroy()
		label.Main:Destroy()
	end
	
	return label
end

-- ColorPicker
function Nebula:ColorPicker(options)
	options = options or {}
	local colorpicker = {}
	
	colorpicker.Text = options.Text or "Color Picker"
	colorpicker.Default = options.Default or Color3.fromRGB(255, 255, 255)
	colorpicker.Callback = options.Callback or function(color) end
	
	colorpicker.Value = colorpicker.Default
	colorpicker.Open = false
	
	colorpicker.Main = Create("Frame", {
		Name = "ColorPicker",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -24, 0, 36),
		
		Children = {
			Create("TextLabel", {
				Name = "Label",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 0, 0, 0),
				Size = UDim2.new(1, -60, 1, 0),
				Font = Enum.Font.Gotham,
				Text = colorpicker.Text,
				TextColor3 = self.Theme.Text,
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left
			}),
			Create("TextButton", {
				Name = "Preview",
				BackgroundColor3 = colorpicker.Default,
				BorderColor3 = self.Theme.Border,
				BorderMode = Enum.BorderMode.Inset,
				BorderSizePixel = 2,
				Position = UDim2.new(1, -40, 0.5, -12),
				Size = UDim2.new(0, 40, 0, 24),
				AutoButtonColor = false,
				AnchorPoint = Vector2.new(1, 0.5),
				
				Children = {
					Create("UICorner", {
						CornerRadius = UDim.new(0, 6)
					}),
					Create("UIStroke", {
						Color = self.Theme.Border,
						Thickness = 1
					})
				}
			}),
			Create("Frame", {
				Name = "Picker",
				BackgroundColor3 = self.Theme.Background,
				BorderColor3 = self.Theme.Border,
				BorderMode = Enum.BorderMode.Inset,
				BorderSizePixel = 2,
				Position = UDim2.new(0, 0, 1, 8),
				Size = UDim2.new(1, 0, 0, 0),
				Visible = false,
				ClipsDescendants = true,
				
				Children = {
					Create("UICorner", {
						CornerRadius = UDim.new(0, 6)
					}),
					Create("UIStroke", {
						Color = self.Theme.Border,
						Thickness = 1
					}),
					Create("ImageLabel", {
						Name = "Spectrum",
						BackgroundColor3 = Color3.new(1, 1, 1),
						BorderSizePixel = 0,
						Position = UDim2.new(0, 8, 0, 8),
						Size = UDim2.new(1, -16, 0, 120),
						Image = "rbxassetid://4155801252",
						ScaleType = Enum.ScaleType.Stretch
					}),
					Create("Frame", {
						Name = "SliderTrack",
						BackgroundColor3 = Color3.new(1, 1, 1),
						BorderColor3 = Color3.new(0, 0, 0),
						BorderSizePixel = 2,
						Position = UDim2.new(0, 8, 0, 140),
						Size = UDim2.new(1, -16, 0, 20),
						
						Children = {
							Create("UIGradient", {
								Color = ColorSequence.new{
									ColorSequenceKeypoint.new(0, Color3.new(1, 0, 0)),
									ColorSequenceKeypoint.new(0.17, Color3.new(1, 1, 0)),
									ColorSequenceKeypoint.new(0.33, Color3.new(0, 1, 0)),
									ColorSequenceKeypoint.new(0.5, Color3.new(0, 1, 1)),
									ColorSequenceKeypoint.new(0.67, Color3.new(0, 0, 1)),
									ColorSequenceKeypoint.new(0.83, Color3.new(1, 0, 1)),
									ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0))
								}
							})
						}
					}),
					Create("Frame", {
						Name = "CurrentColor",
						BackgroundColor3 = colorpicker.Default,
						BorderColor3 = Color3.new(0, 0, 0),
						BorderSizePixel = 2,
						Position = UDim2.new(0, 8, 0, 172),
						Size = UDim2.new(0.5, -12, 0, 30)
					}),
					Create("TextBox", {
						Name = "HexInput",
						BackgroundColor3 = self.Theme.Foreground,
						BorderColor3 = self.Theme.Border,
						BorderSizePixel = 1,
						Position = UDim2.new(0.5, 4, 0, 172),
						Size = UDim2.new(0.5, -12, 0, 30),
						Font = Enum.Font.Gotham,
						PlaceholderText = "Hex Color",
						Text = "#FFFFFF",
						TextColor3 = self.Theme.Text,
						TextSize = 14,
						TextXAlignment = Enum.TextXAlignment.Center
					}),
					Create("TextButton", {
						Name = "Confirm",
						BackgroundColor3 = self.Theme.Accent,
						BorderSizePixel = 0,
						Position = UDim2.new(0, 8, 0, 212),
						Size = UDim2.new(1, -16, 0, 30),
						Font = Enum.Font.Gotham,
						Text = "Confirm",
						TextColor3 = Color3.new(1, 1, 1),
						TextSize = 14,
						AutoButtonColor = false
					})
				}
			})
		}
	})
	
	colorpicker.Preview = colorpicker.Main.Preview
	colorpicker.Picker = colorpicker.Main.Picker
	colorpicker.Spectrum = colorpicker.Picker.Spectrum
	colorpicker.SliderTrack = colorpicker.Picker.SliderTrack
	colorpicker.CurrentColor = colorpicker.Picker.CurrentColor
	colorpicker.HexInput = colorpicker.Picker.HexInput
	colorpicker.Confirm = colorpicker.Picker.Confirm
	
	local function toHex(color)
		local r = math.floor(color.R * 255)
		local g = math.floor(color.G * 255)
		local b = math.floor(color.B * 255)
		return string.format("#%02X%02X%02X", r, g, b)
	end
	
	local function fromHex(hex)
		hex = hex:gsub("#", "")
		if #hex == 3 then
			hex = hex:sub(1,1)..hex:sub(1,1)..hex:sub(2,2)..hex:sub(2,2)..hex:sub(3,3)..hex:sub(3,3)
		end
		
		if #hex == 6 then
			local r = tonumber(hex:sub(1,2), 16) or 255
			local g = tonumber(hex:sub(3,4), 16) or 255
			local b = tonumber(hex:sub(5,6), 16) or 255
			return Color3.fromRGB(r, g, b)
		end
		
		return Color3.new(1, 1, 1)
	end
	
	colorpicker.HexInput.Text = toHex(colorpicker.Value)
	
	colorpicker.Preview.MouseButton1Click:Connect(function()
		if colorpicker.Open then
			colorpicker:Close()
		else
			colorpicker:Open()
		end
	end)
	
	local spectrumDragging = false
	local hueDragging = false
	
	local function updateColorFromSpectrum(position)
		local relativeX = (position.X - colorpicker.Spectrum.AbsolutePosition.X) / colorpicker.Spectrum.AbsoluteSize.X
		local relativeY = (position.Y - colorpicker.Spectrum.AbsolutePosition.Y) / colorpicker.Spectrum.AbsoluteSize.Y
		
		relativeX = math.clamp(relativeX, 0, 1)
		relativeY = math.clamp(relativeY, 0, 1)
		
		local hue = relativeX * 360
		local saturation = 1
		local value = 1 - relativeY
		
		local c = value * saturation
		local x = c * (1 - math.abs((hue / 60) % 2 - 1))
		local m = value - c
		
		local r, g, b = 0, 0, 0
		
		if hue < 60 then
			r, g, b = c, x, 0
		elseif hue < 120 then
			r, g, b = x, c, 0
		elseif hue < 180 then
			r, g, b = 0, c, x
		elseif hue < 240 then
			r, g, b = 0, x, c
		elseif hue < 300 then
			r, g, b = x, 0, c
		else
			r, g, b = c, 0, x
		end
		
		colorpicker.Value = Color3.new(r + m, g + m, b + m)
		colorpicker.Preview.BackgroundColor3 = colorpicker.Value
		colorpicker.CurrentColor.BackgroundColor3 = colorpicker.Value
		colorpicker.HexInput.Text = toHex(colorpicker.Value)
	end
	
	colorpicker.Spectrum.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			spectrumDragging = true
			updateColorFromSpectrum(input.Position)
		end
	end)
	
	colorpicker.Spectrum.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			spectrumDragging = false
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if spectrumDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			updateColorFromSpectrum(input.Position)
		end
	end)
	
	colorpicker.HexInput.FocusLost:Connect(function()
		local hex = colorpicker.HexInput.Text
		local color = fromHex(hex)
		
		colorpicker.Value = color
		colorpicker.Preview.BackgroundColor3 = color
		colorpicker.CurrentColor.BackgroundColor3 = color
		colorpicker.HexInput.Text = toHex(color)
	end)
	
	colorpicker.Confirm.MouseButton1Click:Connect(function()
		colorpicker:Close()
		pcall(colorpicker.Callback, colorpicker.Value)
	end)
	
	colorpicker.Confirm.MouseEnter:Connect(function()
		Tween(colorpicker.Confirm, {BackgroundColor3 = Color3.fromRGB(0, 140, 235)}, 0.2)
	end)
	
	colorpicker.Confirm.MouseLeave:Connect(function()
		Tween(colorpicker.Confirm, {BackgroundColor3 = self.Theme.Accent}, 0.2)
	end)
	
	function colorpicker:Open()
		if not colorpicker.Open then
			colorpicker.Open = true
			colorpicker.Picker.Visible = true
			Tween(colorpicker.Picker, {Size = UDim2.new(1, 0, 0, 250)}, 0.2)
			
			self:DeselectActive()
		end
	end
	
	function colorpicker:Close()
		if colorpicker.Open then
			colorpicker.Open = false
			Tween(colorpicker.Picker, {Size = UDim2.new(1, 0, 0, 0)}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
			
			task.wait(0.2)
			if not colorpicker.Open then
				colorpicker.Picker.Visible = false
			end
		end
	end
	
	function colorpicker:SetColor(color)
		colorpicker.Value = color
		colorpicker.Preview.BackgroundColor3 = color
		colorpicker.CurrentColor.BackgroundColor3 = color
		colorpicker.HexInput.Text = toHex(color)
	end
	
	function colorpicker:GetColor()
		return colorpicker.Value
	end
	
	function colorpicker:SetText(text)
		colorpicker.Text = text
		colorpicker.Main.Label.Text = text
	end
	
	function colorpicker:SetCallback(callback)
		colorpicker.Callback = callback
	end
	
	function colorpicker:Destroy()
		colorpicker.Main:Destroy()
	end
	
	return colorpicker
end

function Nebula:DeselectActive()
	for _, window in pairs(self.Windows) do
		for _, element in pairs(window.Elements) do
			if element.Close then
				pcall(element.Close, element)
			end
		end
	end
end

function Nebula:Destroy()
	self.InputBegan:Disconnect()
	self.ScreenGui:Destroy()
	
	for _, window in pairs(self.Windows) do
		window:Destroy()
	end
	
	setmetatable(self, nil)
end

return Nebula
