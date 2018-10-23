tigris.magic.register_spell("tigris_magic:fireball", {
    description = "Fireball",
    longdesc = "Launches a projectile that burns the area and deals heat damage.",
    cost = {mana = 15},
    emblem = "attack",
    color = "#F33",
    on_use = function(itemstack, player, pointed_thing)
        tigris.create_projectile("tigris_magic:fireball_projectile", {
            pos = vector.add(player:getpos(), vector.new(0, 1.4, 0)),
            velocity = vector.multiply(player:get_look_dir(), 30),
            gravity = 0,
            owner = player:get_player_name(),
            owner_object = player,
        })
        return true
    end,
})

tigris.register_projectile("tigris_magic:fireball_projectile", {
    texture = "fire_basic_flame.png",
    on_node_hit = function(self, pos)
        local search = vector.new(1, 1, 1)
        local start = vector.subtract(pos, search)
        local last = vector.add(pos, search)
        for _,pos in ipairs(minetest.find_nodes_in_area(start, last, {"group:flammable"})) do
            if not minetest.is_protected(pos, self._owner) and math.random(1, 100) < 25 then
                minetest.set_node(pos, {name = "fire:basic_flame"})
            end
        end
        return true
    end,
    on_liquid_hit = function(self, pos)
        return true
    end,
    on_entity_hit = function(self, obj)
        tigris.damage.apply(obj, {heat = 5}, self._owner_object)
        return true
    end,
})

minetest.register_craft({
    output = "tigris_magic:fireball 3",
    recipe = {
        {"default:flint", "default:steel_ingot"},
        {"tigris_magic:mana_essence", "tigris_magic:force_essence"},
    },
})

