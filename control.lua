function swap(e, p, new_name)
    p.play_sound{
        path = "utility/wire_disconnect", -- click!
        position = e.position,
    }

    local old = {
        health = e.health,
        backer_name = e.backer_name,
    }

    e = e.surface.create_entity{
        name = new_name,
        position = e.position,
        quality = e.quality,
        force = e.force,
        fast_replace = true,
        spill = false,
    }

    e.last_user = p
    e.health = old.health
    e.backer_name = old.backer_name
end

function swap_ghost(e, p, new_name)
    p.play_sound{
        path = "utility/wire_disconnect", -- click!
        position = e.position,
    }

    e = e.surface.create_entity{
        name = "entity-ghost",
        inner_name = new_name,
        position = e.position,
        quality = e.quality,
        force = e.force,
        fast_replace = true,
        spill = false,
    }

    e.last_user = p
end

function do_passive_radar_toggle(ev)
    local p = game.players[ev.player_index]
    local e = p.selected
    if e and e.valid and e.force == p.force then
        if e.type == "radar" then
            if e.name == "radar" then
                swap(e, p, "passive-radar")
            elseif e.name == "passive-radar" then
                swap(e, p, "radar")
            end
        elseif e.type == "entity-ghost" and e.ghost_type == "radar" then
            if e.ghost_name == "radar" then
                swap_ghost(e, p, "passive-radar")
            elseif e.ghost_name == "passive-radar" then
                swap_ghost(e, p, "radar")
            end
        end
    end
end

script.on_event(prototypes.custom_input["passive-radar-toggle"], do_passive_radar_toggle)
