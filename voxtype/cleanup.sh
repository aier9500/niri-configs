#!/usr/bin/env sh
# Voxtype post-process cleanup filter.
#
# stdin:  raw Whisper transcript
# stdout: cleaned, single-line text (pasted by Voxtype)
#
# Wired in ~/.config/voxtype/config.toml:
#   [output.post_process]
#   command = "sh -c 'exec \"$HOME/.config/voxtype/cleanup.sh\"'"
#
# All the cleanup logic and prompt-injection defense live in the custom
# `voxtype-cleanup` Ollama model (see voxtype-cleanup.Modelfile). This script
# is just plumbing: call Ollama's HTTP chat API, force a single line, and — if
# the DMS Activity Overlay plugin is installed — tee the result to its capture
# script so the on-screen transcript bubble updates.
#
# The HTTP API is used deliberately instead of `ollama run`: the CLI does
# terminal word-wrapping with cursor redraws even when piped, which corrupted
# output (duplicated word fragments, stray ANSI codes). The API returns clean
# JSON, so that whole bug class is gone.

capture="$HOME/.config/DankMaterialShell/plugins/voxtypeActivityOverlay/scripts/dms-voxtype-activity-overlay-capture"

clean() {
	jq -Rs --arg model voxtype-cleanup \
		'{model:$model, stream:false, messages:[{role:"user", content:.}]}' \
	| curl -s http://localhost:11434/api/chat -d @- \
	| jq -r '.message.content' \
	| tr '\n' ' '
}

if [ -x "$capture" ]; then
	clean | "$capture"
else
	clean
fi
