local M = {
  'github/copilot.vim',
  version = '*',
}

M.config = function()
  vim.keymap.set('i', '<C-s>', '<Plug>(copilot-suggest)', { noremap = false })
end

return M
