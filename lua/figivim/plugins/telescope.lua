local M = {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
}

M.config = function()
  local builtin = require('telescope.builtin')

  vim.keymap.set('n', '<C-p>', builtin.git_files, {})
  vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
  vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
end

return M
