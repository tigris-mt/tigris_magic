tigris.magic.register_spell("tigris_magic:earthly_desolation", {
    description = "Earthly Desolation",
    cost = {mana = 30, hp = 3},
    emblem = "action",
    overlay = "tigris_magic_mana_icon.png",
    color = "#442",
    on_use = function(itemstack, player, pointed_thing)
        local search = vector.new(3, 3, 3)
        local start = vector.subtract(player:getpos(), search)
        local last = vector.add(player:getpos(), search)
        for _,pos in ipairs(minetest.find_nodes_in_area(start, last, {"group:stone", "default:gravel", "group:soil", "group:dirt", "group:sand"})) do
            if not minetest.is_protected(pos, player:get_player_name()) then
                minetest.remove_node(pos)
            end
        end
        return true
    end,
})

minetest.register_craft({
    output = "tigris_magic:earthly_desolation",
    recipe = {
        {"tigris_magic:earth_essence", "tigris_mobs:fang", "tigris_magic:earth_essence"},
        {"default:obsidian", "tigris_magic:earth_essence", "default:obsidian"},
        {"tigris_magic:force_essence", "tigris_magic:force_essence", "tigris_magic:force_essence"},
    },
})

tigris.magic.register_spell("tigris_magic:free_subservient", {
    description = "Free Subservient",
    cost = {mana = 5},
    emblem = "action",
    overlay = "tigris_mobs_bone.png",
    color = "#742",
    on_use = function(itemstack, player, pointed_thing)
        if pointed_thing.type == "object" then
            local obj = pointed_thing.ref
            if obj:is_player() then
                return
            end
            local ent = obj:get_luaentity()
            if ent.tigris_mob and ent.faction == tigris.player.faction(player:get_player_name()) then
                ent.faction = nil
                return true
            end
        end
    end,
})

minetest.register_craft({
    output = "tigris_magic:free_subservient",
    recipe = {
        {"tigris_magic:mana_essence", "tigris_mobs:eye", "group:stick"},
    },
})

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
