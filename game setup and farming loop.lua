-- choose detective and do initial setup before starting farm loop, will rejoin if no detective picked
-- // ========================================================================
-- // 1. CONFIGURATION & HELPER FUNCTIONS
-- // ========================================================================
local plr = game.Players.LocalPlayer
local runService = game:GetService("RunService")
local repStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")

local function teleportTo(position)
    if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
        plr.Character:PivotTo(CFrame.new(position))
    end
end

-- Helper function to check if any active player is on the Guard team
local function isGuardPresent()
    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        if player.Team and player.Team.Name == "Guard" then
            return true
        end
    end
    return false
end

-- Smart walk function with Drop-In Teleport fallback
local function smartWalkTo(targetVector)
    local character = plr.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not rootPart then return end

    -- Start walking
    humanoid:MoveTo(targetVector)

    local timeout = 8 -- The Roblox engine timeout limit
    local startTime = os.clock()

    -- Loop until we are within 3 studs of the target (ignoring Y height)
    while (rootPart.Position * Vector3.new(1, 0, 1) - targetVector * Vector3.new(1, 0, 1)).Magnitude > 3 do
        task.wait(0.2)
        
        -- Timeout fail-safe (The Drop-In Teleport Fallback)
        if os.clock() - startTime > timeout then
            print("⚠️ Walk segment timed out! Teleporting safely from above...")
            
            -- We take the target's X and Z, but use our CURRENT height + 5 studs
            local safeHeight = rootPart.Position.Y + 5
            local safeTarget = Vector3.new(targetVector.X, safeHeight, targetVector.Z)
            
            -- Force teleport
            character:PivotTo(CFrame.new(safeTarget))
            
            -- Give the game engine half a second to register the drop before moving on
            task.wait(0.5) 
            break
        end
    end
end

-- Hyper-fast processing: No disguises, no safe zones. Just grab and go.
local function processItem(item)
    local pPart = item:FindFirstChild("PPart")
    local prompt = pPart and pPart:FindFirstChild("ProximityPrompt")
    
    if not prompt then return false end

    teleportTo(pPart.Position + Vector3.new(0, 4, 0))
    task.wait(1)
    fireproximityprompt(prompt)
    task.wait(1)

    return true
end

-- // ========================================================================
-- // 1.5. BACKGROUND EVENT LISTENERS (Non-Blocking)
-- // ========================================================================

-- TASK 1: Sit quietly in the background and grab the baby whenever it spawns
workspace.ChildAdded:Connect(function(child)
    if child.Name == "BabyPickup" then
        task.wait(0.3) 
        local trigger = child:FindFirstChild("Trigger")
        if trigger then
            local prompt = trigger:FindFirstChild("PickupPrompt")
            if prompt and prompt:IsA("ProximityPrompt") then
                fireproximityprompt(prompt)
                print("👶 Baby silently secured in the background!")
            end
        end
    end
end)

-- TASK 2: Game Over Watcher. Checks for the ending island and teleports back to lobby.
task.spawn(function()
    while task.wait(1) do
        local map = workspace:FindFirstChild("Map")
        if map and map:FindFirstChild("IslandEscape") then
            print("🏁 Game Over detected! Teleporting back to lobby...")
            TeleportService:Teleport(7554888362, plr)
            break -- Stops checking once the teleport is initiated
        end
    end
end)

-- // ========================================================================
-- // 2. CORE FARMING FUNCTIONS
-- // ========================================================================
local function initialBoatSetup()
    print("🚤 Performing initial boat setup...")
    
    -- Boat
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    local target = workspace.Data.Detective.Boat["Speedy Bowrider"].VehicleSeat
    rootPart.CFrame = target.CFrame * CFrame.new(0, 1, 1)
    task.wait(1)
    fireproximityprompt(workspace.Data.Detective.Boat["Speedy Bowrider"].VehicleSeat.EnterBoat)
    task.wait(3)

    -- Water TP
    local player2 = game.Players.LocalPlayer
    local character2 = player2.Character or player2.CharacterAdded:Wait()
    local rootPart2 = character2:FindFirstChild("HumanoidRootPart")
    if rootPart2 then
        rootPart2.CFrame = CFrame.new(-2938, -789, 15438)
    end
    task.wait(1)

    -- Force the character to stand up from the seat
    game:GetService("Players").LocalPlayer.Character.Humanoid.Sit = false
    task.wait(1)
    game:GetService("Players").LocalPlayer.Character.Humanoid.Sit = false
    task.wait(1)
