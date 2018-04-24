tigris.magic.register_spell("tigris_magic:lesser_antigravity", {
    description = "Lesser Antigravity",
    cost = {mana = 50},
    emblem = "action",
    color = "#303",
    on_use = function(itemstack, player, pointed_thing)
        tigris.player.effect(player, "tigris_magic:lesser_antigravity", {
            duration = 5,
        })
        return true
    end,
})

tigris.player.register_effect("tigris_magic:lesser_antigravity", {
    description = "Lesser Antigravity",
    status = "tigris_magic_antigravity.png",

    set = function(player, old, new)
        return {
            time = os.time(),
            duration = math.min(10, (old and math.max(0, ((old.time + old.duration) - os.time())) or 0) + new.duration)
        }
    end,

    apply = function(player, e)
        player:set_physics_override({gravity = 0.1})
    end,

    stop = function(player, e)
        player:set_physics_override({gravity = 1})
    end,
})

minetest.register_craft({
    output = "tigris_magic:lesser_antigravity",
    type = "shapeless",
    recipe = {"tigris_magic:force_essence", "group:leaves", "default:torch"},
})
