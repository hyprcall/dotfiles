-- Keybinds
local mainMod = "SUPER" -- Basically the Windows key

-- Basic
hl.bind(mainMod .. " + Q",        hl.dsp.exec_cmd("wezterm"))
hl.bind(mainMod .. " + C",        hl.dsp.window.close())
hl.bind(mainMod .. " + CTRL + M", hl.dsp.exit())
hl.bind(mainMod .. " + E",        hl.dsp.exec_cmd("thunar"))
hl.bind(mainMod .. " + V",        hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P",        hl.dsp.window.pseudo())                          -- dwindle
hl.bind(mainMod .. " + J",        hl.dsp.layout("togglesplit"))                    -- dwindle
hl.bind(mainMod .. " + D",        hl.dsp.exec_cmd("rofi -show drun -show-icons"))
hl.bind(mainMod .. " + F",        hl.dsp.window.fullscreen({ mode = 0 }))
hl.bind(mainMod .. " + K",        hl.dsp.window.kill())

-- Notficiations
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))

-- File Manager
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("wezterm -e yazi"))
-- Browser
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("brave"))
-- Old settings Currently using gemini-cli
-- hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("brave https://gemini.google.com/app"))

-- Gemini
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("wezterm start --cwd /home/hypr/Gemini -- claude"))

-- Color Pick
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("hyprpicker -a"))

-- Steam Refresh
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprctl dispatch killactive && steam"))

-- Sleep
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd("hyprlock & sleep 0.3 && systemctl suspend"))
-- Lock Screen
hl.bind(mainMod .. " + L",       hl.dsp.exec_cmd("hyprlock"))

-- Screenshots
hl.bind("Print",                hl.dsp.exec_cmd([[grim -g "$(slurp)" - | wl-copy]]))                                              -- Clipboard
hl.bind("CTRL + Print",         hl.dsp.exec_cmd([[grim -g "$(slurp)" - | swappy -f -]]))                                          -- Clipboard to Swappy
hl.bind("CTRL + SHIFT + Print", hl.dsp.exec_cmd([[grim -o "$(hyprctl -j activeworkspace | jq -r '.monitor')" - | swappy -f -]])) -- Fullscreen to Swappy

-- Focus Control
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- GPU Screen Recorder Menu
hl.bind(mainMod .. " + F10", hl.dsp.exec_cmd("~/.config/recorder/menu.sh"))

-- TTS Read Selection
hl.bind("SUPER + SHIFT + T", hl.dsp.exec_cmd("~/.local/bin/read-selection.sh"))
hl.bind("SUPER + ALT + T",   hl.dsp.exec_cmd("~/.local/bin/stop-selection.sh"))
