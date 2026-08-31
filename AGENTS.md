# Agent guide

This repo is used to bootstrap macOS/Linux machines via mise.

## Searching the mise docs

Prefer local docs over fetching them over the network (no curl):

- Docs live at `~/.cache/mise-docs/docs` (a shallow, sparse checkout of
  `github.com/jdx/mise` — only the `docs/` tree). Search with `rg`, e.g.
  `rg -n "bootstrap.repos" ~/.cache/mise-docs/docs`.
- If that directory is missing or stale, run `bash ~/.local/bin/mise-docs`
  (also exposed as `mise run mise-docs`). It is idempotent.
- For command-specific behavior, `mise help <cmd>` and `-h` on subcommands
  come from the installed binary and are always current — check those first
  for CLI details and use `mise ... --dry-run` to preview actions.
- Only fall back to https://mise.jdx.dev if the above are insufficient.

## Verifying config changes

`mise.toml`/`config.toml` edits can be validated in a scratch dir:

```bash
cd /tmp && rm -rf mise-test && mkdir mise-test && cd mise-test
# write a test config, then:
mise trust && mise bootstrap repos/files apply --dry-run
```
