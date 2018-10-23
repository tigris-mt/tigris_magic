tigris.magic.register_spell("tigris_magic:obsidian_arrow", {
    description = "Obsidian Arrow",
    longdesc = "Launches a projectile that deals fleshy damage.",
    cost = {mana = 15},
    emblem = "attack",
    color = "#442",
    overlay = "default_obsidian_shard.png",
    on_use = function(itemstack, player, pointed_thing)
        tigris.create_projectile("tigris_magic:obsidian_arrow_projectile", {
            pos = vector.add(player:getpos(), vector.new(0, 1.4, 0)),
            velocity = vector.multiply(player:get_look_dir(), 30),
            gravity = 0.25,
            owner = player:get_player_name(),
            owner_object = player,
        })
        return true
    end,
})

tigris.register_projectile("tigris_magic:obsidian_arrow_projectile", {
    texture = minetest.registered_items["tigris_magic:obsidian_arrow"].inventory_image,
    on_node_hit = function(self, pos)
        return true
    end,
    on_entity_hit = function(self, obj)
        tigris.damage.apply(obj, {fleshy = 8}, self._owner_object)
        return true
    end,
})

minetest.register_craft({
    output = "tigris_magic:obsidian_arrow 4",
    recipe = {
        {"default:obsidian_shard", "default:obsidian_shard", "default:obsidian_shard"},
        {"default:obsidian_shard", "tigris_magic:earth_essence", ""},
        {"default:obsidian_shard", "", "tigris_magic:force_essence"},
    },
})
