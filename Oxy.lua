-- Oxy.lua
local Oxy = {}

-- ============== Themes ==============
local Themes = {
	DarkRed = {
		MainFrameBg = Color3.fromRGB(18, 18, 18),
		TopBarBg = Color3.fromRGB(35, 0, 0),
		TopBarStroke = Color3.fromRGB(120, 20, 20),
		WorkAreaBg = Color3.fromRGB(25, 25, 25),
		ButtonText = Color3.fromRGB(200, 200, 200),
		ButtonHover = Color3.fromRGB(255, 80, 80),
		TopBarDivider = Color3.fromRGB(120, 20, 20),
		TabBg = Color3.fromRGB(35, 0, 0),


TabHover = Color3.fromRGB(80, 0, 0),
		TabOutline = Color3.fromRGB(50, 0, 0)
	},

	DarkBlue = {
		MainFrameBg = Color3.fromRGB(18, 18, 18),
		TopBarBg = Color3.fromRGB(0, 0, 35),
		TopBarStroke = Color3.fromRGB(0, 0, 120),
		WorkAreaBg = Color3.fromRGB(25, 25, 25),
		ButtonText = Color3.fromRGB(200, 200, 200),
		ButtonHover = Color3.fromRGB(80, 80, 255),
		TopBarDivider = Color3.fromRGB(20, 20, 80),
		TabBg = Color3.fromRGB(0, 0, 35),
		TabHover = Color3.fromRGB(100, 100, 255),
		TabOutline = Color3.fromRGB(0, 0, 50)
	},

	DarkGreen = {
		MainFrameBg = Color3.fromRGB(20, 25, 20),
		TopBarBg = Color3.fromRGB(0, 35, 0),
		TopBarStroke = Color3.fromRGB(0, 120, 0),
		WorkAreaBg = Color3.fromRGB(25, 35, 25),
		ButtonText = Color3.fromRGB(200, 220, 200),
		ButtonHover = Color3.fromRGB(80, 255, 80),
		TopBarDivider = Color3.fromRGB(0, 120, 0),
		TabBg = Color3.fromRGB(0, 35, 0),
		TabHover = Color3.fromRGB(100, 255, 100),
		TabOutline = Color3.fromRGB(0, 50, 0)
	},

	DarkPurple = {
		MainFrameBg = Color3.fromRGB(25, 18, 25),
		TopBarBg = Color3.fromRGB(35, 0, 35),
		TopBarStroke = Color3.fromRGB(120, 0, 120),
		WorkAreaBg = Color3.fromRGB(30, 25, 30),
		ButtonText = Color3.fromRGB(220, 200, 220),
		ButtonHover = Color3.fromRGB(200, 100, 255),
		TopBarDivider = Color3.fromRGB(120, 0, 120),
		TabBg = Color3.fromRGB(35, 0, 35),
		TabHover = Color3.fromRGB(180, 100, 255),
		TabOutline = Color3.fromRGB(50, 0, 50)
	},

	LightGray = {
		MainFrameBg = Color3.fromRGB(240, 240, 240),
		TopBarBg = Color3.fromRGB(200, 200, 200),
		TopBarStroke = Color3.fromRGB(150, 150, 150),
		WorkAreaBg = Color3.fromRGB(255, 255, 255),
		ButtonText = Color3.fromRGB(50, 50, 50),
		ButtonHover = Color3.fromRGB(100, 100, 100),
		TopBarDivider = Color3.fromRGB(150, 150, 150),
		TabBg = Color3.fromRGB(200, 200, 200),
		TabHover = Color3.fromRGB(120, 120, 120),
		TabOutline = Color3.fromRGB(215, 215, 215)
	},
}



-- ============== CreateWindow ==============
function Oxy:CreateWindow(options)
	local themeName = options.Theme or "DarkRed"
	local Theme = Themes[themeName]

	local player = game.Players.LocalPlayer
	local playerGui = player:WaitForChild("PlayerGui")

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = options.Name or "OxyUI"
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.Parent = playerGui

