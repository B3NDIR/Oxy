-- Oxy UI Library (Rayfield-like starter)
-- Autor: Ty :)
-- Wystarczy wrzucić do GitHub i ładować przez loadstring()

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Oxy = {}
Oxy.__index = Oxy

-- Helpers
local function create(class, props, children)
    local inst = Instance.new(class)
    for k,v in pairs(props or {}) do inst[k] = v end
    for _,c in ipairs(children or {}) do c.Parent = inst end
    return inst
end

local function tween(obj, props, time)
    TweenService:Create(obj, TweenInfo.new(time or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end

local Themes = {
    Dark = {
        BG = Color3.fromRGB(22,24,28),
        Panel = Color3.fromRGB(28,30,36),
        Accent = Color3.fromRGB(90,130,255),
        Text = Color3.fromRGB(235,238,245),
        Stroke = Color3.fromRGB(60,64,72),
    }
}

-- Główne okno
function Oxy:CreateWindow(opts)
    opts = opts or {}
    local theme = Themes[opts.Theme or "Dark"]

    local gui = create("ScreenGui", {Parent=PlayerGui, ResetOnSpawn=false, ZIndexBehavior=Enum.ZIndexBehavior.Global})
    local root = create("Frame", {
        Size = UDim2.fromOffset(560,360),
        Position = UDim2.fromScale(0.5,0.5),
        AnchorPoint = Vector2.new(0.5,0.5),
        BackgroundColor3 = theme.BG,
        BorderSizePixel = 0,
        Parent = gui
    }, {
        create("UICorner",{CornerRadius=UDim.new(0,12)}),
        create("UIStroke",{Color=theme.Stroke,Thickness=1})
    })

    -- Sidebar
    local sidebar = create("Frame", {
        Size = UDim2.new(0,140,1,0),
        BackgroundColor3 = theme.Panel,
        Parent = root
    }, {
        create("UICorner",{CornerRadius=UDim.new(0,12)}),
        create("UIStroke",{Color=theme.Stroke,Thickness=1})
    })

    local tabList = create("Frame",{BackgroundTransparency=1,Size=UDim2.new(1,0,1,0),Parent=sidebar},{
        create("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder, Padding=UDim.new(0,6)})
    })

    -- Content
    local content = create("Frame", {
        Size = UDim2.new(1,-150,1,0),
        Position = UDim2.fromOffset(150,0),
        BackgroundColor3 = theme.Panel,
        Parent = root
    }, {
        create("UICorner",{CornerRadius=UDim.new(0,12)}),
        create("UIStroke",{Color=theme.Stroke,Thickness=1})
    })

    local self = setmetatable({
        _gui = gui,
        _root = root,
        _theme = theme,
        _tabs = {},
        _content = content
    }, Oxy)

    -- Funkcja dodająca zakładki
    function self:AddTab(name)
        local btn = create("TextButton", {
            Text=name,
            Size=UDim2.new(1,-12,0,32),
            BackgroundColor3=theme.Panel,
            TextColor3=theme.Text,
            Font=Enum.Font.GothamSemibold,
            TextSize=14,
            Parent=tabList
        }, {
            create("UICorner",{CornerRadius=UDim.new(0,8)}),
            create("UIStroke",{Color=theme.Stroke,Thickness=1})
        })

        local frame = create("ScrollingFrame", {
            Size=UDim2.new(1,0,1,0),
            CanvasSize=UDim2.new(),
            ScrollBarThickness=4,
            BackgroundTransparency=1,
            Visible=false,
            Parent=content
        }, {
            create("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder, Padding=UDim.new(0,6)}),
            create("UIPadding",{PaddingTop=UDim.new(0,8),PaddingLeft=UDim.new(0,8),PaddingRight=UDim.new(0,8)})
        })

        local tab = {Button=btn,Frame=frame}

        btn.MouseButton1Click:Connect(function()
            for _,t in ipairs(self._tabs) do
                t.Frame.Visible=false
                tween(t.Button,{BackgroundColor3=theme.Panel},0.15)
            end
            frame.Visible=true
            tween(btn,{BackgroundColor3=theme.Accent},0.15)
        end)

        -- === Komponenty ===

        -- Button
        function tab:AddButton(opts)
            local b = create("TextButton", {
                Text=opts.Text,
                Size=UDim2.new(1,-16,0,32),
                BackgroundColor3=theme.Panel,
                TextColor3=theme.Text,
                Font=Enum.Font.Gotham,
                TextSize=14,
                Parent=frame
            }, {
                create("UICorner",{CornerRadius=UDim.new(0,8)}),
                create("UIStroke",{Color=theme.Stroke,Thickness=1})
            })
            b.MouseEnter:Connect(function() tween(b,{BackgroundColor3=theme.Stroke},0.12) end)
            b.MouseLeave:Connect(function() tween(b,{BackgroundColor3=theme.Panel},0.12) end)
            b.MouseButton1Click:Connect(function()
                if opts.Callback then opts.Callback() end
            end)
            return b
        end

        -- Toggle
        function tab:AddToggle(opts)
            local state = opts.Default or false
            local holder = create("Frame", {
                Size=UDim2.new(1,-16,0,32),
                BackgroundTransparency=1,
                Parent=frame
            })
            local bg = create("TextButton", {
                Size=UDim2.fromScale(1,1),
                BackgroundColor3=theme.Panel,
                Text="",
                Parent=holder
            }, {
                create("UICorner",{CornerRadius=UDim.new(0,8)}),
                create("UIStroke",{Color=theme.Stroke,Thickness=1})
            })
            local lbl = create("TextLabel", {
                Text=opts.Text,
                Font=Enum.Font.Gotham,
                TextSize=14,
                TextColor3=theme.Text,
                BackgroundTransparency=1,
                Size=UDim2.new(1,-50,1,0),
                Parent=bg
            })
            local knob = create("Frame", {
                Size=UDim2.fromOffset(36,20),
                Position=UDim2.new(1,-42,0.5,-10),
                BackgroundColor3=state and theme.Accent or theme.Stroke,
                Parent=bg
            }, {create("UICorner",{CornerRadius=UDim.new(1,0)})})
            local dot = create("Frame", {
                Size=UDim2.fromOffset(14,14),
                Position=state and UDim2.fromOffset(20,3) or UDim2.fromOffset(2,3),
                BackgroundColor3=Color3.new(1,1,1),
                Parent=knob
            }, {create("UICorner",{CornerRadius=UDim.new(1,0)})})

            local function setState(v)
                state=v
                tween(knob,{BackgroundColor3=v and theme.Accent or theme.Stroke},0.15)
                tween(dot,{Position=v and UDim2.fromOffset(20,3) or UDim2.fromOffset(2,3)},0.15)
                if opts.Callback then opts.Callback(state) end
            end

            bg.MouseButton1Click:Connect(function() setState(not state) end)

            return {Set=setState,Get=function() return state end}
        end

        table.insert(self._tabs, tab)
        if #self._tabs==1 then btn:Activate() end
        return tab
    end

    return self
end

return Oxy
