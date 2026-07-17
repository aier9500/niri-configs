# Fresh Installation

> ![warning] Requires Terra/Copr for DMS

```bash
sudo dnf install niri dms
systemctl --user add-wants niri.service dms
```

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