end

local function travelToBuilding()
    print("🚶‍♂️ Traveling to building from boat...")
    
    -- going to building
    local char3 = game.Players.LocalPlayer.Character
    char3:PivotTo(CFrame.new(-2886, -770, 15396))
    task.wait(0.5)

    local char4 = game.Players.LocalPlayer.Character
    local humanoid = char4:FindFirstChild("Humanoid")
    local root = char4:FindFirstChild("HumanoidRootPart")

    local forceSpeed = runService.Heartbeat:Connect(function()
        if humanoid then humanoid.WalkSpeed = 45 end
    end)

    smartWalkTo(Vector3.new(-2854, root.Position.Y, 15430))
    smartWalkTo(Vector3.new(-2814, root.Position.Y, 15313))
    smartWalkTo(Vector3.new(-2726, root.Position.Y, 15268))
    smartWalkTo(Vector3.new(-2683, root.Position.Y, 15215))
    smartWalkTo(Vector3.new(-2581, root.Position.Y, 15278))
    smartWalkTo(Vector3.new(-2540, root.Position.Y, 15442))
    smartWalkTo(Vector3.new(-2451, root.Position.Y, 15529))
    smartWalkTo(Vector3.new(-2403, root.Position.Y, 15519))
    smartWalkTo(Vector3.new(-2308, root.Position.Y, 15558))
    smartWalkTo(Vector3.new(-2309, root.Position.Y, 15644))
    smartWalkTo(Vector3.new(-2277, root.Position.Y, 15721))
    smartWalkTo(Vector3.new(-2124, root.Position.Y, 15875))
    smartWalkTo(Vector3.new(-2123, root.Position.Y, 15905))
    smartWalkTo(Vector3.new(-2059, root.Position.Y, 15974))
    smartWalkTo(Vector3.new(-1987, root.Position.Y, 15903))

    print("🛑 Sequence finished.")
    task.wait(0.5)
    if forceSpeed then forceSpeed:Disconnect() end

    -- using elevator to ENTER building
    local player3 = game.Players.LocalPlayer
    local character5 = player3.Character or player3.CharacterAdded:Wait()
    local rootPart3 = character5:WaitForChild("HumanoidRootPart")
    local target2 = workspace.Data.Elevator.Island.OpenDoorPromptOutside
    rootPart3.CFrame = target2.CFrame * CFrame.new(-1, 1, 1)
    task.wait(1)
    
    fireproximityprompt(workspace.Data.Elevator.Island.OpenDoorPromptOutside.ProximityPrompt)
    task.wait(1)
    
    local player4 = game.Players.LocalPlayer
    local character6 = player4.Character or player4.CharacterAdded:Wait()
    local rootPart4 = character6:WaitForChild("HumanoidRootPart")
    local target3 = workspace.Data.Elevator.Island.Inside.Main
    rootPart4.CFrame = target3.CFrame * CFrame.new(0,0,0)
    task.wait(1)
    
    local player5 = game.Players.LocalPlayer
    local character7 = player5.Character or player5.CharacterAdded:Wait()
    local rootPart5 = character7:WaitForChild("HumanoidRootPart")
    local target4 = workspace.Data.Elevator.Island.UIPrompt
    rootPart5.CFrame = target4.CFrame * CFrame.new(0, 1, 1)
    task.wait(1)
    
    fireproximityprompt(workspace.Data.Elevator.Island.UIPrompt.ProximityPrompt)
    task.wait(3)
end

local function farmEvidence()
    print("🔍 Starting evidence farm (Speed Mode)...")
    local itemsCollected = 0
    
    while true do
        if itemsCollected >= 8 then
            print("🎒 Inventory full (8/8)! Stopping loop.")
            break
        end

        local folder = workspace:FindFirstChild("Data") 
            and workspace.Data:FindFirstChild("Detective") 
            and workspace.Data.Detective:FindFirstChild("Evidence") 
            and workspace.Data.Detective.Evidence:FindFirstChild("Instances")

        if folder then
            local items = folder:GetChildren()
            if #items > 0 then
                local targetItem = items[1]
                if processItem(targetItem) then
                    itemsCollected = itemsCollected + 1
                    print("📊 Items: " .. itemsCollected .. "/8")
                end
            else
                task.wait(1)
            end
        else
            warn("Evidence folder path not found!")
            task.wait(2)
        end
    end
