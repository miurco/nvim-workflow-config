
vim.pack.add({"https://github.com/folke/snacks.nvim"})
vim.pack.add({"https://github.com/gbprod/yanky.nvim"})
vim.pack.add({"https://github.com/m4xshen/autoclose.nvim"})
vim.pack.add({"https://github.com/nvim-treesitter/nvim-treesitter"})
vim.pack.add({"https://github.com/Saghen/blink.cmp"})

vim.pack.add({"https://github.com/nvim-telescope/telescope.nvim"})
vim.pack.add({"https://github.com/nvim-lua/plenary.nvim"})
vim.pack.add({"https://github.com/stevearc/aerial.nvim"})
vim.pack.add({"https://github.com/lewis6991/gitsigns.nvim"})
vim.pack.add({"https://github.com/kdheepak/lazygit.nvim"})
vim.pack.add({"https://github.com/akinsho/toggleterm.nvim"})
vim.pack.add({"https://github.com/mgierada/lazydocker.nvim"})
vim.pack.add({"https://github.com/alfaix/nvim-zoxide"})

vim.pack.add({"https://github.com/MeanderingProgrammer/render-markdown.nvim"})
vim.pack.add({"https://github.com/shortcuts/no-neck-pain.nvim"})

-- ai completion source plugin
vim.pack.add({"https://github.com/milanglacier/minuet-ai.nvim"})

-- ai code completion
vim.pack.add({"https://github.com/supermaven-inc/supermaven-nvim"})

require('config.options')
require('config.keymaps')
require('config.commands')
require('config.autocmds')
require('lsp')

-- Set colorscheme
vim.cmd.colorscheme('habamax')

-- Apply custom highlight overrides
require('config.highlights')


require('plugins.snacks')
require('plugins.blink')
require('plugins.autoclose')
require('plugins.telescope')
require('plugins.aerial')
require('plugins.yanky')
require('plugins.gitsigns')
require('plugins.lazygit')
require('plugins.lazydocker')
require('plugins.treesitter')
require('plugins.no_neck_pain')
require('plugins.supermaven')

-- Explore things
require('plugins.my_plugin')
