for i,v in pairs(game.coregui:getchildren()) do
	if v.name == "uilb" then
		v:destroy()
	end
end

local uilb = instance.new("screengui")
uilb.name = "uilb"
uilb.parent = game.coregui
uilb.zindexbehavior = enum.zindexbehavior.sibling
uilb.resetonrespawn = false

local function get_next_window_pos()
	local biggest = 0
	local ok = nil
	for i, v in pairs(uilb:getchildren()) do
		if v.position.x.offset > biggest then
			biggest = v.position.x.offset
			ok = v
		end
	end
	if biggest == 0 then
		biggest = biggest + 15
	else
		biggest = biggest + ok.size.x.offset + 10
	end
	return biggest
end

local library = {}

function library:window(title)
	local top = instance.new("frame")
	local uicorner = instance.new("uicorner")
	local container_scroll = instance.new("scrollingframe")
	local uilistlayout = instance.new("uilistlayout")
	local title_label = instance.new("textlabel")
	local minimize_button = instance.new("textbutton")
	local shadow = instance.new("imagelabel")
	local background = instance.new("frame")
	local uicorner_bg = instance.new("uicorner")

	top.name = "top"
	top.parent = uilb
	top.backgroundcolor3 = color3.fromrgb(20, 20, 20)
	top.bordersizepixel = 0
	top.position = udim2.new(0, get_next_window_pos(), 0.01, 0)
	top.size = udim2.new(0, 280, 0, 40)
	top.active = true
	top.draggable = true

	uicorner.cornerradius = udim.new(0, 8)
	uicorner.parent = top

	background.name = "background"
	background.parent = top
	background.backgroundcolor3 = color3.fromrgb(20, 20, 20)
	background.bordersizepixel = 0
	background.size = udim2.new(1, 0, 1, 400)
	background.zindex = -1
	
	uicorner_bg.cornerradius = udim.new(0, 8)
	uicorner_bg.parent = background

	shadow.name = "shadow"
	shadow.parent = top
	shadow.backgroundtransparency = 1.000
	shadow.position = udim2.new(0, -15, 0, -15)
	shadow.size = udim2.new(1, 30, 1, 430)
	shadow.image = "rbxassetid://5554236805"
	shadow.imagecolor3 = color3.fromrgb(0, 0, 0)
	shadow.imagetransparency = 0.8
	shadow.scaletype = enum.scaletype.slice
	shadow.slicecenter = rect.new(23, 23, 277, 277)
	shadow.zindex = -1

	container_scroll.name = "container_scroll"
	container_scroll.parent = top
	container_scroll.backgroundcolor3 = color3.fromrgb(20, 20, 20)
	container_scroll.backgroundtransparency = 1
	container_scroll.clipsdescendants = true
	container_scroll.position = udim2.new(0, 0, 1, 0)
	container_scroll.size = udim2.new(1, 0, 0, 400)
	container_scroll.zindex = 2
	container_scroll.scrollbarthickness = 3
	container_scroll.scrollbarimagecolor3 = color3.fromrgb(60, 60, 60)
	container_scroll.scrollbarimagetransparency = 0.6
	container_scroll.canvassize = udim2.new(0, 0, 0, 0)

	uilistlayout.parent = container_scroll
	uilistlayout.horizontalalignment = enum.horizontalalignment.center
	uilistlayout.sortorder = enum.sortorder.layoutorder
	uilistlayout.padding = udim.new(0, 8)
	uilistlayout.verticalalignment = enum.verticalalignment.top

	title_label.name = "title"
	title_label.parent = top
	title_label.backgroundcolor3 = color3.fromrgb(255, 255, 255)
	title_label.backgroundtransparency = 1.000
	title_label.position = udim2.new(0.05, 0, 0, 0)
	title_label.size = udim2.new(0.7, 0, 1, 0)
	title_label.font = enum.font.gothamsemibold
	title_label.text = title
	title_label.textcolor3 = color3.fromrgb(240, 240, 240)
	title_label.textsize = 15
	title_label.textwrapped = true
	title_label.textxalignment = enum.textxalignment.left

	minimize_button.name = "minimize_button"
	minimize_button.parent = top
	minimize_button.backgroundcolor3 = color3.fromrgb(40, 40, 40)
	minimize_button.bordersizepixel = 0
	minimize_button.position = udim2.new(0.85, 0, 0.2, 0)
	minimize_button.size = udim2.new(0, 24, 0, 24)
	minimize_button.zindex = 2
	minimize_button.font = enum.font.gothamsemibold
	minimize_button.text = "X"
	minimize_button.textcolor3 = color3.fromrgb(200, 200, 200)
	minimize_button.textsize = 14

	local function minimize_script()
		local script = instance.new('script', minimize_button)

		local is_open = true
		
		script.parent.mousebutton1click:connect(function()
			if is_open then
				game:getservice("tweenservice"):create(script.parent, tweeninfo.new(0.25, enum.easingstyle.quad, enum.easingdirection.out), {
					textcolor3 = color3.fromrgb(150, 150, 150),
					text = "-"
				}):play()
				container_scroll:tweenposition(udim2.new(0, 0, 0, 40), "out", "quad", 0.25, true, function()
					container_scroll.visible = false
				end)
				is_open = false
			else
				container_scroll.visible = true
				game:getservice("tweenservice"):create(script.parent, tweeninfo.new(0.25, enum.easingstyle.quad, enum.easingdirection.out), {
					textcolor3 = color3.fromrgb(200, 200, 200),
					text = "X"
				}):play()
				container_scroll:tweenposition(udim2.new(0, 0, 1, 0), "out", "quad", 0.25, true)
				is_open = true
			end
		end)
	end
	coroutine.wrap(minimize_script)()
	
	uilistlayout:getpropertychangedsignal("absolutecontentsize"):connect(function()
		container_scroll.canvassize = udim2.new(0, 0, 0, uilistlayout.absolutecontentsize.y + 10)
	end)
	
	local lib = {}
	
	function lib:button(name, callback)
		local button_container = instance.new("frame")
		local uicorner_btn = instance.new("uicorner")
		local button = instance.new("textbutton")
		local button_name_label = instance.new("textlabel")
		
		button_container.name = "button_container"
		button_container.parent = container_scroll
		button_container.backgroundcolor3 = color3.fromrgb(30, 30, 30)
		button_container.bordersizepixel = 0
		button_container.size = udim2.new(0.9, 0, 0, 36)
		
		uicorner_btn.cornerradius = udim.new(0, 6)
		uicorner_btn.parent = button_container
		
		button.name = "button"
		button.parent = button_container
		button.backgroundcolor3 = color3.fromrgb(255, 255, 255)
		button.backgroundtransparency = 1
		button.size = udim2.new(1, 0, 1, 0)
		button.font = enum.font.sourcesans
		button.text = ""
		button.textcolor3 = color3.fromrgb(0, 0, 0)
		button.textsize = 14.000
		button.autobuttoncolor = false
		
		button_name_label.name = "button_name"
		button_name_label.parent = button_container
		button_name_label.backgroundcolor3 = color3.fromrgb(255, 255, 255)
		button_name_label.backgroundtransparency = 1.000
		button_name_label.size = udim2.new(1, 0, 1, 0)
		button_name_label.font = enum.font.gotham
		button_name_label.text = name
		button_name_label.textcolor3 = color3.fromrgb(220, 220, 220)
		button_name_label.textsize = 13
		
		button.mouseenter:connect(function()
			game:getservice("tweenservice"):create(button_container, tweeninfo.new(0.15, enum.easingstyle.quad), {backgroundcolor3 = color3.fromrgb(35, 35, 35)}):play()
		end)
		
		button.mouseleave:connect(function()
			game:getservice("tweenservice"):create(button_container, tweeninfo.new(0.15, enum.easingstyle.quad), {backgroundcolor3 = color3.fromrgb(30, 30, 30)}):play()
		end)
		
		button.mousebutton1click:connect(function()
			game:getservice("tweenservice"):create(button_container, tweeninfo.new(0.1, enum.easingstyle.quad), {backgroundcolor3 = color3.fromrgb(40, 40, 40)}):play()
			wait(0.1)
			game:getservice("tweenservice"):create(button_container, tweeninfo.new(0.15, enum.easingstyle.quad), {backgroundcolor3 = color3.fromrgb(30, 30, 30)}):play()
			callback()
		end)
		
		button.touchtap:connect(function()
			game:getservice("tweenservice"):create(button_container, tweeninfo.new(0.1, enum.easingstyle.quad), {backgroundcolor3 = color3.fromrgb(40, 40, 40)}):play()
			wait(0.1)
			game:getservice("tweenservice"):create(button_container, tweeninfo.new(0.15, enum.easingstyle.quad), {backgroundcolor3 = color3.fromrgb(30, 30, 30)}):play()
			callback()
		end)
	end
	
	function lib:toggle(name, callback)
		local toggle_container = instance.new("frame")
		local uicorner_toggle = instance.new("uicorner")
		local toggle_name_label = instance.new("textlabel")
		local toggle_button = instance.new("textbutton")
		local uicorner_toggle_bg = instance.new("uicorner")
		local toggle_indicator = instance.new("frame")
		local uicorner_indicator = instance.new("uicorner")
		
		toggle_container.name = "toggle_container"
		toggle_container.parent = container_scroll
		toggle_container.backgroundcolor3 = color3.fromrgb(30, 30, 30)
		toggle_container.bordersizepixel = 0
		toggle_container.size = udim2.new(0.9, 0, 0, 36)
		
		uicorner_toggle.cornerradius = udim.new(0, 6)
		uicorner_toggle.parent = toggle_container
		
		toggle_name_label.name = "toggle_name"
		toggle_name_label.parent = toggle_container
		toggle_name_label.backgroundcolor3 = color3.fromrgb(255, 255, 255)
		toggle_name_label.backgroundtransparency = 1.000
		toggle_name_label.position = udim2.new(0.05, 0, 0, 0)
		toggle_name_label.size = udim2.new(0.65, 0, 1, 0)
		toggle_name_label.font = enum.font.gotham
		toggle_name_label.text = name
		toggle_name_label.textcolor3 = color3.fromrgb(220, 220, 220)
		toggle_name_label.textsize = 13
		toggle_name_label.textxalignment = enum.textxalignment.left
		
		toggle_button.name = "toggle"
		toggle_button.parent = toggle_container
		toggle_button.backgroundcolor3 = color3.fromrgb(40, 40, 40)
		toggle_button.bordercolor3 = color3.fromrgb(27, 42, 53)
		toggle_button.position = udim2.new(0.78, 0, 0.22, 0)
		toggle_button.size = udim2.new(0, 40, 0, 20)
		toggle_button.autobuttoncolor = false
		toggle_button.font = enum.font.sourcesans
		toggle_button.text = ""
		toggle_button.textcolor3 = color3.fromrgb(0, 0, 0)
		toggle_button.textsize = 14.000
		
		uicorner_toggle_bg.cornerradius = udim.new(1, 0)
		uicorner_toggle_bg.parent = toggle_button
		
		toggle_indicator.name = "toggle_indicator"
		toggle_indicator.parent = toggle_button
		toggle_indicator.backgroundcolor3 = color3.fromrgb(100, 100, 100)
		toggle_indicator.bordersizepixel = 0
		toggle_indicator.position = udim2.new(0.05, 0, 0.1, 0)
		toggle_indicator.size = udim2.new(0, 16, 0, 16)
		
		uicorner_indicator.cornerradius = udim.new(1, 0)
		uicorner_indicator.parent = toggle_indicator
		
		local toggled = false
		
		local function toggle_state()
			toggled = not toggled
			if toggled then
				game:getservice("tweenservice"):create(toggle_indicator, tweeninfo.new(0.2, enum.easingstyle.quad), {position = udim2.new(0.55, 0, 0.1, 0), backgroundcolor3 = color3.fromrgb(0, 180, 255)}):play()
				game:getservice("tweenservice"):create(toggle_button, tweeninfo.new(0.2, enum.easingstyle.quad), {backgroundcolor3 = color3.fromrgb(0, 100, 150)}):play()
			else
				game:getservice("tweenservice"):create(toggle_indicator, tweeninfo.new(0.2, enum.easingstyle.quad), {position = udim2.new(0.05, 0, 0.1, 0), backgroundcolor3 = color3.fromrgb(100, 100, 100)}):play()
				game:getservice("tweenservice"):create(toggle_button, tweeninfo.new(0.2, enum.easingstyle.quad), {backgroundcolor3 = color3.fromrgb(40, 40, 40)}):play()
			end
			callback(toggled)
		end
		
		toggle_button.mousebutton1click:connect(toggle_state)
		toggle_button.touchtap:connect(toggle_state)
		
		toggle_container.mouseenter:connect(function()
			game:getservice("tweenservice"):create(toggle_container, tweeninfo.new(0.15, enum.easingstyle.quad), {backgroundcolor3 = color3.fromrgb(35, 35, 35)}):play()
		end)
		
		toggle_container.mouseleave:connect(function()
			game:getservice("tweenservice"):create(toggle_container, tweeninfo.new(0.15, enum.easingstyle.quad), {backgroundcolor3 = color3.fromrgb(30, 30, 30)}):play()
		end)
	end
	
	function lib:slider(name, min, max, default, callback)
		local slider_container = instance.new("frame")
		local uicorner_slider = instance.new("uicorner")
		local slider_name_label = instance.new("textlabel")
		local slider_value_label = instance.new("textlabel")
		local slider_track = instance.new("frame")
		local uicorner_track = instance.new("uicorner")
		local slider_fill = instance.new("frame")
		local uicorner_fill = instance.new("uicorner")
		local slider_button = instance.new("textbutton")
		
		slider_container.name = "slider_container"
		slider_container.parent = container_scroll
		slider_container.backgroundcolor3 = color3.fromrgb(30, 30, 30)
		slider_container.bordersizepixel = 0
		slider_container.size = udim2.new(0.9, 0, 0, 48)
		
		uicorner_slider.cornerradius = udim.new(0, 6)
		uicorner_slider.parent = slider_container
		
		slider_name_label.name = "slider_name"
		slider_name_label.parent = slider_container
		slider_name_label.backgroundcolor3 = color3.fromrgb(255, 255, 255)
		slider_name_label.backgroundtransparency = 1.000
		slider_name_label.position = udim2.new(0.05, 0, 0, 0)
		slider_name_label.size = udim2.new(0.6, 0, 0, 20)
		slider_name_label.font = enum.font.gotham
		slider_name_label.text = name
		slider_name_label.textcolor3 = color3.fromrgb(220, 220, 220)
		slider_name_label.textsize = 13
		slider_name_label.textxalignment = enum.textxalignment.left
		
		slider_value_label.name = "slider_value"
		slider_value_label.parent = slider_container
		slider_value_label.backgroundcolor3 = color3.fromrgb(255, 255, 255)
		slider_value_label.backgroundtransparency = 1.000
		slider_value_label.position = udim2.new(0.7, 0, 0, 0)
		slider_value_label.size = udim2.new(0.25, 0, 0, 20)
		slider_value_label.font = enum.font.gotham
		slider_value_label.text = tostring(default)
		slider_value_label.textcolor3 = color3.fromrgb(180, 180, 180)
		slider_value_label.textsize = 13
		slider_value_label.textxalignment = enum.textxalignment.right
		
		slider_track.name = "slider_track"
		slider_track.parent = slider_container
		slider_track.backgroundcolor3 = color3.fromrgb(40, 40, 40)
		slider_track.bordersizepixel = 0
		slider_track.position = udim2.new(0.05, 0, 0.6, 0)
		slider_track.size = udim2.new(0.9, 0, 0, 4)
		
		uicorner_track.cornerradius = udim.new(1, 0)
		uicorner_track.parent = slider_track
		
		slider_fill.name = "slider_fill"
		slider_fill.parent = slider_track
		slider_fill.backgroundcolor3 = color3.fromrgb(0, 180, 255)
		slider_fill.bordersizepixel = 0
		slider_fill.size = udim2.new((default - min) / (max - min), 0, 1, 0)
		
		uicorner_fill.cornerradius = udim.new(1, 0)
		uicorner_fill.parent = slider_fill
		
		slider_button.name = "slider_button"
		slider_button.parent = slider_track
		slider_button.backgroundcolor3 = color3.fromrgb(255, 255, 255)
		slider_button.bordersizepixel = 0
		slider_button.position = udim2.new((default - min) / (max - min), -8, 0, -6)
		slider_button.size = udim2.new(0, 16, 0, 16)
		slider_button.font = enum.font.sourcesans
		slider_button.text = ""
		slider_button.textcolor3 = color3.fromrgb(0, 0, 0)
		slider_button.textsize = 14.000
		slider_button.autobuttoncolor = false
		
		local uicorner_slider_button = instance.new("uicorner")
		uicorner_slider_button.cornerradius = udim.new(1, 0)
		uicorner_slider_button.parent = slider_button
		
		local dragging = false
		local current_value = default
		
		local function update_slider(input)
			local pos = udim2.new(
				math.clamp((input.position.x - slider_track.absoluteposition.x) / slider_track.absolutesize.x, 0, 1),
				0,
				0, 0
			)
			local value = math.floor(min + (pos.x.scale * (max - min)))
			
			slider_fill.size = udim2.new(pos.x.scale, 0, 1, 0)
			slider_button.position = udim2.new(pos.x.scale, -8, 0, -6)
			slider_value_label.text = tostring(value)
			
			if value ~= current_value then
				current_value = value
				callback(value)
			end
		end
		
		local function start_dragging(input)
			dragging = true
			game:getservice("tweenservice"):create(slider_button, tweeninfo.new(0.15, enum.easingstyle.quad), {size = udim2.new(0, 20, 0, 20)}):play()
		end
		
		local function stop_dragging()
			dragging = false
			game:getservice("tweenservice"):create(slider_button, tweeninfo.new(0.15, enum.easingstyle.quad), {size = udim2.new(0, 16, 0, 16)}):play()
		end
		
		slider_button.inputbegan:connect(function(input)
			if input.userinputtype == enum.userinputtype.mousebutton1 or input.userinputtype == enum.userinputtype.touch then
				start_dragging(input)
			end
		end)
		
		slider_button.inputended:connect(function(input)
			if input.userinputtype == enum.userinputtype.mousebutton1 or input.userinputtype == enum.userinputtype.touch then
				stop_dragging()
			end
		end)
		
		game:getservice("userinputservice").inputchanged:connect(function(input)
			if dragging and (input.userinputtype == enum.userinputtype.mousemovement or input.userinputtype == enum.userinputtype.touch) then
				update_slider(input)
			end
		end)
		
		slider_track.inputbegan:connect(function(input)
			if input.userinputtype == enum.userinputtype.mousebutton1 or input.userinputtype == enum.userinputtype.touch then
				update_slider(input)
				start_dragging(input)
			end
		end)
		
		slider_track.inputended:connect(function(input)
			if input.userinputtype == enum.userinputtype.mousebutton1 or input.userinputtype == enum.userinputtype.touch then
				stop_dragging()
			end
		end)
		
		slider_container.mouseenter:connect(function()
			game:getservice("tweenservice"):create(slider_container, tweeninfo.new(0.15, enum.easingstyle.quad), {backgroundcolor3 = color3.fromrgb(35, 35, 35)}):play()
		end)
		
		slider_container.mouseleave:connect(function()
			game:getservice("tweenservice"):create(slider_container, tweeninfo.new(0.15, enum.easingstyle.quad), {backgroundcolor3 = color3.fromrgb(30, 30, 30)}):play()
		end)
	end
	
	function lib:dropdown(name, options, callback)
		local dropdown_container = instance.new("frame")
		local uicorner_dropdown = instance.new("uicorner")
		local dropdown_name_label = instance.new("textlabel")
		local dropdown_button = instance.new("textbutton")
		local dropdown_arrow = instance.new("imagelabel")
		local dropdown_selected = instance.new("textlabel")
		
		dropdown_container.name = "dropdown_container"
		dropdown_container.parent = container_scroll
		dropdown_container.backgroundcolor3 = color3.fromrgb(30, 30, 30)
		dropdown_container.bordersizepixel = 0
		dropdown_container.size = udim2.new(0.9, 0, 0, 36)
		dropdown_container.clipsdescendants = false
		
		uicorner_dropdown.cornerradius = udim.new(0, 6)
		uicorner_dropdown.parent = dropdown_container
		
		dropdown_name_label.name = "dropdown_name"
		dropdown_name_label.parent = dropdown_container
		dropdown_name_label.backgroundcolor3 = color3.fromrgb(255, 255, 255)
		dropdown_name_label.backgroundtransparency = 1.000
		dropdown_name_label.position = udim2.new(0.05, 0, 0, 0)
		dropdown_name_label.size = udim2.new(0.65, 0, 1, 0)
		dropdown_name_label.font = enum.font.gotham
		dropdown_name_label.text = name
		dropdown_name_label.textcolor3 = color3.fromrgb(220, 220, 220)
		dropdown_name_label.textsize = 13
		dropdown_name_label.textxalignment = enum.textxalignment.left
		
		dropdown_button.name = "dropdown_button"
		dropdown_button.parent = dropdown_container
		dropdown_button.backgroundcolor3 = color3.fromrgb(40, 40, 40)
		dropdown_button.backgroundtransparency = 0
		dropdown_button.position = udim2.new(0.7, 0, 0.22, 0)
		dropdown_button.size = udim2.new(0.25, 0, 0, 20)
		dropdown_button.font = enum.font.sourcesans
		dropdown_button.text = ""
		dropdown_button.textcolor3 = color3.fromrgb(255, 255, 255)
		dropdown_button.textsize = 12.000
		dropdown_button.autobuttoncolor = false
		
		local uicorner_dropdown_button = instance.new("uicorner")
		uicorner_dropdown_button.cornerradius = udim.new(0, 4)
		uicorner_dropdown_button.parent = dropdown_button
		
		dropdown_selected.name = "dropdown_selected"
		dropdown_selected.parent = dropdown_button
		dropdown_selected.backgroundcolor3 = color3.fromrgb(255, 255, 255)
		dropdown_selected.backgroundtransparency = 1.000
		dropdown_selected.position = udim2.new(0.05, 0, 0, 0)
		dropdown_selected.size = udim2.new(0.7, 0, 1, 0)
		dropdown_selected.font = enum.font.gotham
		dropdown_selected.text = "select"
		dropdown_selected.textcolor3 = color3.fromrgb(200, 200, 200)
		dropdown_selected.textsize = 11
		dropdown_selected.textxalignment = enum.textxalignment.left
		
		dropdown_arrow.name = "dropdown_arrow"
		dropdown_arrow.parent = dropdown_button
		dropdown_arrow.backgroundtransparency = 1
		dropdown_arrow.position = udim2.new(0.8, 0, 0.15, 0)
		dropdown_arrow.size = udim2.new(0, 12, 0, 12)
		dropdown_arrow.image = "rbxassetid://4726772334"
		dropdown_arrow.imagecolor3 = color3.fromrgb(200, 200, 200)
		dropdown_arrow.rotation = 90
		
		local dropdown_list = instance.new("frame")
		local dropdown_scroll = instance.new("scrollingframe")
		local uilistlayout_list = instance.new("uilistlayout")
		
		dropdown_list.name = "dropdown_list"
		dropdown_list.parent = uilb
		dropdown_list.backgroundcolor3 = color3.fromrgb(35, 35, 35)
		dropdown_list.bordersizepixel = 0
		dropdown_list.size = udim2.new(0, dropdown_button.absolutesize.x, 0, 0)
		dropdown_list.visible = false
		dropdown_list.zindex = 20
		dropdown_list.clipsdescendants = true
		
		local dropdown_shadow = instance.new("imagelabel")
		dropdown_shadow.name = "dropdown_shadow"
		dropdown_shadow.parent = dropdown_list
		dropdown_shadow.backgroundtransparency = 1
		dropdown_shadow.size = udim2.new(1, 15, 1, 15)
		dropdown_shadow.position = udim2.new(0, -8, 0, -8)
		dropdown_shadow.image = "rbxassetid://5554236805"
		dropdown_shadow.imagecolor3 = color3.fromrgb(0, 0, 0)
		dropdown_shadow.imagetransparency = 0.8
		dropdown_shadow.scaletype = enum.scaletype.slice
		dropdown_shadow.slicecenter = rect.new(23, 23, 277, 277)
		dropdown_shadow.zindex = 19
		
		local uicorner_list = instance.new("uicorner")
		uicorner_list.cornerradius = udim.new(0, 6)
		uicorner_list.parent = dropdown_list
		
		dropdown_scroll.name = "dropdown_scroll"
		dropdown_scroll.parent = dropdown_list
		dropdown_scroll.active = true
		dropdown_scroll.backgroundtransparency = 1
		dropdown_scroll.bordersizepixel = 0
		dropdown_scroll.size = udim2.new(1, -6, 1, -6)
		dropdown_scroll.position = udim2.new(0, 3, 0, 3)
		dropdown_scroll.canvassize = udim2.new(0, 0, 0, 0)
		dropdown_scroll.scrollbarthickness = 3
		dropdown_scroll.scrollbarimagecolor3 = color3.fromrgb(60, 60, 60)
		dropdown_scroll.scrollbarimagetransparency = 0.3
		dropdown_scroll.verticalscrollbarinset = enum.scrollbarinset.always
		dropdown_scroll.zindex = 21
		
		uilistlayout_list.parent = dropdown_scroll
		uilistlayout_list.sortorder = enum.sortorder.layoutorder
		uilistlayout_list.padding = udim.new(0, 3)
		
		local is_open = false
		local selected_option = nil
		
		local function update_list_height()
			local item_count = #options
			local height = math.min(item_count * 28 + 6, 140)
			dropdown_scroll.canvassize = udim2.new(0, 0, 0, item_count * 28)
			return height
		end
		
		local function toggle_dropdown()
			is_open = not is_open
			if is_open then
				dropdown_list.visible = true
				dropdown_list.position = udim2.new(
					0, dropdown_button.absoluteposition.x,
					0, dropdown_button.absoluteposition.y + dropdown_button.absolutesize.y + 4
				)
				dropdown_list.size = udim2.new(0, dropdown_button.absolutesize.x, 0, 0)
				game:getservice("tweenservice"):create(dropdown_arrow, tweeninfo.new(0.2, enum.easingstyle.quad), {rotation = 270}):play()
				game:getservice("tweenservice"):create(dropdown_button, tweeninfo.new(0.2, enum.easingstyle.quad), {backgroundcolor3 = color3.fromrgb(50, 50, 50)}):play()
				dropdown_list:tweenposition(
					udim2.new(
						0, dropdown_button.absoluteposition.x,
						0, dropdown_button.absoluteposition.y + dropdown_button.absolutesize.y + 4
					),
					"out", "quad", 0.2, true
				)
				dropdown_list:tweensize(
					udim2.new(0, dropdown_button.absolutesize.x, 0, update_list_height()),
					"out", "quad", 0.2, true
				)
			else
				game:getservice("tweenservice"):create(dropdown_arrow, tweeninfo.new(0.2, enum.easingstyle.quad), {rotation = 90}):play()
				game:getservice("tweenservice"):create(dropdown_button, tweeninfo.new(0.2, enum.easingstyle.quad), {backgroundcolor3 = color3.fromrgb(40, 40, 40)}):play()
				dropdown_list:tweensize(
					udim2.new(0, dropdown_button.absolutesize.x, 0, 0),
					"out", "quad", 0.2, true,
					function()
						dropdown_list.visible = false
					end
				)
			end
		end
		
		dropdown_button.mousebutton1click:connect(toggle_dropdown)
		dropdown_button.touchtap:connect(toggle_dropdown)
		
		for i, option in ipairs(options) do
			local option_button = instance.new("textbutton")
			local option_text = instance.new("textlabel")
			
			option_button.name = "option_" .. option
			option_button.parent = dropdown_scroll
			option_button.backgroundcolor3 = color3.fromrgb(40, 40, 40)
			option_button.bordersizepixel = 0
			option_button.size = udim2.new(1, 0, 0, 26)
			option_button.font = enum.font.sourcesans
			option_button.text = ""
			option_button.textcolor3 = color3.fromrgb(0, 0, 0)
			option_button.textsize = 14
			option_button.autobuttoncolor = false
			option_button.zindex = 22
			
			local uicorner_option = instance.new("uicorner")
			uicorner_option.cornerradius = udim.new(0, 4)
			uicorner_option.parent = option_button
			
			option_text.name = "option_text"
			option_text.parent = option_button
			option_text.backgroundtransparency = 1
			option_text.size = udim2.new(1, -8, 1, 0)
			option_text.position = udim2.new(0, 4, 0, 0)
			option_text.font = enum.font.gotham
			option_text.text = option
			option_text.textcolor3 = color3.fromrgb(220, 220, 220)
			option_text.textsize = 11
			option_text.textxalignment = enum.textxalignment.left
			option_text.zindex = 24
			
			option_button.mousebutton1click:connect(function()
				selected_option = option
				dropdown_selected.text = option
				toggle_dropdown()
				callback(option)
			end)
			
			option_button.touchtap:connect(function()
				selected_option = option
				dropdown_selected.text = option
				toggle_dropdown()
				callback(option)
			end)
			
			option_button.mouseenter:connect(function()
				game:getservice("tweenservice"):create(option_button, tweeninfo.new(0.15, enum.easingstyle.quad), {backgroundcolor3 = color3.fromrgb(50, 50, 50)}):play()
			end)
			
			option_button.mouseleave:connect(function()
				game:getservice("tweenservice"):create(option_button, tweeninfo.new(0.15, enum.easingstyle.quad), {backgroundcolor3 = color3.fromrgb(40, 40, 40)}):play()
			end)
		end
		
		update_list_height()
		
		local connection
		connection = game:getservice("userinputservice").inputbegan:connect(function(input)
			if (input.userinputtype == enum.userinputtype.mousebutton1 or input.userinputtype == enum.userinputtype.touch) and is_open then
				local mouse_pos = game:getservice("userinputservice"):getmouselocation()
				local dropdown_pos = dropdown_list.absoluteposition
				local dropdown_size = dropdown_list.absolutesize
				
				if not (mouse_pos.x >= dropdown_pos.x and mouse_pos.x <= dropdown_pos.x + dropdown_size.x and
					   mouse_pos.y >= dropdown_pos.y and mouse_pos.y <= dropdown_pos.y + dropdown_size.y) then
					if is_open then
						toggle_dropdown()
					end
				end
			end
		end)
		
		top.destroying:connect(function()
			if connection then
				connection:disconnect()
			end
		end)
		
		dropdown_container.mouseenter:connect(function()
			game:getservice("tweenservice"):create(dropdown_container, tweeninfo.new(0.15, enum.easingstyle.quad), {backgroundcolor3 = color3.fromrgb(35, 35, 35)}):play()
		end)
		
		dropdown_container.mouseleave:connect(function()
			game:getservice("tweenservice"):create(dropdown_container, tweeninfo.new(0.15, enum.easingstyle.quad), {backgroundcolor3 = color3.fromrgb(30, 30, 30)}):play()
		end)
	end
	
	function lib:colorpicker(name, default_color, callback)
		local colorpicker_container = instance.new("frame")
		local uicorner_color = instance.new("uicorner")
		local colorpicker_name_label = instance.new("textlabel")
		local color_button = instance.new("textbutton")
		local color_preview = instance.new("frame")
		local uicorner_preview = instance.new("uicorner")
		
		colorpicker_container.name = "colorpicker_container"
		colorpicker_container.parent = container_scroll
		colorpicker_container.backgroundcolor3 = color3.fromrgb(30, 30, 30)
		colorpicker_container.bordersizepixel = 0
		colorpicker_container.size = udim2.new(0.9, 0, 0, 36)
		
		uicorner_color.cornerradius = udim.new(0, 6)
		uicorner_color.parent = colorpicker_container
		
		colorpicker_name_label.name = "colorpicker_name"
		colorpicker_name_label.parent = colorpicker_container
		colorpicker_name_label.backgroundcolor3 = color3.fromrgb(255, 255, 255)
		colorpicker_name_label.backgroundtransparency = 1.000
		colorpicker_name_label.position = udim2.new(0.05, 0, 0, 0)
		colorpicker_name_label.size = udim2.new(0.65, 0, 1, 0)
		colorpicker_name_label.font = enum.font.gotham
		colorpicker_name_label.text = name
		colorpicker_name_label.textcolor3 = color3.fromrgb(220, 220, 220)
		colorpicker_name_label.textsize = 13
		colorpicker_name_label.textxalignment = enum.textxalignment.left
		
		color_button.name = "color_button"
		color_button.parent = colorpicker_container
		color_button.backgroundcolor3 = color3.fromrgb(40, 40, 40)
		color_button.backgroundtransparency = 0
		color_button.position = udim2.new(0.7, 0, 0.22, 0)
		color_button.size = udim2.new(0.25, 0, 0, 20)
		color_button.font = enum.font.sourcesans
		color_button.text = ""
		color_button.textcolor3 = color3.fromrgb(0, 0, 0)
		color_button.textsize = 14.000
		color_button.autobuttoncolor = false
		
		local uicorner_color_button = instance.new("uicorner")
		uicorner_color_button.cornerradius = udim.new(0, 4)
		uicorner_color_button.parent = color_button
		
		color_preview.name = "color_preview"
		color_preview.parent = color_button
		color_preview.backgroundcolor3 = default_color or color3.fromrgb(0, 180, 255)
		color_preview.bordersizepixel = 0
		color_preview.position = udim2.new(0.1, 0, 0.1, 0)
		color_preview.size = udim2.new(0.8, 0, 0, 16)
		
		uicorner_preview.cornerradius = udim.new(0, 3)
		uicorner_preview.parent = color_preview
		
		local color_picker_frame = nil
		
		local function show_color_picker()
			if color_picker_frame then
				color_picker_frame:destroy()
				color_picker_frame = nil
				return
			end
			
			color_picker_frame = instance.new("frame")
			local uicorner_frame = instance.new("uicorner")
			local color_display = instance.new("frame")
			local uicorner_display = instance.new("uicorner")
			local current_color_label = instance.new("textlabel")
			local new_color_label = instance.new("textlabel")
			
			local color_palette = instance.new("imagebutton")
			local color_palette_cursor = instance.new("frame")
			
			local hue_slider_container = instance.new("frame")
			local hue_slider = instance.new("frame")
			local hue_gradient = instance.new("uigradient")
			local hue_button = instance.new("textbutton")
			
			local r_container = instance.new("frame")
			local r_label = instance.new("textlabel")
			local r_slider = instance.new("frame")
			local r_fill = instance.new("frame")
			local r_button = instance.new("textbutton")
			local r_value = instance.new("textlabel")
			
			local g_container = instance.new("frame")
			local g_label = instance.new("textlabel")
			local g_slider = instance.new("frame")
			local g_fill = instance.new("frame")
			local g_button = instance.new("textbutton")
			local g_value = instance.new("textlabel")
			
			local b_container = instance.new("frame")
			local b_label = instance.new("textlabel")
			local b_slider = instance.new("frame")
			local b_fill = instance.new("frame")
			local b_button = instance.new("textbutton")
			local b_value = instance.new("textlabel")
			
			local hex_container = instance.new("frame")
			local hex_label = instance.new("textlabel")
			local hex_input = instance.new("textbox")
			
			local apply_button = instance.new("textbutton")
			
			local current_color = color_preview.backgroundcolor3
			local h, s, v = current_color:tohsv()
			local r, g, b = math.floor(current_color.r * 255), math.floor(current_color.g * 255), math.floor(current_color.b * 255)
			
			color_picker_frame.name = "color_picker_frame"
			color_picker_frame.parent = uilb
			color_picker_frame.backgroundcolor3 = color3.fromrgb(35, 35, 35)
			color_picker_frame.bordersizepixel = 0
			color_picker_frame.position = udim2.new(0, 0, 0, 0)
			color_picker_frame.size = udim2.new(0, 250, 0, 0)
			color_picker_frame.zindex = 30
			color_picker_frame.clipsdescendants = true
			
			uicorner_frame.cornerradius = udim.new(0, 8)
			uicorner_frame.parent = color_picker_frame
			
			local color_picker_shadow = instance.new("imagelabel")
			color_picker_shadow.name = "color_picker_shadow"
			color_picker_shadow.parent = color_picker_frame
			color_picker_shadow.backgroundtransparency = 1
			color_picker_shadow.size = udim2.new(1, 20, 1, 20)
			color_picker_shadow.position = udim2.new(0, -10, 0, -10)
			color_picker_shadow.image = "rbxassetid://5554236805"
			color_picker_shadow.imagecolor3 = color3.fromrgb(0, 0, 0)
			color_picker_shadow.imagetransparency = 0.8
			color_picker_shadow.scaletype = enum.scaletype.slice
			color_picker_shadow.slicecenter = rect.new(23, 23, 277, 277)
			color_picker_shadow.zindex = 29
			
			color_display.name = "color_display"
			color_display.parent = color_picker_frame
			color_display.backgroundcolor3 = current_color
			color_display.bordersizepixel = 0
			color_display.position = udim2.new(0.05, 0, 0.05, 0)
			color_display.size = udim2.new(0.45, 0, 0, 40)
			
			uicorner_display.cornerradius = udim.new(0, 6)
			uicorner_display.parent = color_display
			
			local new_color_display = instance.new("frame")
			new_color_display.name = "new_color_display"
			new_color_display.parent = color_picker_frame
			new_color_display.backgroundcolor3 = current_color
			new_color_display.bordersizepixel = 0
			new_color_display.position = udim2.new(0.5, 0, 0.05, 0)
			new_color_display.size = udim2.new(0.45, 0, 0, 40)
			
			local uicorner_new_display = instance.new("uicorner")
			uicorner_new_display.cornerradius = udim.new(0, 6)
			uicorner_new_display.parent = new_color_display
			
			current_color_label.name = "current_color_label"
			current_color_label.parent = color_picker_frame
			current_color_label.backgroundtransparency = 1
			current_color_label.position = udim2.new(0.05, 0, 0.22, 0)
			current_color_label.size = udim2.new(0.45, 0, 0, 15)
			current_color_label.font = enum.font.gotham
			current_color_label.text = "current"
			current_color_label.textcolor3 = color3.fromrgb(180, 180, 180)
			current_color_label.textsize = 10
			current_color_label.textxalignment = enum.textxalignment.center
			
			new_color_label.name = "new_color_label"
			new_color_label.parent = color_picker_frame
			new_color_label.backgroundtransparency = 1
			new_color_label.position = udim2.new(0.5, 0, 0.22, 0)
			new_color_label.size = udim2.new(0.45, 0, 0, 15)
			new_color_label.font = enum.font.gotham
			new_color_label.text = "new"
			new_color_label.textcolor3 = color3.fromrgb(180, 180, 180)
			new_color_label.textsize = 10
			new_color_label.textxalignment = enum.textxalignment.center
			
			color_palette.name = "color_palette"
			color_palette.parent = color_picker_frame
			color_palette.backgroundcolor3 = color3.fromhsv(h, 1, 1)
			color_palette.bordersizepixel = 0
			color_palette.position = udim2.new(0.05, 0, 0.32, 0)
			color_palette.size = udim2.new(0.6, 0, 0, 80)
			color_palette.image = "rbxassetid://4155801252"
			color_palette.autobuttoncolor = false
			
			color_palette_cursor.name = "color_palette_cursor"
			color_palette_cursor.parent = color_palette
			color_palette_cursor.backgroundcolor3 = color3.fromrgb(255, 255, 255)
			color_palette_cursor.bordersizepixel = 2
			color_palette_cursor.bordercolor3 = color3.fromrgb(0, 0, 0)
			color_palette_cursor.position = udim2.new(s, -5, 1 - v, -5)
			color_palette_cursor.size = udim2.new(0, 10, 0, 10)
			color_palette_cursor.zindex = 31
			
			local uicorner_palette_cursor = instance.new("uicorner")
			uicorner_palette_cursor.cornerradius = udim.new(1, 0)
			uicorner_palette_cursor.parent = color_palette_cursor
			
			hue_slider_container.name = "hue_slider_container"
			hue_slider_container.parent = color_picker_frame
			hue_slider_container.backgroundtransparency = 1
			hue_slider_container.position = udim2.new(0.68, 0, 0.32, 0)
			hue_slider_container.size = udim2.new(0.25, 0, 0, 80)
			
			hue_slider.name = "hue_slider"
			hue_slider.parent = hue_slider_container
			hue_slider.backgroundcolor3 = color3.fromrgb(255, 255, 255)
			hue_slider.bordersizepixel = 0
			hue_slider.position = udim2.new(0, 0, 0, 0)
			hue_slider.size = udim2.new(1, 0, 1, 0)
			
			hue_gradient.rotation = 90
			hue_gradient.parent = hue_slider
			hue_gradient.color = colorsequence.new{
				colorsequencekeypoint.new(0, color3.fromrgb(255, 0, 0)),
				colorsequencekeypoint.new(0.17, color3.fromrgb(255, 255, 0)),
				colorsequencekeypoint.new(0.33, color3.fromrgb(0, 255, 0)),
				colorsequencekeypoint.new(0.5, color3.fromrgb(0, 255, 255)),
				colorsequencekeypoint.new(0.67, color3.fromrgb(0, 0, 255)),
				colorsequencekeypoint.new(0.83, color3.fromrgb(255, 0, 255)),
				colorsequencekeypoint.new(1, color3.fromrgb(255, 0, 0))
			}
			
			hue_button.name = "hue_button"
			hue_button.parent = hue_slider
			hue_button.backgroundcolor3 = color3.fromrgb(255, 255, 255)
			hue_button.bordersizepixel = 2
			hue_button.bordercolor3 = color3.fromrgb(0, 0, 0)
			hue_button.position = udim2.new(0.5, -8, h, -8)
			hue_button.size = udim2.new(0, 16, 0, 16)
			hue_button.font = enum.font.sourcesans
			hue_button.text = ""
			hue_button.textcolor3 = color3.fromrgb(0, 0, 0)
			hue_button.textsize = 14
			hue_button.autobuttoncolor = false
			hue_button.zindex = 31
			
			local uicorner_hue_button = instance.new("uicorner")
			uicorner_hue_button.cornerradius = udim.new(1, 0)
			uicorner_hue_button.parent = hue_button
			
			local function create_rgb_slider(name, y_pos, value, color_val)
				local container = instance.new("frame")
				local label = instance.new("textlabel")
				local slider = instance.new("frame")
				local fill = instance.new("frame")
				local button = instance.new("textbutton")
				local value_label = instance.new("textlabel")
				
				container.name = name .. "_container"
				container.parent = color_picker_frame
				container.backgroundtransparency = 1
				container.position = udim2.new(0.05, 0, y_pos, 0)
				container.size = udim2.new(0.9, 0, 0, 25)
				
				label.name = name .. "_label"
				label.parent = container
				label.backgroundtransparency = 1
				label.position = udim2.new(0, 0, 0, 0)
				label.size = udim2.new(0.2, 0, 1, 0)
				label.font = enum.font.gotham
				label.text = name
				label.textcolor3 = color3.fromrgb(200, 200, 200)
				label.textsize = 12
				label.textxalignment = enum.textxalignment.left
				
				slider.name = name .. "_slider"
				slider.parent = container
				slider.backgroundcolor3 = color3.fromrgb(50, 50, 50)
				slider.bordersizepixel = 0
				slider.position = udim2.new(0.25, 0, 0.5, 0)
				slider.size = udim2.new(0.5, 0, 0, 4)
				
				local slider_corner = instance.new("uicorner")
				slider_corner.cornerradius = udim.new(1, 0)
				slider_corner.parent = slider
				
				fill.name = name .. "_fill"
				fill.parent = slider
				fill.backgroundcolor3 = color_val
				fill.bordersizepixel = 0
				fill.size = udim2.new(value / 255, 0, 1, 0)
				
				local fill_corner = instance.new("uicorner")
				fill_corner.cornerradius = udim.new(1, 0)
				fill_corner.parent = fill
				
				button.name = name .. "_button"
				button.parent = slider
				button.backgroundcolor3 = color3.fromrgb(255, 255, 255)
				button.bordersizepixel = 0
				button.position = udim2.new(value / 255, -6, 0, -5)
				button.size = udim2.new(0, 14, 0, 14)
				button.font = enum.font.sourcesans
				button.text = ""
				button.textcolor3 = color3.fromrgb(0, 0, 0)
				button.textsize = 14
				button.autobuttoncolor = false
				
				local button_corner = instance.new("uicorner")
				button_corner.cornerradius = udim.new(1, 0)
				button_corner.parent = button
				
				value_label.name = name .. "_value"
				value_label.parent = container
				value_label.backgroundtransparency = 1
				value_label.position = udim2.new(0.8, 0, 0, 0)
				value_label.size = udim2.new(0.2, 0, 1, 0)
				value_label.font = enum.font.gotham
				value_label.text = tostring(value)
				value_label.textcolor3 = color3.fromrgb(180, 180, 180)
				value_label.textsize = 12
				value_label.textxalignment = enum.textxalignment.right
				
				return {container = container, slider = slider, fill = fill, button = button, value = value_label}
			end
			
			local r_data = create_rgb_slider("r", 0.7, r, color3.fromrgb(255, 50, 50))
			local g_data = create_rgb_slider("g", 0.78, g, color3.fromrgb(50, 255, 50))
			local b_data = create_rgb_slider("b", 0.86, b, color3.fromrgb(50, 50, 255))
			
			hex_container.name = "hex_container"
			hex_container.parent = color_picker_frame
			hex_container.backgroundtransparency = 1
			hex_container.position = udim2.new(0.05, 0, 0.94, 0)
			hex_container.size = udim2.new(0.9, 0, 0, 25)
			
			hex_label.name = "hex_label"
			hex_label.parent = hex_container
			hex_label.backgroundtransparency = 1
			hex_label.position = udim2.new(0, 0, 0, 0)
			hex_label.size = udim2.new(0.2, 0, 1, 0)
			hex_label.font = enum.font.gotham
			hex_label.text = "hex"
			hex_label.textcolor3 = color3.fromrgb(200, 200, 200)
			hex_label.textsize = 12
			hex_label.textxalignment = enum.textxalignment.left
			
			hex_input.name = "hex_input"
			hex_input.parent = hex_container
			hex_input.backgroundcolor3 = color3.fromrgb(40, 40, 40)
			hex_input.bordersizepixel = 0
			hex_input.position = udim2.new(0.25, 0, 0, 0)
			hex_input.size = udim2.new(0.75, 0, 1, 0)
			hex_input.font = enum.font.gotham
			hex_input.placeholdertext = "#ffffff"
			hex_input.text = string.format("#%02x%02x%02x", r, g, b)
			hex_input.textcolor3 = color3.fromrgb(220, 220, 220)
			hex_input.textsize = 12
			hex_input.cleartextonfocus = false
			
			local uicorner_hex = instance.new("uicorner")
			uicorner_hex.cornerradius = udim.new(0, 4)
			uicorner_hex.parent = hex_input
			
			local hex_padding = instance.new("uipadding")
			hex_padding.parent = hex_input
			hex_padding.paddingleft = udim.new(0, 8)
			hex_padding.paddingright = udim.new(0, 8)
			
			apply_button.name = "apply_button"
			apply_button.parent = color_picker_frame
			apply_button.backgroundcolor3 = color3.fromrgb(0, 180, 255)
			apply_button.bordersizepixel = 0
			apply_button.position = udim2.new(0.05, 0, 1.02, 0)
			apply_button.size = udim2.new(0.9, 0, 0, 30)
			apply_button.font = enum.font.gothamsemibold
			apply_button.text = "apply"
			apply_button.textcolor3 = color3.fromrgb(255, 255, 255)
			apply_button.textsize = 13
			apply_button.autobuttoncolor = false
			
			local apply_corner = instance.new("uicorner")
			apply_corner.cornerradius = udim.new(0, 6)
			apply_corner.parent = apply_button
			
			local function update_color()
				local new_color = color3.fromhsv(h, s, v)
				new_color_display.backgroundcolor3 = new_color
				color_palette.backgroundcolor3 = color3.fromhsv(h, 1, 1)
				
				r_data.value.text = tostring(r)
				g_data.value.text = tostring(g)
				b_data.value.text = tostring(b)
				hex_input.text = string.format("#%02x%02x%02x", r, g, b)
				
				r_data.fill.size = udim2.new(r / 255, 0, 1, 0)
				r_data.button.position = udim2.new(r / 255, -6, 0, -5)
				
				g_data.fill.size = udim2.new(g / 255, 0, 1, 0)
				g_data.button.position = udim2.new(g / 255, -6, 0, -5)
				
				b_data.fill.size = udim2.new(b / 255, 0, 1, 0)
				b_data.button.position = udim2.new(b / 255, -6, 0, -5)
			end
			
			local function update_from_rgb()
				h, s, v = color3.fromrgb(r, g, b):tohsv()
				color_palette_cursor.position = udim2.new(s, -5, 1 - v, -5)
				hue_button.position = udim2.new(0.5, -8, h, -8)
				update_color()
			end
			
			local function update_from_hsv()
				local rgb_color = color3.fromhsv(h, s, v)
				r = math.floor(rgb_color.r * 255)
				g = math.floor(rgb_color.g * 255)
				b = math.floor(rgb_color.b * 255)
				update_color()
			end
			
			local dragging_palette = false
			local dragging_hue = false
			
			local function update_palette(input)
				local x = math.clamp((input.position.x - color_palette.absoluteposition.x) / color_palette.absolutesize.x, 0, 1)
				local y = math.clamp((input.position.y - color_palette.absoluteposition.y) / color_palette.absolutesize.y, 0, 1)
				s = x
				v = 1 - y
				color_palette_cursor.position = udim2.new(x, -5, y, -5)
				update_from_hsv()
			end
			
			local function update_hue_slider(input)
				local pos_y = math.clamp((input.position.y - hue_slider.absoluteposition.y) / hue_slider.absolutesize.y, 0, 1)
				h = pos_y
				hue_button.position = udim2.new(0.5, -8, pos_y, -8)
				update_from_hsv()
			end
			
			color_palette.inputbegan:connect(function(input)
				if input.userinputtype == enum.userinputtype.mousebutton1 or input.userinputtype == enum.userinputtype.touch then
					dragging_palette = true
					update_palette(input)
				end
			end)
			
			color_palette.inputended:connect(function(input)
				if input.userinputtype == enum.userinputtype.mousebutton1 or input.userinputtype == enum.userinputtype.touch then
					dragging_palette = false
				end
			end)
			
			hue_slider.inputbegan:connect(function(input)
				if input.userinputtype == enum.userinputtype.mousebutton1 or input.userinputtype == enum.userinputtype.touch then
					dragging_hue = true
					update_hue_slider(input)
				end
			end)
			
			hue_slider.inputended:connect(function(input)
				if input.userinputtype == enum.userinputtype.mousebutton1 or input.userinputtype == enum.userinputtype.touch then
					dragging_hue = false
				end
			end)
			
			game:getservice("userinputservice").inputchanged:connect(function(input)
				if dragging_palette and (input.userinputtype == enum.userinputtype.mousemovement or input.userinputtype == enum.userinputtype.touch) then
					update_palette(input)
				elseif dragging_hue and (input.userinputtype == enum.userinputtype.mousemovement or input.userinputtype == enum.userinputtype.touch) then
					update_hue_slider(input)
				end
			end)
			
			local function create_rgb_slider_logic(data, is_r, is_g, is_b)
				local dragging = false
				
				local function update_slider(input)
					local pos = udim2.new(
						math.clamp((input.position.x - data.slider.absoluteposition.x) / data.slider.absolutesize.x, 0, 1),
						0,
						0, 0
					)
					local value = math.floor(pos.x.scale * 255)
					
					data.fill.size = udim2.new(pos.x.scale, 0, 1, 0)
					data.button.position = udim2.new(pos.x.scale, -6, 0, -5)
					data.value.text = tostring(value)
					
					if is_r then r = value
					elseif is_g then g = value
					elseif is_b then b = value end
					
					update_from_rgb()
				end
				
				data.button.inputbegan:connect(function(input)
					if input.userinputtype == enum.userinputtype.mousebutton1 or input.userinputtype == enum.userinputtype.touch then
						dragging = true
						game:getservice("tweenservice"):create(data.button, tweeninfo.new(0.15, enum.easingstyle.quad), {size = udim2.new(0, 18, 0, 18)}):play()
					end
				end)
				
				data.button.inputended:connect(function(input)
					if input.userinputtype == enum.userinputtype.mousebutton1 or input.userinputtype == enum.userinputtype.touch then
						dragging = false
						game:getservice("tweenservice"):create(data.button, tweeninfo.new(0.15, enum.easingstyle.quad), {size = udim2.new(0, 14, 0, 14)}):play()
					end
				end)
				
				data.slider.inputbegan:connect(function(input)
					if input.userinputtype == enum.userinputtype.mousebutton1 or input.userinputtype == enum.userinputtype.touch then
						update_slider(input)
						dragging = true
						game:getservice("tweenservice"):create(data.button, tweeninfo.new(0.15, enum.easingstyle.quad), {size = udim2.new(0, 18, 0, 18)}):play()
					end
				end)
				
				data.slider.inputended:connect(function(input)
					if input.userinputtype == enum.userinputtype.mousebutton1 or input.userinputtype == enum.userinputtype.touch then
						dragging = false
						game:getservice("tweenservice"):create(data.button, tweeninfo.new(0.15, enum.easingstyle.quad), {size = udim2.new(0, 14, 0, 14)}):play()
					end
				end)
				
				game:getservice("userinputservice").inputchanged:connect(function(input)
					if dragging and (input.userinputtype == enum.userinputtype.mousemovement or input.userinputtype == enum.userinputtype.touch) then
						update_slider(input)
					end
				end)
			end
			
			create_rgb_slider_logic(r_data, true, false, false)
			create_rgb_slider_logic(g_data, false, true, false)
			create_rgb_slider_logic(b_data, false, false, true)
			
			hex_input.focuslost:connect(function(enter_pressed)
				if enter_pressed then
					local hex_text = hex_input.text:gsub("#", "")
					if #hex_text == 6 then
						local hr = tonumber("0x" .. hex_text:sub(1, 2)) or 0
						local hg = tonumber("0x" .. hex_text:sub(3, 4)) or 0
						local hb = tonumber("0x" .. hex_text:sub(5, 6)) or 0
						
						r = math.clamp(hr, 0, 255)
						g = math.clamp(hg, 0, 255)
						b = math.clamp(hb, 0, 255)
						
						update_from_rgb()
					end
				end
			end)
			
			apply_button.mousebutton1click:connect(function()
				callback(new_color_display.backgroundcolor3)
				color_preview.backgroundcolor3 = new_color_display.backgroundcolor3
				color_picker_frame:tweensize(udim2.new(0, 250, 0, 0), "out", "quad", 0.2, true, function()
					color_picker_frame:destroy()
					color_picker_frame = nil
				end)
			end)
			
			apply_button.touchtap:connect(function()
				callback(new_color_display.backgroundcolor3)
				color_preview.backgroundcolor3 = new_color_display.backgroundcolor3
				color_picker_frame:tweensize(udim2.new(0, 250, 0, 0), "out", "quad", 0.2, true, function()
					color_picker_frame:destroy()
					color_picker_frame = nil
				end)
			end)
			
			apply_button.mouseenter:connect(function()
				game:getservice("tweenservice"):create(apply_button, tweeninfo.new(0.15, enum.easingstyle.quad), {backgroundcolor3 = color3.fromrgb(0, 160, 235)}):play()
			end)
			
			apply_button.mouseleave:connect(function()
				game:getservice("tweenservice"):create(apply_button, tweeninfo.new(0.15, enum.easingstyle.quad), {backgroundcolor3 = color3.fromrgb(0, 180, 255)}):play()
			end)
			
			color_picker_frame:tweensize(udim2.new(0, 250, 0, 270), "out", "quad", 0.2, true)
			
			local close_connection
			close_connection = game:getservice("userinputservice").inputbegan:connect(function(input)
				if (input.userinputtype == enum.userinputtype.mousebutton1 or input.userinputtype == enum.userinputtype.touch) and color_picker_frame then
					local mouse_pos = game:getservice("userinputservice"):getmouselocation()
					local frame_pos = color_picker_frame.absoluteposition
					local frame_size = color_picker_frame.absolutesize
					
					if not (mouse_pos.x >= frame_pos.x and mouse_pos.x <= frame_pos.x + frame_size.x and
						   mouse_pos.y >= frame_pos.y and mouse_pos.y <= frame_pos.y + frame_size.y) then
						color_picker_frame:tweensize(udim2.new(0, 250, 0, 0), "out", "quad", 0.2, true, function()
							color_picker_frame:destroy()
							color_picker_frame = nil
							if close_connection then
								close_connection:disconnect()
							end
						end)
					end
				end
			end)
			
			local button_pos = color_button.absoluteposition
			local button_size = color_button.absolutesize
			local screen_size = game:getservice("workspace").currentcamera.viewportsize
			
			local right_space = screen_size.x - (button_pos.x + button_size.x)
			local left_space = button_pos.x
			
			if right_space > 260 then
				color_picker_frame.position = udim2.new(0, button_pos.x + button_size.x + 10, 0, button_pos.y)
			elseif left_space > 260 then
				color_picker_frame.position = udim2.new(0, button_pos.x - 260, 0, button_pos.y)
			else
				color_picker_frame.position = udim2.new(0, button_pos.x, 0, button_pos.y + button_size.y + 10)
			end
		end
		
		color_button.mousebutton1click:connect(show_color_picker)
		color_button.touchtap:connect(show_color_picker)
		
		colorpicker_container.mouseenter:connect(function()
			game:getservice("tweenservice"):create(colorpicker_container, tweeninfo.new(0.15, enum.easingstyle.quad), {backgroundcolor3 = color3.fromrgb(35, 35, 35)}):play()
		end)
		
		colorpicker_container.mouseleave:connect(function()
			game:getservice("tweenservice"):create(colorpicker_container, tweeninfo.new(0.15, enum.easingstyle.quad), {backgroundcolor3 = color3.fromrgb(30, 30, 30)}):play()
		end)
	end
	
	function lib:textbox(name, placeholder, callback)
		local textbox_container = instance.new("frame")
		local uicorner_textbox = instance.new("uicorner")
		local textbox_name_label = instance.new("textlabel")
		local textbox_input = instance.new("textbox")
		local uicorner_input = instance.new("uicorner")
		
		textbox_container.name = "textbox_container"
		textbox_container.parent = container_scroll
		textbox_container.backgroundcolor3 = color3.fromrgb(30, 30, 30)
		textbox_container.bordersizepixel = 0
		textbox_container.size = udim2.new(0.9, 0, 0, 56)
		
		uicorner_textbox.cornerradius = udim.new(0, 6)
		uicorner_textbox.parent = textbox_container
		
		textbox_name_label.name = "textbox_name"
		textbox_name_label.parent = textbox_container
		textbox_name_label.backgroundcolor3 = color3.fromrgb(255, 255, 255)
		textbox_name_label.backgroundtransparency = 1.000
		textbox_name_label.position = udim2.new(0.05, 0, 0, 0)
		textbox_name_label.size = udim2.new(0.9, 0, 0, 20)
		textbox_name_label.font = enum.font.gotham
		textbox_name_label.text = name
		textbox_name_label.textcolor3 = color3.fromrgb(220, 220, 220)
		textbox_name_label.textsize = 13
		textbox_name_label.textxalignment = enum.textxalignment.left
		
		textbox_input.name = "textbox_input"
		textbox_input.parent = textbox_container
		textbox_input.backgroundcolor3 = color3.fromrgb(40, 40, 40)
		textbox_input.bordersizepixel = 0
		textbox_input.position = udim2.new(0.05, 0, 0.45, 0)
		textbox_input.size = udim2.new(0.9, 0, 0, 28)
		textbox_input.font = enum.font.gotham
		textbox_input.placeholdertext = placeholder or "enter text..."
		textbox_input.text = ""
		textbox_input.textcolor3 = color3.fromrgb(220, 220, 220)
		textbox_input.textsize = 12
		textbox_input.cleartextonfocus = false
		textbox_input.texttruncate = enum.texttruncate.atend
		
		uicorner_input.cornerradius = udim.new(0, 4)
		uicorner_input.parent = textbox_input
		
		local text_padding = instance.new("uipadding")
		text_padding.parent = textbox_input
		text_padding.paddingleft = udim.new(0, 8)
		text_padding.paddingright = udim.new(0, 8)
		
		textbox_input.focused:connect(function()
			game:getservice("tweenservice"):create(textbox_input, tweeninfo.new(0.15, enum.easingstyle.quad), {backgroundcolor3 = color3.fromrgb(50, 50, 50)}):play()
		end)
		
		textbox_input.focuslost:connect(function(enter_pressed)
			game:getservice("tweenservice"):create(textbox_input, tweeninfo.new(0.15, enum.easingstyle.quad), {backgroundcolor3 = color3.fromrgb(40, 40, 40)}):play()
			if enter_pressed then
				callback(textbox_input.text)
			end
		end)
		
		textbox_container.mouseenter:connect(function()
			game:getservice("tweenservice"):create(textbox_container, tweeninfo.new(0.15, enum.easingstyle.quad), {backgroundcolor3 = color3.fromrgb(35, 35, 35)}):play()
		end)
		
		textbox_container.mouseleave:connect(function()
			game:getservice("tweenservice"):create(textbox_container, tweeninfo.new(0.15, enum.easingstyle.quad), {backgroundcolor3 = color3.fromrgb(30, 30, 30)}):play()
		end)
	end
	
	function lib:label(text)
		local label_container = instance.new("frame")
		local uicorner_label = instance.new("uicorner")
		local label_text = instance.new("textlabel")
		
		label_container.name = "label_container"
		label_container.parent = container_scroll
		label_container.backgroundcolor3 = color3.fromrgb(30, 30, 30)
		label_container.backgroundtransparency = 0
		label_container.size = udim2.new(0.9, 0, 0, 32)
		
		uicorner_label.cornerradius = udim.new(0, 6)
		uicorner_label.parent = label_container
		
		label_text.name = "label_text"
		label_text.parent = label_container
		label_text.backgroundcolor3 = color3.fromrgb(255, 255, 255)
		label_text.backgroundtransparency = 1.000
		label_text.size = udim2.new(1, -10, 1, 0)
		label_text.position = udim2.new(0, 5, 0, 0)
		label_text.font = enum.font.gotham
		label_text.text = text
		label_text.textcolor3 = color3.fromrgb(180, 180, 180)
		label_text.textsize = 12
		label_text.textwrapped = true
	end
	
	function lib:separator()
		local separator_container = instance.new("frame")
		local separator_line = instance.new("frame")
		
		separator_container.name = "separator_container"
		separator_container.parent = container_scroll
		separator_container.backgroundcolor3 = color3.fromrgb(255, 255, 255)
		separator_container.backgroundtransparency = 1
		separator_container.size = udim2.new(0.9, 0, 0, 10)
		
		separator_line.name = "separator_line"
		separator_line.parent = separator_container
		separator_line.backgroundcolor3 = color3.fromrgb(60, 60, 60)
		separator_line.bordersizepixel = 0
		separator_line.position = udim2.new(0.1, 0, 0.5, 0)
		separator_line.size = udim2.new(0.8, 0, 0, 1)
	end
	
	return lib
	
end

return library
