local m = tigris.magic

-- Default mana parameters.
local c_max = tonumber(minetest.settings:get("tigris.magic.mana_max")) or 100
local c_regen = tonumber(minetest.settings:get("tigris.magic.mana_regen")) or 1

tigris.hud.register("tigris_magic:mana", {type = "bar", description = "Mana", texture = "tigris_magic_mana"})
tigris.hud.register("tigris_magic:mana_regen", {type = "text"})

-- Access player mana.
function m.mana(player, set, relative)
    if set then
        if relative then
            set = set + m.mana(player)
        end
        set = math.max(0, math.min(set, m.mana_max(player)))

        player:get_meta():set_float("tigris_magic:mana", set)
        tigris.hud.update(player, "tigris_magic:mana", {current = set, max = m.mana_max(player)})
        tigris.hud.update(player, "tigris_magic:mana_regen", m.mana_regen(player))
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
    local effect = tigris.player.effect(player, "tigris_magic:mana_regen")
    if effect then
        r = r + effect.amount
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
    set = function(player, old, new)
        local rd = 0

        if old then
            local remaining = (old.time + old.duration) - os.time()
            if remaining > 0 then
                -- Increase duration to somewhat stack potions (but not increase regen-per-second due to it).
                rd = (old.amount / new.amount) * remaining
            end
        end

        return {
            amount = new.amount,
            time = os.time(),
            duration = new.duration + rd,
        }
    end,
})
