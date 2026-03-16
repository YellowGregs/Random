local UILibrary = {}
UILibrary.__index = UILibrary

local THEME = {
    -- Window
    window_bg        = Color3.fromRGB(26, 26, 26),
    titlebar_bg      = Color3.fromRGB(20, 20, 20),
    titlebar_border  = Color3.fromRGB(42, 42, 42),

    -- Tabs
    tab_bg           = Color3.fromRGB(22, 22, 22),
    tab_active_bg    = Color3.fromRGB(26, 26, 26),
    tab_text         = Color3.fromRGB(102, 102, 102),
    tab_active_text  = Color3.fromRGB(204, 204, 204),
    tab_border       = Color3.fromRGB(34, 34, 34),
    tab_accent       = Color3.fromRGB(124, 106, 247),

    -- Content rows
    row_bg           = Color3.fromRGB(32, 32, 32),
    row_border       = Color3.fromRGB(38, 38, 38),
    row_text         = Color3.fromRGB(187, 187, 187),
    row_hover_bg     = Color3.fromRGB(38, 38, 38),

    -- Section labels
    label_text       = Color3.fromRGB(124, 106, 247),
    label_border     = Color3.fromRGB(42, 42, 42),

    -- Toggle
    tog_off_bg       = Color3.fromRGB(51, 51, 51),
    tog_off_thumb    = Color3.fromRGB(136, 136, 136),
    tog_on_bg        = Color3.fromRGB(124, 106, 247),
    tog_on_thumb     = Color3.fromRGB(255, 255, 255),
    tog_border       = Color3.fromRGB(68, 68, 68),

    -- Slider
    slider_track     = Color3.fromRGB(51, 51, 51),
    slider_fill      = Color3.fromRGB(124, 106, 247),
    slider_thumb     = Color3.fromRGB(124, 106, 247),
    slider_val_text  = Color3.fromRGB(124, 106, 247),

    -- Dropdown
    dropdown_arrow   = Color3.fromRGB(102, 102, 102),
    dropdown_val     = Color3.fromRGB(136, 136, 136),
    dropdown_menu_bg = Color3.fromRGB(37, 37, 37),
    dropdown_item    = Color3.fromRGB(170, 170, 170),
    dropdown_sel     = Color3.fromRGB(124, 106, 247),

    -- Button
    btn_bg           = Color3.fromRGB(42, 42, 42),
    btn_hover_bg     = Color3.fromRGB(51, 51, 51),
    btn_border       = Color3.fromRGB(58, 58, 58),
    btn_text         = Color3.fromRGB(192, 192, 192),

    -- Colorpicker
    picker_border    = Color3.fromRGB(68, 68, 68),

    -- Keybind badge
    badge_bg         = Color3.fromRGB(34, 34, 34),
    badge_border     = Color3.fromRGB(51, 51, 51),
    badge_text       = Color3.fromRGB(85, 85, 85),

    -- Misc
    separator        = Color3.fromRGB(37, 37, 37),
    muted_text       = Color3.fromRGB(85, 85, 85),
    hint_text        = Color3.fromRGB(102, 102, 102),
}

local LAYOUT = {
    window_w     = 460,
    titlebar_h   = 34,
    tab_bar_h    = 30,
    row_h        = 44,
    row_pad_x    = 14,
    tab_w        = 72,
    corner       = 6,
    tog_w        = 36,
    tog_h        = 20,
    tog_thumb_r  = 7,
    slider_h     = 4,
    slider_thumb = 8,
    font_size_title  = 11,
    font_size_tab    = 11,
    font_size_row    = 12,
    font_size_val    = 11,
    font_size_label  = 10,
    max_visible_rows = 8,
    row_scroll_h     = 44,
}

local function newDraw(class, props)
    local obj = Drawing.new(class)
    for k, v in pairs(props) do
        obj[k] = v
    end
    return obj
end

local function colorToHex(c)
    return string.format("#%02x%02x%02x",
        math.round(c.R * 255),
        math.round(c.G * 255),
        math.round(c.B * 255))
end

