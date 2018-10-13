tigris.magic.register_potion("tigris_magic:minor_mana_potion", {
    description = "Minor Mana Restoration Potion",
    color = "#AA0",
    emblem = "defense",
    on_use = function(itemstack, player)
        tigris.magic.mana(player, 15, true)
        return true
    end,
})

minetest.register_craft({
    output = "tigris_magic:minor_mana_potion",
    type = "shapeless",
    recipe = {"tigris_magic:water_bottle", "tigris_magic:mana_essence"},
})
