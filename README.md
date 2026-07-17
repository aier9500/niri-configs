# niri + DMS dotfiles

Config for the niri window manager plus DankMaterialShell (DMS) presets.
niri config is symlinked; DMS presets you set by hand in its settings app. Optional voice typing via `voxtype` setup before OpenWhispr implements Wayland compositor support.

## Install

> Needs the Terra or Copr repo for DMS

```bash
ln -sfn ~/Projects/niri-dms/niri ~/.config/niri
sudo dnf install niri dms bibata-cursor-theme ocean-sound-theme
systemctl --user add-wants niri.service dms
```

## DMS presets

Set these by hand in DMS settings after a fresh install.

### Personalization

- Wallpaper -> Duplicate with Blur
- Theme color -> Auto
- Automatic Color Mode -> Location
- Cursor theme -> Bibata-Original-Ice (install `bibata-cursor-theme`)
- 24-Hour Format -> true
- Date Format (top bar + lock screen) -> ISO
- Sound Theme -> ocean (install `ocean-sound-theme`)
- Volume Changed sound -> false

### Dank Bar

- Position -> Bottom
- Left: Workspace Switcher, Running Apps
- Right: System Tray, Clipboard, Battery, Control Center, Clock, Notifications

### Power & Security (idle)

- Plugged in: lock 15m, screen off 30m, never sleep
- On battery: lock 10m, screen off 5m, sleep 15m

Keyboard shortcuts live in `niri/user/binds.kdl`.

## Voice Typing (`voxtype`)

- Install: get the rpm from voxtype.io/download (`dnf install voxtype` also
  works but may be an older version)
- Run `voxtype setup` to create the config, then `voxtype setup --download`
  to get the speech model. `voxtype setup check` tells you if anything's
  missing.
- Hotkeys, bound in `niri/user/binds.kdl`:
  - `F8` -> start/stop recording
  - `Shift+F8` -> cancel recording, discards it without pasting anything
  - Set `[hotkey] enabled = false` in the config — niri handles the key, so
    Voxtype's own key-listener should stay off.
  - Only set it `true` on a desktop like GNOME, where Voxtype must listen
    for the key itself.
- Custom words: add proper nouns or jargon to `[whisper] initial_prompt` in
  the config, comma-separated, so they get recognized correctly.
- Output: set `[output] mode = "paste"` so text pastes in cleanly (a single
  clipboard paste, not typed character by character).
- Sound on record start/stop: `[audio.feedback] enabled = true`,
  `volume = 0.2`.
- Notifications: turned off (`on_recording_start`, `on_recording_stop`,
  `on_transcription` all `false` under `[output.notification]`) — redundant
  once the DMS Activity Overlay widget below is on.
- AI cleanup (fixes grammar, converts to British spelling, removes "um"s):
  runs the transcript through a local LLM. One script does it —
  `voxtype/cleanup.sh` — with the cleanup rules baked into its prompt, so
  there's no custom model to build.
  - **Ollama** must be version **0.20 or newer** (the `gemma4` model needs it).
    Fedora's own package is too old — install with
    `curl -fsSL https://ollama.com/install.sh | sh` instead. Then pull the
    model: `ollama pull gemma4:e4b`.
  - **Symlink the script and point the config at it** (like the niri config,
    so editing the repo copy applies live after a daemon restart):
    ```bash
    ln -sfn ~/Projects/niri-dms/voxtype/cleanup.sh ~/.config/voxtype/cleanup.sh
    ```
    ```toml
    [output.post_process]
    command = "sh -c 'exec \"$HOME/.config/voxtype/cleanup.sh\"'"
    ```
  - Two things this design gets right:
    1. **Injection-safe.** Your dictation is sent as a chat _user_ message,
       separate from the model's _system_ rules — so if you dictate
       "ignore your instructions", the model cleans that up as text instead
       of obeying it.
    2. **Clean output.** The script calls Ollama's HTTP API (`curl` + `jq`),
       not the `ollama run` command. `ollama run` does terminal-style word
       wrapping with cursor redraws even with no terminal attached, which
       corrupted the text — duplicated word fragments, stray control codes.
       The API returns plain JSON, so that whole problem is gone.
  - If the DMS Activity Overlay plugin is installed, the script also feeds the
    cleaned text to its on-screen transcript bubble; if it isn't, the script
    just passes the text through. Swap models via the `MODEL=` line in the
    script.
- Keep it running: run `voxtype setup systemd` so it starts automatically
  on login. After changing the config, reload it with
  `systemctl --user restart voxtype`.
- Optional DMS icon: run `voxtype setup dms --install`, then turn on the
  **Voxtype** plugin in DMS Settings -> Plugins and add it to the bar. Needs
  a Nerd Font installed to show its icon, e.g.
  `sudo dnf install jetbrains-mono-nerd-fonts`.
