tigris.magic.register_spell("tigris_magic:lesser_antigravity", {
    description = "Lesser Antigravity",
    longdesc = "Greatly reduces the effects of gravity for several seconds.",
    cost = {mana = 50},
    emblem = "action",
    color = "#303",
    overlay = "tigris_magic_antigravity.png",
    on_use = function(itemstack, player, pointed_thing)
        playereffects.apply_effect_type("tigris_magic:lesser_antigravity", math.random(0, 1) + 5, player)
        return true
    end,
})

playereffects.register_effect_type("tigris_magic:lesser_antigravity", "Antigravity", minetest.registered_items["tigris_magic:lesser_antigravity"].inventory_image, {"tigris_magic:lesser_antigravity"},
    function(player)
        player_monoids.gravity:add_change(player, 0.2, "tigris_magic:lesser_antigravity")
    end,
    function(effect, player)
        player_monoids.gravity:del_change(player, "tigris_magic:lesser_antigravity")
    end)


minetest.register_craft({
    output = "tigris_magic:lesser_antigravity 3",
    recipe = {
        {"group:leaves", "group:leaves", "group:leaves"},
        {"default:torch", "tigris_magic:force_essence", "default:torch"},
    },
})
