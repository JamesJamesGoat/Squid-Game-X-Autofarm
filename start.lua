-- determines what place ID and runs according script
-- Wait for the game to load natively
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- 🛡️ ANTI-AFK SETUP: Starts listening immediately after the game loads
local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
    print("Anti-AFK: Prevented 20-minute kick.")
end)

-- 🛡️ SAFEGUARD: Wait for PlaceId to fetch
while game.PlaceId == 0 do
    task.wait(0.5)
end

local currentPlaceId = tonumber(game.PlaceId)

-- determines what place ID and runs according script
if currentPlaceId == 7559074529 then
    print("🔗 Detective Game Detected! Routing to partition script...")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/JamesJamesGoat/Squid-Game-X-Autofarm/refs/heads/main/game%20setup%20and%20farming%20loop.lua"))()

elseif currentPlaceId == 7554888362 then
    print("🔗 Register Game Detected! Routing to partition script...")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/JamesJamesGoat/Squid-Game-X-Autofarm/refs/heads/main/lobby.lua"))()

else
    print("❌ Not in a targeted PlaceId. Loader remaining idle.")
end
