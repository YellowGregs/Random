for i,v in pairs(game:GetService("CoreGui"):GetChildren()) do
	if v.Name == "UiLib" then
		v:Destroy()
	end
end

local uilib = Instance.new("ScreenGui")
uilib.Name = "UiLib"
uilib.Parent = game:GetService("CoreGui")
uilib.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
uilib.ResetOnSpawn = false

local function get_next_window_pos()
	local biggest = 0;
	local ok = nil;
	for i, v in pairs(uilib:GetChildren()) do
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

local library = {}

function library:Window(title)
	local main_window = Instance.new("Frame")
	local ui_corner = Instance.new("UICorner")
	local container = Instance.new("Frame")
	local ui_list_layout = Instance.new("UIListLayout")
	local top_bar = Instance.new("Frame")
	local title_text = Instance.new("TextLabel")
	local collapse_button = Instance.new("ImageButton")
	local shadow = Instance.new("ImageLabel")
	local background = Instance.new("Frame")
	local ui_corner_bg = Instance.new("UICorner")
	local tab_bar = Instance.new("Frame")
	local tab_container = Instance.new("Frame")
	local tabs_content = Instance.new("Frame")
	local ui_list_layout_tabs = Instance.new("UIListLayout")

	main_window.Name = "MainWindow"
	main_window.Parent = uilib
	main_window.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	main_window.BorderSizePixel = 0
	main_window.Position = UDim2.new(0, get_next_window_pos(), 0.01, 0)
	main_window.Size = UDim2.new(0, 280, 0, 36)
	main_window.Active = true
	main_window.Draggable = true

	ui_corner.CornerRadius = UDim.new(0, 8)
	ui_corner.Parent = main_window

	background.Name = "Background"
	background.Parent = main_window
	background.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	background.BorderSizePixel = 0
	background.Size = UDim2.new(1, 0, 1, 450)
	background.ZIndex = -1
	
	ui_corner_bg.CornerRadius = UDim.new(0, 8)
	ui_corner_bg.Parent = background

	shadow.Name = "Shadow"
	shadow.Parent = main_window
	shadow.BackgroundTransparency = 1.000
	shadow.Position = UDim2.new(0, -15, 0, -15)
	shadow.Size = UDim2.new(1, 30, 1, 480)
	shadow.Image = "rbxassetid://5554236805"
	shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	shadow.ImageTransparency = 0.9
	shadow.ScaleType = Enum.ScaleType.Slice
	shadow.SliceCenter = Rect.new(23, 23, 277, 277)
	shadow.ZIndex = -1

	top_bar.Name = "TopBar"
	top_bar.Parent = main_window
	top_bar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	top_bar.BackgroundTransparency = 1.000
	top_bar.BorderSizePixel = 0
	top_bar.Size = UDim2.new(1, 0, 0, 36)

	title_text.Name = "Title"
	title_text.Parent = top_bar
	title_text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title_text.BackgroundTransparency = 1.000
	title_text.Position = UDim2.new(0.05, 0, 0, 0)
	title_text.Size = UDim2.new(0.7, 0, 1, 0)
	title_text.Font = Enum.Font.GothamMedium
	title_text.Text = title
	title_text.TextColor3 = Color3.fromRGB(220, 220, 220)
	title_text.TextSize = 16
	title_text.TextWrapped = true
	title_text.TextXAlignment = Enum.TextXAlignment.Left

	collapse_button.Name = "CollapseButton"
	collapse_button.Parent = top_bar
	collapse_button.BackgroundTransparency = 1.000
	collapse_button.Position = UDim2.new(0.85, 0, 0.2, 0)
	collapse_button.Rotation = 0
	collapse_button.Size = UDim2.new(0, 24, 0, 24)
	collapse_button.ZIndex = 2
	collapse_button.Image = "rbxassetid://6031094678"
	collapse_button.ImageColor3 = Color3.fromRGB(220, 220, 220)

	tab_bar.Name = "TabBar"
	tab_bar.Parent = main_window
	tab_bar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	tab_bar.BackgroundTransparency = 1.000
	tab_bar.BorderSizePixel = 0
	tab_bar.Position = UDim2.new(0, 0, 1, 0)
	tab_bar.Size = UDim2.new(1, 0, 0, 40)

	tab_container.Name = "TabContainer"
	tab_container.Parent = tab_bar
	tab_container.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	tab_container.BackgroundTransparency = 1.000
	tab_container.BorderSizePixel = 0
	tab_container.Position = UDim2.new(0.05, 0, 0, 0)
	tab_container.Size = UDim2.new(0.9, 0, 1, 0)

	ui_list_layout_tabs.Parent = tab_container
	ui_list_layout_tabs.FillDirection = Enum.FillDirection.Horizontal
	ui_list_layout_tabs.SortOrder = Enum.SortOrder.LayoutOrder
	ui_list_layout_tabs.Padding = UDim.new(0, 5)

	tabs_content.Name = "TabsContent"
	tabs_content.Parent = main_window
	tabs_content.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	tabs_content.BackgroundTransparency = 0
	tabs_content.ClipsDescendants = true
	tabs_content.Position = UDim2.new(0, 0, 1, 40)
	tabs_content.Size = UDim2.new(1, 0, 0, 410)
	tabs_content.ZIndex = 2

	container.Name = "Container"
	container.Parent = main_window
	container.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	container.BackgroundTransparency = 0
	container.ClipsDescendants = true
	container.Position = UDim2.new(0, 0, 1, 0)
	container.Size = UDim2.new(1, 0, 0, 450)
	container.ZIndex = 2

	ui_list_layout.Parent = container
	ui_list_layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	ui_list_layout.SortOrder = Enum.SortOrder.LayoutOrder
	ui_list_layout.Padding = UDim.new(0, 8)
	ui_list_layout.VerticalAlignment = Enum.VerticalAlignment.Top

	local is_collapsed = false
	local function toggle_collapse()
		is_collapsed = not is_collapsed
		if is_collapsed then
			game:GetService("TweenService"):Create(collapse_button, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 180}):Play();
			game:GetService("TweenService"):Create(collapse_button, TweenInfo.new(0.25), {ImageColor3 = Color3.fromRGB(150, 150, 150)}):Play()
			container:TweenSize(UDim2.new(1, 0, 0, 0), "InOut", "Sine", 0.25, true)
			tab_bar:TweenSize(UDim2.new(1, 0, 0, 0), "InOut", "Sine", 0.25, true)
			tabs_content:TweenSize(UDim2.new(1, 0, 0, 0), "InOut", "Sine", 0.25, true)
			game:GetService("TweenService"):Create(background, TweenInfo.new(0.25), {Size = UDim2.new(1, 0, 1, 0)}):Play()
			game:GetService("TweenService"):Create(shadow, TweenInfo.new(0.25), {Size = UDim2.new(1, 30, 1, 30)}):Play()
		else
			game:GetService("TweenService"):Create(collapse_button, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0}):Play();
			game:GetService("TweenService"):Create(collapse_button, TweenInfo.new(0.25), {ImageColor3 = Color3.fromRGB(220, 220, 220)}):Play()
			container:TweenSize(UDim2.new(1, 0, 0, 450), "InOut", "Sine", 0.2, true)
			tab_bar:TweenSize(UDim2.new(1, 0, 0, 40), "InOut", "Sine", 0.2, true)
			tabs_content:TweenSize(UDim2.new(1, 0, 0, 410), "InOut", "Sine", 0.2, true)
			game:GetService("TweenService"):Create(background, TweenInfo.new(0.25), {Size = UDim2.new(1, 0, 1, 450)}):Play()
			game:GetService("TweenService"):Create(shadow, TweenInfo.new(0.25), {Size = UDim2.new(1, 30, 1, 480)}):Play()
		end
	end

	collapse_button.MouseButton1Click:Connect(toggle_collapse)
	
	local lib = {}
	local current_tab = nil
	local tab_contents = {}
	local tab_buttons = {}
	
	function lib:Tab(tab_name)
		local tab_content = Instance.new("ScrollingFrame")
		local ui_list_layout_tab_content = Instance.new("UIListLayout")
		local tab_button = Instance.new("TextButton")
		local tab_button_text = Instance.new("TextLabel")
		
		tab_button.Name = "TabButton_" .. tab_name
		tab_button.Parent = tab_container
		tab_button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
		tab_button.BackgroundTransparency = 0
		tab_button.BorderSizePixel = 0
		tab_button.Size = UDim2.new(0, 70, 0, 30)
		tab_button.Font = Enum.Font.SourceSans
		tab_button.Text = ""
		tab_button.TextColor3 = Color3.fromRGB(0, 0, 0)
		tab_button.TextSize = 14.000
		tab_button.AutoButtonColor = false
		
		local ui_corner_tab = Instance.new("UICorner")
		ui_corner_tab.CornerRadius = UDim.new(0, 6)
		ui_corner_tab.Parent = tab_button
		
		tab_button_text.Name = "TabButtonText"
		tab_button_text.Parent = tab_button
		tab_button_text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		tab_button_text.BackgroundTransparency = 1.000
		tab_button_text.Size = UDim2.new(1, 0, 1, 0)
		tab_button_text.Font = Enum.Font.GothamMedium
		tab_button_text.Text = tab_name
		tab_button_text.TextColor3 = Color3.fromRGB(180, 180, 180)
		tab_button_text.TextSize = 12
		
		tab_content.Name = "TabContent_" .. tab_name
		tab_content.Parent = tabs_content
		tab_content.Active = true
		tab_content.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
		tab_content.BackgroundTransparency = 1.000
		tab_content.BorderSizePixel = 0
		tab_content.Size = UDim2.new(1, 0, 1, 0)
		tab_content.CanvasSize = UDim2.new(0, 0, 0, 0)
		tab_content.ScrollBarThickness = 3
		tab_content.ScrollBarImageColor3 = Color3.fromRGB(40, 40, 40)
		tab_content.Visible = false
		
		ui_list_layout_tab_content.Parent = tab_content
		ui_list_layout_tab_content.HorizontalAlignment = Enum.HorizontalAlignment.Center
		ui_list_layout_tab_content.SortOrder = Enum.SortOrder.LayoutOrder
		ui_list_layout_tab_content.Padding = UDim.new(0, 8)
		ui_list_layout_tab_content.VerticalAlignment = Enum.VerticalAlignment.Top
		
		tab_contents[tab_name] = tab_content
		tab_buttons[tab_name] = {button = tab_button, text = tab_button_text}
		
		if not current_tab then
			current_tab = tab_name
			tab_content.Visible = true
			tab_button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
			tab_button_text.TextColor3 = Color3.fromRGB(255, 255, 255)
		end
		
		tab_button.MouseButton1Click:Connect(function()
			if current_tab ~= tab_name then
				if current_tab then
					tab_contents[current_tab].Visible = false
					tab_buttons[current_tab].button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
					tab_buttons[current_tab].text.TextColor3 = Color3.fromRGB(180, 180, 180)
				end
				
				current_tab = tab_name
				tab_content.Visible = true
				tab_button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
				tab_button_text.TextColor3 = Color3.fromRGB(255, 255, 255)
			end
		end)
		
		tab_button.MouseEnter:Connect(function()
			if current_tab ~= tab_name then
				game:GetService("TweenService"):Create(tab_button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
			end
		end)
		
		tab_button.MouseLeave:Connect(function()
			if current_tab ~= tab_name then
				game:GetService("TweenService"):Create(tab_button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
			end
		end)
		
		local tab_lib = {}
		
		function tab_lib:Folder(folder_name)
			local folder_container = Instance.new("Frame")
			local ui_corner_folder = Instance.new("UICorner")
			local folder_header = Instance.new("TextButton")
			local folder_name_text = Instance.new("TextLabel")
			local folder_toggle = Instance.new("ImageButton")
			local folder_content = Instance.new("Frame")
			local ui_list_layout_folder = Instance.new("UIListLayout")
			
			folder_container.Name = "FolderContainer_" .. folder_name
			folder_container.Parent = tab_content
			folder_container.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			folder_container.BorderSizePixel = 0
			folder_container.Size = UDim2.new(0.92, 0, 0, 40)
			folder_container.ClipsDescendants = true
			
			ui_corner_folder.CornerRadius = UDim.new(0, 6)
			ui_corner_folder.Parent = folder_container
			
			folder_header.Name = "FolderHeader"
			folder_header.Parent = folder_container
			folder_header.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			folder_header.BackgroundTransparency = 1.000
			folder_header.BorderSizePixel = 0
			folder_header.Size = UDim2.new(1, 0, 0, 40)
			folder_header.Text = ""
			folder_header.AutoButtonColor = false
			
			folder_name_text.Name = "FolderName"
			folder_name_text.Parent = folder_header
			folder_name_text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			folder_name_text.BackgroundTransparency = 1.000
			folder_name_text.Position = UDim2.new(0.05, 0, 0, 0)
			folder_name_text.Size = UDim2.new(0.8, 0, 1, 0)
			folder_name_text.Font = Enum.Font.GothamMedium
			folder_name_text.Text = folder_name
			folder_name_text.TextColor3 = Color3.fromRGB(220, 220, 220)
			folder_name_text.TextSize = 14
			folder_name_text.TextXAlignment = Enum.TextXAlignment.Left
			
			folder_toggle.Name = "FolderToggle"
			folder_toggle.Parent = folder_header
			folder_toggle.BackgroundTransparency = 1.000
			folder_toggle.Position = UDim2.new(0.85, 0, 0.25, 0)
			folder_toggle.Rotation = 0
			folder_toggle.Size = UDim2.new(0, 20, 0, 20)
			folder_toggle.Image = "rbxassetid://6031094678"
			folder_toggle.ImageColor3 = Color3.fromRGB(150, 150, 150)
			
			folder_content.Name = "FolderContent"
			folder_content.Parent = folder_container
			folder_content.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			folder_content.BackgroundTransparency = 1.000
			folder_content.BorderSizePixel = 0
			folder_content.Position = UDim2.new(0, 0, 1, 0)
			folder_content.Size = UDim2.new(1, 0, 0, 0)
			
			ui_list_layout_folder.Parent = folder_content
			ui_list_layout_folder.HorizontalAlignment = Enum.HorizontalAlignment.Center
			ui_list_layout_folder.SortOrder = Enum.SortOrder.LayoutOrder
			ui_list_layout_folder.Padding = UDim.new(0, 5)
			ui_list_layout_folder.VerticalAlignment = Enum.VerticalAlignment.Top
			
			local is_folder_open = true
			local folder_elements = {}
			local function toggle_folder()
				is_folder_open = not is_folder_open
				if is_folder_open then
					game:GetService("TweenService"):Create(folder_toggle, TweenInfo.new(0.2), {Rotation = 0}):Play()
					folder_content:TweenSize(UDim2.new(1, 0, 0, #folder_elements * 45), "Out", "Sine", 0.2)
					wait(0.2)
					folder_container:TweenSize(UDim2.new(0.92, 0, 0, 40 + #folder_elements * 45), "Out", "Sine", 0.2)
				else
					game:GetService("TweenService"):Create(folder_toggle, TweenInfo.new(0.2), {Rotation = -90}):Play()
					folder_content:TweenSize(UDim2.new(1, 0, 0, 0), "Out", "Sine", 0.2)
					wait(0.2)
					folder_container:TweenSize(UDim2.new(0.92, 0, 0, 40), "Out", "Sine", 0.2)
				end
			end
			
			folder_toggle.MouseButton1Click:Connect(toggle_folder)
			folder_header.MouseButton1Click:Connect(toggle_folder)
			
			local folder_lib = {}
			
			function folder_lib:Button(name, callback)
				local button_container = Instance.new("Frame")
				local ui_corner_btn = Instance.new("UICorner")
				local button = Instance.new("TextButton")
				local button_name_text = Instance.new("TextLabel")
				local button_hover = Instance.new("Frame")
				
				button_container.Name = "ButtonContainer"
				button_container.Parent = folder_content
				button_container.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				button_container.BorderSizePixel = 0
				button_container.Size = UDim2.new(0.9, 0, 0, 36)
				
				ui_corner_btn.CornerRadius = UDim.new(0, 6)
				ui_corner_btn.Parent = button_container
				
				button_hover.Name = "ButtonHover"
				button_hover.Parent = button_container
				button_hover.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				button_hover.BackgroundTransparency = 0.9
				button_hover.Size = UDim2.new(1, 0, 1, 0)
				button_hover.Visible = false
				
				local ui_corner_hover = Instance.new("UICorner")
				ui_corner_hover.CornerRadius = UDim.new(0, 6)
				ui_corner_hover.Parent = button_hover
				
				button.Name = "Button"
				button.Parent = button_container
				button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				button.BackgroundTransparency = 1
				button.Size = UDim2.new(1, 0, 1, 0)
				button.Font = Enum.Font.SourceSans
				button.Text = ""
				button.TextColor3 = Color3.fromRGB(0, 0, 0)
				button.TextSize = 14.000
				button.AutoButtonColor = false
				
				button_name_text.Name = "ButtonName"
				button_name_text.Parent = button_container
				button_name_text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				button_name_text.BackgroundTransparency = 1.000
				button_name_text.Size = UDim2.new(1, 0, 1, 0)
				button_name_text.Font = Enum.Font.GothamMedium
				button_name_text.Text = name
				button_name_text.TextColor3 = Color3.fromRGB(220, 220, 220)
				button_name_text.TextSize = 14
				
				button.MouseEnter:Connect(function()
					button_hover.Visible = true
					game:GetService("TweenService"):Create(button_container, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
				end)
				
				button.MouseLeave:Connect(function()
					button_hover.Visible = false
					game:GetService("TweenService"):Create(button_container, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
				end)
				
				button.MouseButton1Click:Connect(function()
					game:GetService("TweenService"):Create(button_container, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(0, 170, 255)}):Play()
					wait(0.1)
					game:GetService("TweenService"):Create(button_container, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
					callback()
				end)
				
				table.insert(folder_elements, button_container)
			end
			
			function folder_lib:Toggle(name, callback)
				local toggle_container = Instance.new("Frame")
				local ui_corner_toggle = Instance.new("UICorner")
				local toggle_name_text = Instance.new("TextLabel")
				local toggle_button = Instance.new("TextButton")
				local ui_corner_3 = Instance.new("UICorner")
				local toggle_indicator = Instance.new("Frame")
				local ui_corner_indicator = Instance.new("UICorner")
				
				toggle_container.Name = "ToggleContainer"
				toggle_container.Parent = folder_content
				toggle_container.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				toggle_container.BorderSizePixel = 0
				toggle_container.Size = UDim2.new(0.9, 0, 0, 36)
				
				ui_corner_toggle.CornerRadius = UDim.new(0, 6)
				ui_corner_toggle.Parent = toggle_container
				
				toggle_name_text.Name = "ToggleName"
				toggle_name_text.Parent = toggle_container
				toggle_name_text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				toggle_name_text.BackgroundTransparency = 1.000
				toggle_name_text.Position = UDim2.new(0.05, 0, 0, 0)
				toggle_name_text.Size = UDim2.new(0.65, 0, 1, 0)
				toggle_name_text.Font = Enum.Font.GothamMedium
				toggle_name_text.Text = name
				toggle_name_text.TextColor3 = Color3.fromRGB(220, 220, 220)
				toggle_name_text.TextSize = 14
				toggle_name_text.TextXAlignment = Enum.TextXAlignment.Left
				
				toggle_button.Name = "Toggle"
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
				
				ui_corner_3.CornerRadius = UDim.new(1, 0)
				ui_corner_3.Parent = toggle_button
				
				toggle_indicator.Name = "ToggleIndicator"
				toggle_indicator.Parent = toggle_button
				toggle_indicator.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
				toggle_indicator.BorderSizePixel = 0
				toggle_indicator.Position = UDim2.new(0.05, 0, 0.1, 0)
				toggle_indicator.Size = UDim2.new(0, 16, 0, 16)
				
				ui_corner_indicator.CornerRadius = UDim.new(1, 0)
				ui_corner_indicator.Parent = toggle_indicator
				
				local toggled = false
				toggle_button.MouseButton1Click:Connect(function()
					toggled = not toggled
					if toggled then
						game:GetService("TweenService"):Create(toggle_indicator, TweenInfo.new(0.2), {Position = UDim2.new(0.55, 0, 0.1, 0)}):Play()
						game:GetService("TweenService"):Create(toggle_indicator, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 170, 255)}):Play()
						game:GetService("TweenService"):Create(toggle_button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 100, 150)}):Play()
					else
						game:GetService("TweenService"):Create(toggle_indicator, TweenInfo.new(0.2), {Position = UDim2.new(0.05, 0, 0.1, 0)}):Play()
						game:GetService("TweenService"):Create(toggle_indicator, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play()
						game:GetService("TweenService"):Create(toggle_button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
					end
					callback(toggled)
				end)
				
				table.insert(folder_elements, toggle_container)
			end
			
			function folder_lib:Slider(name, min, max, default, callback)
				local slider_container = Instance.new("Frame")
				local ui_corner_slider = Instance.new("UICorner")
				local slider_name_text = Instance.new("TextLabel")
				local slider_value_text = Instance.new("TextLabel")
				local slider_track = Instance.new("Frame")
				local ui_corner_track = Instance.new("UICorner")
				local slider_fill = Instance.new("Frame")
				local ui_corner_fill = Instance.new("UICorner")
				local slider_button = Instance.new("TextButton")
				
				slider_container.Name = "SliderContainer"
				slider_container.Parent = folder_content
				slider_container.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				slider_container.BorderSizePixel = 0
				slider_container.Size = UDim2.new(0.9, 0, 0, 50)
				
				ui_corner_slider.CornerRadius = UDim.new(0, 6)
				ui_corner_slider.Parent = slider_container
				
				slider_name_text.Name = "SliderName"
				slider_name_text.Parent = slider_container
				slider_name_text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				slider_name_text.BackgroundTransparency = 1.000
				slider_name_text.Position = UDim2.new(0.05, 0, 0, 0)
				slider_name_text.Size = UDim2.new(0.6, 0, 0, 20)
				slider_name_text.Font = Enum.Font.GothamMedium
				slider_name_text.Text = name
				slider_name_text.TextColor3 = Color3.fromRGB(220, 220, 220)
				slider_name_text.TextSize = 14
				slider_name_text.TextXAlignment = Enum.TextXAlignment.Left
				
				slider_value_text.Name = "SliderValue"
				slider_value_text.Parent = slider_container
				slider_value_text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				slider_value_text.BackgroundTransparency = 1.000
				slider_value_text.Position = UDim2.new(0.7, 0, 0, 0)
				slider_value_text.Size = UDim2.new(0.25, 0, 0, 20)
				slider_value_text.Font = Enum.Font.GothamMedium
				slider_value_text.Text = tostring(default)
				slider_value_text.TextColor3 = Color3.fromRGB(180, 180, 180)
				slider_value_text.TextSize = 14
				slider_value_text.TextXAlignment = Enum.TextXAlignment.Right
				
				slider_track.Name = "SliderTrack"
				slider_track.Parent = slider_container
				slider_track.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				slider_track.BorderSizePixel = 0
				slider_track.Position = UDim2.new(0.05, 0, 0.6, 0)
				slider_track.Size = UDim2.new(0.9, 0, 0, 4)
				
				ui_corner_track.CornerRadius = UDim.new(1, 0)
				ui_corner_track.Parent = slider_track
				
				slider_fill.Name = "SliderFill"
				slider_fill.Parent = slider_track
				slider_fill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
				slider_fill.BorderSizePixel = 0
				slider_fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
				
				ui_corner_fill.CornerRadius = UDim.new(1, 0)
				ui_corner_fill.Parent = slider_fill
				
				slider_button.Name = "SliderButton"
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
				
				local ui_corner_button = Instance.new("UICorner")
				ui_corner_button.CornerRadius = UDim.new(1, 0)
				ui_corner_button.Parent = slider_button
				
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
					slider_value_text.Text = tostring(value)
					
					if value ~= current_value then
						current_value = value
						callback(value)
					end
				end
				
				slider_button.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = true
					end
				end)
				
				slider_button.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = false
					end
				end)
				
				game:GetService("UserInputService").InputChanged:Connect(function(input)
					if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						update_slider(input)
					end
				end)
				
				slider_track.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						update_slider(input)
						dragging = true
					end
				end)
				
				slider_track.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = false
					end
				end)
				
				table.insert(folder_elements, slider_container)
			end
			
			function folder_lib:Dropdown(name, options, callback)
				local dropdown_container = Instance.new("Frame")
				local ui_corner_dropdown = Instance.new("UICorner")
				local dropdown_name_text = Instance.new("TextLabel")
				local dropdown_button = Instance.new("TextButton")
				local dropdown_arrow = Instance.new("ImageLabel")
				local dropdown_selected_text = Instance.new("TextLabel")
				
				dropdown_container.Name = "DropdownContainer"
				dropdown_container.Parent = folder_content
				dropdown_container.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				dropdown_container.BorderSizePixel = 0
				dropdown_container.Size = UDim2.new(0.9, 0, 0, 36)
				dropdown_container.ClipsDescendants = false
				
				ui_corner_dropdown.CornerRadius = UDim.new(0, 6)
				ui_corner_dropdown.Parent = dropdown_container
				
				dropdown_name_text.Name = "DropdownName"
				dropdown_name_text.Parent = dropdown_container
				dropdown_name_text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				dropdown_name_text.BackgroundTransparency = 1.000
				dropdown_name_text.Position = UDim2.new(0.05, 0, 0, 0)
				dropdown_name_text.Size = UDim2.new(0.65, 0, 1, 0)
				dropdown_name_text.Font = Enum.Font.GothamMedium
				dropdown_name_text.Text = name
				dropdown_name_text.TextColor3 = Color3.fromRGB(220, 220, 220)
				dropdown_name_text.TextSize = 14
				dropdown_name_text.TextXAlignment = Enum.TextXAlignment.Left
				
				dropdown_button.Name = "DropdownButton"
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
				
				local ui_corner_btn = Instance.new("UICorner")
				ui_corner_btn.CornerRadius = UDim.new(0, 4)
				ui_corner_btn.Parent = dropdown_button
				
				dropdown_selected_text.Name = "DropdownSelected"
				dropdown_selected_text.Parent = dropdown_button
				dropdown_selected_text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				dropdown_selected_text.BackgroundTransparency = 1.000
				dropdown_selected_text.Size = UDim2.new(0.7, 0, 1, 0)
				dropdown_selected_text.Font = Enum.Font.Gotham
				dropdown_selected_text.Text = "Select"
				dropdown_selected_text.TextColor3 = Color3.fromRGB(200, 200, 200)
				dropdown_selected_text.TextSize = 12
				dropdown_selected_text.TextXAlignment = Enum.TextXAlignment.Left
				
				dropdown_arrow.Name = "DropdownArrow"
				dropdown_arrow.Parent = dropdown_button
				dropdown_arrow.BackgroundTransparency = 1
				dropdown_arrow.Position = UDim2.new(0.8, 0, 0.15, 0)
				dropdown_arrow.Size = UDim2.new(0, 12, 0, 12)
				dropdown_arrow.Image = "rbxassetid://6031094678"
				dropdown_arrow.ImageColor3 = Color3.fromRGB(200, 200, 200)
				dropdown_arrow.Rotation = 0
				
				local dropdown_list = Instance.new("ScrollingFrame")
				local ui_list_layout_list = Instance.new("UIListLayout")
				
				dropdown_list.Name = "DropdownList"
				dropdown_list.Parent = uilib
				dropdown_list.Active = true
				dropdown_list.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				dropdown_list.BorderSizePixel = 0
				dropdown_list.Size = UDim2.new(0, dropdown_button.AbsoluteSize.X, 0, 0)
				dropdown_list.CanvasSize = UDim2.new(0, 0, 0, 0)
				dropdown_list.ScrollBarThickness = 3
				dropdown_list.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
				dropdown_list.Visible = false
				dropdown_list.ZIndex = 10
				dropdown_list.ClipsDescendants = true
				
				local ui_corner_list = Instance.new("UICorner")
				ui_corner_list.CornerRadius = UDim.new(0, 6)
				ui_corner_list.Parent = dropdown_list
				
				ui_list_layout_list.Parent = dropdown_list
				ui_list_layout_list.SortOrder = Enum.SortOrder.LayoutOrder
				ui_list_layout_list.Padding = UDim.new(0, 2)
				
				local is_open = false
				local selected_option = nil
				
				local function update_list_height()
					local item_count = #options
					local height = math.min(item_count * 30, 150)
					dropdown_list.CanvasSize = UDim2.new(0, 0, 0, item_count * 30)
					return height
				end
				
				local function toggle_dropdown()
					is_open = not is_open
					if is_open then
						dropdown_list.Visible = true
						dropdown_list.Position = UDim2.new(0, dropdown_button.AbsolutePosition.X, 0, dropdown_button.AbsolutePosition.Y + dropdown_button.AbsoluteSize.Y)
						dropdown_list.Size = UDim2.new(0, dropdown_button.AbsoluteSize.X, 0, 0)
						game:GetService("TweenService"):Create(dropdown_arrow, TweenInfo.new(0.2), {Rotation = 180}):Play()
						game:GetService("TweenService"):Create(dropdown_button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
						dropdown_list:TweenSize(UDim2.new(0, dropdown_button.AbsoluteSize.X, 0, update_list_height()), "Out", "Sine", 0.2)
					else
						game:GetService("TweenService"):Create(dropdown_arrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
						game:GetService("TweenService"):Create(dropdown_button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
						dropdown_list:TweenSize(UDim2.new(0, dropdown_button.AbsoluteSize.X, 0, 0), "Out", "Sine", 0.2, true, function()
							dropdown_list.Visible = false
						end)
					end
				end
				
				dropdown_button.MouseButton1Click:Connect(toggle_dropdown)
				
				for i, option in ipairs(options) do
					local option_button = Instance.new("TextButton")
					option_button.Name = "Option_" .. option
					option_button.Parent = dropdown_list
					option_button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
					option_button.BorderSizePixel = 0
					option_button.Size = UDim2.new(1, -10, 0, 30)
					option_button.Position = UDim2.new(0.05, 0, 0, (i-1)*30)
					option_button.Font = Enum.Font.Gotham
					option_button.Text = option
					option_button.TextColor3 = Color3.fromRGB(200, 200, 200)
					option_button.TextSize = 12
					option_button.AutoButtonColor = false
					option_button.ZIndex = 11
					
					local ui_corner_option = Instance.new("UICorner")
					ui_corner_option.CornerRadius = UDim.new(0, 4)
					ui_corner_option.Parent = option_button
					
					option_button.MouseButton1Click:Connect(function()
						selected_option = option
						dropdown_selected_text.Text = option
						toggle_dropdown()
						callback(option)
					end)
					
					option_button.MouseEnter:Connect(function()
						game:GetService("TweenService"):Create(option_button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
					end)
					
					option_button.MouseLeave:Connect(function()
						game:GetService("TweenService"):Create(option_button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
					end)
				end
				
				update_list_height()
				
				local connection
				connection = game:GetService("UserInputService").InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 and is_open then
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
				
				table.insert(folder_elements, dropdown_container)
			end
			
			function folder_lib:Colorpicker(name, default_color, callback)
				local colorpicker_container = Instance.new("Frame")
				local ui_corner_color = Instance.new("UICorner")
				local colorpicker_name_text = Instance.new("TextLabel")
				local color_button = Instance.new("TextButton")
				local color_preview = Instance.new("Frame")
				local ui_corner_preview = Instance.new("UICorner")
				
				colorpicker_container.Name = "ColorpickerContainer"
				colorpicker_container.Parent = folder_content
				colorpicker_container.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				colorpicker_container.BorderSizePixel = 0
				colorpicker_container.Size = UDim2.new(0.9, 0, 0, 36)
				
				ui_corner_color.CornerRadius = UDim.new(0, 6)
				ui_corner_color.Parent = colorpicker_container
				
				colorpicker_name_text.Name = "ColorpickerName"
				colorpicker_name_text.Parent = colorpicker_container
				colorpicker_name_text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				colorpicker_name_text.BackgroundTransparency = 1.000
				colorpicker_name_text.Position = UDim2.new(0.05, 0, 0, 0)
				colorpicker_name_text.Size = UDim2.new(0.65, 0, 1, 0)
				colorpicker_name_text.Font = Enum.Font.GothamMedium
				colorpicker_name_text.Text = name
				colorpicker_name_text.TextColor3 = Color3.fromRGB(220, 220, 220)
				colorpicker_name_text.TextSize = 14
				colorpicker_name_text.TextXAlignment = Enum.TextXAlignment.Left
				
				color_button.Name = "ColorButton"
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
				
				local ui_corner_btn = Instance.new("UICorner")
				ui_corner_btn.CornerRadius = UDim.new(0, 4)
				ui_corner_btn.Parent = color_button
				
				color_preview.Name = "ColorPreview"
				color_preview.Parent = color_button
				color_preview.BackgroundColor3 = default_color or Color3.fromRGB(0, 170, 255)
				color_preview.BorderSizePixel = 0
				color_preview.Position = UDim2.new(0.1, 0, 0.1, 0)
				color_preview.Size = UDim2.new(0.8, 0, 0, 16)
				
				ui_corner_preview.CornerRadius = UDim.new(0, 4)
				ui_corner_preview.Parent = color_preview
				
				local color_picker_frame = nil
				
				local function show_color_picker()
					if color_picker_frame then
						color_picker_frame:Destroy()
					end
					
					color_picker_frame = Instance.new("Frame")
					local ui_corner_frame = Instance.new("UICorner")
					local title_text_picker = Instance.new("TextLabel")
					local saturation_value_picker = Instance.new("Frame")
					local saturation_value_image = Instance.new("ImageLabel")
					local sv_selector = Instance.new("Frame")
					local ui_corner_selector = Instance.new("UICorner")
					local hue_slider = Instance.new("Frame")
					local ui_corner_hue = Instance.new("UICorner")
					local hue_button = Instance.new("TextButton")
					local ui_corner_huebtn = Instance.new("UICorner")
					local rgb_inputs = Instance.new("Frame")
					local r_label = Instance.new("TextLabel")
					local r_box = Instance.new("TextBox")
					local g_label = Instance.new("TextLabel")
					local g_box = Instance.new("TextBox")
					local b_label = Instance.new("TextLabel")
					local b_box = Instance.new("TextBox")
					local apply_button = Instance.new("TextButton")
					local apply_text = Instance.new("TextLabel")
					local close_button = Instance.new("TextButton")
					local close_text = Instance.new("TextLabel")
					
					local current_color = color_preview.BackgroundColor3
					local h, s, v = current_color:ToHSV()
					
					color_picker_frame.Name = "ColorPickerFrame"
					color_picker_frame.Parent = uilib
					color_picker_frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
					color_picker_frame.BorderSizePixel = 0
					color_picker_frame.Position = UDim2.new(0.4, 0, 0.4, 0)
					color_picker_frame.Size = UDim2.new(0, 300, 0, 250)
					color_picker_frame.Active = true
					color_picker_frame.Draggable = true
					
					ui_corner_frame.CornerRadius = UDim.new(0, 8)
					ui_corner_frame.Parent = color_picker_frame
					
					title_text_picker.Name = "Title"
					title_text_picker.Parent = color_picker_frame
					title_text_picker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					title_text_picker.BackgroundTransparency = 1.000
					title_text_picker.Position = UDim2.new(0.05, 0, 0.02, 0)
					title_text_picker.Size = UDim2.new(0.9, 0, 0, 25)
					title_text_picker.Font = Enum.Font.GothamMedium
					title_text_picker.Text = "Color Picker"
					title_text_picker.TextColor3 = Color3.fromRGB(220, 220, 220)
					title_text_picker.TextSize = 16
					
					saturation_value_picker.Name = "SaturationValuePicker"
					saturation_value_picker.Parent = color_picker_frame
					saturation_value_picker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					saturation_value_picker.BorderSizePixel = 0
					saturation_value_picker.Position = UDim2.new(0.05, 0, 0.15, 0)
					saturation_value_picker.Size = UDim2.new(0, 200, 0, 120)
					
					local hue_color = Color3.fromHSV(h, 1, 1)
					saturation_value_image.Name = "SaturationValueImage"
					saturation_value_image.Parent = saturation_value_picker
					saturation_value_image.BackgroundColor3 = hue_color
					saturation_value_image.Size = UDim2.new(1, 0, 1, 0)
					saturation_value_image.Image = "rbxassetid://4155801252"
					
					sv_selector.Name = "SVSelector"
					sv_selector.Parent = saturation_value_picker
					sv_selector.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					sv_selector.BorderSizePixel = 2
					sv_selector.BorderColor3 = Color3.fromRGB(0, 0, 0)
					sv_selector.Position = UDim2.new(s, -5, 1-v, -5)
					sv_selector.Size = UDim2.new(0, 10, 0, 10)
					sv_selector.ZIndex = 2
					
					ui_corner_selector.CornerRadius = UDim.new(1, 0)
					ui_corner_selector.Parent = sv_selector
					
					hue_slider.Name = "HueSlider"
					hue_slider.Parent = color_picker_frame
					hue_slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					hue_slider.BorderSizePixel = 0
					hue_slider.Position = UDim2.new(0.75, 0, 0.15, 0)
					hue_slider.Size = UDim2.new(0, 20, 0, 120)
					
					ui_corner_hue.CornerRadius = UDim.new(0, 4)
					ui_corner_hue.Parent = hue_slider
					
					local hue_gradient = Instance.new("UIGradient")
					hue_gradient.Parent = hue_slider
					hue_gradient.Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
						ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
						ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
						ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
						ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
					}
					
					hue_button.Name = "HueButton"
					hue_button.Parent = hue_slider
					hue_button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					hue_button.BorderSizePixel = 2
					hue_button.BorderColor3 = Color3.fromRGB(0, 0, 0)
					hue_button.Position = UDim2.new(0, -3, 1-h, -5)
					hue_button.Size = UDim2.new(0, 26, 0, 10)
					hue_button.Font = Enum.Font.SourceSans
					hue_button.Text = ""
					hue_button.TextColor3 = Color3.fromRGB(0, 0, 0)
					hue_button.TextSize = 14.000
					hue_button.AutoButtonColor = false
					
					ui_corner_huebtn.CornerRadius = UDim.new(0, 2)
					ui_corner_huebtn.Parent = hue_button
					
					rgb_inputs.Name = "RGBInputs"
					rgb_inputs.Parent = color_picker_frame
					rgb_inputs.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
					rgb_inputs.BackgroundTransparency = 1
					rgb_inputs.Position = UDim2.new(0.05, 0, 0.7, 0)
					rgb_inputs.Size = UDim2.new(0, 200, 0, 60)
					
					r_label.Name = "RLabel"
					r_label.Parent = rgb_inputs
					r_label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					r_label.BackgroundTransparency = 1
					r_label.Position = UDim2.new(0, 0, 0, 0)
					r_label.Size = UDim2.new(0, 20, 0, 20)
					r_label.Font = Enum.Font.GothamMedium
					r_label.Text = "R:"
					r_label.TextColor3 = Color3.fromRGB(220, 220, 220)
					r_label.TextSize = 14
					r_label.TextXAlignment = Enum.TextXAlignment.Left
					
					r_box.Name = "RBox"
					r_box.Parent = rgb_inputs
					r_box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
					r_box.BorderSizePixel = 0
					r_box.Position = UDim2.new(0.15, 0, 0, 0)
					r_box.Size = UDim2.new(0, 50, 0, 20)
					r_box.Font = Enum.Font.Gotham
					r_box.Text = tostring(math.floor(current_color.r * 255))
					r_box.TextColor3 = Color3.fromRGB(220, 220, 220)
					r_box.TextSize = 14
					r_box.ClearTextOnFocus = false
					
					local ui_corner_r = Instance.new("UICorner")
					ui_corner_r.CornerRadius = UDim.new(0, 4)
					ui_corner_r.Parent = r_box
					
					g_label.Name = "GLabel"
					g_label.Parent = rgb_inputs
					g_label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					g_label.BackgroundTransparency = 1
					g_label.Position = UDim2.new(0.5, 0, 0, 0)
					g_label.Size = UDim2.new(0, 20, 0, 20)
					g_label.Font = Enum.Font.GothamMedium
					g_label.Text = "G:"
					g_label.TextColor3 = Color3.fromRGB(220, 220, 220)
					g_label.TextSize = 14
					g_label.TextXAlignment = Enum.TextXAlignment.Left
					
					g_box.Name = "GBox"
					g_box.Parent = rgb_inputs
					g_box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
					g_box.BorderSizePixel = 0
					g_box.Position = UDim2.new(0.65, 0, 0, 0)
					g_box.Size = UDim2.new(0, 50, 0, 20)
					g_box.Font = Enum.Font.Gotham
					g_box.Text = tostring(math.floor(current_color.g * 255))
					g_box.TextColor3 = Color3.fromRGB(220, 220, 220)
					g_box.TextSize = 14
					g_box.ClearTextOnFocus = false
					
					local ui_corner_g = Instance.new("UICorner")
					ui_corner_g.CornerRadius = UDim.new(0, 4)
					ui_corner_g.Parent = g_box
					
					b_label.Name = "BLabel"
					b_label.Parent = rgb_inputs
					b_label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					b_label.BackgroundTransparency = 1
					b_label.Position = UDim2.new(0, 0, 0.5, 0)
					b_label.Size = UDim2.new(0, 20, 0, 20)
					b_label.Font = Enum.Font.GothamMedium
					b_label.Text = "B:"
					b_label.TextColor3 = Color3.fromRGB(220, 220, 220)
					b_label.TextSize = 14
					b_label.TextXAlignment = Enum.TextXAlignment.Left
					
					b_box.Name = "BBox"
					b_box.Parent = rgb_inputs
					b_box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
					b_box.BorderSizePixel = 0
					b_box.Position = UDim2.new(0.15, 0, 0.5, 0)
					b_box.Size = UDim2.new(0, 50, 0, 20)
					b_box.Font = Enum.Font.Gotham
					b_box.Text = tostring(math.floor(current_color.b * 255))
					b_box.TextColor3 = Color3.fromRGB(220, 220, 220)
					b_box.TextSize = 14
					b_box.ClearTextOnFocus = false
					
					local ui_corner_b = Instance.new("UICorner")
					ui_corner_b.CornerRadius = UDim.new(0, 4)
					ui_corner_b.Parent = b_box
					
					apply_button.Name = "ApplyButton"
					apply_button.Parent = color_picker_frame
					apply_button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
					apply_button.BorderSizePixel = 0
					apply_button.Position = UDim2.new(0.75, 0, 0.7, 0)
					apply_button.Size = UDim2.new(0, 60, 0, 25)
					apply_button.Font = Enum.Font.GothamMedium
					apply_button.Text = ""
					apply_button.TextColor3 = Color3.fromRGB(255, 255, 255)
					apply_button.TextSize = 14
					
					local ui_corner_apply = Instance.new("UICorner")
					ui_corner_apply.CornerRadius = UDim.new(0, 4)
					ui_corner_apply.Parent = apply_button
					
					apply_text.Name = "ApplyText"
					apply_text.Parent = apply_button
					apply_text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					apply_text.BackgroundTransparency = 1.000
					apply_text.Size = UDim2.new(1, 0, 1, 0)
					apply_text.Font = Enum.Font.GothamMedium
					apply_text.Text = "Apply"
					apply_text.TextColor3 = Color3.fromRGB(255, 255, 255)
					apply_text.TextSize = 14
					
					close_button.Name = "CloseButton"
					close_button.Parent = color_picker_frame
					close_button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
					close_button.BorderSizePixel = 0
					close_button.Position = UDim2.new(0.75, 0, 0.85, 0)
					close_button.Size = UDim2.new(0, 60, 0, 25)
					close_button.Font = Enum.Font.GothamMedium
					close_button.Text = ""
					close_button.TextColor3 = Color3.fromRGB(255, 255, 255)
					close_button.TextSize = 14
					
					local ui_corner_close = Instance.new("UICorner")
					ui_corner_close.CornerRadius = UDim.new(0, 4)
					ui_corner_close.Parent = close_button
					
					close_text.Name = "CloseText"
					close_text.Parent = close_button
					close_text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					close_text.BackgroundTransparency = 1.000
					close_text.Size = UDim2.new(1, 0, 1, 0)
					close_text.Font = Enum.Font.GothamMedium
					close_text.Text = "Close"
					close_text.TextColor3 = Color3.fromRGB(220, 220, 220)
					close_text.TextSize = 14
					
					local dragging_hue = false
					local dragging_sv = false
					
					local function update_color_from_hsv()
						current_color = Color3.fromHSV(h, s, v)
						color_preview.BackgroundColor3 = current_color
						saturation_value_image.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
						
						r_box.Text = tostring(math.floor(current_color.r * 255))
						g_box.Text = tostring(math.floor(current_color.g * 255))
						b_box.Text = tostring(math.floor(current_color.b * 255))
					end
					
					local function update_color_from_rgb()
						local r = math.clamp(tonumber(r_box.Text) or 0, 0, 255) / 255
						local g = math.clamp(tonumber(g_box.Text) or 0, 0, 255) / 255
						local b = math.clamp(tonumber(b_box.Text) or 0, 0, 255) / 255
						
						current_color = Color3.new(r, g, b)
						h, s, v = current_color:ToHSV()
						
						hue_button.Position = UDim2.new(0, -3, 1-h, -5)
						sv_selector.Position = UDim2.new(s, -5, 1-v, -5)
						saturation_value_image.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
						color_preview.BackgroundColor3 = current_color
					end
					
					local function update_hue(input)
						local pos = math.clamp((input.Position.Y - hue_slider.AbsolutePosition.Y) / hue_slider.AbsoluteSize.Y, 0, 1)
						h = 1 - pos
						hue_button.Position = UDim2.new(0, -3, pos, -5)
						update_color_from_hsv()
					end
					
					local function update_saturation_value(input)
						local x = math.clamp((input.Position.X - saturation_value_picker.AbsolutePosition.X) / saturation_value_picker.AbsoluteSize.X, 0, 1)
						local y = math.clamp((input.Position.Y - saturation_value_picker.AbsolutePosition.Y) / saturation_value_picker.AbsoluteSize.Y, 0, 1)
						s = x
						v = 1 - y
						sv_selector.Position = UDim2.new(x, -5, y, -5)
						update_color_from_hsv()
					end
					
					hue_button.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							dragging_hue = true
						end
					end)
					
					hue_button.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							dragging_hue = false
						end
					end)
					
					hue_slider.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							update_hue(input)
							dragging_hue = true
						end
					end)
					
					hue_slider.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							dragging_hue = false
						end
					end)
					
					sv_selector.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							dragging_sv = true
						end
					end)
					
					sv_selector.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							dragging_sv = false
						end
					end)
					
					saturation_value_picker.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							update_saturation_value(input)
							dragging_sv = true
						end
					end)
					
					saturation_value_picker.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							dragging_sv = false
						end
					end)
					
					game:GetService("UserInputService").InputChanged:Connect(function(input)
						if dragging_hue and input.UserInputType == Enum.UserInputType.MouseMovement then
							update_hue(input)
						elseif dragging_sv and input.UserInputType == Enum.UserInputType.MouseMovement then
							update_saturation_value(input)
						end
					end)
					
					r_box.FocusLost:Connect(function()
						update_color_from_rgb()
					end)
					
					g_box.FocusLost:Connect(function()
						update_color_from_rgb()
					end)
					
					b_box.FocusLost:Connect(function()
						update_color_from_rgb()
					end)
					
					apply_button.MouseButton1Click:Connect(function()
						callback(current_color)
						color_picker_frame:Destroy()
						color_picker_frame = nil
					end)
					
					close_button.MouseButton1Click:Connect(function()
						color_picker_frame:Destroy()
						color_picker_frame = nil
					end)
					
					update_color_from_hsv()
				end
				
				color_button.MouseButton1Click:Connect(show_color_picker)
				
				table.insert(folder_elements, colorpicker_container)
			end
			
			function folder_lib:Bind(name, default_key, callback)
				local bind_container = Instance.new("Frame")
				local ui_corner_bind = Instance.new("UICorner")
				local bind_name_text = Instance.new("TextLabel")
				local bind_button = Instance.new("TextButton")
				local bind_key_text = Instance.new("TextLabel")
				
				bind_container.Name = "BindContainer"
				bind_container.Parent = folder_content
				bind_container.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				bind_container.BorderSizePixel = 0
				bind_container.Size = UDim2.new(0.9, 0, 0, 36)
				
				ui_corner_bind.CornerRadius = UDim.new(0, 6)
				ui_corner_bind.Parent = bind_container
				
				bind_name_text.Name = "BindName"
				bind_name_text.Parent = bind_container
				bind_name_text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				bind_name_text.BackgroundTransparency = 1.000
				bind_name_text.Position = UDim2.new(0.05, 0, 0, 0)
				bind_name_text.Size = UDim2.new(0.65, 0, 1, 0)
				bind_name_text.Font = Enum.Font.GothamMedium
				bind_name_text.Text = name
				bind_name_text.TextColor3 = Color3.fromRGB(220, 220, 220)
				bind_name_text.TextSize = 14
				bind_name_text.TextXAlignment = Enum.TextXAlignment.Left
				
				bind_button.Name = "BindButton"
				bind_button.Parent = bind_container
				bind_button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				bind_button.BackgroundTransparency = 0
				bind_button.Position = UDim2.new(0.7, 0, 0.22, 0)
				bind_button.Size = UDim2.new(0.25, 0, 0, 20)
				bind_button.Font = Enum.Font.Gotham
				bind_button.Text = ""
				bind_button.TextColor3 = Color3.fromRGB(220, 220, 220)
				bind_button.TextSize = 12
				bind_button.AutoButtonColor = false
				
				local ui_corner_btn = Instance.new("UICorner")
				ui_corner_btn.CornerRadius = UDim.new(0, 4)
				ui_corner_btn.Parent = bind_button
				
				bind_key_text.Name = "BindKeyText"
				bind_key_text.Parent = bind_button
				bind_key_text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				bind_key_text.BackgroundTransparency = 1.000
				bind_key_text.Size = UDim2.new(1, 0, 1, 0)
				bind_key_text.Font = Enum.Font.Gotham
				bind_key_text.Text = tostring(default_key)
				bind_key_text.TextColor3 = Color3.fromRGB(200, 200, 200)
				bind_key_text.TextSize = 12
				
				local listening = false
				local current_key = default_key
				
				local function update_bind(key)
					current_key = key
					bind_key_text.Text = tostring(key)
					callback(key)
				end
				
				bind_button.MouseButton1Click:Connect(function()
					if not listening then
						listening = true
						bind_key_text.Text = "..."
						bind_button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
						
						local connection
						connection = game:GetService("UserInputService").InputBegan:Connect(function(input)
							if listening and input.UserInputType == Enum.UserInputType.Keyboard then
								update_bind(input.KeyCode.Name)
								listening = false
								bind_button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
								connection:Disconnect()
							end
						end)
						
						local cancel_connection
						cancel_connection = game:GetService("UserInputService").InputBegan:Connect(function(input)
							if listening and input.UserInputType == Enum.UserInputType.MouseButton1 then
								local mouse_pos = game:GetService("UserInputService"):GetMouseLocation()
								local button_pos = bind_button.AbsolutePosition
								local button_size = bind_button.AbsoluteSize
								
								if not (mouse_pos.X >= button_pos.X and mouse_pos.X <= button_pos.X + button_size.X and
									   mouse_pos.Y >= button_pos.Y and mouse_pos.Y <= button_pos.Y + button_size.Y) then
									listening = false
									bind_button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
									bind_key_text.Text = tostring(current_key)
									connection:Disconnect()
									cancel_connection:Disconnect()
								end
							end
						end)
					end
				end)
				
				update_bind(default_key)
				
				table.insert(folder_elements, bind_container)
			end
			
			function folder_lib:Box(name, placeholder, callback)
				local box_container = Instance.new("Frame")
				local ui_corner_box = Instance.new("UICorner")
				local box_name_text = Instance.new("TextLabel")
				local text_box = Instance.new("TextBox")
				
				box_container.Name = "BoxContainer"
				box_container.Parent = folder_content
				box_container.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				box_container.BorderSizePixel = 0
				box_container.Size = UDim2.new(0.9, 0, 0, 36)
				
				ui_corner_box.CornerRadius = UDim.new(0, 6)
				ui_corner_box.Parent = box_container
				
				box_name_text.Name = "BoxName"
				box_name_text.Parent = box_container
				box_name_text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				box_name_text.BackgroundTransparency = 1.000
				box_name_text.Position = UDim2.new(0.05, 0, 0, 0)
				box_name_text.Size = UDim2.new(0.65, 0, 1, 0)
				box_name_text.Font = Enum.Font.GothamMedium
				box_name_text.Text = name
				box_name_text.TextColor3 = Color3.fromRGB(220, 220, 220)
				box_name_text.TextSize = 14
				box_name_text.TextXAlignment = Enum.TextXAlignment.Left
				
				text_box.Name = "TextBox"
				text_box.Parent = box_container
				text_box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				text_box.BackgroundTransparency = 0
				text_box.BorderSizePixel = 0
				text_box.Position = UDim2.new(0.7, 0, 0.22, 0)
				text_box.Size = UDim2.new(0.25, 0, 0, 20)
				text_box.Font = Enum.Font.Gotham
				text_box.PlaceholderText = placeholder or "Enter text..."
				text_box.Text = ""
				text_box.TextColor3 = Color3.fromRGB(220, 220, 220)
				text_box.TextSize = 12
				text_box.ClearTextOnFocus = false
				
				local ui_corner_textbox = Instance.new("UICorner")
				ui_corner_textbox.CornerRadius = UDim.new(0, 4)
				ui_corner_textbox.Parent = text_box
				
				text_box.FocusLost:Connect(function()
					callback(text_box.Text)
				end)
				
				table.insert(folder_elements, box_container)
			end
			
			function folder_lib:Label(text)
				local label_container = Instance.new("Frame")
				local ui_corner_label = Instance.new("UICorner")
				local label_text = Instance.new("TextLabel")
				
				label_container.Name = "LabelContainer"
				label_container.Parent = folder_content
				label_container.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				label_container.BorderSizePixel = 0
				label_container.Size = UDim2.new(0.9, 0, 0, 30)
				
				ui_corner_label.CornerRadius = UDim.new(0, 6)
				ui_corner_label.Parent = label_container
				
				label_text.Name = "LabelText"
				label_text.Parent = label_container
				label_text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				label_text.BackgroundTransparency = 1.000
				label_text.Size = UDim2.new(1, 0, 1, 0)
				label_text.Font = Enum.Font.Gotham
				label_text.Text = text
				label_text.TextColor3 = Color3.fromRGB(180, 180, 180)
				label_text.TextSize = 12
				label_text.TextWrapped = true
				
				table.insert(folder_elements, label_container)
			end
			
			function folder_lib:Separator()
				local separator_container = Instance.new("Frame")
				local separator_line = Instance.new("Frame")
				
				separator_container.Name = "SeparatorContainer"
				separator_container.Parent = folder_content
				separator_container.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				separator_container.BorderSizePixel = 0
				separator_container.Size = UDim2.new(0.9, 0, 0, 10)
				
				separator_line.Name = "SeparatorLine"
				separator_line.Parent = separator_container
				separator_line.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
				separator_line.BorderSizePixel = 0
				separator_line.Position = UDim2.new(0.1, 0, 0.5, 0)
				separator_line.Size = UDim2.new(0.8, 0, 0, 1)
				
				table.insert(folder_elements, separator_container)
			end
			
			function folder_lib:DestroyGui()
				local button_container = Instance.new("Frame")
				local ui_corner_btn = Instance.new("UICorner")
				local button = Instance.new("TextButton")
				local button_name_text = Instance.new("TextLabel")
				local button_hover = Instance.new("Frame")
				
				button_container.Name = "ButtonContainer"
				button_container.Parent = folder_content
				button_container.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				button_container.BorderSizePixel = 0
				button_container.Size = UDim2.new(0.9, 0, 0, 36)
				
				ui_corner_btn.CornerRadius = UDim.new(0, 6)
				ui_corner_btn.Parent = button_container
				
				button_hover.Name = "ButtonHover"
				button_hover.Parent = button_container
				button_hover.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				button_hover.BackgroundTransparency = 0.9
				button_hover.Size = UDim2.new(1, 0, 1, 0)
				button_hover.Visible = false
				
				local ui_corner_hover = Instance.new("UICorner")
				ui_corner_hover.CornerRadius = UDim.new(0, 6)
				ui_corner_hover.Parent = button_hover
				
				button.Name = "Button"
				button.Parent = button_container
				button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				button.BackgroundTransparency = 1
				button.Size = UDim2.new(1, 0, 1, 0)
				button.Font = Enum.Font.SourceSans
				button.Text = ""
				button.TextColor3 = Color3.fromRGB(0, 0, 0)
				button.TextSize = 14.000
				button.AutoButtonColor = false
				
				button_name_text.Name = "ButtonName"
				button_name_text.Parent = button_container
				button_name_text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				button_name_text.BackgroundTransparency = 1.000
				button_name_text.Size = UDim2.new(1, 0, 1, 0)
				button_name_text.Font = Enum.Font.GothamMedium
				button_name_text.Text = "Destroy UI"
				button_name_text.TextColor3 = Color3.fromRGB(255, 100, 100)
				button_name_text.TextSize = 14
				
				button.MouseEnter:Connect(function()
					button_hover.Visible = true
					game:GetService("TweenService"):Create(button_container, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 25, 25)}):Play()
				end)
				
				button.MouseLeave:Connect(function()
					button_hover.Visible = false
					game:GetService("TweenService"):Create(button_container, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
				end)
				
				button.MouseButton1Click:Connect(function()
					game:GetService("TweenService"):Create(button_container, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(255, 50, 50)}):Play()
					wait(0.1)
					game:GetService("TweenService"):Create(button_container, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
					main_window:Destroy()
				end)
				
				table.insert(folder_elements, button_container)
			end
			
			return folder_lib
		end
		
		return tab_lib
	end
	
	return lib
	
end

return library
