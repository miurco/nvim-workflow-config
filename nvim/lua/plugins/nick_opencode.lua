-- Required for `opts.events.reload`.
vim.o.autoread = true

-- Configure opencode via vim.g.opencode_opts
vim.g.opencode_opts = {
  port = 13337,
  terminal = {
    cmd = "opencode --port 13337",
  },
}

-- Load opencode to ensure it's available
local ok, opencode = pcall(require, 'opencode')
if not ok then
  vim.notify('opencode.nvim failed to load', vim.log.levels.ERROR)
  return
end

-- Keymaps for opencode interaction
vim.keymap.set('n', '<C-a>', function() opencode.toggle() end, { desc = 'Toggle opencode' })
vim.keymap.set({'n', 'x'}, '<leader>os', function() opencode.select() end, { desc = 'Select opencode prompt' })
vim.keymap.set({'n', 'x'}, '<leader>oa', function() opencode.ask() end, { desc = 'Ask opencode' })
vim.keymap.set('n', '<S-C-u>', function() opencode.command('session.half.page.up') end, { desc = 'Scroll opencode up' })
vim.keymap.set('n', '<S-C-d>', function() opencode.command('session.half.page.down') end, { desc = 'Scroll opencode down' })
