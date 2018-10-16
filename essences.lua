-- Blood and mana are the simplest essences. Mostly above-ground.
-- Body requires materials harvested from mobs.
-- Earth and force are for more complicated spells and potions. Mostly below-ground.
-- Twisted is for the strongest effects.
for _,def in ipairs({
    -- Rose: red + thorns, Steel: iron in blood, Glass: sharp.
    {name = "blood", desc = "Blood", color = "#700",
        recipe = {"flowers:rose", "default:steel_ingot", "default:glass"}},
    -- Dandelion: yellow + strength, Tree: life of the earth, Torch: energy.
    {name = "mana", desc = "Mana", color = "#FF0",
        recipe = {"flowers:dandelion_yellow", "group:tree", "default:torch"}},
    {name = "body", desc = "Body", color = "#FAA",
        recipe = {"mobs:meat_raw", "tigris_mobs:bone", "tigris_mobs:eye"}},
    -- Black tulip: black, Coal block: dead + solidified, Obsidian shard: solid.
    {name = "earth", desc = "Earth", color = "#772",
        recipe = {"flowers:tulip_black", "default:coalblock", "default:obsidian_shard"}},
    -- Geranium: blue, Mese crystal: power, Copper ingot: conduction.
    {name = "force", desc = "Force", color = "#00F",
        recipe = {"flowers:geranium", "default:mese_crystal_fragment", "default:copper_ingot"}},
    -- Combine four root essences with concentrated mese.
    {name = "twisted", desc = "Twisted", color = "#F0F",
        recipe = {"tigris_magic:blood_essence", "tigris_magic:mana_essence", "tigris_magic:earth_essence", "tigris_magic:force_essence",
            "default:mese"}},
}) do
    minetest.register_craftitem("tigris_magic:"..def.name.."_essence", {
        description = def.desc.." Essence",
        inventory_image = "tigris_magic_essence.png^[colorize:"..def.color..":"..tostring(0xCC),
        groups = {essence = 1},
    })

    minetest.register_node("tigris_magic:"..def.name.."_in_stone", {
        description = def.desc .. " Essence in Stone",
        tiles = {"default_stone.png^(tigris_magic_mineral.png^[colorize:"..def.color..":"..tostring(0xCC)..")"},
        groups = {cracky = 2},
        drop = "tigris_magic:" .. def.name .. "_essence",
        sounds = default.node_sound_stone_defaults(),
    })

    minetest.register_craft({
        output = "tigris_magic:" .. def.name .. "_essence",
        type = "shapeless",
        recipe = def.recipe,
    })
end

local function r(name, ymax, ymin, cube)
    minetest.register_ore({
        ore_type       = "scatter",
        ore            = "tigris_magic:" .. name .. "_in_stone",
        wherein        = "default:stone",
        clust_scarcity = cube * cube * cube,
        clust_num_ores = 5,
        clust_size     = 3,
        y_max          = ymax,
        y_min          = ymin,
    })
end

r("blood", tigris.world_limits.max.y, -500, 17)
r("mana", tigris.world_limits.max.y, -500, 17)
r("earth", -400, tigris.world_limits.min.y, 18)
r("force", -400, tigris.world_limits.min.y, 18)

r("blood", tigris.world_limits.max.y, tigris.world_limits.min.y, 38)
r("mana", tigris.world_limits.max.y, tigris.world_limits.min.y, 38)
r("earth", tigris.world_limits.max.y, tigris.world_limits.min.y, 39)
r("force", tigris.world_limits.max.y, tigris.world_limits.min.y, 39)
