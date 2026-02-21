local telescope = require('telescope')

telescope.setup({
	defaults = {
		path_display = { "smart" }, -- or "smart", "shorten", "tail", "truncate"
		layout_config = {
			horizontal = {
				preview_width = 0.6,
			},
		},
	mappings = {
		i = {
			["<esc>"] = require('telescope.actions').close,
			["<C-q>"] = require('telescope.actions').smart_send_to_qflist + require('telescope.actions').open_qflist,
		},
		n = {
			["<C-q>"] = require('telescope.actions').smart_send_to_qflist + require('telescope.actions').open_qflist,
		},
	},
	},
})

-- Dynamic grep with rg options
local function live_grep_with_args()
	local builtin = require('telescope.builtin')
	vim.ui.input({ prompt = 'Rg args: ' }, function(input)
		if input then
			print('Input received:', input)
			local args = vim.fn.split(input)
			print('Split args:', vim.inspect(args))
			local cleaned_args = {}
			for _, arg in ipairs(args) do
				local cleaned = arg:gsub("^['\"]", ""):gsub("['\"]$", "")
				table.insert(cleaned_args, cleaned)
			end
			print('Cleaned args:', vim.inspect(cleaned_args))
			builtin.live_grep({ additional_args = cleaned_args })
		end
	end)
end

-- Quick shortcuts
local function grep_hidden()
	require('telescope.builtin').live_grep({ additional_args = { '--hidden', '--no-ignore' } })
end

local function find_hidden()
	require('telescope.builtin').find_files({ hidden = true, no_ignore = true })
end

-- Load extensions
telescope.load_extension("yank_history")
telescope.load_extension("zoxide")

-- Keymaps
vim.keymap.set('n', '<leader>tt', '<cmd>Telescope<cr>', { desc = 'Telescope context' })
-- Lsp
vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', { desc = 'Go to definition' })
vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', { desc = 'Go to references' })
-- File search
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>f.', find_hidden, { desc = 'Find files (hidden)' })
vim.keymap.set('n', '<leader>b', '<cmd>Telescope buffers<cr>', { desc = 'Telescope buffers' })
-- Grepping
vim.keymap.set('n', 'lg', '<cmd>Telescope live_grep<cr>', { desc = 'Live grep' })
vim.keymap.set('n', 'g.', grep_hidden, { desc = 'Live grep (hidden)' })
vim.keymap.set('n', 'ga', live_grep_with_args, { desc = 'Live grep (custom args)' })
-- Zoxide
vim.keymap.set('n', '<leader>z', '<cmd>Telescope zoxide zoxide<cr>', { desc = 'Zoxide list' })
