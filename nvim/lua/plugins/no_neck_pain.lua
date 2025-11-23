require("no-neck-pain").setup({
	width = 120,
	autocmds = {
		enableOnVimEnter = false,
	},
	buffers = {
		scratchPad = {
			enabled = false,
		},
		bo = {
			filetype = "no-neck-pain",
		},
	},
})

-- Keymap to toggle
vim.keymap.set('n', '<leader>np', '<Cmd>NoNeckPain<CR>', { desc = 'Toggle No Neck Pain', silent = true })
