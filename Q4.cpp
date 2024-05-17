// Personally I would've used a unique_ptr for automatic memory management to clean up the code a bit, i refrained from doing this to keep the scenario similar.

void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    // Attempt to get the player by name
    Player* player = g_game.getPlayerByName(recipient);
    bool newPlayer = false;

    // If the player doesn't exist, load it from the database
    if (!player) {
        player = new Player(nullptr);
        newPlayer = true;
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            delete player; // If the player doesn't exist in the database, free the allocated memory before returning
            return;
        }
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        if (newPlayer) {
			delete player; // If the item doesn't exist, free the allocated memory for the player before returning
		}
        return;
    }

    // Add the item to the player's inbox
    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    // Save the player if they are offline
    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    }

    // If the player was newly created, free the allocated memory always
    if (newPlayer) {
        delete player;
    }
}
