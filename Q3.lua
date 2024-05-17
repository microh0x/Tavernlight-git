-- Removes a member from a player's party if the member is found in the party
function removeMemberFromPlayerParty(playerId, targetId) -- Identify the target using their unique ID to avoid name conflicts
    -- Get the player object from the playerId
    local player = Player(playerId) -- Changed to local variable
    if not player then
        print("Player with ID " .. playerId .. " not found.")
        return false
    end

    -- Get the player's party object
    local party = player:getParty()
    if not party then
        print("Player with ID " .. playerId .. " is not in a party.")
        return false
    end

     -- Iterate through the party members and remove the specified member if found
     for _, member in pairs(party:getMembers()) do
        if member:getID() == targetId then 
            party:removeMember(member) -- No need to construct a new Player object since we already have the member object
            print("Member " .. member:getName() .. " removed from the party.")
            return true
        end
    end

    -- If the member is not found in the party
    print("Member " .. player:getName() .. " not found in the party.")
    return false
end
