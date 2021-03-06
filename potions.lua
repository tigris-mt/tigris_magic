local v = "vessels:glass_bottle"
local s = "vessels:steel_bottle"

function tigris.magic.register_potion(name, def)
    local t = def.strong and "vessels_steel_bottle" or "vessels_glass_bottle"
    local image = t .. ".png^[colorize:"..def.color..":"..tostring(0xCC) .. (
        def.emblem and ("^tigris_magic_emblem_"..def.emblem..".png") or "")
    local vt = def.strong and s or v

    if def.overlay then
        image = image .. "^" .. def.overlay
    end

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

        _doc_items_longdesc = def.longdesc,
        _doc_items_usagehelp = def.usagehelp or "Use the potion to drink it.",

        on_use = def.on_use and function(itemstack, player, pointed_thing)
            if playereffects.has_effect_type(player:get_player_name(), "tigris_magic:drinking") then
                return itemstack
            end
            if def.on_use(itemstack, player, pointed_thing) then
                playereffects.apply_effect_type("tigris_magic:drinking", def.drink_time or 5, player)
                if player:get_inventory():room_for_item("main", vt) then
                    player:get_inventory():add_item("main", vt)
                else
                    minetest.add_item(player:get_pos(), vt)
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

playereffects.register_effect_type("tigris_magic:drinking", "Drinking", minetest.registered_items["tigris_magic:water_bottle"].inventory_image, {"tigris_magic:drinking"}, function() end, function() end)

minetest.register_craft({
    output = "tigris_magic:water_bottle 8",
    recipe = {
        {v, v, v},
        {v, "bucket:bucket_water", v},
        {v, v, v},
    },
    replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}},
})

tigris.magic.register_potion("tigris_magic:lava_bottle", {
    description = "Bottle of Lava",
    color = "#F40",
    strong = true,
})

minetest.register_craft({
    output = "tigris_magic:lava_bottle 8",
    recipe = {
        {s, s, s},
        {s, "bucket:bucket_lava", s},
        {s, s, s},
    },
    replacements = {{"bucket:bucket_lava", "bucket:bucket_empty"}},
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

tigris.include_dir("potions")
