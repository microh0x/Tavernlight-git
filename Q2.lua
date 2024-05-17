-- Was a bit confused about the task, so I made a few assumptions: resultId is an iterable result set, the method storeQuery returns a result set, a method getString that returns a string from a result set, a method next that moves the result set to the next row, a method free that frees the result set.

function printSmallGuildNames(memberCount)
    -- this method is supposed to print names of all guilds that have less than memberCount max members
    local selectGuildQuery = string.format("SELECT name FROM guilds WHERE max_members < %d;", memberCount)
    local resultId = db.storeQuery(selectGuildQuery)


    -- Check if the query returned any results
    if resultId then
        repeat -- Repeat until we have fetched all rows
            local guildName = db.getString(resultId, "name") -- Get the guild name from the result set
            print(guildName)
        until not db.next(resultId)
        db.free(resultId) -- Free the result set to avoid memory leaks
    else
        print("No guilds found with less than " .. memberCount .. " members.")
    end
end