end

local function returnAndDeposit()
    print("💰 Returning to deposit evidence...")
    
    -- using elevator to LEAVE building
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    local target = workspace.Data.Elevator.Lobby.OpenDoorPromptOutside
    rootPart.CFrame = target.CFrame * CFrame.new(-1, 1, 1)
    task.wait(0.5)
    
    fireproximityprompt(workspace.Data.Elevator.Lobby.OpenDoorPromptOutside.ProximityPrompt)
    task.wait(1)
    
    local player2 = game.Players.LocalPlayer
    local character2 = player2.Character or player2.CharacterAdded:Wait()
    local rootPart2 = character2:WaitForChild("HumanoidRootPart")
    local target2 = workspace.Data.Elevator.Lobby.Inside.Main
    rootPart2.CFrame = target2.CFrame * CFrame.new(2,0,0)
    task.wait(0.5)
    
    local player3 = game.Players.LocalPlayer
    local character3 = player3.Character or player3.CharacterAdded:Wait()
    local rootPart3 = character3:WaitForChild("HumanoidRootPart")
    local target3 = workspace.Data.Elevator.Lobby.UIPrompt
    rootPart3.CFrame = target3.CFrame * CFrame.new(-1, 1, 1)
    task.wait(0.5)
    
    fireproximityprompt(workspace.Data.Elevator.Lobby.UIPrompt.ProximityPrompt)
     task.wait(0.5)

    -- going to boat from building 
    local char4 = game.Players.LocalPlayer.Character
    char4:PivotTo(CFrame.new(-1986, -857, 15902))
    task.wait(0.5)

    local char5 = game.Players.LocalPlayer.Character
    local humanoid = char5:FindFirstChild("Humanoid")
    local root = char5:FindFirstChild("HumanoidRootPart")

    local forceSpeed = runService.Heartbeat:Connect(function()
        if humanoid then humanoid.WalkSpeed = 45 end
    end)

    smartWalkTo(Vector3.new(-2059, root.Position.Y, 15974))
    smartWalkTo(Vector3.new(-2123, root.Position.Y, 15905))
    smartWalkTo(Vector3.new(-2124, root.Position.Y, 15875))
    smartWalkTo(Vector3.new(-2277, root.Position.Y, 15721))
    smartWalkTo(Vector3.new(-2309, root.Position.Y, 15644))
    smartWalkTo(Vector3.new(-2308, root.Position.Y, 15558))
    smartWalkTo(Vector3.new(-2403, root.Position.Y, 15519))
    smartWalkTo(Vector3.new(-2451, root.Position.Y, 15529))
    smartWalkTo(Vector3.new(-2540, root.Position.Y, 15442))
    smartWalkTo(Vector3.new(-2581, root.Position.Y, 15278))
    smartWalkTo(Vector3.new(-2683, root.Position.Y, 15215))
    smartWalkTo(Vector3.new(-2726, root.Position.Y, 15268))
    smartWalkTo(Vector3.new(-2814, root.Position.Y, 15313))
    smartWalkTo(Vector3.new(-2854, root.Position.Y, 15430))
    smartWalkTo(Vector3.new(-2928, root.Position.Y, 15395))

    print("🛑 Sequence finished.")
    task.wait(0.5)
    if forceSpeed then forceSpeed:Disconnect() end
    task.wait(1)

-- tp to boat and fire
    local player4 = game.Players.LocalPlayer
    local character6 = player4.Character or player4.CharacterAdded:Wait()
    local rootPart4 = character6:WaitForChild("HumanoidRootPart")
    local target4 = workspace.Data.Detective.Boat["Speedy Bowrider"].RearPart
    rootPart4.CFrame = target4.CFrame * CFrame.new(0, 5, 0)
    task.wait(1)
    
    fireproximityprompt(workspace.Data.Detective.Boat["Speedy Bowrider"].RearPart.Attachment.ProximityPrompt)
    
    -- Give the server 2 seconds to process the deposit and update your money
    task.wait(2) 

    -- ✨ NEW: Read the bank account and print the total
    local leaderstats = plr:FindFirstChild("leaderstats")
    local coins = leaderstats and leaderstats:FindFirstChild("Coins")
    
    if coins then
        print("💰 Deposit successful! Current Coin Balance: " .. coins.Value)
    end
