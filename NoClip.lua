
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local noclip = false
local noclipConnection

function ToggleNoClip()
    if noclip then
        noclip = false
        if noclipConnection then
            noclipConnection:Disconnect()
        end
        UpdateGUI()
    else
        noclip = true
        noclipConnection = RunService.Stepped:Connect(function()
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
        UpdateGUI()
    end
end


local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NoClipGUI"
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Position = UDim2.new(0, 50, 0, 50)
MainFrame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
MainFrame.BorderSizePixel = 1
MainFrame.BorderColor3 = Color3.new(0.3, 0.3, 0.3)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "NO-CLIP CONTROLLER"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0, 2)
CloseButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 16
CloseButton.Parent = TitleBar

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(1, -20, 0, 60)
ToggleButton.Position = UDim2.new(0, 10, 0, 40)
ToggleButton.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
ToggleButton.Text = "NO-CLIP: OFF"
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 16
ToggleButton.Parent = MainFrame

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -20, 0, 40)
StatusLabel.Position = UDim2.new(0, 10, 0, 110)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Status: Collision ON"
StatusLabel.TextColor3 = Color3.new(1, 1, 1)
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.TextSize = 14
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
StatusLabel.Parent = MainFrame


function UpdateGUI()
    if noclip then
        ToggleButton.BackgroundColor3 = Color3.new(0.2, 0.8, 0.2)
        ToggleButton.Text = "NO-CLIP: ON"
        StatusLabel.Text = "Status: No-Collision"
    else
        ToggleButton.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
        ToggleButton.Text = "NO-CLIP: OFF"
        StatusLabel.Text = "Status: Collision ON"
    end
end


CloseButton.MouseButton1Click:Connect(function()
    toggleGUI()
end)

ToggleButton.MouseButton1Click:Connect(function()
    ToggleNoClip()
end)

-- Анимация открытия/закрытия на RightShift
local guiVisible = true

local function toggleGUI()
    guiVisible = not guiVisible

    if guiVisible then
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        local tween = TweenService:Create(MainFrame, tweenInfo, {Position = UDim2.new(0, 50, 0, 50), Size = UDim2.new(0, 300, 0, 200)})
        tween:Play()
    else
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        local tween = TweenService:Create(MainFrame, tweenInfo, {Position = UDim2.new(0, -400, 0, 50), Size = UDim2.new(0, 0, 0, 0)})
        tween:Play()
    end
end

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        toggleGUI()
    end
end)


LocalPlayer.CharacterAdded:Connect(function(character)
    if noclip then
      
        if noclipConnection then
            noclipConnection:Disconnect()
        end
        noclipConnection = RunService.Stepped:Connect(function()
            if not noclip then return end
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
    end
end)

