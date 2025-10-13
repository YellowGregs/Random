local players = game:GetService("Players")
local run_service = game:GetService("RunService")
local local_player = players.LocalPlayer
local camera = workspace.CurrentCamera

local rmonnesy_esp = {}

rmonnesy_esp.settings = {
    enabled = true,
    box_esp = true,
    head_esp = true,
    health_esp = true,
    name_esp = true,
    distance_esp = true,
    -- cham_esp = false,
    skeleton_esp = true,
    tracer_esp = true,
    offscreen_arrow_esp = true,
    outline_esp = true,
    lookat_esp = true,
    circle_esp = true,
    box_type = "corner",           -- 2d, 3d, or corner
    max_distance = 5000,
    text_size = 18,
    font = 2,
    color = Color3.fromRGB(255,255,255),
    outline_color = Color3.fromRGB(0,0,0),
    tracer_color = Color3.fromRGB(255,255,255),
    health_color = Color3.fromRGB(0,255,0),
    distance_color = Color3.fromRGB(255,255,255),
    circle_color = Color3.fromRGB(255,255,255),
    head_color = Color3.fromRGB(255,255,255),
    skeleton_color = Color3.fromRGB(255,255,255),
    arrow_color = Color3.fromRGB(255,255,0),
    lookat_color = Color3.fromRGB(255,0,0)
}

local esp_objects = {}

local function draw_line()
    local line = Drawing.new("Line")
    line.Thickness = 1
    line.Visible = false
    line.Color = rmonnesy_esp.settings.color
    return line
end

local function create_esp(player)
    local esp = {
        box = Drawing.new("Square"),
        name_text = Drawing.new("Text"),
        health_bar = Drawing.new("Square"),
        tracer = draw_line(),
        head_circle = Drawing.new("Circle"),
        distance_text = Drawing.new("Text"),
        lookat_line = draw_line(),
        body_circle = Drawing.new("Circle"),
        offscreen_arrow = draw_line(),
        skeleton = {}
    }

    esp.box.Thickness = 1
    esp.box.Color = rmonnesy_esp.settings.color
    esp.box.Filled = false
    esp.box.Visible = false

    esp.name_text.Size = rmonnesy_esp.settings.text_size
    esp.name_text.Color = rmonnesy_esp.settings.color
    esp.name_text.Outline = rmonnesy_esp.settings.outline_esp
    esp.name_text.OutlineColor = rmonnesy_esp.settings.outline_color
    esp.name_text.Font = rmonnesy_esp.settings.font
    esp.name_text.Center = true
    esp.name_text.Visible = false

    esp.health_bar.Thickness = 1
    esp.health_bar.Filled = true
    esp.health_bar.Visible = false

    esp.tracer.Color = rmonnesy_esp.settings.tracer_color
    esp.tracer.Visible = false

    esp.head_circle.Color = rmonnesy_esp.settings.head_color
    esp.head_circle.Radius = 8
    esp.head_circle.Visible = false

    esp.distance_text.Size = rmonnesy_esp.settings.text_size - 2
    esp.distance_text.Color = rmonnesy_esp.settings.distance_color
    esp.distance_text.Outline = rmonnesy_esp.settings.outline_esp
    esp.distance_text.OutlineColor = rmonnesy_esp.settings.outline_color
    esp.distance_text.Center = true
    esp.distance_text.Visible = false

    esp.lookat_line.Color = rmonnesy_esp.settings.lookat_color
    esp.lookat_line.Visible = false

    esp.body_circle.Color = rmonnesy_esp.settings.circle_color
    esp.body_circle.Visible = false

    esp.offscreen_arrow.Color = rmonnesy_esp.settings.arrow_color
    esp.offscreen_arrow.Visible = false

    for i = 1, 15 do
        esp.skeleton[i] = draw_line()
        esp.skeleton[i].Color = rmonnesy_esp.settings.skeleton_color
    end

    esp_objects[player] = esp
end

local function remove_esp(player)
    local esp = esp_objects[player]
    if not esp then return end
    for _, obj in pairs(esp) do
        if type(obj) == "table" then
            for _, line in pairs(obj) do line:Remove() end
        else
            obj:Remove()
        end
    end
    esp_objects[player] = nil
end

