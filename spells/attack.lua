tigris.magic.register_spell("tigris_magic:freeze", {
    description = "Freeze",
    cost = {mana = 15},
    emblem = "attack",
    color = "#99F",
    on_use = function(itemstack, player, pointed_thing)
        tigris.create_projectile("tigris_magic:freeze_projectile", {
            pos = vector.add(player:getpos(), vector.new(0, 1.4, 0)),
            velocity = vector.multiply(player:get_look_dir(), 30),
            gravity = 0,
            owner = player:get_player_name(),
            owner_object = player,
        })
        return true
    end,
})

tigris.register_projectile("tigris_magic:freeze_projectile", {
    texture = "default_ice.png",
    on_liquid_hit = function(self, pos)
        local search = vector.new(2, 2, 2)
        local start = vector.subtract(pos, search)
        local last = vector.add(pos, search)
        for _,pos in ipairs(minetest.find_nodes_in_area(start, last, {"group:water"})) do
            if not minetest.is_protected(pos, self._owner) and math.random(1, 100) < 75 then
                minetest.set_node(pos, {name = "default:ice"})
            end
        end
        return true
    end,
    on_node_hit = function(self, pos)
        return true
    end,
    on_entity_hit = function(self, obj)
        tigris.damage.apply(obj, {cold = 2}, self._owner_object)
        return true
    end,
})

minetest.register_craft({
    output = "tigris_magic:freeze",
    recipe = {
        {"tigris_mobs:water_lung", "default:ice", "tigris_mobs:water_lung"},
        {"tigris_magic:mana_essence", "tigris_magic:force_essence", "tigris_magic:mana_essence"},
    },
})

tigris.magic.register_spell("tigris_magic:stone_arrow", {
    description = "Stone Arrow",
    cost = {mana = 10},
    emblem = "attack",
    color = "#442",
    overlay = "default_obsidian_shard.png",
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
