local UIS = game:GetService("UserInputService")

local T = {
    win_bg         = Color3.fromRGB(26,  26,  26 ),
    bar_bg         = Color3.fromRGB(20,  20,  20 ),
    bar_border     = Color3.fromRGB(45,  45,  45 ),
    tab_bg         = Color3.fromRGB(22,  22,  22 ),
    tab_active_bg  = Color3.fromRGB(26,  26,  26 ),
    tab_txt        = Color3.fromRGB(100, 100, 100),
    tab_active_txt = Color3.fromRGB(210, 210, 210),
    tab_border     = Color3.fromRGB(38,  38,  38 ),
    accent         = Color3.fromRGB(124, 106, 247),
    row_bg         = Color3.fromRGB(30,  30,  30 ),
    row_border     = Color3.fromRGB(40,  40,  40 ),
    row_txt        = Color3.fromRGB(185, 185, 185),
    lbl_txt        = Color3.fromRGB(124, 106, 247),
    lbl_bg         = Color3.fromRGB(23,  23,  23 ),
    tog_off        = Color3.fromRGB(55,  55,  55 ),
    tog_on         = Color3.fromRGB(124, 106, 247),
    tog_off_thumb  = Color3.fromRGB(130, 130, 130),
    tog_on_thumb   = Color3.fromRGB(255, 255, 255),
    tog_border     = Color3.fromRGB(70,  70,  70 ),
    sl_track       = Color3.fromRGB(50,  50,  50 ),
    sl_fill        = Color3.fromRGB(124, 106, 247),
    sl_val         = Color3.fromRGB(124, 106, 247),
    dd_val         = Color3.fromRGB(130, 130, 130),
    dd_arrow       = Color3.fromRGB(100, 100, 100),
    dd_menu_bg     = Color3.fromRGB(36,  36,  36 ),
    dd_item        = Color3.fromRGB(165, 165, 165),
    dd_sel         = Color3.fromRGB(124, 106, 247),
    btn_bg         = Color3.fromRGB(40,  40,  40 ),
    btn_hover      = Color3.fromRGB(55,  55,  55 ),
    btn_border     = Color3.fromRGB(62,  62,  62 ),
    btn_txt        = Color3.fromRGB(195, 195, 195),
    sw_border      = Color3.fromRGB(70,  70,  70 ),
    hint           = Color3.fromRGB(100, 100, 100),
    badge_bg       = Color3.fromRGB(32,  32,  32 ),
    badge_border   = Color3.fromRGB(55,  55,  55 ),
    badge_txt      = Color3.fromRGB(85,  85,  85 ),
    outline        = Color3.fromRGB(50,  50,  50 ),
}

local L = {
    W         = 400,
    title_h   = 32,
    tab_h     = 28,
    row_h     = 40,
    lbl_h     = 26,
    pad       = 12,
    tog_w     = 34,
    tog_h     = 18,
    tog_r     = 7,
    sl_h      = 4,
    sl_r      = 7,
    btn_h     = 24,
    btn_w     = 88,
    sw_w      = 24,
    sw_h      = 18,
    fs_title  = 11,
    fs_tab    = 11,
    fs_row    = 12,
    fs_val    = 11,
    fs_lbl    = 10,
    fs_hint   = 10,
    max_rows  = 9,
}

local function D(class, props)
    local ok, obj = pcall(Drawing.new, class)
    if not ok then return {} end
    for k, v in pairs(props) do
        pcall(function() obj[k] = v end)
    end
    return obj
end

local function hexStr(c)
    return string.format("#%02x%02x%02x",
        math.clamp(math.round(c.R*255),0,255),
        math.clamp(math.round(c.G*255),0,255),
        math.clamp(math.round(c.B*255),0,255))
end

local function mv2(obj, field, dx, dy)
    pcall(function()
        local p = obj[field]
        obj[field] = Vector2.new(p.X+dx, p.Y+dy)
    end)
end
local function mln(obj, dx, dy)
    pcall(function()
        obj.From = Vector2.new(obj.From.X+dx, obj.From.Y+dy)
        obj.To   = Vector2.new(obj.To.X+dx,   obj.To.Y+dy)
    end)
end

local Lib = {}
Lib.__index = Lib

