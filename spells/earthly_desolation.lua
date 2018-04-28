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

