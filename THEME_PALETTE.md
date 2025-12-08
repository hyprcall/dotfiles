# 🎨 HyprCall Theme Palette
> "Cybersecurity Dark" aesthetic based on hyprcall.com

| Variable Name | Hex Code  | Visual Description | Usage Examples |
| :--- | :--- | :--- | :--- |
| **bg-deep** | `#0d0d0d` | Deepest Black/Grey | Wallpaper, Terminal Background, Lock Screen Base |
| **bg-surface** | `#121212` | Surface Grey | Waybar modules, Rofi window, Floating windows |
| **accent-primary** | `#49b1f5` | **Sky Blue** | **Active Window Border**, Active Workspace, Links, Folder Icons |
| **accent-secondary**| `#ff7242` | **Orange/Salmon** | "Urgent" alerts, Errors, Close buttons, Hover states |
| **text-main** | `#e6e6e6` | Soft White | Clock text, Main titles, Document text |
| **text-dim** | `#b3b3b3` | Light Grey | Inactive module text, Subtitles, Comments |
| **border-inactive** | `#1f1f1f` | Dark Grey | Inactive window borders, Separator lines |

---

## 🔧 App-Specific Snippets

### Hyprland (`hyprland.conf`)
```ini
general {
    col.active_border = rgb(49b1f5)
    col.inactive_border = rgb(1f1f1f)
}
