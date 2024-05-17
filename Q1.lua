-- Constant Variables to remove copy and paste of the same values. 
-- In a real scenario, these values would more than likely come from another function or system.
local STORAGE_KEY = 1000 -- Storage key
local RELEASE_DELAY_MS = 1000 -- Delay in milliseconds

-- Releases the specified Storage Key from the players inventory
local function releaseStorage(player)
    local status = player:setStorageValue(STORAGE_KEY, -1) 
    if not status then
        print("ERROR: Failed to release storage for player: " .. player:getName())
        -- Add any additional error handling here.
    end
end

-- OnLogout Event, releases the Storage Key if its value is set to 1
function onLogout(player)
    if player:getStorageValue(STORAGE_KEY) == 1 then
        addEvent(releaseStorage, RELEASE_DELAY_MS, player) -- Assuming the 1000 was the delay in milliseconds
    end
    return true -- Always return true for OnLogout events, unless you want to prevent the player from logging out if the releaseStorage function fails and you want to retry or do something else.
end