local M = {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/playground',
  },
}

M.config = function()
  require "nvim-treesitter.install".compilers = { 'gcc-12' }
  require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "javascript", "tsx", "typescript", "graphql", "vim", "lua" },

    auto_install = true,

    highlight = {
      enable = true,
    }
  }

  vim.cmd('TSUpdate')
end

return M
