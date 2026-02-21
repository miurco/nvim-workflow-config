require("yanky").setup({
    highlight = {
        timer = 150,
    },
})

-- Make yank highlight match Visual selection
vim.api.nvim_set_hl(0, "YankyPut", { link = "Visual" })
vim.api.nvim_set_hl(0, "YankyYanked", { link = "Visual" })


vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({"n","x"}, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({"n","x"}, "gP", "<Plug>(YankyGPutBefore)")

vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)")

-- Telescope picker for yank history
vim.keymap.set("n", "<leader>p", "<cmd>Telescope yank_history<cr>", { desc = "Yank history" })
