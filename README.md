# niri + DMS dotfiles

niri (WM) config and DankMaterialShell (DMS) presets in one repo.

## Layout

```
niri/            whole niri config      -> symlinked to ~/.config/niri (live)
dank/
  settings.json  minimal DMS overlay    -> copied to ~/.config/DankMaterialShell
  snapshot.sh    capture DMS GUI changes into the overlay
install.sh       fresh-box bootstrap
```

**niri** is live-symlinked: edits show in `git diff` immediately.

**DMS** is snapshot-based, not symlinked. `dank/settings.json` holds only the
settings that differ from DMS defaults (~25 keys, not the full ~370). DMS honors
a partial file — absent keys fall back to code defaults — so this is version-proof:
new DMS defaults are inherited automatically. Trade-off: DMS GUI changes are NOT
auto-tracked. After tweaking DMS, run `dank/snapshot.sh` to capture them.
(`snapshot.sh` strips `wifiNetworkPins` so home SSIDs stay out of git.)

## Fresh Installation

> ![warning] Requires Terra/Copr for DMS

```bash
./install.sh                                  # symlink niri, copy DMS overlay
sudo dnf install niri dms bibata-cursor-theme ocean-sound-theme
systemctl --user add-wants niri.service dms
```

The DMS preset list below is applied automatically by the overlay. It is kept as
a human reference and for the few items not stored in `settings.json` (wallpaper).

## DMS

### Personalization

#### Wallpaper

- Duplicate Wallpaper with Blur

#### Theme & Colors

- Theme color -> Auto
- Automatic Color Mode -> Location
- Cursor theme -> Bibata-Original-Ice (req: `bibata-cursor-theme`)

#### Time & Weather

- Time Format -> 24-Hour Format -> true
- Date Format -> Top Bar Format -> ISO Date
- Date Format -> Lock Screen Format -> ISO Date

#### Sounds

- Sound Theme -> ocean (req: `ocean-sound-theme`)
- Volumn Changed -> false

### Dank Bar

#### Settings

- Position -> Bottom

#### Widgets

- Left
  - Workspace Switcher
  - Running Apps
- Right
  - System Tray
  - Clipboard Manager
  - Battery
  - Control Center
  - Clock
  - Notification Center

### Keyboard Shortcuts

Handled by user/binds

### Power & Security

#### Idle Settings

- AC Power
  - Automatically lock after -> 15 minutes
  - Turn off monitors after -> 30 minutes
  - Suspend system after -> Never
- Battery
  - Automatically lock after -> 10 minutes
  - Turn off monitors after -> 5 minutes
  - Suspend system after -> 15 minutes
