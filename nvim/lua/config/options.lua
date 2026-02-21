-- ═══════════════════════════════════════════════════════════
-- LEADER KEY
-- ═══════════════════════════════════════════════════════════
-- Set leader to <Space> - must be done before any keymaps are defined
-- Changed from backslash to avoid conflict with tmux prefix key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- add to cwd ** so that it could find recursively without specifying the relative path 
vim.opt.path:append({"**", "/usr/include", "/Users/mihai.iurcomgmail.com/github/nvim-workflow-config/**"})

-- sharing same clipboard
-- vim.opt.clipboard="unnamedplus"

-- Sync clipboard between OS and Neovim. Schedule the setting after `UiEnter` because it can
-- increase startup-time. Remove this option if you want your OS clipboard to remain independent.
-- See `:help 'clipboard'`
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    vim.o.clipboard = 'unnamedplus'
  end,
})

-- grep options
vim.opt.grepprg = "rg --vimgrep --smart-case"
vim.opt.grepformat = "%f:%l:%c:%m"
	-- %f - filename where the match was found
	-- %l - line number of the match
	-- %c - column number of the match
	-- %m - text of the matched line


-- fold options
vim.opt.foldmethod='indent'
	-- za : Toggle the fold under the cursor (open if closed, close if open).
	-- zR : Open all folds in the file.
	-- zM : Close all folds in the file.
	-- zc : Close the fold under the cursor.
	-- zo : Open the fold under the cursor.


vim.opt.foldlevel=99

vim.opt.termguicolors = true
vim.opt.hlsearch = false -- Disable search highlighting

-- Global UI preferences
vim.g.border_style = 'rounded' -- Options: 'rounded', 'single', 'double', 'shadow', 'none'

-- Faster CursorHold events (default is 4000ms)
-- Used for LSP document highlights and other CursorHold triggers, and not only. It's a global config/option
vim.opt.updatetime = 300 -- 300ms

-- Split separators for better visibility
vim.opt.fillchars = {
	vert = '│',     -- vertical split separator
	horiz = '─',    -- horizontal split separator
	vertright = '├',
	vertleft = '┤',
	verthoriz = '┼',
	horizup = '┴',
	horizdown = '┬',
}

vim.o.smartindent = true
vim.o.autoindent = true
vim.o.wrap = true
vim.o.cursorline = true
vim.o.signcolumn= "yes"


vim.opt.ignorecase = true
vim.opt.smartcase = true