function UILibrary:Window(title, keybind)
    local win = {
        title    = title or "UI Library",
        keybind  = keybind or "P",
        visible  = true,
        tabs     = {},
        active_tab = nil,
        drawings = {},
        x        = 100,
        y        = 80,
        dragging = false,
        drag_ox  = 0,
        drag_oy  = 0,
        connections = {},
    }
    setmetatable(win, {__index = UILibrary})

    local W = LAYOUT.window_w

    win.d_titlebar = newDraw("Square", {
        Position  = Vector2.new(win.x, win.y),
        Size      = Vector2.new(W, LAYOUT.titlebar_h),
        Color     = THEME.titlebar_bg,
        Filled    = true,
        Visible   = true,
        ZIndex    = 10,
    })

    -- Titlebar bottom border
    win.d_titlebar_border = newDraw("Line", {
        From      = Vector2.new(win.x, win.y + LAYOUT.titlebar_h),
        To        = Vector2.new(win.x + W, win.y + LAYOUT.titlebar_h),
        Color     = THEME.titlebar_border,
        Thickness = 1,
        Visible   = true,
        ZIndex    = 11,
    })

    -- Title text
    win.d_title = newDraw("Text", {
        Text      = title,
        Position  = Vector2.new(win.x + 12, win.y + LAYOUT.titlebar_h / 2 - 6),
        Size      = LAYOUT.font_size_title,
        Color     = THEME.tab_text,
        Visible   = true,
        ZIndex    = 12,
    })

    -- Keybind badge background
    win.d_badge_bg = newDraw("Square", {
        Position  = Vector2.new(win.x + W - 28, win.y + 8),
        Size      = Vector2.new(18, 18),
        Color     = THEME.badge_bg,
        Filled    = true,
        Visible   = true,
        ZIndex    = 11,
    })
    win.d_badge_border = newDraw("Square", {
        Position  = Vector2.new(win.x + W - 28, win.y + 8),
        Size      = Vector2.new(18, 18),
        Color     = THEME.badge_border,
        Filled    = false,
        Thickness = 1,
        Visible   = true,
        ZIndex    = 12,
    })
    win.d_badge_text = newDraw("Text", {
        Text      = keybind or "P",
        Position  = Vector2.new(win.x + W - 22, win.y + 11),
        Size      = 10,
        Color     = THEME.badge_text,
        Visible   = true,
        ZIndex    = 13,
        Centered  = true,
    })

    -- Tab bar background
    win.d_tabbar = newDraw("Square", {
        Position  = Vector2.new(win.x, win.y + LAYOUT.titlebar_h),
        Size      = Vector2.new(W, LAYOUT.tab_bar_h),
        Color     = THEME.tab_bg,
        Filled    = true,
        Visible   = true,
        ZIndex    = 10,
    })
    win.d_tabbar_border = newDraw("Line", {
        From      = Vector2.new(win.x, win.y + LAYOUT.titlebar_h + LAYOUT.tab_bar_h),
        To        = Vector2.new(win.x + W, win.y + LAYOUT.titlebar_h + LAYOUT.tab_bar_h),
        Color     = THEME.tab_border,
        Thickness = 1,
        Visible   = true,
        ZIndex    = 11,
    })

    -- Content body background
    local body_y = win.y + LAYOUT.titlebar_h + LAYOUT.tab_bar_h
    local body_h = LAYOUT.row_h * LAYOUT.max_visible_rows + 2
    win.d_body = newDraw("Square", {
        Position  = Vector2.new(win.x, body_y),
        Size      = Vector2.new(W, body_h),
        Color     = THEME.window_bg,
        Filled    = true,
        Visible   = true,
        ZIndex    = 10,
    })

    -- Window outer border
    local total_h = LAYOUT.titlebar_h + LAYOUT.tab_bar_h + body_h
    win.d_outline = newDraw("Square", {
        Position  = Vector2.new(win.x, win.y),
        Size      = Vector2.new(W, total_h),
        Color     = THEME.titlebar_border,
        Filled    = false,
        Thickness = 1,
        Visible   = true,
        ZIndex    = 20,
    })

    win._body_y = body_y
    win._body_h = body_h
    win._W      = W

    local UIS = game:GetService("UserInputService")
    win.connections.drag_begin = UIS.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mx, my = input.Position.X, input.Position.Y
            if mx >= win.x and mx <= win.x + W and my >= win.y and my <= win.y + LAYOUT.titlebar_h then
                win.dragging = true
                win.drag_ox = mx - win.x
                win.drag_oy = my - win.y
            end
        end
    end)
    win.connections.drag_move = UIS.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and win.dragging then
            local mx, my = input.Position.X, input.Position.Y
            win:_move(mx - win.drag_ox, my - win.drag_oy)
        end
    end)
    win.connections.drag_end = UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            win.dragging = false
        end
    end)

    win.connections.keybind = UIS.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.KeyCode == Enum.KeyCode[win.keybind] then
            win:Toggle()
        end
    end)

    return win
end

