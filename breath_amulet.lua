local time = 3
local timer = 0
minetest.register_globalstep(function(dtime)
    timer = timer + dtime
    if timer > time then
        for _,player in ipairs(minetest.get_connected_players()) do
            if player:get_meta():get_int("tigris_magic:breath") == 1 then
                player:set_breath(player:get_properties().breath_max)
            end
        end
        timer = 0
    end
end)

jewelry.register_action("breath", {
    init = function(state)
        state.breath = false
    end,
    add = function(state, r)
        state.breath = state.breath or r.breath
    end,
    apply = function(state, player)
        player:get_meta():set_int("tigris_magic:breath", state.breath and 1 or 0)
        player:hud_set_flags{breathbar = not state.breath}
    end,
})

jewelry.register("tigris_magic:breath_amulet", {
    description = "Amulet of Breath",
    longdesc = "Permits breathing underwater.",
    image = "jewelry_amulet.png^bubble.png",
    group = "amulet",

    breath = true,

    wear_on_all = true,
})

minetest.register_craft{
    output = "tigris_magic:breath_amulet",
    recipe = {
        {"default:coral_skeleton", "default:sand_with_kelp", "default:coral_skeleton"},
        {"tigris_magic:blood_essence", "jewelry:amulet_base", "tigris_magic:blood_essence"},
    },
}
