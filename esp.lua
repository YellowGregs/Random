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
    -- cham_esp = true, -- Future addition
    skeleton_esp = true,
    tracer_esp = true,
    offscreen_arrow_esp = true,
    outline_esp = true,
    lookat_esp = true,

    team_check = false,              

    box_type = "corner",            -- "2d", "3d", or "corner"
    max_distance = 5000,
    text_size = 18,
    font = 2,

    color = Color3.fromRGB(255,255,255),
    outline_color = Color3.fromRGB(0,0,0),
    tracer_color = Color3.fromRGB(255,255,255),
    health_color = Color3.fromRGB(0,255,0),
    distance_color = Color3.fromRGB(255,255,255),
    head_color = Color3.fromRGB(255,255,255),
    skeleton_color = Color3.fromRGB(255,255,255),
    arrow_color = Color3.fromRGB(255,255,0),
    lookat_color = Color3.fromRGB(255,0,0)
}

local esp_objects = {}

local function new_drawing(class, properties)
    local obj = Drawing.new(class)
    for k, v in pairs(properties or {}) do
        obj[k] = v
    end
    return obj
end

local function remove_esp(player)
    local esp = esp_objects[player]
    if not esp then return end
    for _, obj in pairs(esp) do obj:Remove() end
    esp_objects[player] = nil
end

local function create_esp(player)
    esp_objects[player] = {
        box = new_drawing("Square", {Thickness = 1, Filled = false, Visible = false}),
        name = new_drawing("Text", {
            Size = rmonnesy_esp.settings.text_size,
            Outline = rmonnesy_esp.settings.outline_esp,
            OutlineColor = rmonnesy_esp.settings.outline_color,
            Font = rmonnesy_esp.settings.font,
            Center = true,
            Visible = false
        }),
        health = new_drawing("Square", {Filled = true, Visible = false}),
        tracer = new_drawing("Line", {Thickness = 1, Visible = false}),
        head = new_drawing("Circle", {Thickness = 1, Filled = false, Visible = false}),
        distance = new_drawing("Text", {
            Size = rmonnesy_esp.settings.text_size - 2,
            Outline = rmonnesy_esp.settings.outline_esp,
            OutlineColor = rmonnesy_esp.settings.outline_color,
            Font = rmonnesy_esp.settings.font,
            Center = true,
            Visible = false
        }),
        lookat = new_drawing("Line", {Thickness = 1, Visible = false}),
        arrow = new_drawing("Triangle", {Visible = false}),
        skeleton = {}
    }
end

