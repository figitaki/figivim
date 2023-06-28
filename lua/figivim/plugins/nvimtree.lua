local M = {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  }
}

M.config = function()
  require 'nvim-tree'.setup()

  vim.keymap.set({ 'n', 'v', 'i' }, '<C-t>', ':NvimTreeToggle<CR>')
end

return M