end

-- // ========================================================================
-- // 3. AUTO-JOIN SEQUENCE
-- // ========================================================================
print("✅ Detective Partition Loaded - Attempting Auto-Join...")

local startTime = os.clock()
local globalTimeout = 20
local successfullyJoined = false

local remotes = repStorage:WaitForChild("Remotes", globalTimeout)
local timeRemaining = globalTimeout - (os.clock() - startTime)
local teamRemote = remotes and remotes:WaitForChild("UseDetectiveGamepass", math.max(0, timeRemaining))

if teamRemote then
    while (os.clock() - startTime) < globalTimeout do
        local playerGui = plr:FindFirstChild("PlayerGui")
        local detectiveGui = playerGui and playerGui:FindFirstChild("DetectiveGUI")
        
        if detectiveGui then
            print("🎉 Detective GUI found! Successfully joined the team.")
            successfullyJoined = true
            
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
            
            print("⏳ Waiting 2 seconds before executing boat setup...")
            task.wait(2)
            
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

-- // ========================================================================
-- // 4. MASTER FARMING LOOP (Death-Proof & Memory Edition)
-- // ========================================================================
if successfullyJoined then
    print("🚀 Auto-Join Complete. Initializing Death-Proof Master Loop...")

    local farmThread = nil 
    
    local totalDeposits = 0 
    local maxDeposits = 7

    local function startFarmCycle()
        farmThread = task.spawn(function()
            
            initialBoatSetup() 
            
            -- ✨ NEW: The 5-Second Double-Check Guard Exploit
            if not isGuardPresent() then
                print("⏳ No Guard detected on load. Waiting 5 seconds for late loaders...")
                task.wait(5)
                
                -- The second check
                if not isGuardPresent() then
                    print("❌ Still no Guard in server! Teleporting to lobby to server hop...")
                    TeleportService:Teleport(7554888362, plr)
                    return -- Kills the thread entirely while waiting for teleport
                else
                    print("👮 Guard finally loaded in! Proceeding with speed farm...")
                end
            else
                print("👮 Guard confirmed immediately! Executing speed farm...")
            end
            
            -- Loop runs based on the surviving global counter
            while totalDeposits < maxDeposits do
                local currentCycle = totalDeposits + 1
                print(string.format("🚀 Starting Farm Cycle %d of %d...", currentCycle, maxDeposits))
                
                travelToBuilding()  -- Part 1
                farmEvidence()      -- Part 2
                returnAndDeposit()  -- Part 3
                
                -- We only add +1 AFTER you successfully deposit
                totalDeposits = totalDeposits + 1
                
                -- Smart prints, but ALWAYS waits 5 seconds to protect data
                if totalDeposits == maxDeposits then
                    print("💾 Final deposit complete! Waiting additional 2 seconds before hopping...")
                    task.wait(2)
                else
                    print(string.format("🔁 Cycle %d complete! Waiting 2 seconds before next run...", totalDeposits))
                end
                
                task.wait(2)
            end
            
            print("🛑 Max server deposits reached (7/7)! Teleporting to new server...")
            TeleportService:Teleport(7554888362, plr)
            
        end)
    end

    local function setupCharacter(character)
        if farmThread then
            task.cancel(farmThread)
            farmThread = nil
        end

        local humanoid = character:WaitForChild("Humanoid")
        
        humanoid.Died:Connect(function()
            print("💀 Character died! Instantly killing the farm loop to prevent errors...")
            if farmThread then
                task.cancel(farmThread)
                farmThread = nil
            end
        end)

        task.wait(5) 
        print("🔄 Character loaded! Starting fresh farm sequence...")
        startFarmCycle()
    end

    plr.CharacterAdded:Connect(setupCharacter)

    if plr.Character then
        setupCharacter(plr.Character)
    end
end
