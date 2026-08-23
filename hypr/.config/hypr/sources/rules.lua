-- Window rules

hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

-- Overwatch 2: pin to the VRR monitor (DP-1) and force fullscreen so
-- fullscreen-only VRR (vrr = 2 in monitors.lua) engages. Class confirmed
-- via `hyprctl clients`.
hl.window_rule({
    name       = "overwatch-to-dp1",
    match      = { class = "^(steam_app_2357570)$" },
    monitor    = "DP-1",
    fullscreen = true,
})

-- Aimlabs: same treatment. Verify the class with
-- `hyprctl clients | grep -iA15 aim` while it's open and swap
-- steam_app_714010 if it differs.
hl.window_rule({
    name       = "aimlabs-to-dp1",
    match      = { class = "^(steam_app_714010)$" },
    monitor    = "DP-1",
    fullscreen = true,
})

-- For games running gamescope
-- hl.window_rule({
--     match   = { class = "^(gamescope)$" },
--     monitor = "DP-1",
-- })
