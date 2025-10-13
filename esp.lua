local players = game:GetService("Players")
local run_service = game:GetService("RunService")
local local_player = players.LocalPlayer
local camera = workspace.CurrentCamera

local rmonnesy_esp = {}

rmonnesy_esp.settings = {
    enabled = true,                      -- Master ESP toggle
    box_esp = true,                      -- Player box ESP
    head_esp = true,                     -- Circle around head
    health_esp = true,                   -- Health bar
    name_esp = true,                     -- Display player name
    distance_esp = true,                 -- Distance label
    cham_esp = false,                    -- Body highlight (requires exploit API)
    skeleton_esp = false,                -- Bone ESP lines
    tracer_esp = true,                   -- Line from screen bottom to player
    offscreen_arrow_esp = false,         -- Arrow indicator when player is off-screen
    outline_esp = true,                  -- Outline for text
    lookat_esp = false,                  -- Line showing look direction
    circle_esp = false,                  -- Circle around body
    box_type = "2d",                     -- 2d, 3d, or corner box
    max_distance = 5000,                 -- Max ESP render distance
    text_size = 18,                      -- Default text size
    font = 2,                            -- Drawing font ID
    color = Color3.fromRGB(255,255,255), -- Default ESP color
    outline_color = Color3.fromRGB(0,0,0),
    tracer_color = Color3.fromRGB(255,255,255),
    health_color = Color3.fromRGB(0,255,0),
    distance_color = Color3.fromRGB(255,255,255),
    circle_color = Color3.fromRGB(255,255,255),
    head_color = Color3.fromRGB(255,255,255)
}

local esp_objects = {}

local function create_esp(player)
    local box = Drawing.new("Square")
    box.Thickness = 1
    box.Color = rmonnesy_esp.settings.color
    box.Filled = false
    box.Visible = false

    local name_text = Drawing.new("Text")
    name_text.Size = rmonnesy_esp.settings.text_size
    name_text.Color = rmonnesy_esp.settings.color
    name_text.Outline = rmonnesy_esp.settings.outline_esp
    name_text.OutlineColor = rmonnesy_esp.settings.outline_color
    name_text.Font = rmonnesy_esp.settings.font
    name_text.Center = true
    name_text.Visible = false

    local health_bar = Drawing.new("Square")
    health_bar.Thickness = 1
    health_bar.Filled = true
    health_bar.Color = rmonnesy_esp.settings.health_color
    health_bar.Visible = false

    local tracer = Drawing.new("Line")
    tracer.Thickness = 1
    tracer.Color = rmonnesy_esp.settings.tracer_color
    tracer.Visible = false

    local head_circle = Drawing.new("Circle")
    head_circle.Thickness = 1
    head_circle.Color = rmonnesy_esp.settings.head_color
    head_circle.Filled = false
    head_circle.Visible = false

    local distance_text = Drawing.new("Text")
    distance_text.Size = rmonnesy_esp.settings.text_size - 2
    distance_text.Color = rmonnesy_esp.settings.distance_color
    distance_text.Outline = rmonnesy_esp.settings.outline_esp
    distance_text.OutlineColor = rmonnesy_esp.settings.outline_color
    distance_text.Font = rmonnesy_esp.settings.font
    distance_text.Center = true
    distance_text.Visible = false

    esp_objects[player] = {
        box = box,
        name_text = name_text,
        health_bar = health_bar,
        tracer = tracer,
        head_circle = head_circle,
        distance_text = distance_text
    }
end

local function remove_esp(player)
    local esp = esp_objects[player]
    if not esp then return end
    for _, obj in pairs(esp) do
        obj:Remove()
    end
    esp_objects[player] = nil
end

for _, player in pairs(players:GetPlayers()) do
    if player ~= local_player then
        create_esp(player)
    end
end

players.PlayerAdded:Connect(function(player)
    if player ~= local_player then
        create_esp(player)
    end
end)

players.PlayerRemoving:Connect(remove_esp)

