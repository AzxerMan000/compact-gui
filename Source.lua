local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local CompactGui = {}
CompactGui.__index = CompactGui

function CompactGui.new(titleText, config)
    config = config or {}
    local self = setmetatable({}, CompactGui)

    self.useKeySystem = config.useKeySystem or false
    self.correctKey = config.correctKey or "Compact123"
    self.keyLink = config.keyLink or "https://your-key-link.here"
    self._titleText = titleText or "CompactGui"

    if self.useKeySystem then
        -- Key system UI
        local keyGui = Instance.new("ScreenGui")
        keyGui.Name = "CompactGuiKeyUI"
        keyGui.ResetOnSpawn = false
        keyGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

        local frame = Instance.new("Frame", keyGui)
        frame.Size = UDim2.new(0, 260, 0, 130)
        frame.Position = UDim2.new(0.5, -130, 0.5, -65)
        frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        frame.Active = true
        frame.Draggable = true
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

        local titleLabel = Instance.new("TextLabel", frame)
        titleLabel.Text = "🔐 Enter Key"
        titleLabel.Size = UDim2.new(1, 0, 0, 30)
        titleLabel.Position = UDim2.new(0, 0, 0, 5)
        titleLabel.BackgroundTransparency = 1
        titleLabel.TextColor3 = Color3.new(1, 1, 1)
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextSize = 18

        local keyBox = Instance.new("TextBox", frame)
        keyBox.PlaceholderText = "Enter Key Here"
        keyBox.Size = UDim2.new(0.8, 0, 0, 26)
        keyBox.Position = UDim2.new(0.1, 0, 0, 45)
        keyBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        keyBox.TextColor3 = Color3.new(1, 1, 1)
        keyBox.TextSize = 13
        keyBox.Font = Enum.Font.Gotham
        Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 6)

        local getKey = Instance.new("TextButton", frame)
        getKey.Text = "Get Key"
        getKey.Size = UDim2.new(0.4, -5, 0, 26)
        getKey.Position = UDim2.new(0.1, 0, 0, 85)
        getKey.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
        getKey.TextColor3 = Color3.new(1, 1, 1)
        getKey.Font = Enum.Font.Gotham
        getKey.TextSize = 13
        Instance.new("UICorner", getKey).CornerRadius = UDim.new(0, 6)

        local submit = Instance.new("TextButton", frame)
        submit.Text = "Submit"
        submit.Size = UDim2.new(0.4, -5, 0, 26)
        submit.Position = UDim2.new(0.5, 5, 0, 85)
        submit.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        submit.TextColor3 = Color3.new(1, 1, 1)
        submit.Font = Enum.Font.GothamBold
        submit.TextSize = 13
        Instance.new("UICorner", submit).CornerRadius = UDim.new(0, 6)

        getKey.MouseButton1Click:Connect(function()
            pcall(function()
                setclipboard(self.keyLink)
            end)
            StarterGui:SetCore("SendNotification", {
                Title = "CompactGui",
                Text = "Key link copied to clipboard!",
                Duration = 3
            })
        end)

        submit.MouseButton1Click:Connect(function()
            local inputKey = keyBox.Text
            if inputKey == self.correctKey then
                keyGui:Destroy()
                self:CreateMainGui(self._titleText)
            else
                StarterGui:SetCore("SendNotification", {
                    Title = "CompactGui",
                    Text = "Incorrect Key!",
                    Duration = 3
                })
            end
        end)
    else
        self:CreateMainGui(self._titleText)
    end

    return self
end

