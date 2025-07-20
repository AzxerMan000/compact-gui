local compactGui = {}
compactGui.__index = compactGui

-- Constructor
function compactGui.new(title)
    local self = setmetatable({}, compactGui)

    local screenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    screenGui.Name = "CompactGui"

    local mainFrame = Instance.new("Frame", screenGui)
    mainFrame.Size = UDim2.new(0, 350, 0, 300)
    mainFrame.Position = UDim2.new(0.5, -175, 0.5, -150)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true

    local titleLabel = Instance.new("TextLabel", mainFrame)
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title or "Compact GUI"
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 18
    titleLabel.TextColor3 = Color3.new(1, 1, 1)

    -- Tabs container (left side)
    local tabsFrame = Instance.new("Frame", mainFrame)
    tabsFrame.Size = UDim2.new(0, 100, 1, -40)
    tabsFrame.Position = UDim2.new(0, 0, 0, 40)
    tabsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tabsFrame.BorderSizePixel = 0

    local tabsLayout = Instance.new("UIListLayout", tabsFrame)
    tabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabsLayout.Padding = UDim.new(0, 5)
    tabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    tabsLayout.VerticalAlignment = Enum.VerticalAlignment.Top

    -- Pages container (right side)
    local pagesFrame = Instance.new("Frame", mainFrame)
    pagesFrame.Size = UDim2.new(1, -110, 1, -40)
    pagesFrame.Position = UDim2.new(0, 110, 0, 40)
    pagesFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    pagesFrame.BorderSizePixel = 0
    pagesFrame.ClipsDescendants = true

    local pagesLayout = Instance.new("UIListLayout", pagesFrame)
    pagesLayout.SortOrder = Enum.SortOrder.LayoutOrder
    pagesLayout.Padding = UDim.new(0, 5)

    -- Store tabs and pages
    self.ScreenGui = screenGui
    self.MainFrame = mainFrame
    self.TitleLabel = titleLabel
    self.TabsFrame = tabsFrame
    self.PagesFrame = pagesFrame

    self.Tabs = {}
    self.Pages = {}

    return self
end

-- Helper to hide all pages
function compactGui:HideAllPages()
    for _, page in pairs(self.Pages) do
        page.Visible = false
    end
    for _, tab in pairs(self.Tabs) do
        tab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        tab.TextColor3 = Color3.new(1, 1, 1)
    end
end

-- Create a new tab with empty page
function compactGui:CreateTab(tabName)
    local tabIndex = #self.Tabs + 1

    -- Create tab button
    local tabButton = Instance.new("TextButton", self.TabsFrame)
    tabButton.Size = UDim2.new(1, -10, 0, 30)
    tabButton.Text = tabName or ("Tab " .. tabIndex)
    tabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tabButton.TextColor3 = Color3.new(1, 1, 1)
    tabButton.Font = Enum.Font.SourceSansBold
    tabButton.TextSize = 16
    tabButton.BorderSizePixel = 0
    tabButton.AutoButtonColor = false

    -- Create page frame for this tab
    local pageFrame = Instance.new("ScrollingFrame", self.PagesFrame)
    pageFrame.Size = UDim2.new(1, 0, 1, 0)
    pageFrame.BackgroundTransparency = 1
    pageFrame.ScrollBarThickness = 6
    pageFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    pageFrame.Visible = false
    pageFrame.BorderSizePixel = 0

    local layout = Instance.new("UIListLayout", pageFrame)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 8)
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        pageFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end)

    -- Store tab and page
    self.Tabs[tabIndex] = tabButton
    self.Pages[tabIndex] = pageFrame

    -- Tab button click: show this page, hide others
    tabButton.MouseButton1Click:Connect(function()
        self:HideAllPages()
        pageFrame.Visible = true
        tabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        tabButton.TextColor3 = Color3.fromRGB(0, 1, 0)
    end)

    -- If first tab, select it automatically
    if tabIndex == 1 then
        tabButton:MouseButton1Click()
    end

    -- Return a small API for adding controls to this page:
    local tabApi = {}

    function tabApi:AddButton(text, callback)
        local button = Instance.new("TextButton", pageFrame)
        button.Size = UDim2.new(1, -20, 0, 30)
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        button.TextColor3 = Color3.new(1, 1, 1)
        button.Font = Enum.Font.SourceSans
        button.TextSize = 16
        button.Text = text or "Button"
        button.BorderSizePixel = 0

        button.MouseButton1Click:Connect(function()
            pcall(callback)
        end)

        return button
    end

    function tabApi:AddSubmit(placeholderText, callback)
        local frame = Instance.new("Frame", pageFrame)
        frame.Size = UDim2.new(1, -20, 0, 30)
        frame.BackgroundTransparency = 1
        frame.BorderSizePixel = 0

        local textBox = Instance.new("TextBox", frame)
        textBox.Size = UDim2.new(0.7, 0, 1, 0)
        textBox.Position = UDim2.new(0, 0, 0, 0)
        textBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        textBox.TextColor3 = Color3.new(1, 1, 1)
        textBox.TextSize = 14
        textBox.Font = Enum.Font.SourceSans
        textBox.PlaceholderText = placeholderText or "Enter text"

        local submitBtn = Instance.new("TextButton", frame)
        submitBtn.Size = UDim2.new(0.3, 0, 1, 0)
        submitBtn.Position = UDim2.new(0.7, 0, 0, 0)
        submitBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        submitBtn.TextColor3 = Color3.new(1, 1, 1)
        submitBtn.TextSize = 14
        submitBtn.Font = Enum.Font.SourceSans
        submitBtn.Text = "Submit"
        submitBtn.BorderSizePixel = 0

        submitBtn.MouseButton1Click:Connect(function()
            pcall(callback, textBox.Text)
        end)

        return frame
    end

    function tabApi:AddToggle(text, callback)
        local frame = Instance.new("Frame", pageFrame)
        frame.Size = UDim2.new(1, -20, 0, 30)
        frame.BackgroundTransparency = 1
        frame.BorderSizePixel = 0

        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(0.7, 0, 1, 0)
        label.Position = UDim2.new(0, 0, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = text or "Toggle"
        label.Font = Enum.Font.SourceSans
        label.TextSize = 16
        label.TextColor3 = Color3.new(1, 1, 1)
        label.TextXAlignment = Enum.TextXAlignment.Left

        local toggleBtn = Instance.new("TextButton", frame)
        toggleBtn.Size = UDim2.new(0.3, 0, 1, 0)
        toggleBtn.Position = UDim2.new(0.7, 0, 0, 0)
        toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        toggleBtn.TextColor3 = Color3.new(1, 1, 1)
        toggleBtn.TextSize = 14
        toggleBtn.Font = Enum.Font.SourceSans
        toggleBtn.Text = "OFF"
        toggleBtn.BorderSizePixel = 0

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
