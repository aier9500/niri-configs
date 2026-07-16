# Input Method under Niri (Cantonese / jyut6ping3)

Niri is a bare Wayland compositor — unlike GNOME it does **not** autostart an IME
daemon or export the IM env vars. Whatever CJK input "just worked" in GNOME must be
wired up by hand here. This documents the moving parts so each new machine can be
adapted, not blindly scripted (engine names, layouts, and installed IMEs differ).

## The 3 things GNOME did for you

1. **Started the IME daemon** (`ibus-daemon`) at session login.
2. **Exported IM env vars** so GTK/Qt/XWayland apps route text through it.
3. **Preloaded an engine** in dconf (the Cantonese/Rime schema).

Under Niri you replicate all three. Nothing needs *installing* if it already worked
in GNOME — the config lives in your home dir and is shared.

---

## Decision 1 — which IME stack?

| Stack | When | Notes |
|-------|------|-------|
| **ibus** | Already configured in GNOME; want minimal | Reuses existing `~/.config/ibus/rime/`. Weaker native-Wayland text-input under wlroots-style compositors. |
| **fcitx5** | ibus drops input in native-Wayland apps | Better `text-input-v3` support on Niri. Full reinstall + reconfigure. |

Try ibus first (zero install). Switch to fcitx5 only if real apps still miss input
after a relogin.

## Decision 2 — verify what's already installed

Don't assume. Check before touching anything:

```bash
ls ~/.config/ibus/rime/                       # existing schemas? (jyut6ping3.*)
ls /usr/share/ibus/component/rime.xml          # rime engine registered?
gsettings get org.freedesktop.ibus.general preload-engines   # current engine list
localectl status                               # system keyboard layout/variant
```

If `jyut6ping3.schema.yaml` etc. exist, the Cantonese data is already there — you only
need the 3 wiring steps below. If not, install (`fcitx5-rime` or the official
rime-cantonese script) first.

---

## The wiring (ibus)

### 1. IM env vars — `~/.config/environment.d/ibus.conf`
```ini
GTK_IM_MODULE=ibus
QT_IM_MODULE=ibus
XMODIFIERS=@im=ibus
```
Read by the systemd user session **at login** — needs a relogin to take effect.
Covers GTK, Qt, and XWayland apps. (Native-Wayland apps use the `text-input`
protocol directly, independent of these — hence the fcitx5 caveat above.)

### 2. Preload the engine — dconf
```bash
gsettings set org.freedesktop.ibus.general preload-engines "['rime']"
```
Engine name comes from the component xml / `ibus list-engine` (daemon must be running
to list). Here it's `rime`.

### 3. Autostart the daemon — `~/.config/niri/config.kdl`
```kdl
spawn-at-startup "ibus-daemon" "-rxRd"
```
Flags: `-r` replace running · `-x` XIM server · `-R` auto-restart on crash · `-d` daemonize.

### 4. Apply now (current session, before relogin)
```bash
export GTK_IM_MODULE=ibus QT_IM_MODULE=ibus XMODIFIERS=@im=ibus
ibus-daemon -rxRd
```
Then **relogin** so the env file applies everywhere.

---

## Gotcha — colemak_dh (or any non-qwerty layout)

This system types **colemak_dh** (`localectl`: `us` variant `colemak_dh`), set at the
compositor/system level, not by Niri's (empty) `xkb {}` block.

**Do not** add an `xkb:us::eng` entry to `preload-engines`. ibus xkb engines carry their
own layout and force **qwerty** whenever you're in "English" mode — clobbering colemak_dh.

Instead preload **only** the Rime engine (`['rime']`). Consequences:
- All keys route through Rime; it receives keysyms already mapped to colemak_dh by the
  compositor, so ASCII output stays colemak_dh.
- **English ⇄ Chinese** = Rime's built-in **ASCII toggle** (default `Shift`, or
  `Ctrl+` `` ` ``), *not* an ibus engine switch. Staying inside Rime keeps the layout.
- Trade-off: no true "IME off" state via `Super+space` (only one engine loaded). Adding
  a second engine to get that reintroduces the qwerty clobber — not worth it.

If a machine uses plain qwerty, the `xkb:us::eng` + engine two-slot setup is fine there;
this gotcha is layout-specific.

---

## Verify it works

```bash
ibus engine            # shows active engine (rime)
```
Type in a GTK app: Rime candidate window should appear. Toggle ASCII with `Shift`.
If native-Wayland apps get no input but XWayland ones do → the env-var path works but
the Wayland text-input path doesn't → consider fcitx5.