for _, p in pairs(players:GetPlayers()) do
    if p ~= local_player then create_esp(p) end
end

players.PlayerAdded:Connect(function(p)
    if p ~= local_player then create_esp(p) end
end)

players.PlayerRemoving:Connect(remove_esp)

run_service.RenderStepped:Connect(function()
    if not rmonnesy_esp.settings.enabled then
        for _, esp in pairs(esp_objects) do
            for _, obj in pairs(esp) do
                if type(obj) == "table" then
                    for _, sub in pairs(obj) do sub.Visible = false end
                else
                    obj.Visible = false
                end
            end
        end
        return
    end

    local lp_char = local_player.Character
    if not lp_char or not lp_char:FindFirstChild("HumanoidRootPart") then return end
    local lp_pos = lp_char.HumanoidRootPart.Position
    local view_x, view_y = camera.ViewportSize.X, camera.ViewportSize.Y

    for player, esp in pairs(esp_objects) do
        local char = player.Character
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local head = char and char:FindFirstChild("Head")
        if not humanoid or not root or humanoid.Health <= 0 then
            for _, obj in pairs(esp) do
                if type(obj) == "table" then for _, s in pairs(obj) do s.Visible = false end
                else obj.Visible = false end
            end
            continue
        end

        local dist = (lp_pos - root.Position).Magnitude
        if dist > rmonnesy_esp.settings.max_distance then continue end

        local root_screen, on_screen = camera:WorldToViewportPoint(root.Position)
        if not on_screen then
            if rmonnesy_esp.settings.offscreen_arrow_esp then
                local center = Vector2.new(view_x/2, view_y/2)
                local dir = (Vector2.new(root_screen.X, root_screen.Y) - center).Unit
                local arrow_pos = center + dir * 300
                esp.offscreen_arrow.From = center
                esp.offscreen_arrow.To = arrow_pos
                esp.offscreen_arrow.Visible = true
            else
                esp.offscreen_arrow.Visible = false
            end
            continue
        else
            esp.offscreen_arrow.Visible = false
        end

        local x, y = root_screen.X, root_screen.Y
        local w, h = 60, 90
        local box_type = rmonnesy_esp.settings.box_type

        if rmonnesy_esp.settings.box_esp then
            if box_type == "corner" then
                local size = 8
                esp.box.Visible = false
                esp.corner_lines = esp.corner_lines or {}
                for i = 1, 4 do
                    esp.corner_lines[i] = esp.corner_lines[i] or draw_line()
                    esp.corner_lines[i].Color = rmonnesy_esp.settings.color
                    esp.corner_lines[i].Visible = true
                end
                local tl, tr, bl, br = esp.corner_lines[1], esp.corner_lines[2], esp.corner_lines[3], esp.corner_lines[4]
                tl.From = Vector2.new(x - w/2, y - h/2)
                tl.To = Vector2.new(x - w/2 + size, y - h/2)
                tr.From = Vector2.new(x + w/2 - size, y - h/2)
                tr.To = Vector2.new(x + w/2, y - h/2)
                bl.From = Vector2.new(x - w/2, y + h/2)
                bl.To = Vector2.new(x - w/2 + size, y + h/2)
                br.From = Vector2.new(x + w/2 - size, y + h/2)
                br.To = Vector2.new(x + w/2, y + h/2)
            else
                esp.box.Position = Vector2.new(x - w/2, y - h/2)
                esp.box.Size = Vector2.new(w, h)
                esp.box.Visible = true
            end
        else
            esp.box.Visible = false
        end

        if rmonnesy_esp.settings.tracer_esp then
            esp.tracer.From = Vector2.new(view_x/2, view_y)
            esp.tracer.To = Vector2.new(x, y)
            esp.tracer.Visible = true
        else
            esp.tracer.Visible = false
        end

        if rmonnesy_esp.settings.health_esp then
            local hp = humanoid.Health / humanoid.MaxHealth
            esp.health_bar.Position = Vector2.new(x - w/2 - 5, y + h/2 - (h * hp))
            esp.health_bar.Size = Vector2.new(3, h * hp)
            esp.health_bar.Color = Color3.fromRGB(255 * (1 - hp), 255 * hp, 0)
            esp.health_bar.Visible = true
        else
            esp.health_bar.Visible = false
        end

        if rmonnesy_esp.settings.head_esp and head then
            local hs, vis = camera:WorldToViewportPoint(head.Position)
            if vis then
                esp.head_circle.Position = Vector2.new(hs.X, hs.Y)
                esp.head_circle.Visible = true
            else
                esp.head_circle.Visible = false
            end
        end

        if rmonnesy_esp.settings.circle_esp then
            esp.body_circle.Position = Vector2.new(x, y + h/2)
            esp.body_circle.Radius = w / 2
            esp.body_circle.Visible = true
        else
            esp.body_circle.Visible = false
        end

        if rmonnesy_esp.settings.lookat_esp then
            local dir = root.CFrame.LookVector * 4
            local look_pos, vis = camera:WorldToViewportPoint(root.Position + dir)
            if vis then
                esp.lookat_line.From = Vector2.new(x, y)
                esp.lookat_line.To = Vector2.new(look_pos.X, look_pos.Y)
                esp.lookat_line.Visible = true
            else
                esp.lookat_line.Visible = false
            end
        else
            esp.lookat_line.Visible = false
        end

        if rmonnesy_esp.settings.name_esp then
            esp.name_text.Text = player.Name
            esp.name_text.Position = Vector2.new(x, y - h/2 - 15)
            esp.name_text.Visible = true
        else
            esp.name_text.Visible = false
        end

        if rmonnesy_esp.settings.distance_esp then
            esp.distance_text.Text = string.format("%.0f studs", dist)
            esp.distance_text.Position = Vector2.new(x, y + h/2 + 5)
            esp.distance_text.Visible = true
        else
            esp.distance_text.Visible = false
        end

        if rmonnesy_esp.settings.skeleton_esp and char then
            local bones = {
                {"Head","UpperTorso"},
                {"UpperTorso","LowerTorso"},
                {"LowerTorso","LeftUpperLeg"},
                {"LowerTorso","RightUpperLeg"},
                {"LeftUpperLeg","LeftLowerLeg"},
                {"RightUpperLeg","RightLowerLeg"},
                {"LeftLowerLeg","LeftFoot"},
                {"RightLowerLeg","RightFoot"},
                {"UpperTorso","LeftUpperArm"},
                {"UpperTorso","RightUpperArm"},
                {"LeftUpperArm","LeftLowerArm"},
                {"RightUpperArm","RightLowerArm"},
                {"LeftLowerArm","LeftHand"},
                {"RightLowerArm","RightHand"}
            }
            for i, bone in ipairs(bones) do
                local part1, part2 = char:FindFirstChild(bone[1]), char:FindFirstChild(bone[2])
                if part1 and part2 then
                    local p1, v1 = camera:WorldToViewportPoint(part1.Position)
                    local p2, v2 = camera:WorldToViewportPoint(part2.Position)
                    local line = esp.skeleton[i]
                    if v1 and v2 then
                        line.From = Vector2.new(p1.X, p1.Y)
                        line.To = Vector2.new(p2.X, p2.Y)
                        line.Visible = true
                    else
                        line.Visible = false
                    end
                end
            end
        else
            for _, line in pairs(esp.skeleton) do line.Visible = false end
        end
    end
end)

function rmonnesy_esp.toggle(name, value)
    if rmonnesy_esp.settings[name] ~= nil then
        rmonnesy_esp.settings[name] = value
    end
end

function rmonnesy_esp.set_color(name, color)
    if rmonnesy_esp.settings[name] then
        rmonnesy_esp.settings[name] = color
    end
end

function rmonnesy_esp.set_font(font_id)
    rmonnesy_esp.settings.font = font_id
end

function rmonnesy_esp.set_text_size(size)
    rmonnesy_esp.settings.text_size = size
end

function rmonnesy_esp.set_distance_limit(dist)
    rmonnesy_esp.settings.max_distance = dist
end

function rmonnesy_esp.enable_all()
    for k, v in pairs(rmonnesy_esp.settings) do
        if type(v) == "boolean" then rmonnesy_esp.settings[k] = true end
    end
end

function rmonnesy_esp.disable_all()
    for k, v in pairs(rmonnesy_esp.settings) do
        if type(v) == "boolean" then rmonnesy_esp.settings[k] = false end
    end
end

return rmonnesy_esp
