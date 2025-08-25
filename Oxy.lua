--[[
    Oxy UI Framework - Juju Live Edition
    Updated to match the screenshot layout
]]

local OxyLibrary = {}
OxyLibrary.Windows = {}
OxyLibrary.Tabs = {}

-- Create window based on screenshot layout
function OxyLibrary:CreateWindow(config)
    local title = config.Title or "juju live"

    -- Main GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "OxyUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = game:GetService("CoreGui")

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 500, 0, 400)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MainFrame

    -- Title bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 30)
    TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame

    local TitleText = Instance.new("TextLabel")
    TitleText.Size = UDim2.new(1, -40, 1, 0)
    TitleText.Position = UDim2.new(0, 10, 0, 0)
    TitleText.BackgroundTransparency = 1
    TitleText.Text = title
    TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleText.Font = Enum.Font.GothamBold
    TitleText.TextSize = 14
    TitleText.TextXAlignment = Enum.TextXAlignment.Left
    TitleText.Parent = TitleBar

    -- Close button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 30, 1, 0)
    CloseButton.Position = UDim2.new(1, -30, 0, 0)
    CloseButton.BackgroundTransparency = 1
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 14
    CloseButton.Parent = TitleBar

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- Tab buttons container
    local TabContainer = Instance.new("Frame")
    TabContainer.Size = UDim2.new(1, 0, 0, 30)
    TabContainer.Position = UDim2.new(0, 0, 0, 30)
    TabContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TabContainer.BorderSizePixel = 0
    TabContainer.Parent = MainFrame

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.Parent = TabContainer

    -- Content area
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, 0, 1, -60)
    ContentFrame.Position = UDim2.new(0, 0, 0, 60)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.ClipsDescendants = true
    ContentFrame.Parent = MainFrame

    -- Draggable functionality
    local dragging, dragInput, dragStart, startPos
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    TitleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)

    local Window = {}
    Window.Frame = MainFrame
    Window.ContentFrame = ContentFrame
    Window.Tabs = {}
    Window.CurrentTab = nil

    function Window:AddTab(name)
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(0, 80, 1, 0)
        TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        TabButton.BorderSizePixel = 0
        TabButton.Text = name
        TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabButton.Font = Enum.Font.Gotham
        TabButton.TextSize = 12
        TabButton.Parent = TabContainer

        local TabFrame = Instance.new("ScrollingFrame")
        TabFrame.Size = UDim2.new(1, 0, 1, 0)
        TabFrame.Position = UDim2.new(0, 0, 0, 0)
        TabFrame.BackgroundTransparency = 1
        TabFrame.Visible = false
        TabFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        TabFrame.ScrollBarThickness = 4
        TabFrame.Parent = ContentFrame

        local TabLayout = Instance.new("UIListLayout")
        TabLayout.Padding = UDim.new(0, 5)
        TabLayout.Parent = TabFrame

        local Tab = {
            Name = name,
            Button = TabButton,
            Frame = TabFrame
        }

        TabButton.MouseButton1Click:Connect(function()
            if Window.CurrentTab then
                Window.CurrentTab.Frame.Visible = false
                Window.CurrentTab.Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            end
            
            TabFrame.Visible = true
            TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Window.CurrentTab = Tab
        end)

        table.insert(self.Tabs, Tab)
        
        -- Set first tab as active by default
        if #self.Tabs == 1 then
            TabFrame.Visible = true
            TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Window.CurrentTab = Tab
        end
        
        return Tab
    end

    function Window:AddSection(tab, name)
        local SectionFrame = Instance.new("Frame")
        SectionFrame.Size = UDim2.new(1, -20, 0, 30)
        SectionFrame.Position = UDim2.new(0, 10, 0, #tab.Frame:GetChildren() * 35)
        SectionFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        SectionFrame.BorderSizePixel = 0
        SectionFrame.Parent = tab.Frame

        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 6)
        UICorner.Parent = SectionFrame

        local SectionText = Instance.new("TextLabel")
        SectionText.Size = UDim2.new(1, -10, 1, 0)
        SectionText.Position = UDim2.new(0, 10, 0, 0)
        SectionText.BackgroundTransparency = 1
        SectionText.Text = name
        SectionText.TextColor3 = Color3.fromRGB(255, 255, 255)
        SectionText.Font = Enum.Font.GothamBold
        SectionText.TextSize = 14
        SectionText.TextXAlignment = Enum.TextXAlignment.Left
        SectionText.Parent = SectionFrame

        local Section = {}
        Section.Frame = SectionFrame

        function Section:AddToggle(text, callback)
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Size = UDim2.new(1, -20, 0, 25)
            ToggleFrame.Position = UDim2.new(0, 10, 0, #self.Frame:GetChildren() * 30)
            ToggleFrame.BackgroundTransparency = 1
            ToggleFrame.Parent = self.Frame

            local ToggleText = Instance.new("TextLabel")
            ToggleText.Size = UDim2.new(0.7, 0, 1, 0)
            ToggleText.BackgroundTransparency = 1
            ToggleText.Text = text
            ToggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleText.Font = Enum.Font.Gotham
            ToggleText.TextSize = 12
            ToggleText.TextXAlignment = Enum.TextXAlignment.Left
            ToggleText.Parent = ToggleFrame

            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Size = UDim2.new(0, 40, 0, 20)
            ToggleButton.Position = UDim2.new(1, -40, 0.5, -10)
            ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            ToggleButton.Text = ""
            ToggleButton.Parent = ToggleFrame

            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 10)
            UICorner.Parent = ToggleButton

            local ToggleDot = Instance.new("Frame")
            ToggleDot.Size = UDim2.new(0, 16, 0, 16)
            ToggleDot.Position = UDim2.new(0, 2, 0.5, -8)
            ToggleDot.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
            ToggleDot.Parent = ToggleButton

            local UICorner2 = Instance.new("UICorner")
            UICorner2.CornerRadius = UDim.new(0, 8)
            UICorner2.Parent = ToggleDot

            local isToggled = false

            local function updateToggle()
                if isToggled then
                    ToggleDot.Position = UDim2.new(0, 22, 0.5, -8)
                    ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
                    ToggleDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                else
                    ToggleDot.Position = UDim2.new(0, 2, 0.5, -8)
                    ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    ToggleDot.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
                end
            end

            ToggleButton.MouseButton1Click:Connect(function()
                isToggled = not isToggled
                updateToggle()
                if callback then
                    pcall(callback, isToggled)
                end
            end)

            updateToggle()
        end

        function Section:AddButton(text, callback)
            local Button = Instance.new("TextButton")
            Button.Size = UDim2.new(1, -20, 0, 25)
            Button.Position = UDim2.new(0, 10, 0, #self.Frame:GetChildren() * 30)
            Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Button.Text = text
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.Font = Enum.Font.Gotham
            Button.TextSize = 12
            Button.Parent = self.Frame

            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 6)
            UICorner.Parent = Button

            Button.MouseButton1Click:Connect(function()
                if callback then
                    pcall(callback)
                end
            end)
        end

        return Section
    end

    -- Create tabs based on the screenshot
    local mainTab = Window:AddTab("main")
    local movementTab = Window:AddTab("movement")
    local otherTab = Window:AddTab("other")
    local utilityTab = Window:AddTab("utility")
    local serverTab = Window:AddTab("server")

    -- Add sections and options based on the screenshot
    local movementSection = Window:AddSection(movementTab, "movement")
    movementSection:AddToggle("remove jump cooldown")
    movementSection:AddToggle("remove slowdowns")
    movementSection:AddToggle("jump power")
    movementSection:AddToggle("anti fling")
    movementSection:AddToggle("anti alt")
    movementSection:AddToggle("noclip")
    movementSection:AddToggle("speed")
    movementSection:AddToggle("flight")

    local otherSection = Window:AddSection(otherTab, "other")
    otherSection:AddToggle("animation breaker")
    otherSection:AddToggle("animation player")

    local utilitySection = Window:AddSection(utilityTab, "utility")
    utilitySection:AddToggle("unlock custom crosshair")
    utilitySection:AddToggle("unlock animation packs")
    utilitySection:AddToggle("unlock camera distance")
    utilitySection:AddToggle("remove anti gun macro")
    utilitySection:AddToggle("remove flash bang")
    utilitySection:AddToggle("remove recoil")
    utilitySection:AddToggle("auto reload")
    utilitySection:AddToggle("detect staff")
    utilitySection:AddToggle("notify")
    utilitySection:AddToggle("redeem codes")
    utilitySection:AddToggle("force reset")

    local serverSection = Window:AddSection(serverTab, "server")
    serverSection:AddButton("copy join script")
    serverSection:AddButton("rejoin server")
    serverSection:AddButton("hop servers")

    table.insert(OxyLibrary.Windows, Window)
    return Window
end

return OxyLibrary
