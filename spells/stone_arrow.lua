tigris.magic.register_spell("tigris_magic:stone_arrow", {
    description = "Stone Arrow",
    longdesc = "Launches a projectile that deals low fleshy damage.",
    cost = {mana = 10},
    emblem = "attack",
    color = "#442",
    overlay = "default_flint.png",
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
