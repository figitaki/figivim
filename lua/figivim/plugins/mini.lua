local M = { 'echasnovski/mini.nvim', version = false }

M.config = function()
  require('mini.files').setup()
  local MiniFiles = require('mini.files')
  vim.keymap.set({ 'n', 'v' }, '<C-t>', function()
    MiniFiles.open()
  end)
  vim.keymap.set({ 'n', 'v' }, '<leader>ft', function()
    local _ = MiniFiles.close()
        or MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
    vim.defer_fn(function()
      MiniFiles.reveal_cwd()
    end, 30)
  end)
end

return M
