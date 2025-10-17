local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local safe = {}

safe.isfile = function(name)
	local ok, res = pcall(function() return isfile and isfile(name) or false end)
	return ok and res or false
end

safe.readfile = function(name)
	local ok, res = pcall(function() return readfile and readfile(name) or nil end)
	return ok and res
end

safe.writefile = function(name, content)
	pcall(function()
		if writefile then writefile(name, content) end
	end)
end

safe.append_log = function(name, content)
	pcall(function()
		local existing = ""
		if safe.isfile(name) then existing = safe.readfile(name) or "" end
		safe.writefile(name, existing .. content .. "\n")
	end)
end

local LOG_FILE = "rmonnesy_esp_errors.txt"
local function log_error(err)
	safe.append_log(LOG_FILE, string.format("[%s] %s", os.date(), tostring(err)))
end

local function clamp(x, a, b) return math.max(a, math.min(b, x)) end
local function lerp(a,b,t) return a + (b-a)*t end
local function ColorLerp(c1,c2,t)
	return Color3.new(lerp(c1.R,c2.R,t), lerp(c1.G,c2.G,t), lerp(c1.B,c2.B,t))
end

local rmonnesy_esp = {}
rmonnesy_esp.settings = {
	enabled = true,
	max_distance = 5000,
	text_size = 18,
	font = 2,

	box_esp = true,
	box_type = "3d", -- "2d", "3d", "corner"
	skeleton_esp = true,
	offscreen_arrow_esp = true,
	tracer_esp = true,
	lookat_esp = true,
	head_esp = false,
	health_esp = true,
	name_esp = true,
	distance_esp = true,
	outline_esp = true,

	color_mode = "team", -- "team", "static", "rainbow", "per-player"
	static_color = Color3.fromRGB(255,255,255),
	friend_color = Color3.fromRGB(0,255,0),
	enemy_color = Color3.fromRGB(255,0,0),
	neutral_color = Color3.fromRGB(160,160,160),

	min_scale = 0.35,
	max_scale = 1.0,
	fade_to_color = Color3.fromRGB(110,110,110),

	tracer_color = Color3.fromRGB(255,255,255),
	health_color = Color3.fromRGB(0,255,0),

	arrow_size = 20,
}

rmonnesy_esp.friends = {}

local esp_objects = {}

local function rainbowColor(t)
	local r = math.floor((math.sin(t*1.3)+1)*127.5)
	local g = math.floor((math.sin(t*1.7+2)+1)*127.5)
	local b = math.floor((math.sin(t*1.9+4)+1)*127.5)
	return Color3.fromRGB(r,g,b)
end

local function create_esp(player)
	local objs = {}
	objs.box = Drawing.new("Square")
	objs.box.Thickness = 1
	objs.box.Filled = false
	objs.box.Visible = false

	objs.corner_lines, objs.box_3d, objs.skeleton, objs.arrow = {}, {}, {}, {}

	for i=1,4 do
		local l = Drawing.new("Line"); l.Thickness=1; l.Visible=false
		table.insert(objs.corner_lines,l)
	end
	for i=1,12 do
		local l = Drawing.new("Line"); l.Thickness=1; l.Visible=false
		table.insert(objs.box_3d,l)
	end
	for i=1,10 do
		local l = Drawing.new("Line"); l.Thickness=1; l.Visible=false
		table.insert(objs.skeleton,l)
	end
	for i=1,3 do
		local l = Drawing.new("Line"); l.Thickness=1; l.Visible=false
		table.insert(objs.arrow,l)
	end

	objs.tracer = Drawing.new("Line"); objs.tracer.Thickness=1; objs.tracer.Visible=false
	objs.lookat = Drawing.new("Line"); objs.lookat.Thickness=1; objs.lookat.Visible=false
	objs.head_circle = Drawing.new("Circle"); objs.head_circle.Thickness=1; objs.head_circle.Filled=false; objs.head_circle.Visible=false
	objs.name_text = Drawing.new("Text"); objs.name_text.Center=true; objs.name_text.Visible=false
	objs.distance_text = Drawing.new("Text"); objs.distance_text.Center=true; objs.distance_text.Visible=false
	objs.health_bar = Drawing.new("Square"); objs.health_bar.Filled=true; objs.health_bar.Visible=false

	esp_objects[player] = objs
end