run_service.RenderStepped:Connect(function()
    if not rmonnesy_esp.settings.enabled then
        for _, esp in pairs(esp_objects) do
            for _, obj in pairs(esp) do obj.Visible = false end
        end
        return
    end

    local lp_char = local_player.Character
    if not lp_char or not lp_char:FindFirstChild("HumanoidRootPart") then return end
    local lp_pos = lp_char.HumanoidRootPart.Position

    for player, esp in pairs(esp_objects) do
        local char = player.Character
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local head = char and char:FindFirstChild("Head")

        if not humanoid or not root or humanoid.Health <= 0 then
            for _, obj in pairs(esp) do obj.Visible = false end
            continue
        end

        local dist = (lp_pos - root.Position).Magnitude
        if dist > rmonnesy_esp.settings.max_distance then
            for _, obj in pairs(esp) do obj.Visible = false end
            continue
        end

        local min_vec = Vector3.new(math.huge, math.huge, math.huge)
        local max_vec = Vector3.new(-math.huge, -math.huge, -math.huge)
        local visible = false

        for _, part in pairs(char:GetChildren()) do
            if part:IsA("BasePart") then
                local cf, size = part.CFrame, part.Size
                for _, offset in pairs({
                    Vector3.new(size.X/2,size.Y/2,size.Z/2),
                    Vector3.new(-size.X/2,size.Y/2,size.Z/2),
                    Vector3.new(size.X/2,-size.Y/2,size.Z/2),
                    Vector3.new(size.X/2,size.Y/2,-size.Z/2),
                    Vector3.new(-size.X/2,-size.Y/2,size.Z/2),
                    Vector3.new(size.X/2,-size.Y/2,-size.Z/2),
                    Vector3.new(-size.X/2,size.Y/2,-size.Z/2),
                    Vector3.new(-size.X/2,-size.Y/2,-size.Z/2)
                }) do
                    local pos, onscreen = camera:WorldToViewportPoint(cf * offset)
                    if onscreen then
                        visible = true
                        min_vec = Vector3.new(math.min(min_vec.X,pos.X), math.min(min_vec.Y,pos.Y), pos.Z)
                        max_vec = Vector3.new(math.max(max_vec.X,pos.X), math.max(max_vec.Y,pos.Y), pos.Z)
                    end
                end
            end
        end

        if not visible then
            for _, obj in pairs(esp) do obj.Visible = false end
            continue
        end

        local x, y = min_vec.X, min_vec.Y
        local w, h = max_vec.X - min_vec.X, max_vec.Y - min_vec.Y
        w = math.max(w, 5)
        h = math.max(h, 5)

        if rmonnesy_esp.settings.box_esp then
            esp.box.Position = Vector2.new(x, y)
            esp.box.Size = Vector2.new(w, h)
            esp.box.Visible = true
        else
            esp.box.Visible = false
        end

        if rmonnesy_esp.settings.name_esp then
            esp.name_text.Text = player.Name
            esp.name_text.Position = Vector2.new(x + w / 2, y - 18)
            esp.name_text.Visible = true
        else
            esp.name_text.Visible = false
        end

        if rmonnesy_esp.settings.health_esp then
            local hp_ratio = humanoid.Health / humanoid.MaxHealth
            local bar_height = h * hp_ratio
            local bw, offset = 3, 3
            esp.health_bar.Position = Vector2.new(x - bw - offset, y + h - bar_height)
            esp.health_bar.Size = Vector2.new(bw, bar_height)
            esp.health_bar.Color = Color3.fromRGB(255 * (1 - hp_ratio), 255 * hp_ratio, 0)
            esp.health_bar.Visible = true
        else
            esp.health_bar.Visible = false
        end

        if rmonnesy_esp.settings.tracer_esp then
            local root_screen, vis = camera:WorldToViewportPoint(root.Position)
            if vis then
                esp.tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
                esp.tracer.To = Vector2.new(root_screen.X, root_screen.Y)
                esp.tracer.Visible = true
            else
                esp.tracer.Visible = false
            end
        else
            esp.tracer.Visible = false
        end

        if rmonnesy_esp.settings.head_esp and head then
            local head_screen, vis = camera:WorldToViewportPoint(head.Position)
            if vis then
                esp.head_circle.Position = Vector2.new(head_screen.X, head_screen.Y)
                esp.head_circle.Radius = 8
                esp.head_circle.Visible = true
            else
                esp.head_circle.Visible = false
            end
        else
            esp.head_circle.Visible = false
        end

        if rmonnesy_esp.settings.distance_esp then
            local dist_text = string.format("%.0f studs", dist)
            esp.distance_text.Text = dist_text
            esp.distance_text.Position = Vector2.new(x + w / 2, y + h + 2)
            esp.distance_text.Visible = true
        else
            esp.distance_text.Visible = false
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
