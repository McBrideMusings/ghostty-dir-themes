# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

ghostty-dir-themes (gdt) — manages per-directory color themes for the Ghostty terminal. When you `cd` into a mapped directory, the terminal colors change automatically via OSC escape sequences. Default mode is a lightweight inline picker; `--all` opens the full curses TUI.

## How It Works

1. **`themes.json`** — theme definitions (name → `{bg, fg, cursor}` hex colors)
2. **`mappings.json`** — directory-to-theme associations (`[{directory, theme}]`)
3. **`gdt`** — Python 3 script; inline picker (default), full curses TUI (`--all`), hook generator (`--generate-hook`)
4. **`hook.zsh`** — auto-generated zsh script sourced from `.zshrc`; uses a `chpwd` hook to apply themes on directory change

Flow: user edits mappings in TUI → on save, `hook.zsh` is regenerated with a `case` statement → zsh sources it and applies OSC colors on `cd`.

## Running

```bash
# Inline picker for current directory (default)
./gdt

# Full-screen TUI for managing all mappings
./gdt --all

# Regenerate hook.zsh without any UI
./gdt --generate-hook
```

No dependencies beyond Python 3 stdlib. No build step, no tests, no linting configured.

## Key Architecture Details

- All files live in the same directory; `CONFIG_DIR` is derived from the script's own location
- OSC sequences target `/dev/tty` (or `$TTY`) to change bg (OSC 11), fg (OSC 10), and cursor color (OSC 12)
- The "broadcast" feature (`broadcast_updates`) uses `lsof` to find other zsh ttys and push color updates to them
- `hook.zsh` is a pure shell script with no runtime dependency on Python — it's fully self-contained after generation
