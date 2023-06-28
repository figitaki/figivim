local M = {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  }
}

M.config = function()
  require 'nvim-tree'.setup {
    filters = { custom = { "^.git$" } }
  }

  vim.keymap.set({ 'n', 'v', 'i' }, '<C-t>', ':NvimTreeToggle<CR>')

  local api = require('nvim-tree.api')
  api.events.subscribe(api.events.Event.FileCreated, function(file)
    vim.cmd("edit " .. file.fname)
  end)
end

return M
