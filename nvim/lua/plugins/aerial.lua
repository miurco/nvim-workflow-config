require('aerial').setup({
  -- Priority order for backends
  backends = { "treesitter", "lsp", "markdown" },
  
  -- Layout options
  layout = {
    max_width = { 40, 0.2 },
    width = nil,
    min_width = 20,
    default_direction = "prefer_right",
  },
  
  -- Treesitter-specific options
  treesitter = {
    update_delay = 300, -- Update after 300ms of inactivity
  },
  
  -- Filter which symbol kinds to show
  filter_kind = {
    "Class",
    "Constructor",
    "Enum",
    "Function",
    "Interface",
    "Module",
    "Method",
    "Struct",
  },
  
  -- Show symbols in floating window on hover
  on_attach = function(bufnr)
    vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
    vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
  end,
})

-- Load Telescope extension
require('telescope').load_extension('aerial')

-- Keybindings
vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle<CR>', { desc = 'Toggle Aerial' })
vim.keymap.set('n', '<leader>fa', '<cmd>Telescope aerial<CR>', { desc = 'Find symbols (Aerial)' })
