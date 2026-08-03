-- Environmental Variables for compatibility

-- Nvidia Configs
hl.env("LIBVA_DRIVER_NAME",            "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME",    "nvidia")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("NVD_BACKEND",                  "direct")
hl.env("GBM_BACKEND",                  "nvidia-drm")
hl.env("VDPAU_DRIVER",                 "nvidia")
hl.env("__GL_SHADER_DISK_CACHE_SKIP_CLEANUP", "1")
hl.env("__GL_SHADER_DISK_CACHE_SIZE",  "5000000000")

-- Toolkit Backend
hl.env("GDK_BACKEND", "wayland,x11,*")

-- XDG Specifications
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE",    "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Theming
hl.env("XCURSOR_SIZE", "24")

-- Future AMD iGPU config
