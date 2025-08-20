local Oxy = {}

function Oxy:Init()
    -- Tworzymy ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Główna ramka
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.Parent = ScreenGui

    -- Przycisk zamknięcia
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -35, 0, 5)
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    CloseButton.Parent = MainFrame

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- 🔹 5 przykładowych elementów GUI 🔹

    -- 1. Button
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 100, 0, 30)
    Button.Position = UDim2.new(0, 20, 0, 50)
    Button.Text = "Click me!"
    Button.Parent = MainFrame
    Button.MouseButton1Click:Connect(function()
        print("Button clicked!")
    end)

    -- 2. Slider (prosty)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(0, 200, 0, 20)
    SliderFrame.Position = UDim2.new(0, 20, 0, 100)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    SliderFrame.Parent = MainFrame

    local SliderButton = Instance.new("TextButton")
    SliderButton.Size = UDim2.new(0, 20, 0, 20)
    SliderButton.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
    SliderButton.Parent = SliderFrame
    SliderButton.Text = ""

    SliderButton.MouseButton1Click:Connect(function()
        print("Slider value changed!")
    end)

    -- 3. Toggle
    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(0, 100, 0, 30)
    Toggle.Position = UDim2.new(0, 20, 0, 150)
    Toggle.Text = "Toggle: OFF"
    Toggle.Parent = MainFrame

    local toggled = false
    Toggle.MouseButton1Click:Connect(function()
        toggled = not toggled
        Toggle.Text = toggled and "Toggle: ON" or "Toggle: OFF"
    end)

    -- 4. Input (TextBox)
    local Input = Instance.new("TextBox")
    Input.Size = UDim2.new(0, 150, 0, 30)
    Input.Position = UDim2.new(0, 20, 0, 200)
    Input.PlaceholderText = "Type here..."
    Input.Parent = MainFrame
    Input.FocusLost:Connect(function()
        print("User typed:", Input.Text)
    end)

    -- 5. Dropdown (prosty)
    local Dropdown = Instance.new("TextButton")
    Dropdown.Size = UDim2.new(0, 150, 0, 30)
    Dropdown.Position = UDim2.new(0, 20, 0, 250)
    Dropdown.Text = "Select option"
    Dropdown.Parent = MainFrame

    Dropdown.MouseButton1Click:Connect(function()
        print("Dropdown opened (tu możesz dodać listę opcji)")
    end)
end

return Oxy
