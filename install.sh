#!/usr/bin/env bash
# Fresh-install bootstrap for niri + DankMaterialShell (DMS) dotfiles.
# Symlinks niri config live; copies the minimal DMS overlay (DMS fills defaults).
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
CFG="${XDG_CONFIG_HOME:-$HOME/.config}"

# 1. niri: live dir-symlink
if [ -e "$CFG/niri" ] && [ ! -L "$CFG/niri" ]; then
  echo "backing up existing $CFG/niri -> $CFG/niri.bak"
  mv "$CFG/niri" "$CFG/niri.bak"
fi
ln -sfn "$REPO/niri" "$CFG/niri"
echo "linked $CFG/niri -> $REPO/niri"

# 2. DMS: copy minimal overlay (absent keys fall back to DMS defaults on load)
mkdir -p "$CFG/DankMaterialShell"
DEST="$CFG/DankMaterialShell/settings.json"
if [ -f "$DEST" ]; then
  echo "existing DMS settings kept at $DEST (delete it, then re-run to apply repo overlay)"
else
  cp "$REPO/dank/settings.json" "$DEST"
  echo "installed DMS overlay -> $DEST"
fi

cat <<'EOF'

Next (see README.md for preset details):
  sudo dnf install niri dms bibata-cursor-theme ocean-sound-theme
  systemctl --user add-wants niri.service dms
EOF
