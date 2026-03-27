-- // CONFIGURATION & HELPER FUNCTIONS
local plr = game.Players.LocalPlayer
local runService = game:GetService("RunService")
local escapePosition = Vector3.new(8037, 172, 3718)

local function toggleDisguise()
    local character = plr.Character or plr.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local tool = plr.Backpack:FindFirstChild("Disguise") or character:FindFirstChild("Disguise")
    
    if tool then
        if tool.Parent ~= character then
            humanoid:EquipTool(tool)
        end
        tool:Activate()
        return true
    end
    return false
end

local function teleportTo(position)
    if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
        plr.Character:PivotTo(CFrame.new(position))
    end
end

local function getDetectionY()
    local gui = plr:FindFirstChild("PlayerGui")
    local mover = gui and gui:FindFirstChild("DetectiveGUI") 
        and gui.DetectiveGUI:FindFirstChild("Progress") 
        and gui.DetectiveGUI.Progress:FindFirstChild("Mover")
    
    if mover and mover:FindFirstChild("UIGradient") then
        return mover.UIGradient.Offset.Y
    end
    return 0.5 -- Default to safe
end

local function isDisguised()
    local character = plr.Character
    if character and character:FindFirstChild("Armour") then
        return true
    end
    return false
end

local function processItem(item)
    local pPart = item:FindFirstChild("PPart")
    local prompt = pPart and pPart:FindFirstChild("ProximityPrompt")
    
    if not prompt then return false end

    teleportTo(pPart.Position)
    print("📍 Teleported to evidence.")
    task.wait(1)

    toggleDisguise()
    print("🔓 Removed disguise.")
    task.wait(1)

    fireproximityprompt(prompt)
    print("Interact: Fired proximity prompt.")
    task.wait(1)

    teleportTo(escapePosition)
    print("🚀 Teleported to safe location.")
    task.wait(7)

    toggleDisguise()
    print("🎭 Disguised again.")
    task.wait(8)

    return true
end

-- // FUNCTION 0: INITIAL BOAT SETUP (RUNS ONCE)
local function initialBoatSetup()
    print("🚤 Performing initial boat setup...")
    
    -- Boat to building
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
    toggleDisguise()
    task.wait(1)
end

-- // FUNCTION 1: TRAVEL TO BUILDING (REPEATING LOOP)
local function travelToBuilding()
    print("🚶‍♂️ Traveling to building from boat...")
    
    -- going to building from boat
    local char3 = game.Players.LocalPlayer.Character
    char3:PivotTo(CFrame.new(-2886, -770, 15396))
    task.wait(0.5)

    local char4 = game.Players.LocalPlayer.Character
    local humanoid = char4:FindFirstChild("Humanoid")
    local root = char4:FindFirstChild("HumanoidRootPart")

    print("🏃‍♂️ Forcing WalkSpeed bypass (Ignoring Y-Axis)...")
    local forceSpeed = runService.Heartbeat:Connect(function()
        if humanoid then humanoid.WalkSpeed = 45 end
    end)

    humanoid:MoveTo(Vector3.new(-2854, root.Position.Y, 15430))
    humanoid.MoveToFinished:Wait()
    humanoid:MoveTo(Vector3.new(-2814, root.Position.Y, 15313))
    humanoid.MoveToFinished:Wait()
    humanoid:MoveTo(Vector3.new(-2726, root.Position.Y, 15268))
    humanoid.MoveToFinished:Wait()
    humanoid:MoveTo(Vector3.new(-2683, root.Position.Y, 15215))
    humanoid.MoveToFinished:Wait()
    humanoid:MoveTo(Vector3.new(-2581, root.Position.Y, 15278))
    humanoid.MoveToFinished:Wait()
    humanoid:MoveTo(Vector3.new(-2540, root.Position.Y, 15442))
    humanoid.MoveToFinished:Wait()
    humanoid:MoveTo(Vector3.new(-2451, root.Position.Y, 15529))
    humanoid.MoveToFinished:Wait()
    humanoid:MoveTo(Vector3.new(-2403, root.Position.Y, 15519))
    humanoid.MoveToFinished:Wait()
    humanoid:MoveTo(Vector3.new(-2308, root.Position.Y, 15558))
    humanoid.MoveToFinished:Wait()
    humanoid:MoveTo(Vector3.new(-2309, root.Position.Y, 15644))
    humanoid.MoveToFinished:Wait()
    humanoid:MoveTo(Vector3.new(-2277, root.Position.Y, 15721))
    humanoid.MoveToFinished:Wait()
    humanoid:MoveTo(Vector3.new(-2124, root.Position.Y, 15875))
    humanoid.MoveToFinished:Wait()
    humanoid:MoveTo(Vector3.new(-2123, root.Position.Y, 15905))
    humanoid.MoveToFinished:Wait()
    humanoid:MoveTo(Vector3.new(-2059, root.Position.Y, 15974))
    humanoid.MoveToFinished:Wait()
    humanoid:MoveTo(Vector3.new(-1987, root.Position.Y, 15903))
    humanoid.MoveToFinished:Wait()

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
    task.wait(2)
    
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
    task.wait(5)
end

