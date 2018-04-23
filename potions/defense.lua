tigris.magic.register_potion("tigris_magic:minor_mana_potion", {
    description = "Minor Mana Restoration Potion",
    color = "#00F",
    emblem = "defense",
    on_use = function(itemstack, player)
        tigris.player.effect("tigris_magic:mana_regen", {amount = 3, time = 10})
        return true
    end,
})

minetest.register_craft({
    output = "tigris_magic:minor_mana_potion",
    type = "shapeless",
    recipe = {"tigris_magic:water_bottle", "flowers:geranium"},
})
