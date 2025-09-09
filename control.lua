function swap(e, p, new_name)
    p.play_sound{
        path = "utility/wire_disconnect", -- click!
        position = e.position,
    }

    -- save some properties
    local old = {
        surface = e.surface,
        health = e.health,
        backer_name = e.backer_name,
        position = e.position,
        quality = e.quality,
        force = e.force,
    }

    local connections = {}
    for id, conn in pairs(e.get_wire_connectors()) do
        connections[id] = conn.connections
    end

    e.destroy()

    e = old.surface.create_entity{
        name = new_name,
        player = p,
        position = old.position,
        quality = old.quality,
        force = old.force,
    }
    e.health = old.health
    e.backer_name = old.backer_name

    for id, conns in pairs(connections) do
        local src = e.get_wire_connector(id, true)
        for _, c in pairs(conns) do
            if c.origin ~= defines.wire_origin.radars then
                src.connect_to(c.target, false, c.origin)
            end
        end
    end
end

function do_passive_radar_toggle(ev)
    local p = game.players[ev.player_index]
    local e = p.selected
    if e and e.valid and e.force == p.force and e.type == "radar" then
        if e.name == "radar" then
            swap(e, p, "passive-radar")
        elseif e.name == "passive-radar" then
            swap(e, p, "radar")
        end
    end
end

script.on_event(prototypes.custom_input["passive-radar-toggle"], do_passive_radar_toggle)
