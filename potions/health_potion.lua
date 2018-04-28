tigris.magic.register_potion("tigris_magic:health_potion", {
    description = "Health Restoration Potion",
    color = "#F00",
    emblem = "defense",
    on_use = function(itemstack, player)
        tigris.player.effect(player, "tigris_player:health_regen", {amount = 2, duration = 6})
        return true
    end,
})

minetest.register_craft({
    output = "tigris_magic:health_potion",
    type = "shapeless",
    recipe = {"tigris_magic:minor_health_potion", "tigris_magic:blood_essence", "tigris_mobs:mese_heart"},
})
