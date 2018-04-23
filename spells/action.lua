tigris.magic.register_spell("tigris_magic:test", {
    description = "Test",
    cost = {mana = 30, hp = 2},
    emblem = "action",
    color = "#FF0",
    on_use = function(itemstack, player, pointed_thing)
        minetest.chat_send_player(player:get_player_name(), "!!")
        return true
    end,
})
