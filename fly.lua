local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local flying = false
local flySpeed = 50
local bodyVelocity
local bodyGyro

function startFly()
    if flying then return end
    
    local character = LocalPlayer.Character
    if not character then return end
    if not character:FindFirstChild("HumanoidRootPart") then return end
    
    flying = true
    
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
    bodyVelocity.Parent = character.HumanoidRootPart
    
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
    bodyGyro.P = 1000
    bodyGyro.D = 50
    bodyGyro.Parent = character.HumanoidRootPart
    
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if not flying or not character or not character.HumanoidRootPart then
            connection:Disconnect()
            return
        end
        
        bodyGyro.CFrame = workspace.CurrentCamera.CFrame
        
        local direction = Vector3.new()
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            direction = direction + workspace.CurrentCamera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            direction = direction - workspace.CurrentCamera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            direction = direction - workspace.CurrentCamera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            direction = direction + workspace.CurrentCamera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            direction = direction + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            direction = direction - Vector3.new(0, 1, 0)
        end
        
        if direction.Magnitude > 0 then
            direction = direction.Unit * flySpeed
        end
        
        bodyVelocity.Velocity = direction
    end)
end

function stopFly()
    flying = false
    
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        if bodyVelocity then
            bodyVelocity:Destroy()
            bodyVelocity = nil
        end
        if bodyGyro then
            bodyGyro:Destroy()
            bodyGyro = nil
        end
    end
end

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Q then
        if flying then
            stopFly()
        else
            startFly()
        end
    end
end)

startFly()
