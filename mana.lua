local m = tigris.magic

-- Default mana parameters.
local c_max = tonumber(minetest.settings:get("tigris.magic.mana_max")) or 100
local c_regen = tonumber(minetest.settings:get("tigris.magic.mana_regen")) or 1

tigris.hud.register("m:mana", {type = "text"})

-- Access player mana.
function m.mana(player, set, relative)
    if set then
        if relative then
            set = set + m.mana(player)
        end
        set = math.max(0, math.min(set, m.mana_max(player)))

        player:get_meta():set_float("m:mana", set)
        tigris.hud.update("m:mana", player, set, m.mana_max(player))
        return set
    else
        return player:get_meta():get_float("m:mana")
    end
end

-- Maximum player mana.
function m.mana_max(player)
    return c_max
end

function m.mana_regen(player)
    return c_regen
end

-- Regenerate mana.
local timer = 0
minetest.register_globalstep(function(dtime)
    timer = timer + dtime
    if timer > 1 then
        for _,v in pairs(minetest.get_connected_players()) do
            m.mana(v, m.mana_regen(v) * timer, true)
        end
        timer = 0
    end
end)

-- Trigger mana system for joining players.
minetest.register_on_joinplayer(function(player)
    m.mana(player, 0, true)
end)
