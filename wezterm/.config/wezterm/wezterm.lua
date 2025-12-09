local wezterm = require 'wezterm'

local palette = {
  bg      = "#0d0d0d",
  surface = "#12110F",
  text    = "#e6e6e6",
  text2   = "#b3b3b3",
  red1    = "#ff0012",
  red2    = "#ff0013",
  selection = "#49b1f5",
}

return {
  enable_wayland = false,   -- stable for your setup right now
  font = wezterm.font_with_fallback({
    "JetBrainsMono Nerd Font", "JetBrains Mono", "Fira Code", "Noto Color Emoji"
  }),
  font_size = 16.0,
  line_height = 1.5,

  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = true,

  window_padding = { left = 5, right = 5, top = 4, bottom = 4 },
  window_background_opacity = 0.85,

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
