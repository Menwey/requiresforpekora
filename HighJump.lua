function HighJump(power)
    power = power or 150
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.JumpPower = power
            print("✅ HighJump: " .. power)
        end
    end
end
