
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

-- ESP для игроков
function ESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local highlight = Instance.new("Highlight")
            highlight.Parent = player.Character
            highlight.Adornee = player.Character
            highlight.FillColor = player.TeamColor.Color
            highlight.OutlineColor = Color3.new(1, 1, 1)
        end
    end
end

-- Авто-ферм монет
function AutoFarmCoins()
    while task.wait(1) do
        pcall(function()
            local coins = Workspace:FindFirstChild("CoinContainer")
            if coins then
                for _, coin in pairs(coins:GetChildren()) do
                    if coin:IsA("Part") then
                        LocalPlayer.Character:MoveTo(coin.Position)
                        task.wait(0.5)
                    end
                end
            end
        end)
    end
end

-- Авто-убийство (для мура)
function AutoKill()
    while task.wait(2) do
        pcall(function()
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
                    if player.Character.Humanoid.Health > 0 then
                        LocalPlayer.Character:MoveTo(player.Character.HumanoidRootPart.Position)
                        task.wait(0.5)
                    end
                end
            end
        end)
    end
end

-- Анти-афк
function AntiAFK()
    local VirtualUser = game:GetService("VirtualUser")
    LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end

-- Удалить двери тюрьмы
function RemovePrisonDoors()
    pcall(function()
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj.Name:lower():find("door") or obj.Name:lower():find("gate") then
                obj:Destroy()
            end
        end
    end)
end

-- Получить все оружие
function GetAllGuns()
    pcall(function()
        for _, gun in pairs(Workspace:GetDescendants()) do
            if gun:IsA("Tool") then
                gun.Parent = LocalPlayer.Backpack
            end
        end
    end)
end

-- GUI для MM2
local MM2Gui = Instance.new("ScreenGui")
MM2Gui.Name = "MM2Hacks"
MM2Gui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 350)
MainFrame.Position = UDim2.new(0, 100, 0, 100)
MainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.new(1, 0, 0)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = MM2Gui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.new(1, 0, 0)
Title.Text = "MM2 HACKS"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.Parent = MainFrame

local buttons = {
    {"ESP Players", function() ESP() end},
    {"Auto Farm Coins", function() AutoFarmCoins() end},
    {"Auto Kill (Murderer)", function() AutoKill() end},
    {"Remove Prison Doors", function() RemovePrisonDoors() end},
    {"Get All Guns", function() GetAllGuns() end},
    {"Anti AFK", function() AntiAFK() end}
}

for i, btn in ipairs(buttons) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.9, 0, 0, 40)
    button.Position = UDim2.new(0.05, 0, 0, 35 + (i * 45))
    button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.6)
    button.Text = btn[1]
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 14
    button.Parent = MainFrame
    
    button.MouseButton1Click:Connect(btn[2])
end

-- Автоматически включаем Anti-AFK
AntiAFK()
