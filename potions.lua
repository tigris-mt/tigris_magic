--[[
description: Description
color: #FFF
emblem: nil or action, attack, defense
on_use: nil or function(itemstack, player, pointed_thing)
--]]
function tigris.magic.register_potion(name, def)
    local image = "vessels_glass_bottle.png^[colorize:"..def.color..":"..tostring(0xCC) .. (
        def.emblem and ("^tigris_magic_emblem_"..def.emblem..".png") or "")
    local node = {
        description = def.description,
        drawtype = "plantlike",
        tiles = {image},
        inventory_image = image,
        wield_image = image,
        paramtype = "light",
        is_ground_content = false,
        walkable = false,
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
        },
        groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
        sounds = default.node_sound_glass_defaults(),

        on_use = def.on_use and function(itemstack, player, pointed_thing)
            if def.on_use(itemstack, player, pointed_thing) then
                if player:get_inventory():room_for_item("main", "vessels:glass_bottle") then
                    player:get_inventory():add_item("main", "vessels:glass_bottle")
                else
                    minetest.add_item(player:get_pos(), "vessels:glass_bottle")
                end
                itemstack:take_item()
            end
            return itemstack
        end or nil,

    }

    minetest.register_node(name, node)
end

tigris.magic.register_potion("tigris_magic:water_bottle", {
    description = "Bottle of Water",
    color = "#02A",
})

minetest.register_craft({
    output = "tigris_magic:water_bottle",
    type = "shapeless",
    recipe = {"vessels:glass_bottle", "bucket:bucket_water"},
    replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}},
})

tigris.magic.register_potion("tigris_magic:purified_water_bottle", {
    description = "Purified Bottle of Water",
    color = "#23B",
})

minetest.register_craft({
    type = "cooking",
    output = "tigris_magic:purified_water_bottle",
    recipe = "tigris_magic:water_bottle",
    cooktime = 5,
})

tigris.include("potions/defense.lua")
