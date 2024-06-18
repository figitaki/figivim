local function open()
  vim.open('todo.norg')
end

vim.keymap.set('n', '<leader>nt', function() open() end)
