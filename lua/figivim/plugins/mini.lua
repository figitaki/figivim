local M = { 'echasnovski/mini.nvim', version = false }

M.config = function()
  require('mini.files').setup()
  local MiniFiles = require('mini.files')
  vim.keymap.set({ 'n', 'v' }, '<C-t>', function()
    MiniFiles.open()
  end)
end

return M
