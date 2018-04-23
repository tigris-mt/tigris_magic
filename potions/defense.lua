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
    recipe = {"tigris_magic:water_bottle", "flowers:geranium"},
})

tigris.magic.register_potion("tigris_magic:mana_potion", {
    description = "Mana Restoration Potion",
    color = "#FF0",
    emblem = "defense",
    on_use = function(itemstack, player)
        tigris.player.effect(player, "tigris_magic:mana_regen", {amount = 24, duration = 5})
        return true
    end,
})

minetest.register_craft({
    output = "tigris_magic:mana_potion",
    type = "shapeless",
    recipe = {"tigris_magic:minor_mana_potion", "default:obsidian"},
})
