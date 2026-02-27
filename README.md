# ghostty-dir-themes (gdt)

Manage per-directory color themes for the [Ghostty](https://ghostty.org) terminal. When you `cd` into a mapped directory, your terminal colors change automatically.

## Requirements

- macOS or Linux
- Python 3 (stdlib only, no pip dependencies)
- [Ghostty](https://ghostty.org) terminal
- zsh

## Installation

### Homebrew (macOS)

```bash
brew tap McBrideMusings/tap
brew install gdt
```

### Manual (git clone)

```bash
git clone https://github.com/McBrideMusings/ghostty-dir-themes.git
cd ghostty-dir-themes
chmod +x gdt
sudo ln -s "$(pwd)/gdt" /usr/local/bin/gdt
```

### Shell Hook Setup

After installing, generate the hook and source it from your `.zshrc`:

```bash
gdt --generate-hook
echo 'source ~/.config/gdt/hook.zsh' >> ~/.zshrc
```

Restart your shell or run `source ~/.zshrc`.

## Usage

### Inline Picker (default)

Run `gdt` in any directory to pick a theme for it:

```bash
gdt
```

| Key | Action |
|-----|--------|
| `Left` / `Right` (or `h` / `l`) | Cycle through themes (live preview) |
| `Enter` | Save mapping and keep theme |
| `q` / `Esc` | Quit without saving (restores previous theme) |

### Full-Screen TUI

Use `--all` to manage all directory mappings at once:

```bash
gdt --all
```

| Key | Action |
|-----|--------|
| `a` | Add a directory mapping |
| `b` | Batch-fill all subdirectories of a root |
| `d` | Delete the selected mapping |
| `Enter` | Edit theme for selected mapping (carousel) |
| `s` | Save mappings and regenerate the hook |
| `q` | Quit (auto-saves if there are changes) |

### Delete a Mapping

Run `gdt --delete` to remove a mapping for the current directory.

### Doctor

Check for broken directory mappings (directories that no longer exist) and clean them up:

```bash
gdt --doctor
```

### Regenerate Hook

```bash
gdt --generate-hook
```

## Configuration

gdt stores its configuration in `~/.config/gdt/` (or `$XDG_CONFIG_HOME/gdt/`). You can override this with the `GDT_CONFIG_DIR` environment variable.

- `~/.config/gdt/mappings.json` — directory-to-theme associations
- `~/.config/gdt/hook.zsh` — auto-generated zsh hook (sourced from `.zshrc`)

## How It Works

1. The TUI reads Ghostty's installed themes (built-in and user themes from `~/.config/ghostty/themes/`)
2. You map directories to themes using the TUI
3. On save, a `hook.zsh` script is generated with a `case` statement matching directories to OSC color sequences
4. zsh's `chpwd` hook runs the matcher every time you `cd`, applying the matching theme instantly
5. The generated hook is pure shell with no Python dependency at runtime

## Theme Discovery

gdt discovers themes from two locations:

- **Built-in (macOS):** `/Applications/Ghostty.app/Contents/Resources/ghostty/themes`
- **Built-in (Linux):** `/usr/share/ghostty/themes`
- **User:** `~/.config/ghostty/themes/`

## Platform Support

gdt works on **macOS** and **Linux** with **zsh**. It relies on `/dev/tty` for OSC output, `lsof` for broadcasting theme changes to other terminals, and platform-specific paths for theme discovery. Windows is not supported.
