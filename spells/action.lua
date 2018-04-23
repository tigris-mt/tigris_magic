tigris.magic.register_spell("tigris_magic:test", {
    description = "Test",
    cost = {mana = 30, hp = 2, breath = 2},
    emblem = "action",
    color = "#FF0",
    on_use = function(itemstack, player, pointed_thing)
        return true
    end,
})
