local noclipActive = false
local noclipConnection

function ToggleNoClip()
    if noclipActive then
        noclipActive = false
        if noclipConnection then
            noclipConnection:Disconnect()
        end
        print("✅ NoClip: OFF")
    else
        noclipActive = true
        noclipConnection = RunService.Stepped:Connect(function()
            if not noclipActive then return end
            local character = LocalPlayer.Character
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
        print("✅ NoClip: ON")
    end
end
