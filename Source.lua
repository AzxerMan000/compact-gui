local compactGui = {}
compactGui.__index = compactGui

-- Constructor
function compactGui.new(title)
    local self = setmetatable({}, compactGui)

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CompactGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game:GetService("CoreGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 350, 0, 300)
    mainFrame.Position = UDim2.new(0.5, -175, 0.5, -150)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = mainFrame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title or "Compact GUI"
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 18
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.Parent = mainFrame

    local tabsFrame = Instance.new("Frame")
    tabsFrame.Size = UDim2.new(0, 100, 1, -40)
    tabsFrame.Position = UDim2.new(0, 0, 0, 40)
    tabsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tabsFrame.BorderSizePixel = 0
    tabsFrame.Parent = mainFrame

    local tabCorner = corner:Clone()
    tabCorner.Parent = tabsFrame

    local tabsLayout = Instance.new("UIListLayout")
    tabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabsLayout.Padding = UDim.new(0, 5)
    tabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    tabsLayout.VerticalAlignment = Enum.VerticalAlignment.Top
    tabsLayout.Parent = tabsFrame

    local pagesFrame = Instance.new("Frame")
    pagesFrame.Size = UDim2.new(1, -110, 1, -40)
    pagesFrame.Position = UDim2.new(0, 110, 0, 40)
    pagesFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    pagesFrame.BorderSizePixel = 0
    pagesFrame.ClipsDescendants = true
    pagesFrame.Parent = mainFrame

    local pageCorner = corner:Clone()
    pageCorner.Parent = pagesFrame

    local pagesLayout = Instance.new("UIListLayout")
    pagesLayout.SortOrder = Enum.SortOrder.LayoutOrder
    pagesLayout.Padding = UDim.new(0, 5)
    pagesLayout.Parent = pagesFrame

    self.ScreenGui = screenGui
    self.MainFrame = mainFrame
    self.TitleLabel = titleLabel
    self.TabsFrame = tabsFrame
    self.PagesFrame = pagesFrame
    self.Tabs = {}
    self.Pages = {}

    return self
end

function compactGui:HideAllPages()
    for _, page in pairs(self.Pages) do
        page.Visible = false
    end
    for _, tab in pairs(self.Tabs) do
        tab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        tab.TextColor3 = Color3.new(1, 1, 1)
    end
end

function compactGui:CreateTab(tabName)
    local tabIndex = #self.Tabs + 1

    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(1, -10, 0, 30)
    tabButton.Text = tabName or ("Tab " .. tabIndex)
    tabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tabButton.TextColor3 = Color3.new(1, 1, 1)
    tabButton.Font = Enum.Font.SourceSansBold
    tabButton.TextSize = 16
    tabButton.BorderSizePixel = 0
    tabButton.AutoButtonColor = false
    tabButton.Parent = self.TabsFrame

    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 6)
    tabCorner.Parent = tabButton

    local pageFrame = Instance.new("ScrollingFrame")
    pageFrame.Size = UDim2.new(1, 0, 1, 0)
    pageFrame.BackgroundTransparency = 1
    pageFrame.ScrollBarThickness = 6
    pageFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    pageFrame.Visible = false
    pageFrame.BorderSizePixel = 0
    pageFrame.Parent = self.PagesFrame

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 8)
    layout.Parent = pageFrame

    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        pageFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end)

    self.Tabs[tabIndex] = tabButton
    self.Pages[tabIndex] = pageFrame

    tabButton.MouseButton1Click:Connect(function()
        self:HideAllPages()
        pageFrame.Visible = true
        tabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        tabButton.TextColor3 = Color3.fromRGB(0, 1, 0)
    end)

    if tabIndex == 1 then
        tabButton:MouseButton1Click()
    end

    local tabApi = {}

    function tabApi:AddButton(text, callback)
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, -20, 0, 30)
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        button.TextColor3 = Color3.new(1, 1, 1)
        button.Font = Enum.Font.SourceSans
        button.TextSize = 16
        button.Text = text or "Button"
        button.BorderSizePixel = 0
        button.Parent = pageFrame

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = button

        button.MouseButton1Click:Connect(function()
            pcall(callback)
        end)

        return button
    end

    function tabApi:AddSubmit(placeholderText, callback)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, -20, 0, 30)
        frame.BackgroundTransparency = 1
        frame.BorderSizePixel = 0
        frame.Parent = pageFrame

        local textBox = Instance.new("TextBox")
        textBox.Size = UDim2.new(0.7, 0, 1, 0)
        textBox.Position = UDim2.new(0, 0, 0, 0)
        textBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        textBox.TextColor3 = Color3.new(1, 1, 1)
        textBox.TextSize = 14
        textBox.Font = Enum.Font.SourceSans
        textBox.PlaceholderText = placeholderText or "Enter text"
        textBox.Parent = frame

        local submitBtn = Instance.new("TextButton")
        submitBtn.Size = UDim2.new(0.3, 0, 1, 0)
        submitBtn.Position = UDim2.new(0.7, 0, 0, 0)
        submitBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        submitBtn.TextColor3 = Color3.new(1, 1, 1)
        submitBtn.TextSize = 14
        submitBtn.Font = Enum.Font.SourceSans
        submitBtn.Text = "Submit"
        submitBtn.BorderSizePixel = 0
        submitBtn.Parent = frame

        local submitCorner = Instance.new("UICorner")
        submitCorner.CornerRadius = UDim.new(0, 6)
        submitCorner.Parent = submitBtn

        submitBtn.MouseButton1Click:Connect(function()
            pcall(callback, textBox.Text)
        end)

        return frame
    end

    function tabApi:AddToggle(text, callback)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, -20, 0, 30)
        frame.BackgroundTransparency = 1
        frame.BorderSizePixel = 0
        frame.Parent = pageFrame

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.7, 0, 1, 0)
        label.Position = UDim2.new(0, 0, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = text or "Toggle"
        label.Font = Enum.Font.SourceSans
        label.TextSize = 16
        label.TextColor3 = Color3.new(1, 1, 1)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame

        local toggleBtn = Instance.new("TextButton")
        toggleBtn.Size = UDim2.new(0.3, 0, 1, 0)
        toggleBtn.Position = UDim2.new(0.7, 0, 0, 0)
        toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        toggleBtn.TextColor3 = Color3.new(1, 1, 1)
        toggleBtn.TextSize = 14
        toggleBtn.Font = Enum.Font.SourceSans
        toggleBtn.Text = "OFF"
        toggleBtn.BorderSizePixel = 0
        toggleBtn.Parent = frame

        local toggleCorner = Instance.new("UICorner")
        toggleCorner.CornerRadius = UDim.new(0, 6)
        toggleCorner.Parent = toggleBtn

        local toggled = false
        toggleBtn.MouseButton1Click:Connect(function()
            toggled = not toggled
            toggleBtn.Text = toggled and "ON" or "OFF"
            toggleBtn.BackgroundColor3 = toggled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(60, 60, 60)
            if callback then
                pcall(callback, toggled)
            end
        end)

        return frame
    end

    return tabApi
end

return compactGui
