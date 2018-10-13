tigris.magic.register_potion("tigris_magic:health_potion", {
    description = "Health Restoration Potion",
    color = "#F00",
    emblem = "defense",
    on_use = function(itemstack, player)
        player:set_hp(player:get_hp() + 7)
        return true
    end,
})

minetest.register_craft({
    output = "tigris_magic:health_potion",
    type = "shapeless",
    recipe = {"tigris_magic:minor_health_potion", "tigris_magic:blood_essence", "tigris_mobs:mese_heart"},
})
