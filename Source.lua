-- CompactGuiModule.lua
local CompactGui = {}
CompactGui.__index = CompactGui

function CompactGui.new(titleText)
	local self = setmetatable({}, CompactGui)

	local CoreGui = game:GetService("CoreGui")
	local Players = game:GetService("Players")
	local Player = Players.LocalPlayer
	local PlayerGui = Player:FindFirstChild("PlayerGui") or CoreGui

	-- ScreenGui
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "CompactGui"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = PlayerGui

	-- Main Frame
	local mainFrame = Instance.new("Frame")
	mainFrame.Name = "MainFrame"
	mainFrame.Size = UDim2.new(0, 400, 0, 300)
	mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
	mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	mainFrame.BorderSizePixel = 0
	mainFrame.Active = true
	mainFrame.Draggable = true
	mainFrame.ClipsDescendants = true
	mainFrame.Parent = screenGui
	mainFrame.BackgroundTransparency = 0
	mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	mainFrame.Visible = true
	mainFrame.ZIndex = 1
	mainFrame.AutomaticSize = Enum.AutomaticSize.Y
	mainFrame.SizeConstraint = Enum.SizeConstraint.RelativeXY
	mainFrame.ClipsDescendants = false
	mainFrame.BorderMode = Enum.BorderMode.Outline
	mainFrame.BackgroundTransparency = 0
	mainFrame:SetAttribute("Minimized", false)

	-- UICorner
	local corner = Instance.new("UICorner", mainFrame)
	corner.CornerRadius = UDim.new(0, 12)

	-- Titlebar
	local titleBar = Instance.new("Frame")
	titleBar.Size = UDim2.new(1, 0, 0, 35)
	titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	titleBar.BorderSizePixel = 0
	titleBar.Parent = mainFrame

	Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 12)

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, -70, 1, 0)
	title.Position = UDim2.new(0, 10, 0, 0)
	title.Text = titleText or "My Small GUI"
	title.TextColor3 = Color3.new(1, 1, 1)
	title.Font = Enum.Font.SourceSansBold
	title.TextSize = 18
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.BackgroundTransparency = 1
	title.Parent = titleBar

	-- Close Button
	local closeButton = Instance.new("TextButton")
	closeButton.Size = UDim2.new(0, 25, 0, 25)
	closeButton.Position = UDim2.new(1, -30, 0.1, 0)
	closeButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
	closeButton.Text = "X"
	closeButton.TextColor3 = Color3.new(1, 1, 1)
	closeButton.Font = Enum.Font.SourceSansBold
	closeButton.TextSize = 14
	closeButton.BorderSizePixel = 0
	closeButton.Parent = titleBar
	Instance.new("UICorner", closeButton).CornerRadius = UDim.new(1, 0)

	closeButton.MouseButton1Click:Connect(function()
		screenGui:Destroy()
	end)

	-- Minimize Button
	local minimizeButton = Instance.new("TextButton")
	minimizeButton.Size = UDim2.new(0, 25, 0, 25)
	minimizeButton.Position = UDim2.new(1, -60, 0.1, 0)
	minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 200, 40)
	minimizeButton.Text = "-"
	minimizeButton.TextColor3 = Color3.new(1, 1, 1)
	minimizeButton.Font = Enum.Font.SourceSansBold
	minimizeButton.TextSize = 18
	minimizeButton.BorderSizePixel = 0
	minimizeButton.Parent = titleBar
	Instance.new("UICorner", minimizeButton).CornerRadius = UDim.new(1, 0)

	minimizeButton.MouseButton1Click:Connect(function()
		mainFrame.Visible = not mainFrame:GetAttribute("Minimized")
		mainFrame:SetAttribute("Minimized", not mainFrame:GetAttribute("Minimized"))
	end)

	-- Tab holder (Left side)
	local tabHolder = Instance.new("Frame")
	tabHolder.Name = "TabHolder"
	tabHolder.Size = UDim2.new(0, 100, 1, -35)
	tabHolder.Position = UDim2.new(0, 0, 0, 35)
	tabHolder.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	tabHolder.BorderSizePixel = 0
	tabHolder.Parent = mainFrame
	Instance.new("UICorner", tabHolder).CornerRadius = UDim.new(0, 12)

	local tabLayout = Instance.new("UIListLayout", tabHolder)
	tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
	tabLayout.Padding = UDim.new(0, 6)

	-- Button Area (Right side)
	local buttonArea = Instance.new("Frame")
	buttonArea.Name = "ButtonArea"
	buttonArea.Size = UDim2.new(1, -110, 1, -45)
	buttonArea.Position = UDim2.new(0, 110, 0, 45)
	buttonArea.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	buttonArea.BorderSizePixel = 0
	buttonArea.Parent = mainFrame
	Instance.new("UICorner", buttonArea).CornerRadius = UDim.new(0, 12)

	local buttonLayout = Instance.new("UIListLayout", buttonArea)
	buttonLayout.SortOrder = Enum.SortOrder.LayoutOrder
	buttonLayout.Padding = UDim.new(0, 6)

	-- AddTab function
	function self:AddTab(name, callback)
		local tabButton = Instance.new("TextButton")
		tabButton.Size = UDim2.new(1, -10, 0, 30)
		tabButton.Text = name or "Tab"
		tabButton.TextColor3 = Color3.new(1, 1, 1)
		tabButton.Font = Enum.Font.SourceSansBold
		tabButton.TextSize = 16
		tabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		tabButton.BorderSizePixel = 0
		tabButton.Parent = tabHolder
		Instance.new("UICorner", tabButton).CornerRadius = UDim.new(1, 0)

		tabButton.MouseButton1Click:Connect(function()
			pcall(callback)
		end)

		return tabButton
	end

	-- AddButton function
	function self:AddButton(text, callback)
		local button = Instance.new("TextButton")
		button.Size = UDim2.new(1, -10, 0, 30)
		button.Text = text or "Button"
		button.TextColor3 = Color3.new(1, 1, 1)
		button.Font = Enum.Font.SourceSans
		button.TextSize = 16
		button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		button.BorderSizePixel = 0
		button.Parent = buttonArea
		Instance.new("UICorner", button).CornerRadius = UDim.new(1, 0)

		button.MouseButton1Click:Connect(function()
			pcall(callback)
		end)

		return button
	end

	return self
end

return CompactGui
