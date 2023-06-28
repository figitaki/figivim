local M = {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/playground',
  },
}

M.config = function()
  require "nvim-treesitter.install".compilers = { 'gcc-12' }
  vim.cmd('TSUpdate')
end

M.opts = {
  ensure_installed = { "javascript", "typescript", "graphql", "vim", "lua" },

  auto_install = true,

  highlight = {
    enable = true,
  }
}

return M