local function remove_esp(player)
	local esp = esp_objects[player]
	if not esp then return end
	for _, v in pairs(esp) do
		if type(v)=="table" then for _,o in pairs(v) do pcall(function() o:Remove() end) end
		else pcall(function() v:Remove() end) end
	end
	esp_objects[player]=nil
end

for _,pl in pairs(Players:GetPlayers()) do if pl~=LocalPlayer then create_esp(pl) end end
Players.PlayerAdded:Connect(function(pl) if pl~=LocalPlayer then create_esp(pl) end end)
Players.PlayerRemoving:Connect(remove_esp)

local function get_player_color(player, dist, now)
	local s = rmonnesy_esp.settings
	local base
	if s.color_mode=="static" then base=s.static_color
	elseif s.color_mode=="rainbow" then base=rainbowColor(now + (player.UserId or 0)*0.0001)
	elseif s.color_mode=="per-player" then
		local h=0; for i=1,#player.Name do h=h+player.Name:byte(i) end
		base=rainbowColor(h*0.01+now)
	else
		if rmonnesy_esp.friends[player.Name] then
			base=s.friend_color
		elseif player.Team and LocalPlayer.Team and player.Team==LocalPlayer.Team then
			base=s.friend_color
		elseif player.Team and LocalPlayer.Team and player.Team~=LocalPlayer.Team then
			base=s.enemy_color
		else base=s.neutral_color end
	end

	local t = clamp(1 - dist/s.max_distance, 0, 1)
	local faded = ColorLerp(s.fade_to_color, base, t)
	return faded, t
end

local function get_part_corners(part)
	local cf=part.CFrame; local sx,sy,sz=part.Size.X/2,part.Size.Y/2,part.Size.Z/2
	return {
		cf*Vector3.new(sx,sy,sz), cf*Vector3.new(-sx,sy,sz), cf*Vector3.new(sx,-sy,sz),
		cf*Vector3.new(sx,sy,-sz), cf*Vector3.new(-sx,-sy,sz), cf*Vector3.new(sx,-sy,-sz),
		cf*Vector3.new(-sx,sy,-sz), cf*Vector3.new(-sx,-sy,-sz),
	}
end

