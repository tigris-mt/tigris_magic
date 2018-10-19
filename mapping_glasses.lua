if not minetest.get_modpath("map") then
    return
end

jewelry.register("tigris_magic:mapping_glasses", {
    description = "Glasses of Mapping\nUse with 'Minimap' key",
    longdesc = "Enables the user to access the minimap.",
    image = "map_mapping_kit.png^jewelry_glasses.png",
    group = "glasses",

    wear_on_all = true,
})

minetest.register_craft{
    output = "tigris_magic:mapping_glasses",
    recipe = {
        {"tigris_magic:earth_essence", "jewelry:glasses_base", "tigris_magic:earth_essence"},
        {"tigris_magic:blood_essence", "tigris_magic:earth_essence", "tigris_magic:blood_essence"},
    },
}

local old = map.update_hud_flags
function map.update_hud_flags(player)
    if player:get_inventory():contains_item("jewelry", "tigris_magic:mapping_glasses") then
        player:hud_set_flags{
            minimap = true,
            minimap_radar = true,
        }
    else
        return old(player)
    end
end
