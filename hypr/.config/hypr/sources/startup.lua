-- Startup apps and daemons

hl.on("hyprland.start", function()
    -- Programs that need to start for the system to operate
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("swaync")

    -- Hypr Ecosystem
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hyprsunset")

    -- Other
    hl.exec_cmd("openrgb --startminimized --profile ~/.config/OpenRGB/Red.orp")
    hl.exec_cmd("easyeffects --gapplication-service")
    hl.exec_cmd("waybar --config ~/.config/waybar/config")
    hl.exec_cmd("otd-daemon")
    hl.exec_cmd("steam")

    -- Loopback
    hl.exec_cmd("pw-loopback -n 'MyMicLoopback' --capture-props='easyeffects_source' --playback-props='alsa_output.usb-Razer_Razer_Nari_Ultimate-00.pro-output-1'")

    -- Docker X11 Permissions
    hl.exec_cmd("xhost +local:root")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE")
    hl.exec_cmd("systemctl --user start xdg-desktop-portal-hyprland")
    hl.exec_cmd("systemctl --user start xdg-desktop-portal")
end)
