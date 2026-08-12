## How Ctrl+h/j/k/l Navigation Works in Tmux + Nvim environment

### The Flow

```
┌─────────────────────────────────────────────────────────┐
│ YOU: Press Ctrl+h                                       │
└────────────────────┬────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────┐
│ TMUX: "Is vim running in current pane?"                │
│       ps -o comm= | grep vim                            │
└────────┬─────────────────────────┬──────────────────────┘
         │                         │
    YES  │                         │ NO
         │                         │
         ▼                         ▼
┌─────────────────────┐   ┌──────────────────────────────┐
│ TMUX:               │   │ TMUX:                        │
│ send-keys C-h       │   │ select-pane -L               │
│ (pass to nvim)      │   │ (switch panes immediately)   │
└────────┬────────────┘   └──────────────────────────────┘
         │                         │
         │                         └─────► DONE ✓
         │
         ▼
┌─────────────────────────────────────────────────────────┐
│ NVIM: Receives Ctrl+h                                   │
│       Keymap catches it: <C-h> → navigate('h')          │
└────────────────────┬────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────┐
│ NVIM: Try to move within splits                         │
│       vim.cmd('wincmd h')  -- same as <C-w>h            │
│                                                          │
│       Check: Did window number change?                  │
└────────┬─────────────────────────┬──────────────────────┘
         │                         │
    YES  │                         │ NO
         │                         │
         ▼                         ▼
┌─────────────────────┐   ┌──────────────────────────────┐
│ Moved to different  │   │ At edge, no split exists     │
│ split successfully  │   │ vim.fn.system(               │
│                     │   │   'tmux select-pane -L'      │
│ DONE ✓              │   │ )                             │
└─────────────────────┘   └──────────┬───────────────────┘
                                     │
                                     ▼
                          ┌──────────────────────────────┐
                          │ TMUX: Receives command       │
                          │       select-pane -L         │
                          │       (switch panes)         │
                          │                              │
                          │ DONE ✓                       │
                          └──────────────────────────────┘
```

### Key Insight

**TMUX is the gatekeeper, NVIM is the decision maker.**

- Tmux decides: "Who should handle this keystroke?"
- Nvim decides: "Can I navigate further, or should tmux take over?"

### Configuration Files

**~/.tmux.conf:**
```bash
# Detect if vim is running in current pane
is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\S+\/)?g?(view|n?vim?x?)(diff)?$'"

# If vim is running, send keys to it; otherwise, switch panes
bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
```

**~/.config/nvim/lua/config/keymaps.lua:**
```lua
-- Smart navigation: try vim splits first, fall back to tmux panes
local function navigate(direction)
  local win_before = vim.fn.winnr()
  vim.cmd('wincmd ' .. direction)  -- wincmd h = <C-w>h
  local win_after = vim.fn.winnr()
  
  -- If we didn't move, we're at the edge - tell tmux to switch panes
  if win_before == win_after then
    local tmux_direction = ({h = 'L', j = 'D', k = 'U', l = 'R'})[direction]
    vim.fn.system('tmux select-pane -' .. tmux_direction)
  end
end

vim.keymap.set('n', '<C-h>', function() navigate('h') end, { desc = 'Navigate left', silent = true })
vim.keymap.set('n', '<C-j>', function() navigate('j') end, { desc = 'Navigate down', silent = true })
vim.keymap.set('n', '<C-k>', function() navigate('k') end, { desc = 'Navigate up', silent = true })
vim.keymap.set('n', '<C-l>', function() navigate('l') end, { desc = 'Navigate right', silent = true })
```

### Usage

**Same keys, context-aware behavior:**

- **In shell:** `Ctrl+h/j/k/l` → Navigate between tmux panes
- **In nvim:** `Ctrl+h/j/k/l` → Navigate between nvim splits
- **At edge:** `Ctrl+h/j/k/l` → Navigate to adjacent tmux pane

**Zero plugins required!**