function Lib:Window(title, keybind)
    local W_ = L.W
    local body_h = L.row_h * L.max_rows

    local win = {
        title      = title,
        keybind    = keybind or "RightBracket",
        visible    = true,
        tabs       = {},
        active_tab = nil,
        x          = 60,
        y          = 60,
        _body_y    = 60 + L.title_h + L.tab_h,
        _body_h    = body_h,
        _dragging  = false,
        _dx        = 0,
        _dy        = 0,
        _conns     = {},
        _d         = {},
    }

    local function wy() return win.y end
    local total_h = L.title_h + L.tab_h + body_h

    -- Window background + outline
    win._d.win_bg   = D("Square",{Position=Vector2.new(win.x,win.y),Size=Vector2.new(W_,total_h),Color=T.win_bg,Filled=true,Visible=true,ZIndex=1})
    win._d.outline  = D("Square",{Position=Vector2.new(win.x,win.y),Size=Vector2.new(W_,total_h),Color=T.outline,Filled=false,Thickness=1,Visible=true,ZIndex=25})

    -- Titlebar
    win._d.title_bg  = D("Square",{Position=Vector2.new(win.x,win.y),Size=Vector2.new(W_,L.title_h),Color=T.bar_bg,Filled=true,Visible=true,ZIndex=2})
    win._d.title_bdr = D("Line",  {From=Vector2.new(win.x,win.y+L.title_h),To=Vector2.new(win.x+W_,win.y+L.title_h),Color=T.bar_border,Thickness=1,Visible=true,ZIndex=3})
    win._d.title_txt = D("Text",  {Text=title,Position=Vector2.new(win.x+L.pad, win.y+L.title_h/2 - L.fs_title/2),Size=L.fs_title,Color=T.tab_txt,Visible=true,ZIndex=4})

    -- Keybind badge (top-right)
    local bx = win.x + W_ - 26
    local by = win.y + 7
    win._d.badge_bg  = D("Square",{Position=Vector2.new(bx,by),Size=Vector2.new(18,18),Color=T.badge_bg,Filled=true,Visible=true,ZIndex=3})
    win._d.badge_bdr = D("Square",{Position=Vector2.new(bx,by),Size=Vector2.new(18,18),Color=T.badge_border,Filled=false,Thickness=1,Visible=true,ZIndex=4})
    win._d.badge_txt = D("Text",  {Text=(keybind or "P"):sub(1,1):upper(),Position=Vector2.new(bx+9,by+4),Size=9,Color=T.badge_txt,Centered=true,Visible=true,ZIndex=5})

    -- Tab bar
    local tby = win.y + L.title_h
    win._d.tab_bg  = D("Square",{Position=Vector2.new(win.x,tby),Size=Vector2.new(W_,L.tab_h),Color=T.tab_bg,Filled=true,Visible=true,ZIndex=2})
    win._d.tab_bdr = D("Line",  {From=Vector2.new(win.x,tby+L.tab_h),To=Vector2.new(win.x+W_,tby+L.tab_h),Color=T.tab_border,Thickness=1,Visible=true,ZIndex=3})

    -- Body background
    win._d.body_bg = D("Square",{Position=Vector2.new(win.x,win._body_y),Size=Vector2.new(W_,body_h),Color=T.win_bg,Filled=true,Visible=true,ZIndex=1})

    local function onBegin(input)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
        local mx,my = input.Position.X, input.Position.Y
        if mx>=win.x and mx<=win.x+W_ and my>=win.y and my<=win.y+L.title_h then
            win._dragging = true
            win._dx = mx - win.x
            win._dy = my - win.y
        end
    end
    local function onMove(input)
        if not win._dragging then return end
        if input.UserInputType ~= Enum.UserInputType.MouseMovement then return end
        win:_move(input.Position.X - win._dx, input.Position.Y - win._dy)
    end
    local function onEnd(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            win._dragging = false
        end
    end
    local function onKey(input, gpe)
        if gpe then return end
        local ok, kc = pcall(function() return Enum.KeyCode[win.keybind] end)
        if ok and input.KeyCode == kc then win:_toggleVis() end
    end

    table.insert(win._conns, UIS.InputBegan:Connect(onBegin))
    table.insert(win._conns, UIS.InputChanged:Connect(onMove))
    table.insert(win._conns, UIS.InputEnded:Connect(onEnd))
    table.insert(win._conns, UIS.InputBegan:Connect(onKey))

    setmetatable(win, {__index = Lib})
    return win
end

function Lib:_toggleVis()
    self.visible = not self.visible
    local v = self.visible
    for _, obj in pairs(self._d) do
        pcall(function() obj.Visible = v end)
    end
    for _, tab in ipairs(self.tabs) do
        local active = (tab == self.active_tab)
        pcall(function() tab._d.bg.Visible      = v end)
        pcall(function() tab._d.txt.Visible     = v end)
        pcall(function() tab._d.accent.Visible  = v and active end)
        pcall(function() tab._d.divider.Visible = v end)
        for _, row in ipairs(tab.rows) do
            row:_show(v and active)
        end
    end
end

function Lib:_move(nx, ny)
    local dx = nx - self.x
    local dy = ny - self.y
    self.x = nx
    self.y = ny
    self._body_y = self._body_y + dy

    for _, obj in pairs(self._d) do
        pcall(function() if obj.Position then mv2(obj,"Position",dx,dy) end end)
        pcall(function() if obj.From     then mln(obj,dx,dy)            end end)
    end
    for _, tab in ipairs(self.tabs) do
        tab:_shift(dx, dy)
    end
    self:_layoutTabs()
end

function Lib:_layoutTabs()
    local n = #self.tabs
    if n == 0 then return end
    local W_ = L.W
    local tw  = math.floor(W_ / n)
    local tby = self.y + L.title_h

    for i, tab in ipairs(self.tabs) do
        local tx = self.x + (i-1)*tw
        local is = (tab == self.active_tab)

        pcall(function()
            tab._d.bg.Position = Vector2.new(tx, tby)
            tab._d.bg.Size     = Vector2.new(tw, L.tab_h)
            tab._d.bg.Color    = is and T.tab_active_bg or T.tab_bg
        end)
        pcall(function()
            tab._d.txt.Position = Vector2.new(tx + tw/2, tby + L.tab_h/2 - L.fs_tab/2)
            tab._d.txt.Color    = is and T.tab_active_txt or T.tab_txt
        end)
        pcall(function()
            tab._d.accent.From    = Vector2.new(tx+4, tby+L.tab_h-1)
            tab._d.accent.To      = Vector2.new(tx+tw-4, tby+L.tab_h-1)
            tab._d.accent.Visible = is and self.visible
        end)
        pcall(function()
            tab._d.divider.From    = Vector2.new(tx+tw, tby+4)
            tab._d.divider.To      = Vector2.new(tx+tw, tby+L.tab_h-4)
            tab._d.divider.Visible = (i < n) and self.visible
        end)

        tab._tx = tx
        tab._tw = tw
    end
end

function Lib:_switchTab(tab)
    if self.active_tab == tab then return end
    for _, row in ipairs(self.active_tab.rows) do row:_show(false) end
    self.active_tab = tab
    self:_layoutTabs()
    for _, row in ipairs(tab.rows) do row:_show(true) end
end

function Lib:Tab(name)
    local win = self
    local tab = {
        name   = name,
        win    = win,
        rows   = {},
        _tx    = 0,
        _tw    = 0,
        _cur_y = win._body_y,
        _d     = {},
    }

    tab._d.bg     = D("Square",{Position=Vector2.new(0,0),Size=Vector2.new(50,L.tab_h),Color=T.tab_bg,Filled=true,Visible=true,ZIndex=3})
    tab._d.txt    = D("Text",  {Text=name,Position=Vector2.new(0,0),Size=L.fs_tab,Color=T.tab_txt,Centered=true,Visible=true,ZIndex=5})
    tab._d.accent = D("Line",  {From=Vector2.new(0,0),To=Vector2.new(10,0),Color=T.accent,Thickness=2,Visible=false,ZIndex=6})
    tab._d.divider= D("Line",  {From=Vector2.new(0,0),To=Vector2.new(0,10),Color=T.tab_border,Thickness=1,Visible=false,ZIndex=4})

    table.insert(win.tabs, tab)
    if #win.tabs == 1 then win.active_tab = tab end
    win:_layoutTabs()

    if #win.tabs > 1 then
    end

    local c = UIS.InputBegan:Connect(function(input)
        if not win.visible then return end
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
        local mx,my = input.Position.X, input.Position.Y
        local tby = win.y + L.title_h
        if mx >= tab._tx and mx <= tab._tx + tab._tw
            and my >= tby and my <= tby + L.tab_h then
            win:_switchTab(tab)
        end
    end)
    table.insert(win._conns, c)

    function tab:_shift(dx, dy)
        self._cur_y = self._cur_y + dy
        for _, row in ipairs(self.rows) do row:_shift(dx, dy) end
    end

    setmetatable(tab, {__index = Lib})
    return tab
end

local function makeRow(tab, h)
    local win = tab.win
    local W_  = L.W
    local rx  = win.x
    local ry  = tab._cur_y
    local vis = (tab == win.active_tab)

    local row = {
        _win   = win,
        _tab   = tab,
        _rx    = rx,
        _ry    = ry,
        _h     = h,
        _vis   = vis,
        _extra = {},
    }

    row._bg  = D("Square",{Position=Vector2.new(rx,ry),Size=Vector2.new(W_,h),Color=T.row_bg,Filled=true,Visible=vis,ZIndex=6})
    row._sep = D("Line",  {From=Vector2.new(rx,ry+h),To=Vector2.new(rx+W_,ry+h),Color=T.row_border,Thickness=1,Visible=vis,ZIndex=7})
    row._lbl = D("Text",  {Text="",Position=Vector2.new(rx+L.pad, ry + h/2 - L.fs_row/2),Size=L.fs_row,Color=T.row_txt,Visible=vis,ZIndex=8})

    function row:_show(v)
        self._vis = v
        pcall(function() self._bg.Visible  = v end)
        pcall(function() self._sep.Visible = v end)
        pcall(function() self._lbl.Visible = v end)
        for _, e in ipairs(self._extra) do
            if not e._forcehide then
                pcall(function() e.Visible = v end)
            end
        end
    end

    function row:_shift(dx, dy)
        self._rx = self._rx + dx
        self._ry = self._ry + dy
        pcall(function() mv2(self._bg,  "Position", dx, dy) end)
        pcall(function() mln(self._sep, dx, dy) end)
        pcall(function() mv2(self._lbl, "Position", dx, dy) end)
        for _, e in ipairs(self._extra) do
            pcall(function() if e.Position then mv2(e,"Position",dx,dy) end end)
            pcall(function() if e.From     then mln(e,dx,dy)            end end)
            pcall(function() if e.Center   then
                local c = e.Center
                e.Center = Vector2.new(c.X+dx, c.Y+dy)
            end end)
        end
    end

    function row:_addE(obj, forcehide)
        obj._forcehide = forcehide or false
        table.insert(self._extra, obj)
        return obj
    end

    tab._cur_y = tab._cur_y + h
    table.insert(tab.rows, row)
    return row, rx, ry, W_, vis
end

function Lib:Label(text)
    local tab = self
    local win = tab.win
    local W_  = L.W
    local rx  = win.x
    local ry  = tab._cur_y
    local vis = (tab == win.active_tab)
    local h   = L.lbl_h

    local row = {
        _win   = win,
        _tab   = tab,
        _rx    = rx,
        _ry    = ry,
        _h     = h,
        _vis   = vis,
        _extra = {},
    }

    row._bg  = D("Square",{Position=Vector2.new(rx,ry),Size=Vector2.new(W_,h),Color=T.lbl_bg,Filled=true,Visible=vis,ZIndex=6})
    row._sep = D("Line",  {From=Vector2.new(rx,ry+h),To=Vector2.new(rx+W_,ry+h),Color=T.bar_border,Thickness=1,Visible=vis,ZIndex=7})
    row._lbl = D("Text",  {Text=text,Position=Vector2.new(rx+L.pad, ry + h/2 - L.fs_lbl/2),Size=L.fs_lbl,Color=T.lbl_txt,Visible=vis,ZIndex=8})

    function row:_show(v)
        self._vis = v
        pcall(function() self._bg.Visible  = v end)
        pcall(function() self._sep.Visible = v end)
        pcall(function() self._lbl.Visible = v end)
    end
    function row:_shift(dx, dy)
        self._rx=self._rx+dx; self._ry=self._ry+dy
        pcall(function() mv2(self._bg,  "Position",dx,dy) end)
        pcall(function() mln(self._sep, dx,dy) end)
        pcall(function() mv2(self._lbl, "Position",dx,dy) end)
    end

    tab._cur_y = tab._cur_y + h
    table.insert(tab.rows, row)
    return row
end

function Lib:Button(label, btnText, callback)
    if type(btnText) == "function" then
        callback = btnText; btnText = label
    end
    local row, rx, ry, W_, vis = makeRow(self, L.row_h)
    row._lbl.Text = label

    local bx = rx + W_ - L.pad - L.btn_w
    local by = ry + (L.row_h - L.btn_h) / 2

    local dbg  = row:_addE(D("Square",{Position=Vector2.new(bx,by),Size=Vector2.new(L.btn_w,L.btn_h),Color=T.btn_bg,Filled=true,Visible=vis,ZIndex=9}))
    local dbdr = row:_addE(D("Square",{Position=Vector2.new(bx,by),Size=Vector2.new(L.btn_w,L.btn_h),Color=T.btn_border,Filled=false,Thickness=1,Visible=vis,ZIndex=10}))
    local dtxt = row:_addE(D("Text",  {Text=btnText,Position=Vector2.new(bx+L.btn_w/2, by+L.btn_h/2-L.fs_val/2),Size=L.fs_val,Color=T.btn_txt,Centered=true,Visible=vis,ZIndex=11}))

    local c = UIS.InputBegan:Connect(function(input)
        if not row._vis then return end
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
        local mx,my = input.Position.X, input.Position.Y
        if mx>=bx and mx<=bx+L.btn_w and my>=by and my<=by+L.btn_h then
            dbg.Color = T.btn_hover
            if callback then task.spawn(callback) end
            task.delay(0.15, function() pcall(function() dbg.Color = T.btn_bg end) end)
        end
    end)
    table.insert(self.win._conns, c)
    return row
end

function Lib:Toggle(label, default, callback)
    local row, rx, ry, W_, vis = makeRow(self, L.row_h)
    row._lbl.Text = label

    local state = (default == true)

    local tx = rx + W_ - L.pad - L.tog_w
    local ty = ry + (L.row_h - L.tog_h) / 2
    local cy = math.floor(ty + L.tog_h / 2)

    local toff_cx = tx + L.tog_r + 2
    local ton_cx  = tx + L.tog_w - L.tog_r - 2

    local dtrack = row:_addE(D("Square",{Position=Vector2.new(tx,ty),Size=Vector2.new(L.tog_w,L.tog_h),Color=state and T.tog_on or T.tog_off,Filled=true,Visible=vis,ZIndex=9}))
    local dtbdr  = row:_addE(D("Square",{Position=Vector2.new(tx,ty),Size=Vector2.new(L.tog_w,L.tog_h),Color=T.tog_border,Filled=false,Thickness=1,Visible=vis,ZIndex=10}))
    local dthumb = row:_addE(D("Circle",{Center=Vector2.new(state and ton_cx or toff_cx, cy),Radius=L.tog_r,Color=state and T.tog_on_thumb or T.tog_off_thumb,Filled=true,Visible=vis,ZIndex=11}))

    local function apply(s)
        state = s
        pcall(function() dtrack.Color = s and T.tog_on or T.tog_off end)
        pcall(function() dthumb.Color = s and T.tog_on_thumb or T.tog_off_thumb end)
        pcall(function() dthumb.Center = Vector2.new(s and ton_cx or toff_cx, cy) end)
        if callback then task.spawn(callback, s) end
    end

    local c = UIS.InputBegan:Connect(function(input)
        if not row._vis then return end
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
        local mx,my = input.Position.X, input.Position.Y
        if mx>=tx and mx<=tx+L.tog_w and my>=ty and my<=ty+L.tog_h then
            apply(not state)
        end
    end)
    table.insert(self.win._conns, c)

    row.Set = function(s) apply(s) end
    row.Get = function() return state end
    return row
end

function Lib:Slider(label, min, max, default, callback)
    local row, rx, ry, W_, vis = makeRow(self, L.row_h)

    row._lbl.Text     = label
    row._lbl.Position = Vector2.new(rx+L.pad, ry+8)

    local val = math.clamp(default or min, min, max)

    local dval = row:_addE(D("Text",{
        Text=tostring(math.round(val)),
        Position=Vector2.new(rx+W_-L.pad, ry+8),
        Size=L.fs_val, Color=T.sl_val, Visible=vis, ZIndex=9
    }))

    local trx = rx + L.pad
    local try = ry + L.row_h - 14
    local trw = W_ - L.pad*2

    local dtrk = row:_addE(D("Square",{Position=Vector2.new(trx,try),Size=Vector2.new(trw,L.sl_h),Color=T.sl_track,Filled=true,Visible=vis,ZIndex=9}))

    local function fw() return math.max(L.sl_r, (val-min)/(max-min)*trw) end

    local dfill = row:_addE(D("Square",{Position=Vector2.new(trx,try),Size=Vector2.new(fw(),L.sl_h),Color=T.sl_fill,Filled=true,Visible=vis,ZIndex=10}))
    local dthumb= row:_addE(D("Circle",{Center=Vector2.new(trx+fw(), try+L.sl_h/2),Radius=L.sl_r,Color=T.sl_fill,Filled=true,Visible=vis,ZIndex=11}))

    local function applyVal(v)
        val = math.clamp(v, min, max)
        local f = fw()
        pcall(function() dval.Text       = tostring(math.round(val)) end)
        pcall(function() dfill.Size      = Vector2.new(f, L.sl_h) end)
        pcall(function() dthumb.Center   = Vector2.new(trx+f, try+L.sl_h/2) end)
        if callback then task.spawn(callback, math.round(val)) end
    end

    local dragging = false
    local c1 = UIS.InputBegan:Connect(function(input)
        if not row._vis then return end
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
        local mx,my = input.Position.X, input.Position.Y
        if mx>=trx and mx<=trx+trw and my>=try-8 and my<=try+L.sl_h+8 then
            dragging = true
            applyVal(min + math.clamp((mx-trx)/trw,0,1)*(max-min))
        end
    end)
    local c2 = UIS.InputChanged:Connect(function(input)
        if not row._vis or not dragging then return end
        if input.UserInputType ~= Enum.UserInputType.MouseMovement then return end
        applyVal(min + math.clamp((input.Position.X-trx)/trw,0,1)*(max-min))
    end)
    local c3 = UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging=false end
    end)
    table.insert(self.win._conns, c1)
    table.insert(self.win._conns, c2)
    table.insert(self.win._conns, c3)

    row.Set = function(v) applyVal(v) end
    row.Get = function() return val end
    return row