function UILibrary:_move(nx, ny)
    local dx = nx - self.x
    local dy = ny - self.y
    self.x = nx
    self.y = ny

    local function shiftV2(obj, field)
        local v = obj[field]
        obj[field] = Vector2.new(v.X + dx, v.Y + dy)
    end
    local function shiftLine(obj)
        obj.From = Vector2.new(obj.From.X + dx, obj.From.Y + dy)
        obj.To   = Vector2.new(obj.To.X + dx, obj.To.Y + dy)
    end

    shiftV2(self.d_titlebar, "Position")
    shiftLine(self.d_titlebar_border)
    shiftV2(self.d_title, "Position")
    shiftV2(self.d_badge_bg, "Position")
    shiftV2(self.d_badge_border, "Position")
    shiftV2(self.d_badge_text, "Position")
    shiftV2(self.d_tabbar, "Position")
    shiftLine(self.d_tabbar_border)
    shiftV2(self.d_body, "Position")
    shiftV2(self.d_outline, "Position")

    for _, tab in ipairs(self.tabs) do
        tab:_shift(dx, dy)
    end
end

function UILibrary:Toggle()
    self.visible = not self.visible
    local v = self.visible
    self.d_titlebar.Visible      = v
    self.d_titlebar_border.Visible = v
    self.d_title.Visible         = v
    self.d_badge_bg.Visible      = v
    self.d_badge_border.Visible  = v
    self.d_badge_text.Visible    = v
    self.d_tabbar.Visible        = v
    self.d_tabbar_border.Visible = v
    self.d_body.Visible          = v
    self.d_outline.Visible       = v
    for _, tab in ipairs(self.tabs) do
        tab:_setVisible(v and (tab == self.active_tab))
    end
end

function UILibrary:_refreshTabs()
    local n      = #self.tabs
    local W      = self._W
    local tab_w  = math.floor(W / math.max(n, 1))
    local ty     = self.y + LAYOUT.titlebar_h
    local th     = LAYOUT.tab_bar_h

    for i, tab in ipairs(self.tabs) do
        local tx = self.x + (i - 1) * tab_w
        local is_active = (tab == self.active_tab)

        tab.d_tab_bg.Position = Vector2.new(tx, ty)
        tab.d_tab_bg.Size     = Vector2.new(tab_w, th)
        tab.d_tab_bg.Color    = is_active and THEME.tab_active_bg or THEME.tab_bg

        tab.d_tab_text.Position = Vector2.new(tx + tab_w / 2, ty + th / 2 - 5)
        tab.d_tab_text.Color    = is_active and THEME.tab_active_text or THEME.tab_text

        tab.d_tab_accent.From    = Vector2.new(tx + 6, ty + th - 2)
        tab.d_tab_accent.To      = Vector2.new(tx + tab_w - 6, ty + th - 2)
        tab.d_tab_accent.Visible = is_active

        if i < n then
            tab.d_tab_divider.From = Vector2.new(tx + tab_w, ty + 4)
            tab.d_tab_divider.To   = Vector2.new(tx + tab_w, ty + th - 4)
            tab.d_tab_divider.Visible = true
        else
            tab.d_tab_divider.Visible = false
        end

        tab._tx   = tx
        tab._tw   = tab_w
    end
end

