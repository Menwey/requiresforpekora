-- MM2 Skitek - FIXED VERSION
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

print("MM2 Skitek loaded!")

-- Speed Hack
local speedHackEnabled = false
function ToggleSpeedHack()
    if not LocalPlayer.Character then return end
    local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    speedHackEnabled = not speedHackEnabled
    if speedHackEnabled then
        humanoid.WalkSpeed = 50
    else
        humanoid.WalkSpeed = 16
    end
    print("Speed Hack: " .. (speedHackEnabled and "ON" or "OFF"))
end

-- ESP для игроков
function ESP()
    print("Adding ESP...")
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local highlight = player.Character:FindFirstChild("SkitekESP")
            if not highlight then
                highlight = Instance.new("Highlight")
                highlight.Name = "SkitekESP"
                highlight.FillColor = Color3.new(1, 0, 0)
                highlight.OutlineColor = Color3.new(1, 1, 1)
                highlight.Parent = player.Character
            else
                highlight:Destroy()
            end
        end
    end
end

-- Авто-ферм монет
local coinFarmEnabled = false
function ToggleCoinFarm()
    coinFarmEnabled = not coinFarmEnabled
    print("Coin Farm: " .. (coinFarmEnabled and "ON" or "OFF"))
    
    if coinFarmEnabled then
        coroutine.wrap(function()
            while coinFarmEnabled do
                task.wait(1)
                pcall(function()
                    local coins = Workspace:FindFirstChild("CoinContainer")
                    if coins and LocalPlayer.Character then
                        local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if root then
                            for _, coin in pairs(coins:GetChildren()) do
                                if coin:IsA("Part") and coinFarmEnabled then
                                    root.CFrame = coin.CFrame
                                    task.wait(0.5)
                                end
                            end
                        end
                    end
                end)
            end
        end)()
    end
end

-- Авто-убийство
local autoKillEnabled = false
function ToggleAutoKill()
    autoKillEnabled = not autoKillEnabled
    print("Auto Kill: " .. (autoKillEnabled and "ON" or "OFF"))
    
    if autoKillEnabled then
        coroutine.wrap(function()
            while autoKillEnabled do
                task.wait(2)
                pcall(function()
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character and autoKillEnabled then
                            local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
                            local humanoid = player.Character:FindFirstChild("Humanoid")
                            local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            
                            if targetRoot and humanoid and humanoid.Health > 0 and myRoot then
                                myRoot.CFrame = targetRoot.CFrame
                                task.wait(0.5)
                            end
                        end
                    end
                end)
            end
        end)()
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
        local count = 0
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("Part") and (obj.Name:lower():find("door") or obj.Name:lower():find("gate")) then
                obj:Destroy()
                count = count + 1
            end
        end
        print("Removed " .. count .. " doors/gates")
    end)
end

-- Получить оружие
function GetGuns()
    print("Getting guns...")
    pcall(function()
        local count = 0
        for _, gun in pairs(Workspace:GetDescendants()) do
            if gun:IsA("Tool") then
                gun.Parent = LocalPlayer.Backpack
                count = count + 1
            end
        end
        print("Got " .. count .. " guns")
    end)
end

-- GUI в стиле Skitek Loader
local MM2Gui = Instance.new("ScreenGui")
MM2Gui.Name = "MM2SkitekGUI"
MM2Gui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 450)
MainFrame.Position = UDim2.new(0, 100, 0, 100)
MainFrame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
MainFrame.BorderSizePixel = 1
MainFrame.BorderColor3 = Color3.new(0.3, 0.3, 0.3)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = MM2Gui

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
Title.Text = "MM2 SKITEK"
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

CloseButton.MouseButton1Click:Connect(function()
    MM2Gui:Destroy()
end)

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -20, 1, -40)
ScrollFrame.Position = UDim2.new(0, 10, 0, 35)
ScrollFrame.BackgroundColor3 = Color3.new(0.12, 0.12, 0.12)
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 400)
ScrollFrame.Parent = MainFrame

local buttons = {
    {"Speed Hack", ToggleSpeedHack, Color3.new(0.2, 0.6, 0.2)},
    {"ESP Players", ESP, Color3.new(0.8, 0.2, 0.2)},
    {"Toggle Coin Farm", ToggleCoinFarm, Color3.new(0.2, 0.5, 0.8)},
    {"Toggle Auto Kill", ToggleAutoKill, Color3.new(0.8, 0.2, 0.2)},
    {"Remove Doors", RemoveDoors, Color3.new(0.6, 0.2, 0.8)},
    {"Get Guns", GetGuns, Color3.new(0.8, 0.8, 0.2)},
    {"Anti AFK", AntiAFK, Color3.new(0.8, 0.5, 0.2)}
}

for i, btn in ipairs(buttons) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 40)
    button.Position = UDim2.new(0, 5, 0, (i-1) * 50)
    button.BackgroundColor3 = btn[3]
    button.Text = btn[1]
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 14
    button.AutoButtonColor = true
    button.Parent = ScrollFrame
    
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = btn[3] + Color3.new(0.1, 0.1, 0.1)
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = btn[3]
    end)
    
    button.MouseButton1Click:Connect(btn[2])
end

-- Автоматически включаем Anti-AFK
AntiAFK()
print("MM2 Skitek fully loaded!")
