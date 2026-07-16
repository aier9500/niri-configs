# Fresh Installation

> ![warning] Requires Terra/Copr for DMS

```bash
sudo dnf install niri dms
systemctl --user add-wants niri.service dms
```

## Soft dependencies (used by dms but not by user/\*.kdl)

bibata-cursor-theme
ocean-sound-theme
