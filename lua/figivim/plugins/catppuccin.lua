local M = {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
}

M.config = function()
  require 'catppuccin'.setup {
    transparent_background = true,
    flavor = "latte",
    integrations = {
      cmp = true,
      gitsigns = true,
      illuminate = true,
      leap = true,
      mason = true,
      noice = true,
      notify = true,
      treesitter = true,
      telescope = true,
      lsp_saga = true,
      mini = {
        enabled = true,
        indentscope_color = "",
      },
    }
  }

  vim.cmd([[ colorscheme catppuccin ]])
end

return M
