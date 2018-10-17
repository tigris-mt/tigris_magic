tigris.magic.register_potion("tigris_magic:mana_potion", {
    description = "Mana Restoration Potion",
    longdesc = "Restores a large amount of mana.",
    color = "#FF0",
    emblem = "defense",
    on_use = function(itemstack, player)
        tigris.magic.mana(player, 30, true)
        return true
    end,
})

minetest.register_craft({
    output = "tigris_magic:mana_potion",
    type = "shapeless",
    recipe = {"tigris_magic:minor_mana_potion", "tigris_magic:mana_essence", "tigris_mobs:mese_heart"},
})
