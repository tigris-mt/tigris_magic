tigris.magic.register_potion("tigris_magic:minor_health_potion", {
    description = "Minor Health Restoration Potion",
    longdesc = "Restores some health.",
    color = "#A00",
    emblem = "defense",
    on_use = function(itemstack, player)
        player:set_hp(player:get_hp() + 4)
        return true
    end,
})

minetest.register_craft({
    output = "tigris_magic:minor_health_potion",
    type = "shapeless",
    recipe = {"tigris_magic:water_bottle", "tigris_magic:blood_essence"},
})
