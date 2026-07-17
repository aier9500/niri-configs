# voxtype/

Local-LLM cleanup for [Voxtype](https://voxtype.io) voice dictation. Full setup
lives in the root `README.md` ("Voice Typing"); this folder holds the two
portable pieces:

- **`voxtype-cleanup.Modelfile`** — builds the `voxtype-cleanup` Ollama model.
  The cleanup rules (British spelling, grammar, filler removal, single-line) and
  the prompt-injection defense are baked into its `SYSTEM` prompt.
  Build: `ollama create voxtype-cleanup -f voxtype-cleanup.Modelfile`
- **`cleanup.sh`** — the `[output.post_process]` filter. Plumbing only: sends the
  transcript to Ollama's HTTP chat API, forces a single line, and (if present)
  tees to the DMS Activity Overlay capture script. Install to
  `~/.config/voxtype/cleanup.sh`.

Neither file is symlinked — copy/build them per machine as documented above.
