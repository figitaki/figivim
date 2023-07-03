local M = {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.2',
  dependencies = { 'nvim-lua/plenary.nvim' },
}

M.config = function()
  local builtin = require('telescope.builtin')

  vim.keymap.set('n', '<C-p>', builtin.find_files, {})
  vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
end

return M
