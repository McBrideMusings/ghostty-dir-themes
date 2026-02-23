# ghostty-dir-themes (gdt)

A curses TUI that manages per-directory color themes for the [Ghostty](https://ghostty.org) terminal. When you `cd` into a mapped directory, your terminal colors change automatically.

## Requirements

- macOS (Linux support is possible but untested)
- Python 3 (stdlib only, no pip dependencies)
- [Ghostty](https://ghostty.org) terminal
- zsh

## Installation

Clone the repo anywhere you like:

```bash
git clone https://github.com/user/ghostty-dir-themes.git ~/.config/ghostty-dir-themes
```

Make sure the `gdt` script is executable:

```bash
chmod +x ~/.config/ghostty-dir-themes/gdt
```

Generate the shell hook and source it from your `.zshrc`:

```bash
~/.config/ghostty-dir-themes/gdt --generate-hook
echo 'source ~/.config/ghostty-dir-themes/hook.zsh' >> ~/.zshrc
```

Restart your shell or run `source ~/.zshrc`.

## Usage

Launch the TUI:

```bash
~/.config/ghostty-dir-themes/gdt
```

### TUI Controls

| Key | Action |
|-----|--------|
| `a` | Add a directory mapping |
| `b` | Batch-fill all subdirectories of a root |
| `d` | Delete the selected mapping |
| `Enter` | Edit theme for selected mapping (carousel) |
| `s` | Save mappings and regenerate the hook |
| `q` | Quit (auto-saves if there are changes) |

In the theme carousel:

| Key | Action |
|-----|--------|
| `Left` / `Right` | Cycle through available Ghostty themes |
| `Enter` | Confirm selection |
| `Esc` | Cancel |

### Regenerate Hook Without TUI

```bash
~/.config/ghostty-dir-themes/gdt --generate-hook
```

## How It Works

1. The TUI reads Ghostty's installed themes (built-in and user themes from `~/.config/ghostty/themes/`)
2. You map directories to themes using the TUI
3. On save, a `hook.zsh` script is generated with a `case` statement matching directories to OSC color sequences
4. zsh's `chpwd` hook runs the matcher every time you `cd`, applying the matching theme instantly
5. The generated hook is pure shell with no Python dependency at runtime

## Theme Discovery

gdt discovers themes from two locations:

- **Built-in:** `/Applications/Ghostty.app/Contents/Resources/ghostty/themes`
- **User:** `~/.config/ghostty/themes/`

## Platform Support

gdt currently works on **macOS** with **zsh**. It relies on `/dev/tty` for OSC output, `lsof` for broadcasting theme changes to other terminals, and the macOS Ghostty.app bundle path for theme discovery. Windows is not supported.
