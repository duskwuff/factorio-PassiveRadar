function swap(e, p, new_name)
    p.play_sound{
        path = "utility/wire_disconnect", -- click!
        position = e.position,
    }

    -- save some properties
    local old_health = e.health
    local old_backer_name = e.backer_name

    e = e.surface.create_entity{
        name = new_name,
        position = e.position,
        quality = e.quality,
        force = e.force,
        fast_replace = true,
        player = p,
    }

    e.health = old_health
    e.backer_name = old_backer_name
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
