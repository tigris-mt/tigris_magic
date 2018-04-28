tigris.magic.register_potion("tigris_magic:mana_potion", {
    description = "Mana Restoration Potion",
    color = "#FF0",
    emblem = "defense",
    on_use = function(itemstack, player)
        tigris.player.effect(player, "tigris_magic:mana_regen", {amount = 4, duration = 11})
        return true
    end,
})

minetest.register_craft({
    output = "tigris_magic:mana_potion",
    type = "shapeless",
    recipe = {"tigris_magic:minor_mana_potion", "tigris_magic:mana_essence", "tigris_mobs:mese_heart"},
})