function UILibrary:Tab(name)
    local win = self
    local tab = {
        name     = name,
        win      = win,
        rows     = {},
        visible  = false,
        scroll   = 0,
        _tx      = 0,
        _tw      = 0,
    }
    setmetatable(tab, {__index = UILibrary})

    tab.d_tab_bg = newDraw("Square", {
        Position = Vector2.new(0, 0),
        Size     = Vector2.new(50, LAYOUT.tab_bar_h),
        Color    = THEME.tab_bg,
        Filled   = true,
        Visible  = true,
        ZIndex   = 11,
    })
    tab.d_tab_text = newDraw("Text", {
        Text     = name,
        Position = Vector2.new(0, 0),
        Size     = LAYOUT.font_size_tab,
        Color    = THEME.tab_text,
        Centered = true,
        Visible  = true,
        ZIndex   = 13,
    })
    tab.d_tab_accent = newDraw("Line", {
        From      = Vector2.new(0, 0),
        To        = Vector2.new(50, 0),
        Color     = THEME.tab_accent,
        Thickness = 2,
        Visible   = false,
        ZIndex    = 14,
    })
    tab.d_tab_divider = newDraw("Line", {
        From      = Vector2.new(0, 0),
        To        = Vector2.new(0, LAYOUT.tab_bar_h),
        Color     = THEME.tab_border,
        Thickness = 1,
        Visible   = false,
        ZIndex    = 12,
    })

    table.insert(win.tabs, tab)

    if #win.tabs == 1 then
        win.active_tab = tab
        tab.visible = true
    end

    win:_refreshTabs()

    local UIS = game:GetService("UserInputService")
    tab._conn = UIS.InputBegan:Connect(function(input)
        if not win.visible then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mx, my = input.Position.X, input.Position.Y
            local ty = win.y + LAYOUT.titlebar_h
            if mx >= tab._tx and mx <= tab._tx + tab._tw
                and my >= ty and my <= ty + LAYOUT.tab_bar_h then
                win:_switchTab(tab)
            end
        end
    end)

    function tab:_setVisible(v)
        self.d_tab_bg.Visible      = v or (self.win.visible)
        self.d_tab_text.Visible    = v or (self.win.visible)
        self.d_tab_accent.Visible  = v and (self == self.win.active_tab)
        self.d_tab_divider.Visible = self.win.visible and (#self.win.tabs > 1)
        for _, row in ipairs(self.rows) do
            row:_setVisible(v)
        end
    end

    function tab:_shift(dx, dy)
        local function sv2(obj, field)
            local p = obj[field]
            obj[field] = Vector2.new(p.X + dx, p.Y + dy)
        end
        local function sl(obj)
            obj.From = Vector2.new(obj.From.X + dx, obj.From.Y + dy)
            obj.To   = Vector2.new(obj.To.X + dx, obj.To.Y + dy)
        end
        sv2(self.d_tab_bg, "Position")
        sv2(self.d_tab_text, "Position")
        sl(self.d_tab_accent)
        sl(self.d_tab_divider)
        for _, row in ipairs(self.rows) do
            row:_shift(dx, dy)
        end
    end

    function tab:_getNextY()
        return win._body_y + #self.rows * LAYOUT.row_h
    end

    return tab
end

function UILibrary:_switchTab(tab)
    if self.active_tab == tab then return end
    -- hide old
    for _, row in ipairs(self.active_tab.rows) do
        row:_setVisible(false)
    end
    self.active_tab = tab
    self:_refreshTabs()
    for _, row in ipairs(tab.rows) do
        row:_setVisible(true)
    end
end

local function newRow(tab, kind)
    local win = tab.win
    local row_index = #tab.rows
    local rx = win.x
    local ry = tab:_getNextY()
    local W  = win._W
    local row = {
        kind    = kind,
        tab     = tab,
        win     = win,
        rx      = rx,
        ry      = ry,
        visible = (tab == win.active_tab),
        drawings = {},
    }
    setmetatable(row, {__index = UILibrary})

    row.d_bg = newDraw("Square", {
        Position = Vector2.new(rx, ry),
        Size     = Vector2.new(W, LAYOUT.row_h),
        Color    = THEME.row_bg,
        Filled   = true,
        Visible  = row.visible,
        ZIndex   = 15,
    })
    row.d_border = newDraw("Line", {
        From     = Vector2.new(rx, ry + LAYOUT.row_h),
        To       = Vector2.new(rx + W, ry + LAYOUT.row_h),
        Color    = THEME.row_border,
        Thickness = 1,
        Visible  = row.visible,
        ZIndex   = 16,
    })
    row.d_label = newDraw("Text", {
        Text     = "",
        Position = Vector2.new(rx + LAYOUT.row_pad_x, ry + LAYOUT.row_h / 2 - 6),
        Size     = LAYOUT.font_size_row,
        Color    = THEME.row_text,
        Visible  = row.visible,
        ZIndex   = 17,
    })

    function row:_setVisible(v)
        self.visible = v
        self.d_bg.Visible     = v
        self.d_border.Visible = v
        self.d_label.Visible  = v
        for _, d in ipairs(self.drawings) do
            if d._base_visible ~= false then
                d.Visible = v
            end
        end
    end

    function row:_shift(dx, dy)
        self.rx = self.rx + dx
        self.ry = self.ry + dy
        local function sv2(obj, field)
            local p = obj[field]
            obj[field] = Vector2.new(p.X + dx, p.Y + dy)
        end
        local function sl(obj)
            obj.From = Vector2.new(obj.From.X + dx, obj.From.Y + dy)
            obj.To   = Vector2.new(obj.To.X + dx, obj.To.Y + dy)
        end
        sv2(self.d_bg, "Position")
        sl(self.d_border)
        sv2(self.d_label, "Position")
        for _, d in ipairs(self.drawings) do
            if d.Position then sv2(d, "Position")
            elseif d.From then sl(d) end
        end
    end

    table.insert(tab.rows, row)
    return row
end

function UILibrary:Label(text)
    local tab = self
    local win = tab.win
    local rx  = win.x
    local ry  = tab:_getNextY()
    local W   = win._W
    local vis = (tab == win.active_tab)

    local row = {
        kind    = "label",
        tab     = tab,
        win     = win,
        rx      = rx,
        ry      = ry,
        visible = vis,
        drawings = {},
    }
    setmetatable(row, {__index = UILibrary})

    row.d_bg = newDraw("Square", {
        Position = Vector2.new(rx, ry),
        Size     = Vector2.new(W, 28),
        Color    = THEME.window_bg,
        Filled   = true,
        Visible  = vis,
        ZIndex   = 15,
    })
    row.d_label_txt = newDraw("Text", {
        Text     = text,
        Position = Vector2.new(rx + LAYOUT.row_pad_x, ry + 7),
        Size     = LAYOUT.font_size_label,
        Color    = THEME.label_text,
        Visible  = vis,
        ZIndex   = 17,
    })
    row.d_sep = newDraw("Line", {
        From     = Vector2.new(rx, ry + 27),
        To       = Vector2.new(rx + W, ry + 27),
        Color    = THEME.label_border,
        Thickness = 1,
        Visible  = vis,
        ZIndex   = 16,
    })

    function row:_setVisible(v)
        self.visible = v
        self.d_bg.Visible        = v
        self.d_label_txt.Visible = v
        self.d_sep.Visible       = v
        for _, d in ipairs(self.drawings) do d.Visible = v end
    end

    function row:_shift(dx, dy)
        self.rx = self.rx + dx
        self.ry = self.ry + dy
        local function sv2(o, f) local p=o[f]; o[f]=Vector2.new(p.X+dx,p.Y+dy) end
        local function sl(o) o.From=Vector2.new(o.From.X+dx,o.From.Y+dy); o.To=Vector2.new(o.To.X+dx,o.To.Y+dy) end
        sv2(self.d_bg, "Position")
        sv2(self.d_label_txt, "Position")
        sl(self.d_sep)
        for _, d in ipairs(self.drawings) do
            if d.Position then sv2(d, "Position") elseif d.From then sl(d) end
        end
    end

    local old_get = tab._getNextY
    tab._label_offset = (tab._label_offset or 0) + 28 - LAYOUT.row_h

    table.insert(tab.rows, row)
    return row
end

function UILibrary:Button(text, callback)
    local tab = self
    local row = newRow(tab, "button")
    row.d_label.Text = text

    local W   = tab.win._W
    local rx  = row.rx
    local ry  = row.ry
    local vis = row.visible

    local btn_w  = 90
    local btn_h  = 26
    local btn_x  = rx + W - LAYOUT.row_pad_x - btn_w
    local btn_y  = ry + (LAYOUT.row_h - btn_h) / 2

    local d_btn_bg = newDraw("Square", {
        Position = Vector2.new(btn_x, btn_y),
        Size     = Vector2.new(btn_w, btn_h),
        Color    = THEME.btn_bg,
        Filled   = true,
        Visible  = vis,
        ZIndex   = 18,
    })
    local d_btn_border = newDraw("Square", {
        Position  = Vector2.new(btn_x, btn_y),
        Size      = Vector2.new(btn_w, btn_h),
        Color     = THEME.btn_border,
        Filled    = false,
        Thickness = 1,
        Visible   = vis,
        ZIndex    = 19,
    })
    local d_btn_text = newDraw("Text", {
        Text     = text,
        Position = Vector2.new(btn_x + btn_w / 2, btn_y + btn_h / 2 - 5),
        Size     = LAYOUT.font_size_val,
        Color    = THEME.btn_text,
        Centered = true,
        Visible  = vis,
        ZIndex   = 20,
    })

    table.insert(row.drawings, d_btn_bg)
    table.insert(row.drawings, d_btn_border)
    table.insert(row.drawings, d_btn_text)

    row.d_label.Text  = ""
    row.d_label.Color = THEME.row_text

    row.d_label.Text = text

    local UIS = game:GetService("UserInputService")
    row._btn_conn = UIS.InputBegan:Connect(function(input)
        if not row.visible then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mx, my = input.Position.X, input.Position.Y
            if mx >= btn_x and mx <= btn_x + btn_w
                and my >= btn_y and my <= btn_y + btn_h then
                d_btn_bg.Color = THEME.btn_hover_bg
                if callback then
                    task.spawn(callback)
                end
                task.delay(0.12, function()
                    d_btn_bg.Color = THEME.btn_bg
                end)
            end
        end
    end)

    return row
end

function UILibrary:Toggle(text, default, callback)
    local tab = self
    local row = newRow(tab, "toggle")
    row.d_label.Text = text

    local state = default or false
    local rx  = row.rx
    local ry  = row.ry
    local W   = tab.win._W
    local vis = row.visible

    local tog_x = rx + W - LAYOUT.row_pad_x - LAYOUT.tog_w
    local tog_y = ry + (LAYOUT.row_h - LAYOUT.tog_h) / 2

    local d_track = newDraw("Square", {
        Position  = Vector2.new(tog_x, tog_y),
        Size      = Vector2.new(LAYOUT.tog_w, LAYOUT.tog_h),
        Color     = state and THEME.tog_on_bg or THEME.tog_off_bg,
        Filled    = true,
        Visible   = vis,
        ZIndex    = 18,
    })
    local d_track_border = newDraw("Square", {
        Position  = Vector2.new(tog_x, tog_y),
        Size      = Vector2.new(LAYOUT.tog_w, LAYOUT.tog_h),
        Color     = THEME.tog_border,
        Filled    = false,
        Thickness = 1,
        Visible   = vis,
        ZIndex    = 19,
    })

    local thumb_off_x = tog_x + 2
    local thumb_on_x  = tog_x + LAYOUT.tog_w - LAYOUT.tog_thumb_r * 2 - 2
    local thumb_cx    = state and (thumb_on_x + LAYOUT.tog_thumb_r) or (thumb_off_x + LAYOUT.tog_thumb_r)
    local thumb_cy    = tog_y + LAYOUT.tog_h / 2

    local d_thumb = newDraw("Circle", {
        Center    = Vector2.new(thumb_cx, thumb_cy),
        Radius    = LAYOUT.tog_thumb_r,
        Color     = state and THEME.tog_on_thumb or THEME.tog_off_thumb,
        Filled    = true,
        Visible   = vis,
        ZIndex    = 20,
    })

    table.insert(row.drawings, d_track)
    table.insert(row.drawings, d_track_border)
    table.insert(row.drawings, d_thumb)

    local function applyState(s)
        state = s
        d_track.Color = s and THEME.tog_on_bg or THEME.tog_off_bg
        d_thumb.Color = s and THEME.tog_on_thumb or THEME.tog_off_thumb
        local tx = s and (thumb_on_x + LAYOUT.tog_thumb_r) or (thumb_off_x + LAYOUT.tog_thumb_r)
        d_thumb.Center = Vector2.new(tx, thumb_cy)
        if callback then callback(s) end
    end

    local UIS = game:GetService("UserInputService")
    row._tog_conn = UIS.InputBegan:Connect(function(input)
        if not row.visible then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mx, my = input.Position.X, input.Position.Y
            if mx >= tog_x and mx <= tog_x + LAYOUT.tog_w
                and my >= tog_y and my <= tog_y + LAYOUT.tog_h then
                applyState(not state)
            end
        end
    end)

    row.SetState = applyState
    row.GetState = function() return state end
    return row
end

function UILibrary:Slider(text, min, max, default, callback)
    local tab = self
    local row = newRow(tab, "slider")
    row.d_label.Text = text
    row.d_label.Position = Vector2.new(row.rx + LAYOUT.row_pad_x, row.ry + 8)

    local val = math.clamp(default or min, min, max)
    local rx  = row.rx
    local ry  = row.ry
    local W   = tab.win._W
    local vis = row.visible

    local val_x = rx + W - LAYOUT.row_pad_x - 30
    local val_y = ry + 8

    local d_val = newDraw("Text", {
        Text     = tostring(math.round(val)),
        Position = Vector2.new(val_x, val_y),
        Size     = LAYOUT.font_size_val,
        Color    = THEME.slider_val_text,
        Visible  = vis,
        ZIndex   = 18,
    })

    local track_x  = rx + LAYOUT.row_pad_x
    local track_y  = ry + LAYOUT.row_h - 14
    local track_w  = W - LAYOUT.row_pad_x * 2
    local track_h  = LAYOUT.slider_h

    local d_track_bg = newDraw("Square", {
        Position  = Vector2.new(track_x, track_y),
        Size      = Vector2.new(track_w, track_h),
        Color     = THEME.slider_track,
        Filled    = true,
        Visible   = vis,
        ZIndex    = 18,
    })

    local function getFillW()
        return math.max(LAYOUT.slider_thumb, (val - min) / (max - min) * track_w)
    end

    local d_track_fill = newDraw("Square", {
        Position  = Vector2.new(track_x, track_y),
        Size      = Vector2.new(getFillW(), track_h),
        Color     = THEME.slider_fill,
        Filled    = true,
        Visible   = vis,
        ZIndex    = 19,
    })

    local thumb_cx = track_x + getFillW()
    local thumb_cy = track_y + track_h / 2

    local d_thumb = newDraw("Circle", {
        Center    = Vector2.new(thumb_cx, thumb_cy),
        Radius    = LAYOUT.slider_thumb,
        Color     = THEME.slider_thumb,
        Filled    = true,
        Visible   = vis,
        ZIndex    = 20,
    })

    table.insert(row.drawings, d_val)
    table.insert(row.drawings, d_track_bg)
    table.insert(row.drawings, d_track_fill)
    table.insert(row.drawings, d_thumb)

    local function applyVal(v)
        val = math.clamp(v, min, max)
        local t = (val - min) / (max - min)
        local fw = math.max(LAYOUT.slider_thumb, t * track_w)
        d_val.Text = tostring(math.round(val))
        d_track_fill.Size = Vector2.new(fw, track_h)
        d_thumb.Center = Vector2.new(track_x + fw, thumb_cy)
        if callback then callback(math.round(val)) end
    end

    local dragging_slider = false
    local UIS = game:GetService("UserInputService")

    row._sl_begin = UIS.InputBegan:Connect(function(input)
        if not row.visible then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mx, my = input.Position.X, input.Position.Y
            local r = LAYOUT.slider_thumb
            local tcx = d_thumb.Center.X
            local tcy = d_thumb.Center.Y
            if math.abs(mx - tcx) <= r + 4 and math.abs(my - tcy) <= r + 4 then
                dragging_slider = true
            elseif mx >= track_x and mx <= track_x + track_w
                and my >= track_y - 6 and my <= track_y + track_h + 6 then
                local t = (mx - track_x) / track_w
                applyVal(min + t * (max - min))
                dragging_slider = true
            end
        end
    end)
    row._sl_move = UIS.InputChanged:Connect(function(input)
        if not row.visible then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging_slider then
            local mx = input.Position.X
            local t  = math.clamp((mx - track_x) / track_w, 0, 1)
            applyVal(min + t * (max - min))
        end
    end)
    row._sl_end = UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging_slider = false
        end
    end)

    row.SetValue = applyVal
    row.GetValue = function() return val end
    return row
