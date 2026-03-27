-- script to walk to que area, will timeout after 2 mins 30 sec and rejoin if still in game
local plr = game.Players.LocalPlayer
local runService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")

print("✅ Register Partition Loaded - Walking to matchmaking queue...")

-- Start the 150-second Fail-Safe (Teleports instead of closing)
task.delay(150, function()
    warn("⏱️ 150 seconds reached in Register game. Teleporting to a new server...")
    TeleportService:Teleport(7554888362, plr) 
end)

local character = plr.Character or plr.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

task.wait(3) 

print("🏃‍♂️ Forcing WalkSpeed bypass (35)...")
local forceSpeed = runService.Heartbeat:Connect(function()
    if humanoid then humanoid.WalkSpeed = 35 end
end)

print("🚶‍♂️ Moving to queue pad...")
humanoid:MoveTo(Vector3.new(312, 20, -625))

humanoid.MoveToFinished:Wait()
print("🏁 Arrived at the queue! Waiting to be teleported to the Main Game...")

if forceSpeed then forceSpeed:Disconnect() end
