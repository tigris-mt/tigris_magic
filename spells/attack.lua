tigris.magic.register_spell("tigris_magic:stone_arrow", {
    description = "Stone Arrow",
    cost = {mana = 10},
    emblem = "attack",
    color = "#442",
    on_use = function(itemstack, player, pointed_thing)
        tigris.create_projectile("tigris_magic:stone_arrow_projectile", {
            pos = vector.add(player:getpos(), vector.new(0, 1.4, 0)),
            velocity = vector.multiply(player:get_look_dir(), 30),
            gravity = 0.25,
            owner = player:get_player_name(),
            owner_object = player,
        })
        return true
    end,
})

tigris.register_projectile("tigris_magic:stone_arrow_projectile", {
    texture = minetest.registered_items["tigris_magic:stone_arrow"].inventory_image,
    on_node_hit = function(self, pos)
        return true
    end,
    on_entity_hit = function(self, obj)
        tigris.damage.apply(obj, {fleshy = 4}, self._owner_object)
        return true
    end,
})

minetest.register_craft({
    output = "tigris_magic:stone_arrow 6",
    recipe = {
        {"group:stone", "group:stone", "group:stone"},
        {"group:stone", "tigris_magic:earth_essence", ""},
        {"group:stone", "", "tigris_magic:force_essence"},
    },
})

tigris.magic.register_spell("tigris_magic:earthly_desolation", {
    description = "Earthly Desolation",
    cost = {mana = 30, hp = 3},
    emblem = "attack",
    color = "#A42",
    on_use = function(itemstack, player, pointed_thing)
        local search = vector.new(3, 3, 3)
        local start = vector.subtract(player:getpos(), search)
        local last = vector.add(player:getpos(), search)
        for _,pos in ipairs(minetest.find_nodes_in_area(start, last, {"group:stone", "default:gravel"})) do
                minetest.remove_node(pos)
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