RunService.RenderStepped:Connect(function()
	local s = rmonnesy_esp.settings
	if not s.enabled then
		for _,esp in pairs(esp_objects) do
			for _,obj in pairs(esp) do
				if type(obj)=="table" then for _,o in pairs(obj) do o.Visible=false end
				else obj.Visible=false end
			end
		end
		return
	end

	local lp_char = LocalPlayer.Character
	if not lp_char then return end
	local lp_root = lp_char:FindFirstChild("HumanoidRootPart")
	if not lp_root then return end
	local lp_pos = lp_root.Position
	local now = tick()

	for player,esp in pairs(esp_objects) do
		local char = player.Character
		if not char then for _,v in pairs(esp) do if type(v)=="table" then for _,o in pairs(v) do o.Visible=false end else v.Visible=false end end continue end
		local hum = char:FindFirstChildOfClass("Humanoid")
		local root = char:FindFirstChild("HumanoidRootPart")
		local head = char:FindFirstChild("Head")
		if not hum or not root or hum.Health<=0 then for _,v in pairs(esp) do if type(v)=="table" then for _,o in pairs(v) do o.Visible=false end else v.Visible=false end end continue end

		local dist = (lp_pos - root.Position).Magnitude
		if dist > s.max_distance then for _,v in pairs(esp) do if type(v)=="table" then for _,o in pairs(v) do o.Visible=false end else v.Visible=false end end continue end

		local color, scaleT = get_player_color(player, dist, now)
		local scale = lerp(s.min_scale, s.max_scale, scaleT)
		local transparency = clamp(scaleT * 0.8 + 0.2, 0.25, 1) 

            local minX, minY = math.huge, math.huge
            local maxX, maxY = -math.huge, -math.huge
            local anyOnScreen = false
            local parts = {}
            for _, part in pairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    table.insert(parts, part)
                    local corners = get_part_corners(part)
                    for _, c in pairs(corners) do
                        local p, onScreen = Camera:WorldToViewportPoint(c)
                        if onScreen then
                            anyOnScreen = true
                            minX = math.min(minX, p.X)
                            minY = math.min(minY, p.Y)
                            maxX = math.max(maxX, p.X)
                            maxY = math.max(maxY, p.Y)
                        end
                    end
                end
            end

            if not anyOnScreen then
                -- offscreen arrow handling
                if rmonnesy_esp.settings.offscreen_arrow_esp then
                    if head then
                        local camP = Camera.CFrame.Position
                        local dir = (root.Position - camP).Unit
                        local angle = math.atan2(dir.Z, dir.X)
                        local screenCenter = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
                        local toScreen = (Vector2.new(root.Position.X, root.Position.Z) - Vector2.new(camP.X, camP.Z))
                        local angle2 = math.atan2(toScreen.Y, toScreen.X)
                        -- clamp arrow pos to edge
                        local cx, cy = screenCenter.X, screenCenter.Y
                        local m = math.tan(angle2)
                        local edgeX = cx + math.cos(angle2) * (math.min(cx,cy) - 30)
                        local edgeY = cy + math.sin(angle2) * (math.min(cx,cy) - 30)

                        -- triangle points
                        local size = rmonnesy_esp.settings.arrow_size * scale
                        local p1 = Vector2.new(edgeX, edgeY)
                        local p2 = Vector2.new(edgeX + math.cos(angle2 + math.pi*0.7) * size, edgeY + math.sin(angle2 + math.pi*0.7) * size)
                        local p3 = Vector2.new(edgeX + math.cos(angle2 - math.pi*0.7) * size, edgeY + math.sin(angle2 - math.pi*0.7) * size)

                        -- draw
                        for i,line in pairs(esp.arrow) do line.Visible = true end
                        esp.arrow[1].From = p1; esp.arrow[1].To = p2
                        esp.arrow[2].From = p2; esp.arrow[2].To = p3
                        esp.arrow[3].From = p3; esp.arrow[3].To = p1
                        for _,line in pairs(esp.arrow) do
                            line.Color = color
                            line.Transparency = transparency
                        end
                    end
                end

                for _, v in pairs(esp) do
                    if type(v) == "table" and v ~= esp.arrow then for _,o in pairs(v) do pcall(function() o.Visible = false end) end
                    elseif v ~= esp.arrow then pcall(function() v.Visible = false end) end
                end

                continue
            else
                for _,line in pairs(esp.arrow) do line.Visible = false end
            end

            local x, y = minX, minY
            local w, h = maxX - minX, maxY - minY
            w = math.max(w, 6) h = math.max(h, 6)

            if rmonnesy_esp.settings.box_esp then
                if rmonnesy_esp.settings.box_type == "2d" then
                    esp.box.Position = Vector2.new(x, y)
                    esp.box.Size = Vector2.new(w, h)
                    esp.box.Color = color
                    esp.box.Transparency = transparency
                    esp.box.Visible = true
                    -- hide other box forms
                    for i,line in pairs(esp.box_3d) do line.Visible = false end
                    for i,line in pairs(esp.corner_lines) do line.Visible = false end
                elseif rmonnesy_esp.settings.box_type == "corner" then
                    esp.box.Visible = false
                    -- corner lengths
                    local cl = math.clamp(math.min(w,h)*0.25, 6, 40) * scale
                    -- top-left
                    esp.corner_lines[1].From = Vector2.new(x, y)
                    esp.corner_lines[1].To = Vector2.new(x + cl, y)
                    esp.corner_lines[2].From = Vector2.new(x, y)
                    esp.corner_lines[2].To = Vector2.new(x, y + cl)
                    -- top-right
                    esp.corner_lines[3].From = Vector2.new(x + w, y)
                    esp.corner_lines[3].To = Vector2.new(x + w - cl, y)
                    esp.corner_lines[4].From = Vector2.new(x + w, y)
                    esp.corner_lines[4].To = Vector2.new(x + w, y + cl)
                    for i,line in pairs(esp.corner_lines) do
                        line.Color = color
                        line.Transparency = transparency
                        line.Visible = true
                    end
                    for i,line in pairs(esp.box_3d) do line.Visible = false end
                else -- 3d
                    esp.box.Visible = false
                    local corners_world = {}
                    for _,part in pairs(parts) do
                        local cs = get_part_corners(part)
                        for _,c in pairs(cs) do table.insert(corners_world, c) end
                    end
                    local minv = Vector3.new(math.huge, math.huge, math.huge)
                    local maxv = Vector3.new(-math.huge, -math.huge, -math.huge)
                    for _,v in pairs(corners_world) do
                        minv = Vector3.new(math.min(minv.X, v.X), math.min(minv.Y, v.Y), math.min(minv.Z, v.Z))
                        maxv = Vector3.new(math.max(maxv.X, v.X), math.max(maxv.Y, v.Y), math.max(maxv.Z, v.Z))
                    end
                    local b_corners = {
                        Vector3.new(minv.X, minv.Y, minv.Z), Vector3.new(maxv.X, minv.Y, minv.Z), Vector3.new(maxv.X, maxv.Y, minv.Z), Vector3.new(minv.X, maxv.Y, minv.Z),
                        Vector3.new(minv.X, minv.Y, maxv.Z), Vector3.new(maxv.X, minv.Y, maxv.Z), Vector3.new(maxv.X, maxv.Y, maxv.Z), Vector3.new(minv.X, maxv.Y, maxv.Z),
                    }
                    local edges = {{1,2},{2,3},{3,4},{4,1},{5,6},{6,7},{7,8},{8,5},{1,5},{2,6},{3,7},{4,8}}
                    for i,edge in pairs(edges) do
                        local a, b = b_corners[edge[1]], b_corners[edge[2]]
                        local pa, va = Camera:WorldToViewportPoint(a)
                        local pb, vb = Camera:WorldToViewportPoint(b)
                        esp.box_3d[i].From = Vector2.new(pa.X, pa.Y)
                        esp.box_3d[i].To = Vector2.new(pb.X, pb.Y)
                        esp.box_3d[i].Color = color
                        esp.box_3d[i].Transparency = transparency
                        esp.box_3d[i].Visible = true
                    end
                    for i,line in pairs(esp.corner_lines) do line.Visible = false end
                end
            else
                esp.box.Visible = false
                for i,line in pairs(esp.box_3d) do line.Visible = false end
                for i,line in pairs(esp.corner_lines) do line.Visible = false end
            end

            -- skeleton
            if rmonnesy_esp.settings.skeleton_esp then
                local hp = head and head.Position or nil
                local rootp = root.Position
                local neck = (head and (char:FindFirstChild("Neck") and char:FindFirstChild("Neck").C0))
                local torso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
                local larm = char:FindFirstChild("LeftUpperArm") or char:FindFirstChild("Left Arm")
                local rarm = char:FindFirstChild("RightUpperArm") or char:FindFirstChild("Right Arm")
                local lleg = char:FindFirstChild("LeftUpperLeg") or char:FindFirstChild("Left Leg")
                local rleg = char:FindFirstChild("RightUpperLeg") or char:FindFirstChild("Right Leg")

                local points = {}
                if head then table.insert(points, head.Position) end
                if torso then table.insert(points, torso.Position) end
                if larm then table.insert(points, larm.Position) end
                if rarm then table.insert(points, rarm.Position) end
                if lleg then table.insert(points, lleg.Position) end
                if rleg then table.insert(points, rleg.Position) end

                -- head->torso, torso->limbs
                local screenPoints = {}
                for i,p in pairs(points) do
                    local s, on = Camera:WorldToViewportPoint(p)
                    screenPoints[i] = {vec = Vector2.new(s.X, s.Y), on = on}
                end

                -- map: 1=head,2=torso,3=larm,4=rarm,5=lleg,6=rleg
                -- draw lines
                local sk = esp.skeleton
                -- head->torso
                if screenPoints[1] and screenPoints[2] then
                    sk[1].From = screenPoints[1].vec; sk[1].To = screenPoints[2].vec; sk[1].Visible = true
                else sk[1].Visible = false end
                -- torso->larm
                if screenPoints[2] and screenPoints[3] then sk[2].From = screenPoints[2].vec; sk[2].To = screenPoints[3].vec; sk[2].Visible = true else sk[2].Visible = false end
                -- torso->rarm
                if screenPoints[2] and screenPoints[4] then sk[3].From = screenPoints[2].vec; sk[3].To = screenPoints[4].vec; sk[3].Visible = true else sk[3].Visible = false end
                -- torso->lleg
                if screenPoints[2] and screenPoints[5] then sk[4].From = screenPoints[2].vec; sk[4].To = screenPoints[5].vec; sk[4].Visible = true else sk[4].Visible = false end
                -- torso->rleg
                if screenPoints[2] and screenPoints[6] then sk[5].From = screenPoints[2].vec; sk[5].To = screenPoints[6].vec; sk[5].Visible = true else sk[5].Visible = false end

                for i=1,#sk do
                    sk[i].Color = color
                    sk[i].Transparency = transparency
                end
            else
                for i=1,#esp.skeleton do esp.skeleton[i].Visible = false end
            end

            -- name, distance, health, tracer, head circle, lookat
            if rmonnesy_esp.settings.name_esp then
                esp.name_text.Text = player.Name
                esp.name_text.Position = Vector2.new(x + w/2, y - 14 * scale)
                esp.name_text.Size = rmonnesy_esp.settings.text_size * scale
                esp.name_text.Color = color
                esp.name_text.Outline = rmonnesy_esp.settings.outline_esp
                esp.name_text.Visible = true
            else esp.name_text.Visible = false end

            if rmonnesy_esp.settings.distance_esp then
                esp.distance_text.Text = string.format("%.0f studs", dist)
                esp.distance_text.Position = Vector2.new(x + w/2, y + h + 6 * scale)
                esp.distance_text.Size = (rmonnesy_esp.settings.text_size - 2) * scale
                esp.distance_text.Color = color
                esp.distance_text.Visible = true
            else esp.distance_text.Visible = false end

            if rmonnesy_esp.settings.health_esp and humanoid then
                local hp_ratio = clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
                local bh = h * hp_ratio
                local bw = math.max(2, 4 * scale)
                esp.health_bar.Position = Vector2.new(x - bw - 4, y + h - bh)
                esp.health_bar.Size = Vector2.new(bw, bh)
                esp.health_bar.Color = Color3.fromHSV(0.33 * hp_ratio, 1, 1)
                esp.health_bar.Transparency = transparency
                esp.health_bar.Visible = true
            else esp.health_bar.Visible = false end

            if rmonnesy_esp.settings.tracer_esp then
                local root_screen, vis = Camera:WorldToViewportPoint(root.Position)
                if vis then
                    esp.tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                    esp.tracer.To = Vector2.new(root_screen.X, root_screen.Y)
                    esp.tracer.Color = rmonnesy_esp.settings.tracer_color
                    esp.tracer.Transparency = transparency
                    esp.tracer.Visible = true
                else esp.tracer.Visible = false end
            else esp.tracer.Visible = false end

            if rmonnesy_esp.settings.head_esp and head then
                local head_screen, vis = Camera:WorldToViewportPoint(head.Position)
                if vis then
                    esp.head_circle.Position = Vector2.new(head_screen.X, head_screen.Y)
                    esp.head_circle.Radius = 6 * scale
                    esp.head_circle.Color = color
                    esp.head_circle.Transparency = transparency
                    esp.head_circle.Visible = true
                else esp.head_circle.Visible = false end
            else esp.head_circle.Visible = false end

            if rmonnesy_esp.settings.lookat_esp and head then
                local lookvec = (head.CFrame.LookVector)
                local from = head.Position
                local to = from + lookvec * math.clamp(dist, 4, 50)
                local sf, visf = Camera:WorldToViewportPoint(from)
                local st, vist = Camera:WorldToViewportPoint(to)
                if visf and vist then
                    esp.lookat.From = Vector2.new(sf.X, sf.Y)
                    esp.lookat.To = Vector2.new(st.X, st.Y)
                    esp.lookat.Color = color
                    esp.lookat.Transparency = transparency
                    esp.lookat.Visible = true
                else esp.lookat.Visible = false end
            else esp.lookat.Visible = false end

            continue
        end
    end)
    if not ok then
        log_error(err)
    end
end)

function rmonnesy_esp.toggle(name,val)
	if rmonnesy_esp.settings[name]~=nil then rmonnesy_esp.settings[name]=val end
end
function rmonnesy_esp.set_color_mode(mode) rmonnesy_esp.settings.color_mode=mode end
function rmonnesy_esp.add_friend(name) rmonnesy_esp.friends[name]=true end
function rmonnesy_esp.remove_friend(name) rmonnesy_esp.friends[name]=nil end
function rmonnesy_esp.destroy()
	for p in pairs(esp_objects) do remove_esp(p) end
	esp_objects = {}
end

if not Drawing then error("Drawing API not found in this environment") end
return rmonnesy_esp
