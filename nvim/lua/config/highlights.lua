-- Custom highlight overrides
-- Apply these AFTER the colorscheme loads

-- Kotlin/Java keywords (val, var, fun, class, etc.)

-- You can also customize other treesitter groups:
-- vim.api.nvim_set_hl(0, '@keyword.function', { fg = '#7aa2f7' })  -- Function keywords (fun, def)
-- vim.api.nvim_set_hl(0, '@keyword.modifier', { fg = '#9d7cd8' }) -- Modifiers (private, public)
-- vim.api.nvim_set_hl(0, '@variable', { fg = '#c0caf5' })          -- Variables
-- vim.api.nvim_set_hl(0, '@function', { fg = '#7aa2f7' })          -- Function names
-- vim.api.nvim_set_hl(0, '@type', { fg = '#0db9d7' })              -- Types/Classes
-- vim.api.nvim_set_hl(0, '@string', { fg = '#9ece6a' })            -- Strings
-- vim.api.nvim_set_hl(0, '@number', { fg = '#ff9e64' })            -- Numbers

-- To see all available treesitter groups: :help treesitter-highlight-groups
-- To inspect what group is under cursor: <leader>hi

-- Split separators - make them more visible
vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#565f89', bold = true })  -- Brighter, bold separator
vim.api.nvim_set_hl(0, 'VertSplit', { fg = '#565f89', bold = true })     -- Legacy name for compatibility

-- Inlay hints - make them ghost-like (subtle, low contrast)
-- Since termguicolors=false, use ctermfg (terminal colors) instead of guifg
vim.api.nvim_set_hl(0, 'LspInlayHint', { ctermfg = 240, italic = true })  -- Dark gray (240), italic
-- Alternative darkness levels to try:
-- vim.api.nvim_set_hl(0, 'LspInlayHint', { ctermfg = 238, italic = true })  -- Even dimmer (238)
-- vim.api.nvim_set_hl(0, 'LspInlayHint', { ctermfg = 236, italic = true })  -- Very dim (236)
-- vim.api.nvim_set_hl(0, 'LspInlayHint', { ctermfg = 234, italic = true })  -- Almost invisible (234)

-- LSP document highlight - highlight references to symbol under cursor
-- Barely visible background, works with any theme (termguicolors=false)
vim.api.nvim_set_hl(0, 'LspReferenceText', { ctermbg = 236 })   -- Read/text references
vim.api.nvim_set_hl(0, 'LspReferenceRead', { ctermbg = 236 })   -- Read access
vim.api.nvim_set_hl(0, 'LspReferenceWrite', { ctermbg = 236 })  -- Write access
