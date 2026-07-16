# Niri shortcut cheatsheet

Source: `user/binds.kdl` (single file — `dms/binds.kdl` is no longer included by `config.kdl`; DMS may
regenerate it but it's ignored). **IPC** = spawns a `dms ipc call …` service. Mod = Super.

---

## Launchers & apps
| Key | Action | IPC |
|-----|--------|-----|
| `Super+Return` | Terminal (ghostty) | |
| `Super+E` | Files (nautilus) | |
| `Super+B` | Zen Browser | |
| `Super+A` | App launcher (spotlight) | ✅ |
| `Super+V` | Clipboard manager | ✅ |
| `Super+Y` | Wallpaper browser (dankdash) | ✅ |
| `Super+N` | Notepad | ✅ |
| `Super+M` | Notifications | ✅ |
| `Super+I` | DMS settings | ✅ |
| `Super+Shift+W` | Create window rule | ✅ |

## Window management
| Key | Action |
|-----|--------|
| `Super+X` / `Alt+F4` | Close window |
| `Super+F` | Maximize column (100% width) |
| `Super+Shift+F` | Fullscreen (true) |
| `Super+T` | Toggle floating |
| `Super+Shift+T` | Focus floating ↔ tiling |

## Focus
| Key | Action |
|-----|--------|
| `Super+←/→` | Focus column left/right |
| `Super+↑/↓` | Focus window up/down (in column) |
| `Super+Home/End` | Focus first/last column |
| `Super+Ctrl+←/→` | Focus monitor left/right |

## Move / arrange
| Key | Action |
|-----|--------|
| `Super+[ / Super+]` | Move column to monitor left/right |
| `Super+Ctrl+Shift+↑/↓` | Move column to workspace up/down |
| `Super+Shift+←/→` | Consume/expel window to neighbour column |
| `Super+Shift+↑/↓` | Move window up/down in column |
| `Super+Alt+←/→` | Move column (reposition in strip) |

## Workspaces
| Key | Action |
|-----|--------|
| `Super+Ctrl+↑/↓` | Switch workspace |
| `Super+PageUp/PageDown` | Switch workspace |
| `Super+1…9` | Switch to workspace N |
| `Super+Shift+1…9` | Move column to workspace N |
| `Super+Shift+PageUp/PageDown` | Reorder workspace itself |

## Sizing
| Key | Action |
|-----|--------|
| `Super+R` | Cycle preset column widths |
| `Super+Ctrl+R` | Reset window height |
| `Super+C` | Center column |
| `Super+Ctrl+C` | Center visible columns |
| `Super+-` / `Super+=` | Column width −/+10% |
| `Super+Shift+-` / `Super+Shift+=` | Window height −/+10% |

## Mouse wheel (hold Super)
| Key | Action |
|-----|--------|
| `Super+Wheel↕` | Switch workspace |
| `Super+Wheel↔` | Focus column |

## Overview / language / system
| Key | Action | IPC |
|-----|--------|-----|
| `Super+Tab` | Toggle overview | |
| `Super+Space` | Switch keyboard layout | |
| `Super+Shift+Slash` | Show hotkey overlay (live) | |
| `Super+L` | Lock screen | ✅ |
| `Ctrl+Alt+Delete` | Power menu (logout/reboot/shutdown live here) | ✅ |
| `Ctrl+Shift+Escape` | System monitor (Mission Center) | |
| `Super+Escape` | Toggle shortcut inhibit | |

## Media / brightness (function keys)
| Key | Action | IPC |
|-----|--------|-----|
| `XF86Audio Raise/Lower/Mute/MicMute` | Volume / mute | ✅ |
| `XF86Audio Play/Pause/Prev/Next` | MPRIS transport | ✅ |
| `Ctrl+XF86Audio Raise/Lower` | MPRIS volume | ✅ |
| `XF86MonBrightness Up/Down` | Screen brightness | ✅ |

## Screenshots
| Key | Action |
|-----|--------|
| `Print` / `XF86Launch1` | Screenshot (region UI) |
| `Ctrl+Print` / `Ctrl+XF86Launch1` | Screenshot whole screen |
| `Alt+Print` / `Alt+XF86Launch1` | Screenshot window |
| `Super+Shift+S` | Screenshot (region UI, user alias) |

---

## Freed / intentionally unbound
Kept clear on purpose so DMS defaults or future binds don't collide:
`Super+Shift+Ctrl+*`, `Super+Shift+Alt+*` (fully open families), `Super+Shift+X`,
`Super+Ctrl+Wheel`, `Super+Ctrl+Shift+Wheel`, `Super+Comma`, `Super+Period`,
`Super+Ctrl+Home/End`, `Super+Alt+L`, `Super+Shift+E`, `Super+Alt+↑/↓`,
`Super+Shift+Return`, `Super+Shift+Escape`, `Alt+Space`, `Alt+Shift+S`, `F13`.
Most of `D G H J K O P Q U Z` (colemak cleanup) are also free letters.
