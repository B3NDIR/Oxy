--[[
    Oxy UI Framework
    by You
    Ładowanie: local Oxy = loadstring(game:HttpGet("URL/oxy.lua"))()
]]

local OxyLibrary = {}
OxyLibrary.Windows = {}

-- tworzenie okna na środku ekranu
function OxyLibrary:CreateWindow(config)
    local title = config.Title or "Oxy Window"

    -- główne GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "OxyUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = game:GetService("CoreGui")

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 400, 0, 600)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    local TitleBar = Instance.new("TextLabel")
    TitleBar.Size = UDim2.new(1, 0, 0, 30)
    TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TitleBar.Text = title
    TitleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleBar.Font = Enum.Font.GothamBold
    TitleBar.TextSize = 14
    TitleBar.Parent = MainFrame

    -- draggable
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

    function Window:AddButton(text, callback)
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(1, -20, 0, 30)
        Button.Position = UDim2.new(0, 10, 0, #MainFrame:GetChildren() * 35)
        Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Button.Text = text
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.Font = Enum.Font.Gotham
        Button.TextSize = 14
        Button.Parent = MainFrame

        local UIC = Instance.new("UICorner", Button)
        UIC.CornerRadius = UDim.new(0, 6)

        Button.MouseButton1Click:Connect(function()
            if callback then
                pcall(callback)
            end
        end)
    end

    table.insert(OxyLibrary.Windows, Window)
    return Window
end

return OxyLibrary
