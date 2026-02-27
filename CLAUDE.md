# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

ghostty-dir-themes (gdt) — manages per-directory color themes for the Ghostty terminal. When you `cd` into a mapped directory, the terminal colors change automatically via OSC escape sequences. Default mode is a lightweight inline picker; `--all` opens the full curses TUI.

## How It Works

1. **`mappings.json`** — directory-to-theme associations (`[{directory, theme}]`), stored in `~/.config/gdt/`
2. **`gdt`** — Python 3 script; inline picker (default), full curses TUI (`--all`), hook generator (`--generate-hook`), theme refresh (`--refresh`)
3. **`hook.zsh`** — auto-generated zsh script sourced from `.zshrc`; uses a `chpwd` hook to apply themes on directory change

Themes are discovered from Ghostty's built-in and user theme directories, not stored in this repo.

Flow: user edits mappings in TUI → on save, `hook.zsh` is regenerated with a `case` statement → zsh sources it and applies OSC colors on `cd`.

## Running

```bash
# Inline picker for current directory (default)
./gdt

# Full-screen TUI for managing all mappings
./gdt --all

# Regenerate hook.zsh without any UI
./gdt --generate-hook

# Reapply the theme for the current directory
./gdt --refresh

# Print version
./gdt --version

# Check for broken directory mappings (stale paths)
./gdt --doctor
```

No dependencies beyond Python 3 stdlib. No build step, no tests, no linting configured.

## Key Architecture Details

- Config lives in `~/.config/gdt/` (XDG-compliant), overridable via `$GDT_CONFIG_DIR` env var
- OSC sequences target `/dev/tty` (or `$TTY`) to change bg (OSC 11), fg (OSC 10), and cursor color (OSC 12)
- The "broadcast" feature (`broadcast_updates`) uses `lsof` to find other zsh ttys and push color updates to them
- `hook.zsh` is a pure shell script with no runtime dependency on Python — it's fully self-contained after generation

## Distribution

- **Homebrew**: `Formula/gdt.rb` is a reference copy; the live formula lives in the `McBrideMusings/homebrew-tap` repo
- **Release workflow**: `.github/workflows/release.yml` triggers on `v*` tags — creates a GitHub Release and auto-updates the Homebrew tap
- **apt/deb**: tracked in issue #1, not yet implemented
