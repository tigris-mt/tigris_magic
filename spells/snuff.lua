tigris.magic.register_spell("tigris_magic:snuff", {
    description = "Snuff",
    cost = {mana = 30},
    emblem = "defense",
    color = "#70F",
    on_use = function(itemstack, player, pointed_thing)
        tigris.create_projectile("tigris_magic:snuff_projectile", {
            pos = vector.add(player:getpos(), vector.new(0, 1.4, 0)),
            velocity = vector.multiply(player:get_look_dir(), 20),
            gravity = 0.25,
            owner = player:get_player_name(),
            owner_object = player,
        })
        return true
    end,
})

local function f(self, pos)
    local search = vector.new(8, 8, 8)
    local start = vector.subtract(pos, search)
    local last = vector.add(pos, search)
    for _,pos in ipairs(minetest.find_nodes_in_area(start, last, {"fire:basic_flame"})) do
        if not minetest.is_protected(pos, self._owner) then
            minetest.set_node(pos, {name = "default:water_flowing"})
        end
    end
    return true
end

tigris.register_projectile("tigris_magic:snuff_projectile", {
    texture = "default_water.png",
    on_any_hit = f,
    on_entity_hit = function(self, obj)
        return f(self, obj:getpos())
    end,
})

minetest.register_craft({
    output = "tigris_magic:snuff",
    recipe = {
        {"tigris_magic:freeze", "", "tigris_magic:freeze"},
        {"tigris_mobs:water_lung", "tigris_mobs:water_lung", "tigris_mobs:water_lung"},
        {"tigris_magic:freeze", "", "tigris_magic:freeze"},
    },
})