end

function UILibrary:Dropdown(text, options, callback)
    local tab = self
    local row = newRow(tab, "dropdown")
    row.d_label.Text = text

    local selected = options[1] or ""
    local open     = false
    local rx  = row.rx
    local ry  = row.ry
    local W   = tab.win._W
    local vis = row.visible

    local d_val = newDraw("Text", {
        Text     = selected,
        Position = Vector2.new(rx + W - LAYOUT.row_pad_x - 20, ry + LAYOUT.row_h / 2 - 5),
        Size     = LAYOUT.font_size_val,
        Color    = THEME.dropdown_val,
        Visible  = vis,
        ZIndex   = 18,
    })
    local d_arrow = newDraw("Text", {
        Text     = "<",
        Position = Vector2.new(rx + W - LAYOUT.row_pad_x - 8, ry + LAYOUT.row_h / 2 - 5),
        Size     = LAYOUT.font_size_val,
        Color    = THEME.dropdown_arrow,
        Visible  = vis,
        ZIndex   = 18,
    })

    table.insert(row.drawings, d_val)
    table.insert(row.drawings, d_arrow)

    local menu_items = {}
    for i, opt in ipairs(options) do
        local item_y = ry + LAYOUT.row_h + (i - 1) * 28

        local d_item_bg = newDraw("Square", {
            Position = Vector2.new(rx + LAYOUT.row_pad_x, item_y),
            Size     = Vector2.new(W - LAYOUT.row_pad_x * 2, 26),
            Color    = THEME.dropdown_menu_bg,
            Filled   = true,
            Visible  = false,
            ZIndex   = 30,
        })
        local d_item_txt = newDraw("Text", {
            Text     = opt,
            Position = Vector2.new(rx + LAYOUT.row_pad_x + 8, item_y + 6),
            Size     = LAYOUT.font_size_val,
            Color    = (opt == selected) and THEME.dropdown_sel or THEME.dropdown_item,
            Visible  = false,
            ZIndex   = 31,
        })
        d_item_bg._base_visible = false
        d_item_txt._base_visible = false
        table.insert(row.drawings, d_item_bg)
        table.insert(row.drawings, d_item_txt)
        table.insert(menu_items, {bg=d_item_bg, txt=d_item_txt, val=opt, iy=item_y})
    end

    local function closeMenu()
        open = false
        d_arrow.Text = "<"
        for _, item in ipairs(menu_items) do
            item.bg.Visible  = false
            item.txt.Visible = false
        end
    end

    local function openMenu()
        open = true
        d_arrow.Text = "v"
        for _, item in ipairs(menu_items) do
            item.bg.Visible  = row.visible
            item.txt.Visible = row.visible
        end
    end

    local UIS = game:GetService("UserInputService")
    row._dd_conn = UIS.InputBegan:Connect(function(input)
        if not row.visible then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mx, my = input.Position.X, input.Position.Y

            if open then
                for _, item in ipairs(menu_items) do
                    if mx >= rx + LAYOUT.row_pad_x and mx <= rx + W - LAYOUT.row_pad_x
                        and my >= item.iy and my <= item.iy + 26 then
                        selected = item.val
                        d_val.Text = selected
                        for _, it2 in ipairs(menu_items) do
                            it2.txt.Color = (it2.val == selected) and THEME.dropdown_sel or THEME.dropdown_item
                        end
                        closeMenu()
                        if callback then callback(selected) end
                        return
                    end
                end
                closeMenu()
            else
                if mx >= rx and mx <= rx + W and my >= ry and my <= ry + LAYOUT.row_h then
                    openMenu()
                end
            end
        end
    end)

    row.SetValue  = function(v) selected = v; d_val.Text = v end
    row.GetValue  = function() return selected end
    return row
