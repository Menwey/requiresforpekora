
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")


function ESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local highlight = Instance.new("Highlight")
            highlight.Parent = player.Character
            highlight.Adornee = player.Character
            highlight.FillColor = player.TeamColor.Color
            highlight.OutlineColor = Color3.new(1, 1, 1)
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        end
    end
end


function AutoFarmCoins()
    while true do
        wait(1)
        pcall(function()
            local coins = Workspace:FindFirstChild("CoinContainer")
            if coins then
                for _, coin in pairs(coins:GetChildren()) do
                    if coin:IsA("Part") then
                        LocalPlayer.Character:MoveTo(coin.Position)
                        wait(0.5)
                    end
                end
            end
        end)
    end
end


function AutoKill()
    while true do
        wait(2)
        pcall(function()
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
                    if player.Character.Humanoid.Health > 0 then
                        LocalPlayer.Character:MoveTo(player.Character.HumanoidRootPart.Position)
                        wait(0.5)
                    end
                end
            end
        end)
    end
end


function AntiAFK()
    local VirtualUser = game:GetService("VirtualUser")
    LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end


function RemovePrisonDoors()
    pcall(function()
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj.Name:lower():find("door") or obj.Name:lower():find("gate") then
                obj:Destroy()
            end
        end
    end)
end

function GetAllGuns()
    pcall(function()
        for _, gun in pairs(Workspace:GetDescendants()) do
            if gun:IsA("Tool") then
                gun.Parent = LocalPlayer.Backpack
            end
        end
    end)
end


local MM2Gui = Instance.new("ScreenGui")
MM2Gui.Name = "MM2Hacks"
MM2Gui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 350)
MainFrame.Position = UDim2.new(0, 50, 0, 50)
MainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.new(1, 0, 0)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = MM2Gui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0,