-- // FUNCTION 2: FARM EVIDENCE
local function farmEvidence()
    print("🔍 Starting evidence farm...")
    local itemsCollected = 0
    
    while true do
        if itemsCollected >= 8 then
            print("🎒 Inventory full (8/8)! Stopping loop.")
            break
        end

        if not isDisguised() then
            toggleDisguise()
            task.wait(8)
        end

        repeat
            task.wait(1)
            if not isDisguised() then
                print("⚠️ Disguise lost while waiting! Re-equipping...")
                toggleDisguise()
                task.wait(8)
            end

            local currentY = getDetectionY()
            if currentY <= 0.17 then
                local detectionPercent = math.clamp(math.floor((0.5 - currentY) * 100), 0, 100)
                print(string.format("⚠️ [Waiting] %d%% Detected | Waiting for cooldown below 33%%...", detectionPercent))
            end
        until isDisguised() and getDetectionY() >= 0.17

        print("✅ Safe to collect! Detection below 33%. Proceeding to next item...")

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

-- // FUNCTION 3: RETURN AND DEPOSIT
local function returnAndDeposit()
    print("💰 Returning to deposit evidence...")
    
    -- using elevator to LEAVE building
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    local target = workspace.Data.Elevator.Lobby.OpenDoorPromptOutside
    rootPart.CFrame = target.CFrame * CFrame.new(-1, 1, 1)
    task.wait(1)
    
    fireproximityprompt(workspace.Data.Elevator.Lobby.OpenDoorPromptOutside.ProximityPrompt)
    task.wait(2)
    
    local player2 = game.Players.LocalPlayer
    local character2 = player2.Character or player2.CharacterAdded:Wait()
    local rootPart2 = character2:WaitForChild("HumanoidRootPart")
    local target2 = workspace.Data.Elevator.Lobby.Inside.Main
    rootPart2.CFrame = target2.CFrame * CFrame.new(0,0,0)
    task.wait(1)
    
    local player3 = game.Players.LocalPlayer
    local character3 = player3.Character or player3.CharacterAdded:Wait()
    local rootPart3 = character3:WaitForChild("HumanoidRootPart")
    local target3 = workspace.Data.Elevator.Lobby.UIPrompt
    rootPart3.CFrame = target3.CFrame * CFrame.new(-1, 1, 1)
    task.wait(1)
    
    fireproximityprompt(workspace.Data.Elevator.Lobby.UIPrompt.ProximityPrompt)
     task.wait(3)

    -- going to boat from building 
    local char4 = game.Players.LocalPlayer.Character
    char4:PivotTo(CFrame.new(-1986, -857, 15902))
    task.wait(0.5)

    local char5 = game.Players.LocalPlayer.Character
    local humanoid = char5:FindFirstChild("Humanoid")
    local root = char5:FindFirstChild("HumanoidRootPart")

    print("🏃‍♂️ Forcing WalkSpeed bypass (Ignoring Y-Axis)...")
    local forceSpeed = runService.Heartbeat:Connect(function()
        if humanoid then humanoid.WalkSpeed = 45 end
    end)

    humanoid:MoveTo(Vector3.new(-2059, root.Position.Y, 15974))
    humanoid.MoveToFinished:Wait()
    humanoid:MoveTo(Vector3.new(-2123, root.Position.Y, 15905))
    humanoid.MoveToFinished:Wait()
    humanoid:MoveTo(Vector3.new(-2124, root.Position.Y, 15875))
    humanoid.MoveToFinished:Wait()
    humanoid:MoveTo(Vector3.new(-2277, root.Position.Y, 15721))
    humanoid.MoveToFinished:Wait()
    humanoid:MoveTo(Vector3.new(-2309, root.Position.Y, 15644))
    humanoid.MoveToFinished:Wait()
    humanoid:MoveTo(Vector3.new(-2308, root.Position.Y, 15558))
    humanoid.MoveToFinished:Wait()
    humanoid:MoveTo(Vector3.new(-2403, root.Position.Y, 15519))
    humanoid.MoveToFinished:Wait()
    humanoid:MoveTo(Vector3.new(-2451, root.Position.Y, 15529))
    humanoid.MoveToFinished:Wait()
    humanoid:MoveTo(Vector3.new(-2540, root.Position.Y, 15442))
    humanoid.MoveToFinished:Wait()
    humanoid:MoveTo(Vector3.new(-2581, root.Position.Y, 15278))
    humanoid.MoveToFinished:Wait()
    humanoid:MoveTo(Vector3.new(-2683, root.Position.Y, 15215))
    humanoid.MoveToFinished:Wait()
    humanoid:MoveTo(Vector3.new(-2726, root.Position.Y, 15268))
    humanoid.MoveToFinished:Wait()
    humanoid:MoveTo(Vector3.new(-2814, root.Position.Y, 15313))
    humanoid.MoveToFinished:Wait()
    humanoid:MoveTo(Vector3.new(-2854, root.Position.Y, 15430))
    humanoid.MoveToFinished:Wait()
    humanoid:MoveTo(Vector3.new(-2928, root.Position.Y, 15395))
    humanoid.MoveToFinished:Wait()

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
    task.wait(2)
    
    fireproximityprompt(workspace.Data.Detective.Boat["Speedy Bowrider"].RearPart.Attachment.ProximityPrompt)
    task.wait(3)
end

-- // INITIALIZATION
initialBoatSetup()

-- // MASTER LOOP
while true do
    travelToBuilding()  -- Part 1
    farmEvidence()      -- Part 2
    returnAndDeposit()  -- Part 3
    
    print("🔁 Cycle complete! Waiting 5 seconds before restarting...")
    task.wait(5)
end
