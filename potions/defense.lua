tigris.magic.register_potion("tigris_magic:minor_mana_potion", {
    description = "Minor Mana Restoration Potion",
    color = "#AA0",
    emblem = "defense",
    on_use = function(itemstack, player)
        tigris.player.effect(player, "tigris_magic:mana_regen", {amount = 3, duration = 10})
        return true
    end,
})

minetest.register_craft({
    output = "tigris_magic:minor_mana_potion",
    type = "shapeless",
    recipe = {"tigris_magic:water_bottle", "tigris_magic:mana_essence"},
})

tigris.magic.register_potion("tigris_magic:minor_health_potion", {
    description = "Minor Health Restoration Potion",
    color = "#A00",
    emblem = "defense",
    on_use = function(itemstack, player)
        tigris.player.effect(player, "tigris_player:health_regen", {amount = 1, duration = 4})
        return true
    end,
})

minetest.register_craft({
    output = "tigris_magic:minor_health_potion",
    type = "shapeless",
    recipe = {"tigris_magic:water_bottle", "tigris_magic:blood_essence"},
})