end

function Lib:Dropdown(label, options, callback)
    local row, rx, ry, W_, vis = makeRow(self, L.row_h)
    row._lbl.Text = label

    local selected = options[1] or ""
    local open = false

    local dval   = row:_addE(D("Text",{Text=selected,Position=Vector2.new(rx+W_-L.pad-16, ry+L.row_h/2-L.fs_val/2),Size=L.fs_val,Color=T.dd_val,Visible=vis,ZIndex=9}))
    local darrow = row:_addE(D("Text",{Text="<",Position=Vector2.new(rx+W_-L.pad-3, ry+L.row_h/2-L.fs_val/2),Size=L.fs_val,Color=T.dd_arrow,Visible=vis,ZIndex=9}))

    local items = {}
    for i, opt in ipairs(options) do
        local iy  = ry + L.row_h + (i-1)*26
        local ibg = row:_addE(D("Square",{Position=Vector2.new(rx+L.pad,iy),Size=Vector2.new(W_-L.pad*2,24),Color=T.dd_menu_bg,Filled=true,Visible=false,ZIndex=20}), true)
        local ibdr= row:_addE(D("Square",{Position=Vector2.new(rx+L.pad,iy),Size=Vector2.new(W_-L.pad*2,24),Color=T.outline,Filled=false,Thickness=1,Visible=false,ZIndex=21}), true)
        local itxt= row:_addE(D("Text",  {Text=opt,Position=Vector2.new(rx+L.pad*2, iy+6),Size=L.fs_val,Color=(opt==selected) and T.dd_sel or T.dd_item,Visible=false,ZIndex=22}), true)
        table.insert(items, {bg=ibg,bdr=ibdr,txt=itxt,val=opt,iy=iy})
    end

    local function closeMenu()
        open=false; darrow.Text="<"
        for _,it in ipairs(items) do
            pcall(function() it.bg.Visible=false; it.bdr.Visible=false; it.txt.Visible=false end)
        end
    end
    local function openMenu()
        open=true; darrow.Text="v"
        for _,it in ipairs(items) do
            pcall(function() it.bg.Visible=row._vis; it.bdr.Visible=row._vis; it.txt.Visible=row._vis end)
        end
    end

    local c = UIS.InputBegan:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
        local mx,my = input.Position.X, input.Position.Y
        if open then
            local hit = false
            for _,it in ipairs(items) do
                if mx>=rx+L.pad and mx<=rx+W_-L.pad and my>=it.iy and my<=it.iy+24 then
                    selected=it.val
                    pcall(function() dval.Text=selected end)
                    for _,it2 in ipairs(items) do
                        pcall(function() it2.txt.Color=(it2.val==selected) and T.dd_sel or T.dd_item end)
                    end
                    closeMenu()
                    if callback then task.spawn(callback,selected) end
                    hit=true; break
                end
            end
            if not hit then closeMenu() end
        else
            if not row._vis then return end
            if mx>=rx and mx<=rx+W_ and my>=ry and my<=ry+L.row_h then openMenu() end
        end
    end)
    table.insert(self.win._conns, c)

    row.Set = function(v) selected=v; pcall(function() dval.Text=v end) end
    row.Get = function() return selected end
    return row
