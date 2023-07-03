local M = {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/playground',
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
}

M.config = function()
  require "nvim-treesitter.install".compilers = { 'gcc-12' }
  require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "javascript", "tsx", "typescript", "graphql", "vim", "lua" },

    auto_install = true,

    highlight = {
      enable = true,
    },

    textobjects = {
      select = {
        enable = true,

        lookahead = true,

        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner"
      }
    }
  }

  vim.cmd('TSUpdate')
end

return M
