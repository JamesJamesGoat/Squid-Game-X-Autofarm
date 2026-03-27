-- determines what place ID and runs according script
-- Wait for the game to load natively
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- 🛡️ SAFEGUARD: Wait for PlaceId to fetch
while game.PlaceId == 0 do
    task.wait(0.1)
end

local currentPlaceId = tonumber(game.PlaceId)

if currentPlaceId == 7559074529 then
    print("🔗 Detective Game Detected! Routing to partition script...")
    -- PASTE YOUR RAW GITHUB/PASTEBIN LINK FOR SCRIPT #2 HERE:
    loadstring(game:HttpGet("YOUR_RAW_LINK_TO_DETECTIVE_SCRIPT"))()

elseif currentPlaceId == 7554888362 then
    print("🔗 Register Game Detected! Routing to partition script...")
    -- PASTE YOUR RAW GITHUB/PASTEBIN LINK FOR SCRIPT #3 HERE:
    loadstring(game:HttpGet("YOUR_RAW_LINK_TO_REGISTER_SCRIPT"))()

else
    print("❌ Not in a targeted PlaceId. Loader remaining idle.")
end