-- ============== MainFrame ==============
	local MainFrame = Instance.new("Frame")
	MainFrame.Size = UDim2.new(0, 800, 0, 400)
	MainFrame.Position = UDim2.new(0.5, -400, 0.5, -200)
	MainFrame.BackgroundColor3 = Theme.MainFrameBg
	MainFrame.BorderSizePixel = 0
	MainFrame.Parent = ScreenGui

	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(0, 12)
	UICorner.Parent = MainFrame

	local UIStroke = Instance.new("UIStroke")
	UIStroke.Color = Theme.TopBarStroke
	UIStroke.Thickness = 2
	UIStroke.Parent = MainFrame
	

	-- ============== TopBar ==============
	local TopBar = Instance.new("Frame")
	TopBar.Size = UDim2.new(1, 0, 0, 35)
	TopBar.BackgroundColor3 = Theme.TopBarBg
	TopBar.BorderSizePixel = 0
	TopBar.Parent = MainFrame

	local FullCorner = Instance.new("UICorner")
	FullCorner.CornerRadius = UDim.new(0, 12)
	FullCorner.Parent = TopBar

	-- BottomCover
	local BottomCover = Instance.new("Frame")
	BottomCover.Size = UDim2.new(1, 0, 0, 12)
	BottomCover.Position = UDim2.new(0, 0, 1, -12)
	BottomCover.BackgroundColor3 = TopBar.BackgroundColor3
	BottomCover.BorderSizePixel = 0
	BottomCover.Parent = TopBar

	-- Divider pod BottomCover
	local TopBarDivider = Instance.new("Frame")
	TopBarDivider.Size = UDim2.new(1, 0, 0, 2)
	TopBarDivider.Position = UDim2.new(0, 0, 1, 0)
	TopBarDivider.BackgroundColor3 = Theme.TopBarDivider
	TopBarDivider.BorderSizePixel = 0
	TopBarDivider.Parent = TopBar

	-- TopBar Left
	local UITextService = game:GetService("TextService")

	local InfoSection = Instance.new("Frame")
	InfoSection.Size = UDim2.new(0, 0, 1, 0)
	InfoSection.Position = UDim2.new(0, 10, 0, 0) -- przy lewej krawędzi TopBar
	InfoSection.BackgroundTransparency = 1
	InfoSection.Parent = TopBar

	local InfoLayout = Instance.new("UIListLayout")
	InfoLayout.FillDirection = Enum.FillDirection.Horizontal
	InfoLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	InfoLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	InfoLayout.SortOrder = Enum.SortOrder.LayoutOrder
	InfoLayout.Padding = UDim.new(0, 8)
	InfoLayout.Parent = InfoSection

	local function CreateDivider()
		local dividerFrame = Instance.new("Frame")
		dividerFrame.Size = UDim2.new(0, 2, 0.6, 0)
		dividerFrame.BackgroundColor3 = Theme.TopBarDivider
		dividerFrame.BorderSizePixel = 0
		dividerFrame.AnchorPoint = Vector2.new(0, 0.5)
		dividerFrame.Position = UDim2.new(0, 0, 0.5, 0)
		return dividerFrame
	end

	local function GetTextWidth(text, font, size)
		local bounds = UITextService:GetTextSize(text, size, font, Vector2.new(1000, 1000))
		return bounds.X
	end

	-- Ikona
	local IconFrame = Instance.new("Frame")
	IconFrame.Size = UDim2.new(0, 24, 1, 0)
	IconFrame.BackgroundTransparency = 1
	IconFrame.Parent = InfoSection

	local Icon = Instance.new("ImageLabel")
	Icon.Size = UDim2.new(0, 20, 0, 20)
	Icon.Position = UDim2.new(0.5, -10, 0.5, -10)
	Icon.BackgroundTransparency = 1
	Icon.Image = options.Icon or "rbxassetid://0"
	Icon.Parent = IconFrame

	CreateDivider().Parent = InfoSection

	-- Nazwa
	local NameText = options.Title or "OxyUI"
	local NameWidth = GetTextWidth(NameText, Enum.Font.SourceSansBold, 16) + 10

	local NameFrame = Instance.new("Frame")
	NameFrame.Size = UDim2.new(0, NameWidth, 1, 0)
	NameFrame.BackgroundTransparency = 1
	NameFrame.Parent = InfoSection

	local NameLabel = Instance.new("TextLabel")
	NameLabel.Text = NameText
	NameLabel.Size = UDim2.new(1, 0, 1, 0)
	NameLabel.TextColor3 = Theme.ButtonText
	NameLabel.Font = Enum.Font.SourceSansBold
	NameLabel.TextSize = 16
	NameLabel.BackgroundTransparency = 1
	NameLabel.TextXAlignment = Enum.TextXAlignment.Left
	NameLabel.Parent = NameFrame

	CreateDivider().Parent = InfoSection

	-- Autor
	local AuthorText = options.Author or "Autor"
	local AuthorWidth = GetTextWidth(AuthorText, Enum.Font.SourceSansBold, 14) + 10

	local AuthorFrame = Instance.new("Frame")
	AuthorFrame.Size = UDim2.new(0, AuthorWidth, 1, 0)
	AuthorFrame.BackgroundTransparency = 1
	AuthorFrame.Parent = InfoSection

	local AuthorLabel = Instance.new("TextLabel")
	AuthorLabel.Text = AuthorText
	AuthorLabel.Size = UDim2.new(1, 0, 1, 0)
	AuthorLabel.TextColor3 = Theme.ButtonText
	AuthorLabel.Font = Enum.Font.SourceSansBold
	AuthorLabel.TextSize = 14
	AuthorLabel.BackgroundTransparency = 1
	AuthorLabel.TextXAlignment = Enum.TextXAlignment.Left
	AuthorLabel.Parent = AuthorFrame

	-- Update InfoSection Width
	local function UpdateInfoSectionWidth()
		local totalWidth = 0
		for _, child in ipairs(InfoSection:GetChildren()) do
			if child:IsA("Frame") then
				totalWidth = totalWidth + child.Size.X.Offset
			end
		end

		local padding = InfoLayout.Padding.Offset * (#InfoSection:GetChildren() - 1)
		InfoSection.Size = UDim2.new(0, totalWidth + padding, 1, 0)
	end

	UpdateInfoSectionWidth()


	-- ============== Dragging ==============
	local UserInputService = game:GetService("UserInputService")
	local dragging = false
	local dragStart, startPos

	TopBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = MainFrame.Position
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			MainFrame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

-- ============== Control Buttons ==============
	local ControlButtons = Instance.new("Frame")
	ControlButtons.Size = UDim2.new(0, 120, 1, 0)
	ControlButtons.Position = UDim2.new(1, -110, 0, 0)
	ControlButtons.BackgroundTransparency = 1
	ControlButtons.Parent = TopBar

	local CL = Instance.new("UIListLayout")
	CL.FillDirection = Enum.FillDirection.Horizontal
	CL.Padding = UDim.new(0, 5)
	CL.HorizontalAlignment = Enum.HorizontalAlignment.Center
	CL.VerticalAlignment = Enum.VerticalAlignment.Center
	CL.Parent = ControlButtons

	local TweenService = game:GetService("TweenService")

	local function CreateCtrlButton(txt)
		local Btn = Instance.new("TextButton")
		Btn.Size = UDim2.new(0, 25, 0, 25)
		Btn.Text = txt
		Btn.BackgroundTransparency = 1
		Btn.TextColor3 = Theme.ButtonText
		Btn.Font = Enum.Font.SourceSansBold
		Btn.TextSize = 16
		Btn.Parent = ControlButtons

		local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		local function TweenColor(targetColor)
			local tween = TweenService:Create(Btn, tweenInfo, {TextColor3 = targetColor})
			tween:Play()
		end

		Btn.MouseEnter:Connect(function()
			TweenColor(Theme.ButtonHover)
		end)
		Btn.MouseLeave:Connect(function()
			TweenColor(Theme.ButtonText)
		end)

		return Btn
	end

	local Minimize = CreateCtrlButton("M")
	local Maximize = CreateCtrlButton("S")
	local Close = CreateCtrlButton("X")

	Close.MouseButton1Click:Connect(function()
		ScreenGui:Destroy()
	end)


-- ============== WorkArea ==============
	local WorkArea = Instance.new("Frame")
	WorkArea.Size = UDim2.new(1, -20, 1, -92)
	WorkArea.Position = UDim2.new(0, 10, 0, 82)
	WorkArea.BackgroundColor3 = Theme.WorkAreaBg
	WorkArea.BorderSizePixel = 0
	WorkArea.Parent = MainFrame

	local WorkCorner = Instance.new("UICorner")
	WorkCorner.CornerRadius = UDim.new(0, 8)
	WorkCorner.Parent = WorkArea
	
	
-- ============== Tabs ==============
	local TabBar = Instance.new("Frame")
	TabBar.Size = UDim2.new(1, -20, 0, 30)
	TabBar.Position = UDim2.new(0, 10, 0, 45) -- 40 px od góry MainFrame (pod TopBar)
	TabBar.BackgroundTransparency = 1
	TabBar.Parent = MainFrame

	local TabLayout = Instance.new("UIListLayout")
	TabLayout.FillDirection = Enum.FillDirection.Horizontal
	TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	TabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	TabLayout.Padding = UDim.new(0, 10)
	TabLayout.Parent = TabBar

	local Tabs = {} -- tu będziemy przechowywać przyciski zakładek

	local function CreateTab(name)
		local Tab = Instance.new("TextButton")
		Tab.Text = name
		Tab.Size = UDim2.new(0, 80, 0, 30) -- mniejsze wymiary
		Tab.BackgroundColor3 = Theme.TopBarBg
		Tab.TextColor3 = Theme.ButtonText
		Tab.Font = Enum.Font.SourceSansBold
		Tab.TextSize = 18
		Tab.Parent = TabBar

		-- Zaokrąglone rogi
		local Corner = Instance.new("UICorner")
		Corner.CornerRadius = UDim.new(0, 15) -- połowa wysokości = okrągły
		Corner.Parent = Tab
		
		-- Obramówka przycisku
		local Stroke = Instance.new("UIStroke")
		Stroke.Color = Theme.TabOutline
		Stroke.Thickness = 2
		Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border -- upewniamy się, że obejmuje tylko ramkę
		Stroke.Parent = Tab

		-- Efekt hover
		Tab.MouseEnter:Connect(function()
			Tab.BackgroundColor3 = Theme.ButtonHover
		end)
		Tab.MouseLeave:Connect(function()
			if not Tab.Active then
				Tab.BackgroundColor3 = Theme.TopBarBg
			end
		end)

		-- Aktywna zakładka
		Tab.MouseButton1Click:Connect(function()
			for _, t in pairs(Tabs) do
				t.Active = false
				t.BackgroundColor3 = Theme.TopBarBg
			end
			Tab.Active = true
			Tab.BackgroundColor3 = Theme.ButtonHover
		end)

		table.insert(Tabs, Tab)
		return Tab
	end


	-- Tworzymy przykładowe zakładki
	CreateTab("Tab1")
	CreateTab("Tab2")
	CreateTab("Tab3")

	
	

-- ============== Keybind toggle ==============
	if options.ToggleUIKeybind then
		local UIS = game:GetService("UserInputService")
		local uiVisible = true
		UIS.InputBegan:Connect(function(input, processed)
			if not processed and input.KeyCode == Enum.KeyCode[options.ToggleUIKeybind] then
				uiVisible = not uiVisible
				MainFrame.Visible = uiVisible
			end
		end)
	end





	return {
		ScreenGui = ScreenGui,
		MainFrame = MainFrame,
		WorkArea = WorkArea,
	}
end


return Oxy
