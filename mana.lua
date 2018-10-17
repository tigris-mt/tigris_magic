local m = tigris.magic

-- Default mana parameters.
local c_max = tonumber(minetest.settings:get("tigris.magic.mana_max")) or 100
local c_regen = tonumber(minetest.settings:get("tigris.magic.mana_regen")) or 1

tigris.hud.register("tigris_magic:mana", {type = "bar", description = "Mana", texture = "tigris_magic_mana"})

-- Access player mana.
function m.mana(player, set, relative)
    if set then
        if relative then
            set = set + m.mana(player)
        end
        set = math.max(0, math.min(set, m.mana_max(player)))

        player:get_meta():set_float("tigris_magic:mana", set)
        tigris.hud.update(player, "tigris_magic:mana", {current = set, max = m.mana_max(player)})
        return set
    else
        return player:get_meta():get_float("tigris_magic:mana")
    end
end

-- Maximum player mana.
function m.mana_max(player)
    return player:get_meta():get_float("tigris_magic:mana_max")
end

m.mana_max_monoid = player_monoids.make_monoid{
    combine = function(a, b)
        return a * b
    end,
    fold = function(tab)
        local r = c_max
        for _,v in pairs(tab) do
            r = r * v
        end
        return r
    end,
    identity = c_max,
    apply = function(n, player)
        player:get_meta():set_float("tigris_magic:mana_max", n)
    end,
    on_change = function() return end,
}

function m.mana_regen(player)
    return player:get_meta():get_float("tigris_magic:mana_regen")
end

m.mana_regen_monoid = player_monoids.make_monoid{
    combine = function(a, b)
        return a * b
    end,
    fold = function(tab)
        local r = c_regen
        for _,v in pairs(tab) do
            r = r * v
        end
        return r
    end,
    identity = c_regen,
    apply = function(n, player)
        player:get_meta():set_float("tigris_magic:mana_regen", n)
    end,
    on_change = function() return end,
}

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
