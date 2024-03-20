local status_telescope_ok, telescope = pcall(require, "telescope")
if not status_telescope_ok then
  return
end

local status_builtin_ok, builtin = pcall(require, "telescope.builtin")
if not status_builtin_ok then
  return
end

-- Keymaps
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

telescope.setup()

