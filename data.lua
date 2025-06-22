local passive_radar = table.deepcopy(data.raw.radar["radar"])
passive_radar.name = "passive-radar"
passive_radar.energy_usage = "100kW"
passive_radar.heating_energy = "100kW"
passive_radar.max_distance_of_sector_revealed = 0
passive_radar.energy_per_sector = "1TJ" -- 115 days @ 100kW, lol
passive_radar.energy_per_nearby_scan = "100kJ" -- 1/s
passive_radar.rotation_speed = -0.003 -- slower and backwards
passive_radar.placeable_by = { item = "radar", count = 1 }
for _, p in pairs(passive_radar.pictures.layers) do
    p.tint = { 0.4, 1.0, 0.7 } -- greenish
end

data:extend{
    passive_radar,
    {
        type = "custom-input",
        name = "passive-radar-toggle",
        key_sequence = "",
        linked_game_control = "rotate",
    },
}
