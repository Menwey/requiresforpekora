-- NoClip отдельно
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

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
    end
end

ToggleNoClip()
