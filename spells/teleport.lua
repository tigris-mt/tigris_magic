local function fail(self)
    minetest.chat_send_player(self._owner, "You feel a slight tug, but nothing happens.")
end

tigris.magic.register_spell("tigris_magic:teleport", {
    description = "Short-Range Teleport",
    cost = {mana = 35, hp = 4},
    emblem = "action",
    color = "#CCF",
    overlay = "tigris_magic_teleport.png",
    on_use = function(itemstack, player, pointed_thing)
        tigris.create_projectile("tigris_magic:teleport_projectile", {
            pos = vector.add(player:getpos(), vector.new(0, player:get_properties().eye_height or 1.625, 0)),
            velocity = vector.multiply(player:get_look_dir(), 18),
            gravity = 1,
            owner = player:get_player_name(),
            owner_object = player,
        })
        return true
    end,
})

tigris.register_projectile("tigris_magic:teleport_projectile", {
    texture = "tigris_magic_teleport.png",
    load_map = true,
    on_node_hit = function(self, pos)
        if self._owner and self._owner_object and self._last_passable then
            if minetest.get_player_by_name(self._owner) then
                self._owner_object:setpos(self._last_passable)
            end
        else
            fail(self)
        end
        return true
    end,

    on_timeout = fail,
})

minetest.register_craft({
    output = "tigris_magic:teleport 2",
    recipe = {
        {"tigris_magic:force_essence", "tigris_magic:force_essence", "tigris_magic:force_essence"},
        {"", "tigris_magic:twisted_essence", ""},
    },
})

