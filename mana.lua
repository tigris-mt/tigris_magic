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
    return c_max
end

function m.mana_regen(player)
    local r = c_regen
    -- If player is very hot, cancel natural regeneration.
    if tigris.player.effect(player, "tigris_thermal:very_hot") then
        r = r - c_regen
    end
    return r
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

tigris.player.register_effect("tigris_magic:mana_regen", {
    description = "Mana Regeneration",
    status = true,
    set = function(player, old, new)
        local remaining = 0

        if old then
            remaining = old.remaining
        end

        local tex = "tigris_player_effect_plus.png^[colorize:#FF0:200"
        if new.amount >= 10 then
            tex = tex .. "^(tigris_player_effect_enhance.png^[colorize:#FF0:200)"
        end

        local d = (remaining + new.duration)
        local a = new.amount * (new.duration / d) + (old and old.amount or 0) * (remaining / d)

        return {
            status = tex,
            text = math.floor(a),
            amount = a,
            remaining = d,
        }
    end,

    apply = function(player, e, dtime)
        m.mana(player, e.amount * dtime, true)
    end,
})
