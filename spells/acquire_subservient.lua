tigris.magic.register_spell("tigris_magic:acquire_subservient", {
    description = "Acquire Subservient",
    longdesc = "Claim a mob for yourself or for your faction.",
    usagehelp = "Use on a tame mob.",
    cost = {mana = 15},
    emblem = "action",
    overlay = "tigris_mobs_eye.png",
    color = "#742",
    on_use = function(itemstack, player, pointed_thing)
        if pointed_thing.type == "object" then
            local obj = pointed_thing.ref
            if obj:is_player() then
                return
            end
            local ent = obj:get_luaentity()
            if ent.tigris_mob and not ent.faction and ent._data.tame then
                ent.faction = tigris.player_faction(player:get_player_name())
                return true
            else
                minetest.chat_send_player(player:get_player_name(), "You cannot acquire it.")
                return false
            end
        end
    end,
})

minetest.register_craft({
    output = "tigris_magic:acquire_subservient 3",
    recipe = {
        {"tigris_magic:twisted_essence", "tigris_mobs:eye", "group:stick"},
    },
})

tigris.magic.register_spell("tigris_magic:retrieve_subservient", {
    description = "Retrieve Subservient",
    longdesc = "Retrieve a mob to your inventory.",
    usagehelp = "Use on a mob claimed by you or your faction.",
    cost = {mana = 30},
    emblem = "action",
    overlay = "tigris_mobs_cursed_brain.png",
    color = "#742",
    on_use = function(itemstack, player, pointed_thing)
        if pointed_thing.type == "object" then
            local obj = pointed_thing.ref
            if obj:is_player() then
                return
            end
            local ent = obj:get_luaentity()
            if ent.tigris_mob and ent.faction == tigris.player_faction(player:get_player_name()) then
                minetest.add_item(obj:getpos(), player:get_inventory():add_item("main", ItemStack(ent.name)))
                obj:remove()
                return true
            else
                minetest.chat_send_player(player:get_player_name(), "It is not yours.")
                return false
            end
        end
    end,
})

minetest.register_craft({
    output = "tigris_magic:retrieve_subservient 3",
    recipe = {
        {"tigris_magic:blood_essence", "tigris_mobs:cursed_brain", "tigris_magic:blood_essence"},
        {"tigris_magic:force_essence", "default:torch", "tigris_magic:force_essence"},
    },
})
