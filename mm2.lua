
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

print("MM2 Script loaded!")

-- ESP для игроков
function ESP()
    print("ESP activated!")
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                local highlight = Instance.new("Highlight")
                highlight.Parent = player.Character
                highlight.Adornee = player.Character
                highlight.FillColor = Color3.new(1, 0, 0)
                highlight.OutlineColor = Color3.new(1, 1, 1)
                print("ESP added for: " .. player.Name)
            end
        end
    end
end

-- Авто-ферм монет
local coinFarmEnabled = false
function ToggleCoinFarm()
    coinFarmEnabled = not coinFarmEnabled
    print("Coin Farm: " .. (coinFarmEnabled and "ENABLED" or "DISABLED"))
    
    if coinFarmEnabled then
        while coinFarmEnabled and task.wait(1) do
            pcall(function()
                local coins = Workspace:FindFirstChild("CoinContainer")
                if coins then
                    for _, coin in pairs(coins:GetChildren()) do
                        if coin:IsA("Part") and LocalPlayer.Character then
                            local humanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            if humanoidRootPart then
                                humanoidRootPart.CFrame = coin.CFrame
                                task.wait(0.3)
                            end
                        end
                    end
                end
            end)
        end
    end
end

-- Авто-убийство
local autoKillEnabled = false
function ToggleAutoKill()
    autoKillEnabled = not autoKillEnabled
    print("Auto Kill: " .. (autoKillEnabled and "ENABLED" or "DISABLED"))
    
    if autoKillEnabled then
        while autoKillEnabled and task.wait(2) do
            pcall(function()
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        local humanoid = player.Character:FindFirstChild("Humanoid")
                        local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
                        if humanoid and humanoid.Health > 0 and humanoidRootPart and LocalPlayer.Character then
                            local myRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            if myRoot then
                                myRoot.CFrame = humanoidRootPart.CFrame
                                task.wait(0.5)
                            end
                        end
                    end
                end
            end)
        end
    end
end

-- Анти-афк
function AntiAFK()
    local VirtualUser = game:GetService("VirtualUser")
    LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
    print("Anti-AFK activated!")
end

-- Удалить двери
function RemoveDoors()
    print("Removing doors...")
    pcall(function()
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("Part") and (obj.Name:lower():find("door") or obj.Name:lower():find("gate")) then
                obj:Destroy()
            end
        end
    end)
end

-- Получить оружие
function GetGuns()
    print("Getting guns...")
    pcall(function()
        for _, gun in pairs(Workspace:GetDescendants()) do
            if gun:IsA("Tool") then
                gun.Parent = LocalPlayer.Backpack
            end
        end
    end)
end

-- Speed Hack для MM2
local speedHackEnabled = false
local originalSpeed = 16
function ToggleSpeedHack()
    speedHackEnabled = not speedHackEnabled
    print("Speed Hack: " .. (speedHackEnabled and "ENABLED" or "DISABLED"))
    
    if speedHackEnabled then
        originalSpeed = LocalPlayer.Character.Humanoid.WalkSpeed
        LocalPlayer.Character.Humanoid.WalkSpeed = 50
    else
        LocalPlayer.Character.Humanoid.WalkSpeed = originalSpeed
    end
end

-- GUI для MM2
local MM2Gui = Instance.new("ScreenGui")
MM2Gui.Name = "MM2Hacks"
MM2Gui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 400)
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
Title.Text = "MM2 HACKS - WORKING"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.Parent = MainFrame

local buttons = {
    {"ESP Players", function() ESP() end, Color3.new(1, 0, 0)},
    {"Toggle Coin Farm", function() ToggleCoinFarm() end, Color3.new(0, 1, 0)},
    {"Toggle Auto Kill", function() ToggleAutoKill() end, Color3.new(1, 0, 0)},
    {"Remove Doors", function() RemoveDoors() end, Color3.new(0.5, 0.5, 1)},
    {"Get Guns", function() GetGuns() end, Color3.new(1, 1, 0)},
    {"Speed Hack", function() ToggleSpeedHack() end, Color3.new(0, 1, 1)},
    {"Anti AFK", function() AntiAFK() end, Color3.new(1, 0.5, 0)}
}

for i, btn in ipairs(buttons) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.9, 0, 0, 40)
    button.Position = UDim2.new(0.05, 0, 0, 35 + (i * 45))
    button.BackgroundColor3 = btn[3]
    button.Text = btn[1]
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 12
    button.Parent = MainFrame
    
    button.MouseButton1Click:Connect(btn[2])
end

-- Автоматически включаем Anti-AFK
AntiAFK()
print("MM2 Script fully loaded! Check console for messages.")
