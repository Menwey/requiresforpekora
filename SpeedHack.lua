-- SpeedHack с GUI для настройки
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local speedHackEnabled = false
local currentSpeed = 50

-- Создаем GUI для SpeedHack
local SpeedGui = Instance.new("ScreenGui")
SpeedGui.Name = "SpeedHackGUI"
SpeedGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 250, 0, 150)
MainFrame.Position = UDim2.new(0, 50, 0, 50)
MainFrame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
MainFrame.BorderSizePixel = 1
MainFrame.BorderColor3 = Color3.new(0.3, 0.3, 0.3)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = SpeedGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Title.Text = "SPEED HACK"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 14
Title.Parent = MainFrame

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, 0, 0, 20)
SpeedLabel.Position = UDim2.new(0, 0, 0, 35)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Speed: " .. currentSpeed
SpeedLabel.TextColor3 = Color3.new(1, 1, 1)
SpeedLabel.Font = Enum.Font.SourceSans
SpeedLabel.TextSize = 12
SpeedLabel.Parent = MainFrame

local SpeedSlider = Instance.new("TextButton")
SpeedSlider.Size = UDim2.new(0.8, 0, 0, 20)
SpeedSlider.Position = UDim2.new(0.1, 0, 0, 60)
SpeedSlider.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
SpeedSlider.Text = "Change Speed"
SpeedSlider.TextColor3 = Color3.new(1, 1, 1)
SpeedSlider.Font = Enum.Font.SourceSans
SpeedSlider.TextSize = 12
SpeedSlider.Parent = MainFrame

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0.8, 0, 0, 30)
ToggleButton.Position = UDim2.new(0.1, 0, 0, 90)
ToggleButton.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
ToggleButton.Text = "ENABLE"
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 14
ToggleButton.Parent = MainFrame

local function updateSpeed()
    if speedHackEnabled then
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = currentSpeed
            end
        end
    end
    SpeedLabel.Text = "Speed: " .. currentSpeed
end

SpeedSlider.MouseButton1Click:Connect(function()
    currentSpeed = currentSpeed + 10
    if currentSpeed > 200 then
        currentSpeed = 16
    end
    updateSpeed()
end)

ToggleButton.MouseButton1Click:Connect(function()
    speedHackEnabled = not speedHackEnabled
    if speedHackEnabled then
        ToggleButton.BackgroundColor3 = Color3.new(0.2, 0.8, 0.2)
        ToggleButton.Text = "DISABLE"
    else
        ToggleButton.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
        ToggleButton.Text = "ENABLE"
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 16
            end
        end
    end
    updateSpeed()
end)

-- NoClip функция
local noclip = false
local noclipConnection

function ToggleNoClip()
    if noclip then
        noclip = false
        if noclipConnection then
            noclipConnection:Disconnect()
        end
    else
        noclip = true
        noclipConnection = game:GetService("RunService").Stepped:Connect(function()
            if not noclip then return end
            local character = LocalPlayer.Character
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
end

-- HighJump функция
function SetHighJump(power)
    power = power or 100
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.JumpPower = power
        end
    end
end

-- Автоматически устанавливаем высокий прыжок
SetHighJump(100)

-- Привязка клавиш для удобства
local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.V then
        ToggleNoClip()
    end
end)
