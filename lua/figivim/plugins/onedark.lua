local M = {
  'navarasu/onedark.nvim',
}

M.config = function()
  require 'onedark'.setup {
    style = "deep"
  }
  vim.cmd([[ colorscheme onedark ]])
end

return M