end

function UILibrary:Colorpicker(text, default, callback)
    local tab = self
    local row = newRow(tab, "colorpicker")
    row.d_label.Text = text

    local color = default or Color3.fromRGB(255, 0, 0)
    local rx  = row.rx
    local ry  = row.ry
    local W   = tab.win._W
    local vis = row.visible

    local sw_w, sw_h = 26, 20
    local sw_x = rx + W - LAYOUT.row_pad_x - sw_w
    local sw_y = ry + (LAYOUT.row_h - sw_h) / 2

    local d_swatch = newDraw("Square", {
        Position = Vector2.new(sw_x, sw_y),
        Size     = Vector2.new(sw_w, sw_h),
        Color    = color,
        Filled   = true,
        Visible  = vis,
        ZIndex   = 18,
    })
    local d_swatch_border = newDraw("Square", {
        Position  = Vector2.new(sw_x, sw_y),
        Size      = Vector2.new(sw_w, sw_h),
        Color     = THEME.picker_border,
        Filled    = false,
        Thickness = 1,
        Visible   = vis,
        ZIndex    = 19,
    })
    local d_hex = newDraw("Text", {
        Text     = colorToHex(color),
        Position = Vector2.new(sw_x - 48, ry + LAYOUT.row_h / 2 - 5),
        Size     = 10,
        Color    = THEME.hint_text,
        Visible  = vis,
        ZIndex   = 18,
    })

    table.insert(row.drawings, d_swatch)
    table.insert(row.drawings, d_swatch_border)
    table.insert(row.drawings, d_hex)

    local presets = {
        Color3.fromRGB(124,106,247),
        Color3.fromRGB(255,0,0),
        Color3.fromRGB(0,255,0),
        Color3.fromRGB(0,0,255),
        Color3.fromRGB(255,165,0),
        Color3.fromRGB(255,255,255),
        Color3.fromRGB(255,20,147),
        Color3.fromRGB(0,255,255),
    }
    local preset_idx = 1

    local UIS = game:GetService("UserInputService")
    row._cp_conn = UIS.InputBegan:Connect(function(input)
        if not row.visible then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mx, my = input.Position.X, input.Position.Y
            if mx >= sw_x and mx <= sw_x + sw_w and my >= sw_y and my <= sw_y + sw_h then
                preset_idx = (preset_idx % #presets) + 1
                color = presets[preset_idx]
                d_swatch.Color = color
                d_hex.Text = colorToHex(color)
                if callback then callback(color) end
            end
        end
    end)

    row.SetColor = function(c)
        color = c
        d_swatch.Color = c
        d_hex.Text = colorToHex(c)
    end
    row.GetColor = function() return color end
    return row
end

return UILibrary
