local m = tigris.magic

local c_max = tonumber(minetest.settings:get("tigris.magic.mana_max")) or 100
local c_regen = tonumber(minetest.settings:get("tigris.magic.mana_regen")) or 5

tigris.hud.register("tigris_magic:mana", {type = "text"})

function tigris.magic.mana(player, set, relative)
    if set then
        if relative then
            set = set + tigris.magic.mana(player)
        end
        set = math.max(0, math.min(set, tigris.magic.mana_max(player)))

        player:get_meta():set_float("tigris_magic:mana", set)
        tigris.hud.update("tigris_magic:mana", player, set, tigris.magic.mana_max(player))
        return set
    else
        return player:get_meta():get_float("tigris_magic:mana")
    end
end

function tigris.magic.mana_max(player)
    return c_max
end

local timer = 0
minetest.register_globalstep(function(dtime)
    timer = timer + dtime
    if timer > 1 then
        for _,v in pairs(minetest.get_connected_players()) do
            tigris.magic.mana(v, c_regen * timer, true)
        end
        timer = 0
    end
end)

minetest.register_on_joinplayer(function(player)
    tigris.magic.mana(player, 0, true)
end)
