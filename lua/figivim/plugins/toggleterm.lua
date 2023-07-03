local M = {
  'akinsho/toggleterm.nvim',
}

M.config = function()
  require('toggleterm').setup {
    open_mapping = [[<c-\>]],
    direction = 'horizontal',
    size = 20
  }

  function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    -- vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<leader>q', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
  end

  vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

  local Terminal = require('toggleterm.terminal').Terminal
  local lazygit  = Terminal:new({
    cmd = "lazygit",
    hidden = true,
    direction = "float"
  })

  function _lazygit_toggle()
    lazygit:toggle()
  end

  vim.api.nvim_set_keymap(
    "n", "<leader>g",
    "<cmd>lua _lazygit_toggle()<CR>",
    { noremap = true, silent = true }
  )

  vim.keymap.set('v', '<C-o>', function()
    require 'toggleterm'.send_lines_to_terminal("visual_selection", true, '1')
  end)
end

return M
