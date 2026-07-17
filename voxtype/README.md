# voxtype/

Local-LLM cleanup for [Voxtype](https://voxtype.io) voice dictation. Full setup
lives in the root `README.md` ("Voice Typing"); this folder holds the one
portable piece:

- **`cleanup.sh`** — the `[output.post_process]` filter. Takes the raw
  transcript on stdin, sends it to a stock Ollama model via the HTTP chat API
  (`curl` + `jq`), and returns cleaned, single-line text. If the DMS Activity
  Overlay plugin is installed it also tees the result to the overlay's capture
  script; if not, it just passes the text through.

The cleanup rules (British spelling, grammar, filler removal, single-line) live
in the `SYSTEM` prompt inside the script, sent as a separate chat role from the
dictation — so there is **no custom Ollama model to build**. Setup on a fresh
machine is just:

```bash
ollama pull gemma4:e4b                                          # the model
ln -sfn ~/Projects/niri-dms/voxtype/cleanup.sh ~/.config/voxtype/cleanup.sh
```

`cleanup.sh` is symlinked into `~/.config/voxtype/`, so repo edits apply live
(restart the daemon). Swap the model by editing the `MODEL=` line at the top.
