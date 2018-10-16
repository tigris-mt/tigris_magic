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
            if ent.tigris_mob and ent.faction == tigris.player_faction(player:get_player_name()) then
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
