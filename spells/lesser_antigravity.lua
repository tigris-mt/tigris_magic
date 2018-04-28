tigris.magic.register_spell("tigris_magic:lesser_antigravity", {
    description = "Lesser Antigravity",
    cost = {mana = 50},
    emblem = "action",
    color = "#303",
    overlay = "tigris_magic_antigravity.png",
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
            remaining = new.duration + math.min(2, old and old.remaining or 0),
        }
    end,

    apply = function(player, e)
        tigris.player.property(player, "tigris_magic:lesser_antigravity", "gravity", 0.1)
    end,

    stop = function(player, e)
        tigris.player.property(player, "tigris_magic:lesser_antigravity", "gravity", 1)
    end,
})

minetest.register_craft({
    output = "tigris_magic:lesser_antigravity 3",
    recipe = {
        {"group:leaves", "group:leaves", "group:leaves"},
        {"default:torch", "tigris_magic:force_essence", "default:torch"},
    },
})