end

function Lib:Colorpicker(label, default, callback)
    local row, rx, ry, W_, vis = makeRow(self, L.row_h)
    row._lbl.Text = label

    local color = default or Color3.fromRGB(255,0,0)
    local sx = rx + W_ - L.pad - L.sw_w
    local sy = ry + (L.row_h - L.sw_h)/2

    local dsw  = row:_addE(D("Square",{Position=Vector2.new(sx,sy),Size=Vector2.new(L.sw_w,L.sw_h),Color=color,Filled=true,Visible=vis,ZIndex=9}))
    local dsbdr= row:_addE(D("Square",{Position=Vector2.new(sx,sy),Size=Vector2.new(L.sw_w,L.sw_h),Color=T.sw_border,Filled=false,Thickness=1,Visible=vis,ZIndex=10}))
    local dhex = row:_addE(D("Text",  {Text=hexStr(color),Position=Vector2.new(sx-52, ry+L.row_h/2-L.fs_hint/2),Size=L.fs_hint,Color=T.hint,Visible=vis,ZIndex=9}))

    local presets = {
        Color3.fromRGB(124,106,247), Color3.fromRGB(230,50,50),
        Color3.fromRGB(50,200,80),   Color3.fromRGB(50,140,255),
        Color3.fromRGB(255,160,0),   Color3.fromRGB(255,20,147),
        Color3.fromRGB(0,220,220),   Color3.fromRGB(240,240,240),
    }
    local pidx = 1

    local c = UIS.InputBegan:Connect(function(input)
        if not row._vis then return end
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
        local mx,my = input.Position.X, input.Position.Y
        if mx>=sx and mx<=sx+L.sw_w and my>=sy and my<=sy+L.sw_h then
            pidx = pidx % #presets + 1
            color = presets[pidx]
            pcall(function() dsw.Color = color; dhex.Text = hexStr(color) end)
            if callback then task.spawn(callback, color) end
        end
    end)
    table.insert(self.win._conns, c)

    row.Set = function(c2) color=c2; pcall(function() dsw.Color=c2; dhex.Text=hexStr(c2) end) end
    row.Get = function() return color end
    return row
end

function Lib:Destroy()
    for _, c in ipairs(self._conns) do pcall(function() c:Disconnect() end) end
    Drawing.Clear()
end

return Lib
