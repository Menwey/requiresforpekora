-- MM2 Skitek - FINAL VERSION
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

print("MM2 Skitek menu loaded! Press insert to hide/show menu")

-- Создаем GUI сразу
local MM2Gui = Instance.new("ScreenGui")
MM2Gui.Name = "MM2SkitekGUI"
MM2Gui.Parent = game:GetService("CoreGui")

-- Уведомления
function ShowNotification(text)
    local notification = Instance.new("TextLabel")
    notification.Size = UDim2.new(0, 300, 0, 40)
    notification.Position = UDim2.new(1, -320, 1, -50)
    notification.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    notification.BorderSizePixel = 0
    notification.Text = text
    notification.TextColor3 = Color3.new(1, 1, 1)
    notification.Font = Enum.Font.SourceSansBold
    notification.TextSize = 14
    notification.Parent = MM2Gui
    
    local tweenIn = TweenService:Create(notification, TweenInfo.new(0.3), {
        Position = UDim2.new(1, -320, 1, -100)
    })
    tweenIn:Play()
    
    task.wait(5)
    
    local tweenOut = TweenService:Create(notification, TweenInfo.new(0.3), {
        Position = UDim2.new(1, -320, 1, -50)
    })
    tweenOut:Play()
    
    tweenOut.Completed:Connect(function()
        notification:Destroy()
    end)
end

-- Speed Hack из твоего репозитория
local speedHackEnabled = false
function ToggleSpeedHack()
    speedHackEnabled = not speedHackEnabled
    
    if speedHackEnabled then
      
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Menwey/requiresforpekora/refs/heads/main/SpeedHack.lua"))()
        ShowNotification("Speed Hack: ON")
    else
        ShowNotification("Speed Hack: OFF")
    end
end

-- ESP квадратиками
local espEnabled = false
local espBoxes = {}

function ESP()
    espEnabled = not espEnabled
    
    if espEnabled then
        ShowNotification("ESP: ON")
        
        local function createBox(player)
            if player == LocalPlayer then return end
            
            local box = Instance.new("Frame")
            box.Size = UDim2.new(0, 50, 0, 50)
            box.BackgroundColor3 = Color3.new(1, 0, 0)
            box.BorderSizePixel = 2
            box.BorderColor3 = Color3.new(1, 1, 1)
            box.BackgroundTransparency = 0.3
            box.Visible = false
            box.Parent = MM2Gui
            
            espBoxes[player] = box
            
            local connection
            connection = RunService.RenderStepped:Connect(function()
                if not espEnabled or not player.Character then
                    connection:Disconnect()
                    if box then box:Destroy() end
                    return
                end
                
                local head = player.Character:FindFirstChild("Head")
                if head then
                    local screenPos, onScreen = Workspace.CurrentCamera:WorldToViewportPoint(head.Position)
                    if onScreen then
                        box.Visible = true
                        box.Position = UDim2.new(0, screenPos.X - 25, 0, screenPos.Y - 25)
                    else
                        box.Visible = false
                    end
                end
            end)
        end
        
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                createBox(player)
            end
        end
        
        Players.PlayerAdded:Connect(function(player)
            createBox(player)
        end)
        
    else
        ShowNotification("ESP: OFF")
        for player, box in pairs(espBoxes) do
            if box then
                box:Destroy()
            end
        end
        espBoxes = {}
    end
end

-- ФЛИНГ МУРДЕР
local flingEnabled = false
function FlingMurder()
    flingEnabled = not flingEnabled
    
    if flingEnabled then
        ShowNotification("Fling Murder: ON")
        coroutine.wrap(function()
            while flingEnabled and LocalPlayer.Character do
                pcall(function()
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character and flingEnabled then
                            local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
                            if targetRoot then
                                local bodyVelocity = Instance.new("BodyVelocity")
                                bodyVelocity.Velocity = Vector3.new(0, 100, 0)
                                bodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
                                bodyVelocity.Parent = targetRoot
                                
                                task.wait(0.3)
                                bodyVelocity:Destroy()
                                
                                targetRoot.Velocity = Vector3.new(
                                    math.random(-500, 500),
                                    math.random(200, 400),
                                    math.random(-500, 500)
                                )
                            end
                        end
                    end
                end)
                task.wait(1)
            end
        end)()
    else
        ShowNotification("Fling Murder: OFF")
    end
