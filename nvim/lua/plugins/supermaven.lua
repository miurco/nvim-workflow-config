require("supermaven-nvim").setup({
    keymaps = {
        accept_suggestion = "<Tab>",
        accept_word = "<C-w>",
    },
    completion = {
        trigger = {
            length = 3,
        },
    },
    indent = {
        priority = 2000,
    },
})
