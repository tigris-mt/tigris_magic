jewelry.register_action("mana", {
    init = function(state)
        state.mana = {
            regen = 1,
            max = 1,
        }
    end,
    add = function(state, r)
        for k,v in pairs(r.mana or {}) do
            assert(state.mana[k])
            state.mana[k] = state.mana[k] * v
        end
    end,
    apply = function(state, player)
        tigris.magic.mana_regen_monoid:add_change(player, state.mana.regen, "jewelry:mana_regen")
        tigris.magic.mana_max_monoid:add_change(player, state.mana.max, "jewelry:mana_max")
    end,
})

jewelry.register("tigris_magic:solar_shield_amulet", {
    description = "Amulet of Solar Shield",
    image = "jewelry_amulet.png^tigris_magic_solar_shield.png",
    group = "amulet",

    absorb = {"sun"},
    armor = {sun = 0, heat = 0.75},

    -- At damage every ~5 seconds, 720 uses will give 1 hour of sunwalking assuming no other damage.
    uses = 720,
    wear_on_all = true,
})

minetest.register_craft{
    output = "tigris_magic:solar_shield_amulet",
    recipe = {
        {"group:coal", "default:obsidian", "group:coal"},
        {"tigris_magic:mana_essence", "jewelry:amulet_base", "tigris_magic:force_essence"},
    },
}

jewelry.register("tigris_magic:speed_anklet", {
    description = "Anklet of Speed",
    image = "jewelry_anklet.png^tigris_magic_speed.png",
    group = "anklet",

    effects = {speed = 1.5, jump = 1.1},
    wear_on_all = true,
})

minetest.register_craft{
    output = "tigris_magic:speed_anklet",
    recipe = {
        {"default:ice", "tigris_magic:blood_essence", "default:ice"},
        {"tigris_magic:force_essence", "jewelry:anklet_base", "tigris_magic:force_essence"},
    },
}

jewelry.register("tigris_magic:mana_boost_bracelet", {
    description = "Bracelet of Mana Boost",
    image = "jewelry_bracelet.png^tigris_magic_mana_icon.png",
    group = "bracelet",

    mana = {max = 1.3, regen = 1.5},
    wear_on_all = true,
})

minetest.register_craft{
    output = "tigris_magic:mana_boost_bracelet",
    recipe = {
        {"tigris_magic:mana_essence", "tigris_magic:twisted_essence", "tigris_magic:mana_essence"},
        {"tigris_magic:mana_essence", "jewelry:bracelet_base", "tigris_magic:mana_essence"},
        {"tigris_magic:mana_essence", "tigris_magic:twisted_essence", "tigris_magic:mana_essence"},
    },
}
