tigris.magic.register_spell("tigris_magic:inferno", {
    description = "Inferno",
    cost = {mana = 75, hp = 10},
    emblem = "attack",
    color = "#F00",
    on_use = function(itemstack, player, pointed_thing)
        local pos = player:getpos()

        for _,obj in ipairs(minetest.get_objects_inside_radius(pos, 8)) do
            if not tigris.damage.friendly(player, obj) then
                tigris.damage.apply(obj, {heat = 15}, player)
            end
        end

        local search = vector.new(7, 7, 7)
        local start = vector.subtract(pos, search)
        local last = vector.add(pos, search)
        for _,pos in ipairs(minetest.find_nodes_in_area(start, last, {"group:flammable"})) do
            if not minetest.is_protected(pos, player:get_player_name()) and math.random(1, 100) < 75 then
                minetest.set_node(pos, {name = "fire:basic_flame"})
            end
        end

        return true
    end,
})

minetest.register_craft({
    output = "tigris_magic:inferno",
    recipe = {
        {"tigris_magic:force_essence", "default:mese", "tigris_magic:force_essence"},
        {"tigris_mobs:eye", "default:flint", "tigris_mobs:eye"},
        {"", "tigris_magic:twisted_essence", ""},
    },
})
