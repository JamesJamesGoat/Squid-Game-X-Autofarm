-- script to walk to que area, will timeout after 2 mins 30 sec and rejoin if still in game
local plr = game.Players.LocalPlayer
local runService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local PathfindingService = game:GetService("PathfindingService")

print("✅ Register Partition Loaded - Calculating path to queue...")

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

-- // PATHFINDING LOGIC
local targetPos = Vector3.new(312, 20, -625)

-- Create the path settings
local path = PathfindingService:CreatePath({
    AgentRadius = 2,
    AgentHeight = 5,
    AgentCanJump = true,
    WaypointSpacing = 4
})

-- Compute the path wrapped in a pcall for safety
local success, errorMessage = pcall(function()
    path:ComputeAsync(rootPart.Position, targetPos)
end)

if success and path.Status == Enum.PathStatus.Success then
    print("🗺️ Path successfully calculated! Following waypoints...")
    local waypoints = path:GetWaypoints()
    
    for i, waypoint in ipairs(waypoints) do
        -- If the waypoint requires a jump, make the character jump
        if waypoint.Action == Enum.PathWaypointAction.Jump then
            humanoid.Jump = true
        end
        
        -- Move to the next breadcrumb and wait until we reach it
        humanoid:MoveTo(waypoint.Position)
        humanoid.MoveToFinished:Wait()
    end
    print("🏁 Arrived at the queue via Pathfinding!")
else
    -- // INSTANT TELEPORT FALLBACK
    warn("⚠️ Pathfinding failed (Status: " .. tostring(path.Status) .. "). Teleporting instantly to queue...")
    
    -- PivotTo is the safest way to instantly teleport a whole character model
    character:PivotTo(CFrame.new(targetPos))
    
    print("🏁 Arrived at the queue via Teleport!")
end

-- Clean up the WalkSpeed loop so it doesn't run forever
if forceSpeed then forceSpeed:Disconnect() end
