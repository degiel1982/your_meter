-- Register Lightmeter tool
minetest.register_tool("your_meter:lightmeter", {
    description = "Lightmeter",
    inventory_image = "default_stick.png",
    on_use = function(itemstack, user, pointed_thing)
        if pointed_thing and pointed_thing.type == "node" then
            -- Get the position directly above the pointed node
            local pos = vector.add(pointed_thing.under, {x = 0, y = 1, z = 0})
            local light_level = minetest.get_node_light(pos)
            if light_level then
                minetest.chat_send_player(user:get_player_name(), "Light Level Above Node: " .. light_level)
            else
                minetest.chat_send_player(user:get_player_name(), "No light data available above this node.")
            end
        end
    end,
})

-- Register Watermeter tool
minetest.register_tool("your_meter:watermeter", {
    description = "Watermeter",
    inventory_image = "default_stick.png",
    on_use = function(itemstack, user, pointed_thing)
        if pointed_thing and pointed_thing.type == "node" then
            local pos = pointed_thing.under
            for dx = -1, 1 do
                for dy = -1, 0 do
                    for dz = -1, 1 do
                        local check_pos = vector.add(pos, {x = dx, y = dy, z = dz})
                        local node_name = minetest.get_node(check_pos).name
                        if minetest.get_item_group(node_name, "water") > 0 then
                            minetest.chat_send_player(user:get_player_name(), "Water found nearby!")
                            return
                        end
                    end
                end
            end
            minetest.chat_send_player(user:get_player_name(), "No water nearby.")
        end
    end,
})

-- Register Crafting Recipes
minetest.register_craft({
    output = "your_meter:lightmeter",
    recipe = {
        {"", "default:glass", ""},
        {"", "default:stick", ""},
        {"", "", ""},
    },
})

minetest.register_craft({
    output = "your_meter:watermeter",
    recipe = {
        {"", "default:glass", ""},
        {"", "default:glass", ""},
        {"", "default:stick", ""},
    },
})
