local M = {
  'dccsillag/magma-nvim',
  build = ':UpdateRemotePlugins',
}

M.config = function()
  vim.keymap.set('n', '<leader>jr', '<cmd>MagmaEvaluateOperator<cr>', { silent = true })
  vim.keymap.set('v', '<leader>jr', '<cmd><C-u>MagmaEvaluateVisual<cr>', { silent = true })
end

return M
