local M = {
  'navarasu/onedark.nvim',
}

M.config = function()
  require 'onedark'.setup {
    style = "darker",
    highlight = {
      ['WinBar'] = { bg = "NvimLightGrey1" }
    }

  }
  vim.cmd([[ colorscheme onedark ]])
end

return M