for _, p in ipairs(players:GetPlayers()) do
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
                if typeof(obj) == "table" then
                    for _, sub in pairs(obj) do sub.Visible = false end
                else
                    obj.Visible = false
                end
            end
        end
        return
    end

    local lp_char = local_player.Character
    local lp_hrp = lp_char and lp_char:FindFirstChild("HumanoidRootPart")
    if not lp_hrp then return end

    for player, esp in pairs(esp_objects) do
        local char = player.Character
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local head = char and char:FindFirstChild("Head")

        if not humanoid or not root or humanoid.Health <= 0 then
            for _, obj in pairs(esp) do
                if typeof(obj) == "table" then
                    for _, sub in pairs(obj) do sub.Visible = false end
                else
                    obj.Visible = false
                end
            end
            continue
        end

        if rmonnesy_esp.settings.team_check and player.Team == local_player.Team then
            for _, obj in pairs(esp) do
                if typeof(obj) == "table" then
                    for _, sub in pairs(obj) do sub.Visible = false end
                else
                    obj.Visible = false
                end
            end
            continue
        end

        local dist = (lp_hrp.Position - root.Position).Magnitude
        if dist > rmonnesy_esp.settings.max_distance then
            for _, obj in pairs(esp) do
                if typeof(obj) == "table" then
                    for _, sub in pairs(obj) do sub.Visible = false end
                else
                    obj.Visible = false
                end
            end
            continue
        end

        local root_pos, vis = camera:WorldToViewportPoint(root.Position)
        if not vis then
            if rmonnesy_esp.settings.offscreen_arrow_esp then
                local screen_center = camera.ViewportSize / 2
                local dir = (root.Position - camera.CFrame.Position).Unit
                local angle = math.atan2(dir.X, dir.Z)
                local radius = 250
                local pos = screen_center + Vector2.new(math.sin(angle), -math.cos(angle)) * radius

                esp.arrow.PointA = pos
                esp.arrow.PointB = pos + Vector2.new(-8, 14)
                esp.arrow.PointC = pos + Vector2.new(8, 14)
                esp.arrow.Color = rmonnesy_esp.settings.arrow_color
                esp.arrow.Visible = true
            end
            continue
        else
            esp.arrow.Visible = false
        end

        local box_size = Vector2.new(50, 70)
        local box_pos = Vector2.new(root_pos.X - box_size.X / 2, root_pos.Y - box_size.Y)

        -- BOX ESP
        if rmonnesy_esp.settings.box_esp then
            esp.box.Size = box_size
            esp.box.Position = box_pos
            esp.box.Color = rmonnesy_esp.settings.color
            esp.box.Visible = true
        else
            esp.box.Visible = false
        end

        -- NAME
        if rmonnesy_esp.settings.name_esp then
            esp.name.Text = player.DisplayName
            esp.name.Position = Vector2.new(root_pos.X, box_pos.Y - 15)
            esp.name.Color = rmonnesy_esp.settings.color
            esp.name.Visible = true
        else
            esp.name.Visible = false
        end

        -- HEALTH BAR
        if rmonnesy_esp.settings.health_esp then
            local hp_ratio = humanoid.Health / humanoid.MaxHealth
            local bar_height = box_size.Y * hp_ratio
            esp.health.Position = Vector2.new(box_pos.X - 6, box_pos.Y + (box_size.Y - bar_height))
            esp.health.Size = Vector2.new(4, bar_height)
            esp.health.Color = Color3.fromRGB(255 * (1 - hp_ratio), 255 * hp_ratio, 0)
            esp.health.Visible = true
        else
            esp.health.Visible = false
        end

        -- DISTANCE
        if rmonnesy_esp.settings.distance_esp then
            esp.distance.Text = string.format("%.0f studs", dist)
            esp.distance.Position = Vector2.new(root_pos.X, box_pos.Y + box_size.Y + 12)
            esp.distance.Color = rmonnesy_esp.settings.distance_color
            esp.distance.Visible = true
        else
            esp.distance.Visible = false
        end

        -- HEAD
        if rmonnesy_esp.settings.head_esp and head then
            local head_pos, head_vis = camera:WorldToViewportPoint(head.Position)
            if head_vis then
                esp.head.Position = Vector2.new(head_pos.X, head_pos.Y)
                esp.head.Radius = 8
                esp.head.Color = rmonnesy_esp.settings.head_color
                esp.head.Visible = true
            end
        else
            esp.head.Visible = false
        end

        -- LOOKAT
        if rmonnesy_esp.settings.lookat_esp then
            local look_dir = root.CFrame.LookVector
            local look_end = root.Position + (look_dir * 5)
            local look_screen, look_vis = camera:WorldToViewportPoint(look_end)
            if look_vis then
                esp.lookat.From = Vector2.new(root_pos.X, root_pos.Y)
                esp.lookat.To = Vector2.new(look_screen.X, look_screen.Y)
                esp.lookat.Color = rmonnesy_esp.settings.lookat_color
                esp.lookat.Visible = true
            else
                esp.lookat.Visible = false
            end
        else
            esp.lookat.Visible = false
        end

        -- SKELETON
        if rmonnesy_esp.settings.skeleton_esp then
            local skeleton_parts = {
                head = head,
                torso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso"),
                leftArm = char:FindFirstChild("LeftUpperArm") or char:FindFirstChild("Left Arm"),
                rightArm = char:FindFirstChild("RightUpperArm") or char:FindFirstChild("Right Arm"),
                leftLeg = char:FindFirstChild("LeftUpperLeg") or char:FindFirstChild("Left Leg"),
                rightLeg = char:FindFirstChild("RightUpperLeg") or char:FindFirstChild("Right Leg")
            }

            local function drawBone(fromPart, toPart)
                if not (fromPart and toPart) then return end
                local fromPos, fromVis = camera:WorldToViewportPoint(fromPart.Position)
                local toPos, toVis = camera:WorldToViewportPoint(toPart.Position)
                if fromVis and toVis then
                    local bone = esp.skeleton[fromPart.Name] or new_drawing("Line", {Thickness = 1})
                    bone.From = Vector2.new(fromPos.X, fromPos.Y)
                    bone.To = Vector2.new(toPos.X, toPos.Y)
                    bone.Color = rmonnesy_esp.settings.skeleton_color
                    bone.Visible = true
                    esp.skeleton[fromPart.Name] = bone
                end
            end

            drawBone(skeleton_parts.head, skeleton_parts.torso)
            drawBone(skeleton_parts.torso, skeleton_parts.leftArm)
            drawBone(skeleton_parts.torso, skeleton_parts.rightArm)
            drawBone(skeleton_parts.torso, skeleton_parts.leftLeg)
            drawBone(skeleton_parts.torso, skeleton_parts.rightLeg)
        else
            for _, bone in pairs(esp.skeleton) do bone.Visible = false end
        end
    end
end)

function rmonnesy_esp.toggle(name, value)
    if rmonnesy_esp.settings[name] ~= nil then
        rmonnesy_esp.settings[name] = value
    end
end

function rmonnesy_esp.set_color(name, color)
    if rmonnesy_esp.settings[name] ~= nil then
        rmonnesy_esp.settings[name] = color
    end
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
