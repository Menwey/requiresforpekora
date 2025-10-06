function SpeedHack(speed)
    speed = speed or 100
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = speed
            print("✅ SpeedHack: " .. speed)
        end
    end
end