function CompactGui:CreateMainGui(titleText)
    self.gui = Instance.new("ScreenGui")
    self.gui.Name = "CompactGui"
    self.gui.ResetOnSpawn = false
    self.gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

    self.main = Instance.new("Frame", self.gui)
    self.main.Size = UDim2.new(0, 400, 0, 260)
    self.main.Position = UDim2.new(0.5, -200, 0.5, -130)
    self.main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    self.main.Active = true
    self.main.Draggable = true
    Instance.new("UICorner", self.main).CornerRadius = UDim.new(0, 12)

    self.title = Instance.new("TextLabel", self.main)
    self.title.Size = UDim2.new(1, -80, 0, 25)
    self.title.Position = UDim2.new(0, 10, 0, 5)
    self.title.Text = titleText or "CompactGui"
    self.title.BackgroundTransparency = 1
    self.title.TextColor3 = Color3.new(1, 1, 1)
    self.title.Font = Enum.Font.GothamBold
    self.title.TextSize = 18
    self.title.TextXAlignment = Enum.TextXAlignment.Left

    self.kill = Instance.new("TextButton", self.main)
    self.kill.Size = UDim2.new(0, 30, 0, 22)
    self.kill.Position = UDim2.new(1, -35, 0, 5)
    self.kill.Text = "X"
    self.kill.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    self.kill.TextColor3 = Color3.new(1, 1, 1)
    self.kill.Font = Enum.Font.GothamBold
    self.kill.TextSize = 16
    Instance.new("UICorner", self.kill).CornerRadius = UDim.new(0, 6)

    self.minimize = Instance.new("TextButton", self.main)
    self.minimize.Size = UDim2.new(0, 30, 0, 22)
    self.minimize.Position = UDim2.new(1, -70, 0, 5)
    self.minimize.Text = "-"
    self.minimize.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    self.minimize.TextColor3 = Color3.new(1, 1, 1)
    self.minimize.Font = Enum.Font.GothamBold
    self.minimize.TextSize = 16
    Instance.new("UICorner", self.minimize).CornerRadius = UDim.new(0, 6)

    self.restore = Instance.new("TextButton", self.gui)
    self.restore.Size = UDim2.new(0, 200, 0, 36)
    self.restore.Position = UDim2.new(0.5, -100, 0, 10)
    self.restore.Text = "Open"
    self.restore.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    self.restore.TextColor3 = Color3.new(1, 1, 1)
    self.restore.Font = Enum.Font.Gotham
    self.restore.TextSize = 16
    self.restore.Visible = false
    Instance.new("UICorner", self.restore).CornerRadius = UDim.new(0, 10)

    local stroke = Instance.new("UIStroke", self.restore)
    stroke.Thickness = 3

    local rainbowColors = {
        Color3.fromRGB(255, 0, 0),
        Color3.fromRGB(255, 127, 0),
        Color3.fromRGB(255, 255, 0),
        Color3.fromRGB(0, 255, 0),
        Color3.fromRGB(0, 0, 255),
        Color3.fromRGB(75, 0, 130),
        Color3.fromRGB(148, 0, 211),
    }

    spawn(function()
        local i = 1
        while true do
            local nextIndex = (i % #rainbowColors) + 1
            local tween = TweenService:Create(stroke, TweenInfo.new(2), {Color = rainbowColors[nextIndex]})
            tween:Play()
            tween.Completed:Wait()
            i = nextIndex
        end
    end)

                    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

                    local label = Instance.new("TextLabel", frame)
                    label.Text = name
                    label.Size = UDim2.new(0.6, 0, 1, 0)
                    label.Position = UDim2.new(0.05, 0, 0, 0)
                    label.BackgroundTransparency = 1
                    label.Font = Enum.Font.Gotham
                    label.TextSize = 16
                    label.TextColor3 = Color3.new(1, 1, 1)
                    label.TextXAlignment = Enum.TextXAlignment.Left

                    local toggle = Instance.new("TextButton", frame)
                    toggle.Size = UDim2.new(0, 50, 0, 24)
                    toggle.Position = UDim2.new(1, -60, 0.5, -12)
                    toggle.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
                    toggle.Text = "OFF"
                    toggle.TextColor3 = Color3.new(1, 1, 1)
                    toggle.Font = Enum.Font.GothamBold
                    toggle.TextSize = 14
                    Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 12)

                    local on = false
                    toggle.MouseButton1Click:Connect(function()
                        on = not on
                        toggle.Text = on and "ON" or "OFF"
                        toggle.BackgroundColor3 = on and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(120, 120, 120)
                        if callback and typeof(callback) == "function" then
                            callback(on)
                        end
                    end)
                end

            elseif k == "AddButton" then
                return function(_, name, onClick)
                    local button = Instance.new("TextButton", t.page)
                    button.Size = UDim2.new(1, 0, 0, 40)
                    button.Text = name
                    button.Font = Enum.Font.Gotham
                    button.TextSize = 16
                    button.TextColor3 = Color3.new(1, 1, 1)
                    button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)

                    local currentCallback = onClick
                    button.MouseButton1Click:Connect(function()
                        if currentCallback and typeof(currentCallback) == "function" then
                            currentCallback()
                        else
                            print(name .. " button clicked!")
                        end
                    end)

                    return button, function(newCallback)
                        currentCallback = newCallback
                    end
                end
            else
                return rawget(t, k)
            end
        end
    })
end

function CompactGui:Kill()
    local tween = TweenService:Create(self.main, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 100, 0, 80),
        Position = UDim2.new(0.5, -50, 0.5, -40),
        BackgroundTransparency = 1,
    })
    tween:Play()
    tween.Completed:Wait()
    self.gui:Destroy()
end

function CompactGui:Minimize()
    self.main.Visible = false
    self.restore.Visible = true
end

function CompactGui:Restore()
    self.main.Visible = true
    self.restore.Visible = false
    self.main.Size = UDim2.new(0, 100, 0, 80)
    self.main.Position = UDim2.new(0.5, -50, 0.5, -40)
    self.main.BackgroundTransparency = 1

    local tween = TweenService:Create(self.main, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 500, 0, 400),
        Position = UDim2.new(0.5, -250, 0.5, -200),
        BackgroundTransparency = 0,
    })
    tween:Play()
end

return CompactGui
