-- choose detective and do initial setup before starting farm loop, will rejoin if no detective picked
local plr = game.Players.LocalPlayer
local repStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")

print("✅ Detective Partition Loaded - Attempting Auto-Join...")

local startTime = os.clock()
local globalTimeout = 20

local remotes = repStorage:WaitForChild("Remotes", globalTimeout)
local timeRemaining = globalTimeout - (os.clock() - startTime)
local teamRemote = remotes and remotes:WaitForChild("UseDetectiveGamepass", math.max(0, timeRemaining))

if teamRemote then
    while (os.clock() - startTime) < globalTimeout do
        local playerGui = plr:FindFirstChild("PlayerGui")
        local detectiveGui = playerGui and playerGui:FindFirstChild("DetectiveGUI")
        
        if detectiveGui then
            print("🎉 Detective GUI found! Successfully joined the team.")
            
            print("⏳ Waiting 5 seconds for tutorial UI...")
            task.wait(5)
            
            local tutorialBtn = detectiveGui:FindFirstChild("Tutorial") and detectiveGui.Tutorial:FindFirstChild("Okay")
            
            if tutorialBtn then
                print("🖱️ Closing tutorial (Click 1/2)...")
                firesignal(tutorialBtn.MouseButton1Up)
                task.wait(1)
                print("🖱️ Closing tutorial (Click 2/2)...")
                firesignal(tutorialBtn.MouseButton1Up)
                print("✅ Tutorial cleared!")
            else
                warn("⚠️ Could not find the Tutorial 'Okay' button. It may already be closed.")
            end
            
            print("🚀 Launching Detective Autofarm script...")
            local success, err = pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/JamesJamesGoat/Squid-Game-X-Autofarm/refs/heads/main/detective%20autofarm.lua"))()
            end)
            
            if not success then
                warn("❌ Failed to execute external autofarm: " .. tostring(err))
            end
            
            break 
        end
        
        teamRemote:FireServer()
        task.wait(0.5) 
    end
    
    local finalGuiCheck = plr:FindFirstChild("PlayerGui")
    if not (finalGuiCheck and finalGuiCheck:FindFirstChild("DetectiveGUI")) then
        warn("❌ Detective team full. Teleporting back to Register game...")
        TeleportService:Teleport(7554888362, plr)
    end
else
    warn("❌ 20-second timeout reached. Teleporting back to Register game...")
    TeleportService:Teleport(7554888362, plr)
end
