-- Compact GUI Library local compactGui = {} compactGui.__index = compactGui

function compactGui.new(title) local self = setmetatable({}, compactGui)

local screenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
screenGui.Name = "CompactGui"

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 250, 0, 200)
mainFrame.Position = UDim2.new(0.5, -125, 0.5, -100)
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

local buttonLayout = Instance.new("UIListLayout", mainFrame)
buttonLayout.SortOrder = Enum.SortOrder.LayoutOrder
buttonLayout.Padding = UDim.new(0, 6)
buttonLayout.VerticalAlignment = Enum.VerticalAlignment.Top
buttonLayout.FillDirection = Enum.FillDirection.Vertical
buttonLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    mainFrame.Size = UDim2.new(0, 250, 0, titleLabel.Size.Y.Offset + buttonLayout.AbsoluteContentSize.Y + 12)
end)

self.Frame = mainFrame
self.Title = titleLabel

return self

end

function compactGui:AddButton(text, callback) local button = Instance.new("TextButton", self.Frame) button.Size = UDim2.new(1, -20, 0, 30) button.BackgroundColor3 = Color3.fromRGB(50, 50, 50) button.TextColor3 = Color3.new(1, 1, 1) button.Font = Enum.Font.SourceSans button.TextSize = 16 button.Text = text or "Button" button.AutoButtonColor = true button.BorderSizePixel = 0

button.MouseButton1Click:Connect(function()
    pcall(callback)
end)

return button

end

function compactGui:AddSubmit(text, callback) local frame = Instance.new("Frame", self.Frame) frame.Size = UDim2.new(1, -20, 0, 30) frame.BackgroundTransparency = 1 frame.BorderSizePixel = 0

local textBox = Instance.new("TextBox", frame)
textBox.Size = UDim2.new(0.7, 0, 1, 0)
textBox.Position = UDim2.new(0, 0, 0, 0)
textBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
textBox.TextColor3 = Color3.new(1, 1, 1)
textBox.TextSize = 14
textBox.Font = Enum.Font.SourceSans
textBox.PlaceholderText = text or "Enter text"

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

return compactGui

