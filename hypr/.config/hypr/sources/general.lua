-- General Look and Feel

hl.config({
    general = {
        gaps_in     = 5,
        gaps_out    = 20,
        border_size = 2,

        -- Colors
        col = {
            active_border   = { colors = {"rgba(3c1d25ee)", "rgba(ff0000ee)"}, angle = 45 },
            inactive_border = "rgb(121212)",
        },

        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },
})

-- Dwindle Layout
hl.config({
    dwindle = {
        -- poseudotile     = true,   -- NOTE: removed in 0.55, will likely warn/error
        preserve_split = true,
    },
})

-- Master Layout
hl.config({
    master = {
        new_status = "master",
    },
})

-- Other
hl.config({
    misc = {
        force_default_wallpaper = 1,
        disable_hyprland_logo   = false,
        vrr                     = 3,
    },
})
