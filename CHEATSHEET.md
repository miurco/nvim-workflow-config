# Quick Reference Cheat Sheet

> **Backslash (`\`) is your command key everywhere!**

## Navigation (No Space needed)

| Key | Action | Where |
|-----|--------|-------|
| `Ctrl` `h` | Left | tmux panes ↔ nvim splits |
| `Ctrl` `j` | Down | tmux panes ↔ nvim splits |
| `Ctrl` `k` | Up | tmux panes ↔ nvim splits |
| `Ctrl` `l` | Right | tmux panes ↔ nvim splits |

## Tmux Commands

### Panes
| Command | Action |
|---------|--------|
| `\` `\|` | Split horizontal |
| `\` `-` | Split vertical |
| `\` `h/j/k/l` | Navigate panes |
| `\` `H/J/K/L` | Resize panes |
| `\` `z` | Zoom/unzoom pane |
| `\` `q` | Kill pane |

### Windows
| Command | Action |
|---------|--------|
| `\` `c` | New window |
| `\` `n` | Next window |
| `\` `p` | Previous window |
| `\` `w` | List windows |
| `\` `Q` | Kill window |

### Sessions
| Command | Action |
|---------|--------|
| `\` `s` | List sessions |
| `\` `d` | Detach |

### Other
| Command | Action |
|---------|--------|
| `\` `:` | Command prompt |
| `\` `[` | Copy mode |
| `\` `r` | Reload config |
