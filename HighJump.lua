-- HighJump отдельно
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

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

SetHighJump(100)
