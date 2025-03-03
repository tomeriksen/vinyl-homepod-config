rule = {
    matches = {
        {
            -- Matcha Pisound-ingången
            { "node.name", "matches", "alsa_input.platform-soc_sound.stereo-fallback" },
        },
    },
    apply_properties = {
        ["node.rate"] = 96000,
        ["node.lock-rate"] = true,
    },
}

table.insert(alsa_monitor.rules, rule)
