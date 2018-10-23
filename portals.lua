local function get_dest(meta)
    local dest = minetest.string_to_pos(meta:get_string("dest"))
    if not dest then
        return
    end
    VoxelManip():read_from_map(dest, dest)
    if minetest.get_node(dest).name ~= "tigris_magic:portal" or minetest.get_meta(dest):get_string("id") ~= meta:get_string("dest_id") then
        return
    end
    return dest
end

local function update(pos, force)
    local meta = minetest.get_meta(pos)
    local dest = get_dest(meta)
    meta:set_string("infotext", "To: " .. (dest and minetest.pos_to_string(dest) or "???"))

    if dest then
        local a, b = vector.add(pos, vector.new(0, 1, 0)), vector.add(pos, vector.new(0, 2, 0))
        if minetest.get_node(a).name == "air" or minetest.get_node(a).name == "tigris_magic:portal_filling" then
            minetest.set_node(a, {name = "tigris_magic:portal_filling"})
            minetest.get_node_timer(a):start(10)
            if minetest.get_node(b).name == "air" or minetest.get_node(b).name == "tigris_magic:portal_filling" then
                minetest.set_node(b, {name = "tigris_magic:portal_filling"})
                minetest.get_node_timer(b):start(10)
            end
        end
    end

    minetest.get_node_timer(pos):start(force and 1 or math.random(3, 8))
    return dest
end

local last_portal = {}

minetest.register_node("tigris_magic:portal", {
    description = "Portal Base",
    tiles = {"tigris_magic_portal.png"},
    groups = {cracky = 1},
    sounds = default.node_sound_metal_defaults(),

    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("id", math.random(1, 1000) .. math.random(1, 1000) .. math.random(1, 1000))
        update(pos, true)
    end,

    on_timer = function(pos)
        local dest = update(pos)
        if dest then
            for _,obj in ipairs(minetest.get_objects_inside_radius(pos, 4)) do
                if (minetest.get_gametime() - (last_portal[obj] or 0) > 3) and vector.distance(vector.round(obj:getpos()), vector.add(pos, vector.new(0, 1, 0))) < 0.5 then
                    obj:setpos(vector.add(dest, vector.new(0, 1, 0)))
                    last_portal[obj] = minetest.get_gametime()
                end
            end
        end
    end,

    on_rightclick = function(pos, _, clicker, itemstack)
        if minetest.is_protected(pos, clicker:get_player_name()) then
            return
        end

        if itemstack:get_name() ~= "tigris_magic:portal_wand" then
            return
        end

        local meta = minetest.get_meta(pos)
        local im = itemstack:get_meta()

        if im:get_string("pos") ~= "" then
            meta:set_string("dest", im:get_string("pos"))
            meta:set_string("dest_id", im:get_string("id"))
            update(pos, true)
            itemstack:take_item()
        else
            im:set_string("id", meta:get_string("id"))
            im:set_string("pos", minetest.pos_to_string(pos))
            im:set_string("description", "Portal Wand " .. minetest.pos_to_string(pos))
            minetest.chat_send_player(clicker:get_player_name(), "Portal information transferred to wand.")
        end

        return itemstack
    end,
})

minetest.register_craft{
    output = "tigris_magic:portal",
    recipe = {
        {"default:obsidian", "tigris_magic:twisted_essence", "default:obsidian"},
        {"default:obsidian", "tigris_magic:teleport", "default:obsidian"},
        {"default:obsidian", "tigris_magic:twisted_essence", "default:obsidian"},
    },
}

minetest.register_tool("tigris_magic:portal_wand", {
    description = "Empty Portal Wand",
    inventory_image = "tigris_magic_portal_wand.png",
})

minetest.register_craft{
    output = "tigris_magic:portal_wand",
    recipe = {
        {"tigris_magic:mana_essence", "default:paper", ""},
        {"default:paper", "group:stick", ""},
        {"", "", "group:stick"},
    },
}

minetest.register_node("tigris_magic:portal_filling", {
    description = "Portal Filling",
    groups = {liquid = 3},
    tiles = {"tigris_magic_portal_filling.png"},
    alpha = 128,
    paramtype = "light",
    walkable = false,
    pointable = false,
    diggable = false,
    drop = "",
    buildable_to = true,
    liquidtype = "source",
    liquid_renewable = false,
    liquid_alternative_flowing = "tigris_magic:portal_filling",
    liquid_alternative_source = "tigris_magic:portal_filling",
    liquid_range = 0,
    liquid_viscosity = 11,
    drawtype = "liquid",

    on_construct = function(pos)
        minetest.get_node_timer(pos):start(10)
    end,

    on_timer = function(pos)
        minetest.remove_node(pos)
    end,
})
