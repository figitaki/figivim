local M = {
  'navarasu/onedark.nvim',
}

M.config = function()
  require 'onedark'.setup {
    style = "darker"
  }
  vim.cmd([[ colorscheme onedark ]])
end

return M
