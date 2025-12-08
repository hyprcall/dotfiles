local wezterm = require 'wezterm'

local palette = {
  bg      = "#121015",
  surface = "#1A1217",
  text    = "#E6D9DF",
  text2   = "#BBAEB4",
  red1    = "#FF4C4C",
  red2    = "#FF6B6B",
  selection = "#2A1B22",
}

return {
  enable_wayland = false,   -- stable for your setup right now
  font = wezterm.font_with_fallback({
    "JetBrainsMono Nerd Font", "JetBrains Mono", "Fira Code", "Noto Color Emoji"
  }),
  font_size = 16.0,
  line_height = 1.5,

  hide_tab_bar_if_only_one_tab = false,
  use_fancy_tab_bar = true,

  window_padding = { left = 10, right = 10, top = 8, bottom = 8 },
  window_background_opacity = 0.95,

  colors = {
    foreground = palette.text,
    background = palette.bg,
    cursor_bg = palette.red1,
    cursor_fg = palette.bg,
    cursor_border = palette.red1,

    selection_bg = palette.selection,
    selection_fg = palette.text,

    ansi =    { "#3b3a3b", palette.red1, "#3db39e", "#c8a36a", "#8b78ff", "#d674a6", "#48b3c7", palette.text },
    brights = { "#50484d", "#ff505d", "#4ed0bb", "#f0bf7f", "#9a8aff", "#f087ba", "#59d2e5", "#f0e9ec" },

    tab_bar = {
      background = palette.surface,
      active_tab = { bg_color = palette.surface, fg_color = palette.text, intensity = "Bold" },
      inactive_tab = { bg_color = palette.bg, fg_color = palette.text2 },
      inactive_tab_hover = { bg_color = palette.surface, fg_color = palette.text },
      new_tab = { bg_color = palette.bg, fg_color = palette.text2 },
      new_tab_hover = { bg_color = palette.surface, fg_color = palette.text },
    },
  },

  keys = {
    {key="Enter", mods="ALT",        action=wezterm.action.SplitHorizontal{domain="CurrentPaneDomain"}},
    {key="Enter", mods="ALT|SHIFT",  action=wezterm.action.SplitVertical{domain="CurrentPaneDomain"}},
    {key="j",    mods="ALT",         action=wezterm.action.ActivatePaneDirection("Left")},
    {key="k",    mods="ALT",         action=wezterm.action.ActivatePaneDirection("Down")},
    {key="i",    mods="ALT",         action=wezterm.action.ActivatePaneDirection("Up")},
    {key="l",    mods="ALT",         action=wezterm.action.ActivatePaneDirection("Right")},
    {key="C",    mods="CTRL|SHIFT",  action=wezterm.action.CopyTo "Clipboard"},
    {key="V",    mods="CTRL|SHIFT",  action=wezterm.action.PasteFrom "Clipboard"},
    {key="t",    mods="ALT",         action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
    {key="f",    mods="ALT",         action=wezterm.action.ToggleFullScreen},
  },

  mouse_bindings = {
    -- copy selection on mouse-up (and open links if clicked)
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "NONE",
      action = wezterm.action.CompleteSelectionOrOpenLinkAtMouseCursor("ClipboardAndPrimarySelection"),
    },
    {
      event = { Down = { streak = 1, button = "Right" } },
      mods = "NONE",
      action = wezterm.action.PasteFrom("Clipboard"),
    },
  },
}
