local m = tigris.magic

--[[
description: Item description.
cost: Cost table. {mana = 12}
emblem: action, attack, defense
color: #FFF
groups: {spell = 1} or nil
on_use: function(itemstack, player, pointed_thing)
do_cost: nil or function(player, cost)
--]]
function m.register_spell(name, def)
    local desc = def.description
    for k,v in pairs(def.cost) do
        desc = desc .. " (" .. k .. ": " .. v .. ")"
    end

    local do_cost = def.do_cost or (function(player, cost)
        local d = {}

        -- Check costs and enqueue action for success.
        for k,v in pairs(cost) do
            if k == "mana" then
                if tigris.magic.mana(player) < v then
                    return false
                end
                d[k] = function() tigris.magic.mana(player, -v, true) end
            elseif k == "hp" then
                if player:get_hp() <= v then
                    return false
                end
                d[k] = function() player:set_hp(player:get_hp() - v) end
            elseif k == "breath" then
                if player:get_breath() <= v then
                    return false
                end
                d[k] = function() player:set_breath(player:get_breath() - v) end
            else
                error("Unknown cost: " .. k)
            end
        end

        -- All checks passed, perform cost actions and return success.
        for _,v in pairs(d) do
            v()
        end
        return true
    end)

    local item = {
        description = desc,
        inventory_image = "tigris_magic_essence.png^[colorize:"..def.color..":"..tostring(0xCC).."^tigris_magic_emblem_"..def.emblem..".png",
        groups = def.groups or {spell = 1},
        original = def,

        on_use = function(itemstack, player, pointed_thing)
            if not do_cost(player, def.cost) then
                return
            end
            if def.on_use(itemstack, player, pointed_thing) then
                itemstack:take_item()
            end
            return itemstack
        end,
    }

    if def.overlay then
        item.inventory_image = item.inventory_image .. "^" .. def.overlay
    end

    minetest.register_craftitem(name, item)
end

tigris.include("spells/action.lua")
tigris.include("spells/attack.lua")
tigris.include("spells/defense.lua")