end

-- Коин фарм под картой
local coinFarmEnabled = false
function ToggleCoinFarm()
    coinFarmEnabled = not coinFarmEnabled
    
    if coinFarmEnabled then
        ShowNotification("Coin Farm: ON")
        coroutine.wrap(function()
            while coinFarmEnabled and LocalPlayer.Character do
                pcall(function()
                    local coins = Workspace:FindFirstChild("CoinContainer") or Workspace:FindFirstChild("Coins")
                    if coins then
                        local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if root then
                            for _, coin in pairs(coins:GetChildren()) do
                                if coin:IsA("Part") and coinFarmEnabled then
                                    local undergroundPos = coin.Position - Vector3.new(0, 50, 0)
                                    local tweenInfo = TweenInfo.new(0.2)
                                    local tween = TweenService:Create(root, tweenInfo, {CFrame = CFrame.new(undergroundPos)})
                                    tween:Play()
                                    task.wait(0.3)
                                end
                            end
                        end
                    end
                end)
                task.wait(0.3)
            end
        end)()
    else
        ShowNotification("Coin Farm: OFF")
    end
end

-- Убийство всех (телепортация врагов к игроку)
local killAllEnabled = false
function ToggleKillAll()
    killAllEnabled = not killAllEnabled
    
    if killAllEnabled then
        ShowNotification("Kill All: ON")
        coroutine.wrap(function()
            while killAllEnabled and LocalPlayer.Character do
                pcall(function()
                    local myRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if myRoot then
                        for _, player in pairs(Players:GetPlayers()) do
                            if player ~= LocalPlayer and player.Character and killAllEnabled then
                                local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
                                local humanoid = player.Character:FindFirstChild("Humanoid")
                                
                                if targetRoot and humanoid and humanoid.Health > 0 then
                                    targetRoot.CFrame = myRoot.CFrame * CFrame.new(0, 0, -3)
                                    task.wait(0.1)
                                end
                            end
                        end
                    end
                end)
                task.wait(0.5)
            end
        end)()
    else
        ShowNotification("Kill All: OFF")
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

-- Основное меню
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0, 100, 0, 100)
MainFrame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
MainFrame.BorderSizePixel = 1
MainFrame.BorderColor3 = Color3.new(0.3, 0.3, 0.3)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
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
Title.Text = "MM2 Skitek"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0, 2)
CloseButton.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
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
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 350)
ScrollFrame.Parent = MainFrame

local buttons = {
    {"Speed Hack", ToggleSpeedHack, Color3.new(0.2, 0.6, 0.2)},
    {"ESP Players", ESP, Color3.new(0.8, 0.2, 0.2)},
    {"Fling Murder", FlingMurder, Color3.new(0.9, 0.1, 0.1)},
    {"Coin Farm", ToggleCoinFarm, Color3.new(0.2, 0.5, 0.8)},
    {"Kill All", ToggleKillAll, Color3.new(0.8, 0.2, 0.2)},
    {"Anti AFK", AntiAFK, Color3.new(0.8, 0.5, 0.2)}
}

for i, btn in ipairs(buttons) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 40)
    button.Position = UDim2.new(0, 5, 0, (i-1) * 55)
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

-- анимация открытия/закрытия
local guiVisible = true

local function toggleGUI()
    if guiVisible then
        local tween = TweenService:Create(MainFrame, TweenInfo.new(0.2), {
            Size = UDim2.new(0, 0, 0, 0)
        })
        tween:Play()
        tween.Completed:Connect(function()
            MainFrame.Visible = false
            guiVisible = false
        end)
    else
        MainFrame.Visible = true
        local tween = TweenService:Create(MainFrame, TweenInfo.new(0.2), {
            Size = UDim2.new(0, 300, 0, 400)
        })
        tween:Play()
        guiVisible = true
    end
end

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        toggleGUI()
    end
end)

AntiAFK()
