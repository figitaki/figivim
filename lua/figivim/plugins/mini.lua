local M = { 'echasnovski/mini.nvim', version = false }

M.config = function()
  require('mini.files').setup()
  vim.keymap.set({ 'n', 'v' }, '<C-t>', function()
    MiniFiles.open()
  end)
end

return M
