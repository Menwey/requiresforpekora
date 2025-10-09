local tool
for i,v in pairs (game.Players:GetPlayers()) do
 tool = v.Backpack:FindFirstChild'OddPotion' or v.Character:FindFirstChild'OddPotion'
 if tool then break end
end
 
for i,v in pairs(workspace.NewerMap:GetDescendants()) do
 tool.TransEvent:FireServer(v,1)
end
-- 
