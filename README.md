> [!WARNING]
> THE COMMANDS IN THIS README IS DESIGNED FOR THE REPO TO BE CLONED TO `~/Projects` with its original name `Niri-dms`!!!

```bash
mkdir -p ~/Projects
cd ~/Projects
git clone https://github.com/aier9500/niri-dms
```

# Niri + DMS dotfiles

Config for the Niri window manager plus DankMaterialShell (DMS) presets.

Niri config is symlinked; DMS settings set by hand in its settings app. Optional voice typing via `voxtype` setup before OpenWhispr implements Wayland compositor support.

## Install Niri & DMS

> Needs the Terra or Copr repo for DMS

```bash
ln -sfn ~/Projects/niri-dms/niri ~/.config/niri
systemctl --user add-wants niri.service dms
```

## DMS suggested presets

Some settings worth changing in the DMS settings after fresh install. Sorted by section.

> [!IMPORTANT]
> This repo's keyboard shortcuts live in `niri/user/binds.kdl`.
>
> I highly suggest declaring bindings via the .kdl file and upload them to a remote instead of using the GUI.

### Personalization

- Wallpaper -> Duplicate with Blur -> true (blurry overview)
- Theme & Colors
  - Theme color -> Auto
  - Cursor theme

### Dank Bar

- Positions
- Widgets

### Power & Security -> Power & Sleep

- Plugged in: lock 15m, screen off 30m, never sleep
- On battery: lock 10m, screen off 5m, sleep 15m

## Voice Typing (`voxtype`)

Press hotkey, talk, and the text pastes at your cursor. An optional local-LLM tidies the grammar and spelling. Set it up in these blocks.

`voxtype`'s config file lives in `~/.config/voxtype.config.toml`.

You can edit via the TUI using `voxtype configure`.

> [!TIP]
> This is the solution I would suggest before OpenWhispr (which has a much simpler setup) implements better Wayland compositor support.
>
> Currently the universal keybinding does not work without an extensive amount of tweaks.

### Install `voxtype`

Get the rpm from [voxtype.io/download](https://voxtype.io/download) (or `dnf install voxtype`, which may be older). Then:

```bash
voxtype setup             # create the config
voxtype setup --download  # download the speech model
voxtype setup check       # report anything still missing
```

### `voxtype` Binding

In Niri, it is bound via `niri/user/binds.kdl`:

- `Alt+Space` -> start / stop recording
- `Alt+Shift+Space` -> cancel, discards without pasting

In the `voxtype` config, set `[hotkey] enabled = false` so Niri owns the key. (Set it `true` only on a desktop like GNOME, where Voxtype must listen for the key.)

### Paste + sound

- `[output] mode = "paste"` -> text copies to clipboard and lands as one clean paste, not typed character by character.
- `[audio.feedback] enabled = true`, `volume = 0.2` -> soft beep on record upon start and stop.

### Teach it your words

Add proper nouns and jargon to `[whisper] initial_prompt`, comma-separated.

Example:

```toml
# ...

[whisper]
model = "base.en"
initial_prompt = "Vocabulary: OpenWhispr, Qwen, LLM, local LLM, local chat, self-hosting, Iker, Erik, Katie, ProArt, ProArt P16, Zenbook, Zenbook S16, ThinkPad, Logi Bolt, Delux M800, NuPhy Air 75, IBM Plex, Fedora, Arch, Ubuntu, Debian, Gnome, KDE Plasma, Hyprland, NixOS, X11, Wayland, systemd, Bash, Zsh, Vim, Neovim, Docker, GitHub, GitLab, VS Code, JetBrains, Rust, Cargo, npm, pnpm, WireGuard, Tailscale, Btrfs, ZFS, Postgres, Redis, Flatpak, BU Questrom, NYU Stern, UofT, sonion, brainrot, low-key, high-key, Tuxie's, Tuxie's Wiki, arepa, empanada, Niri, Voxtype, PaperWM, compositor, Wayland compositor"

# ... code omitted
```

### AI cleanup (optional)

Runs each transcript through a local LLM to fix grammar, converts to British spelling, strips the "um"s.

> [!TIP]
> This repo has a script that pipes raw output to Gemma 4 E4B and processes it; it contains the prompt that is given to the LLM to clean up text.
>
> Feel free to tweak the script if 1) you don't want conversion to British English, 2) want specific writing style/tone, 3) others.

> [!WARNING]
> Needs Ollama **0.20+** (the one packaged in dnf is too old as of 2026-07-17). That's why we are curling.

```bash
curl -fsSL https://ollama.com/install.sh | sh
ollama pull gemma4:e4b
ln -sfn ~/Projects/niri-dms/voxtype/cleanup.sh ~/.config/voxtype/cleanup.sh
```

Then point the post processing command at the script in the config:

```toml
[output.post_process]
command = "sh -c 'exec \"$HOME/.config/voxtype/cleanup.sh\"'"
```

Swap models by editing its `MODEL=` line. Default uses Gemma 4 E4B

### Autostart

```bash
voxtype setup systemd             # autostart on login
systemctl --user restart voxtype  # reload after any config change
```

### DMS extras

- **Status icon** -> `voxtype setup dms --install`, then enable the **Voxtype**
  plugin in DMS Settings -> Plugins and add it to the bar. Needs a Nerd Font
  (`sudo dnf install jetbrains-mono-nerd-fonts`).
- **Activity Overlay** -> if that plugin is installed, `cleanup.sh` feeds it the
  live transcript bubble automatically. Nothing to configure.
