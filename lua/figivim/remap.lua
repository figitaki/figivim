-- easier split navigation
vim.keymap.set('n', '<c-j>', '<c-w><c-j>')
vim.keymap.set('n', '<c-k>', '<c-w><c-k>')
vim.keymap.set('n', '<c-l>', '<c-w><c-l>')
vim.keymap.set('n', '<c-h>', '<c-w><c-h>')

-- move vertically by visual line when on a wrapped line
vim.keymap.set('', 'j', 'gj')
vim.keymap.set('', 'k', 'gk')

-- better maps for start and end of line
vim.keymap.set('n', 'B', '^')
vim.keymap.set('n', 'E', '$')

-- vv to generate a vertical split
vim.keymap.set('n', 'vv', '<C-w>v', { silent = true })

-- buffer navigation
vim.keymap.set('n', '<leader>]', '<cmd>bn<cr>')
vim.keymap.set('n', '<leader>[', '<cmd>bp<cr>')
vim.keymap.set('n', '<leader>x', '<cmd>bd<cr>')

-- toggle search highlight
vim.keymap.set('n', '<leader><space>', '<cmd>nohlsearch<cr>')

-- folds
vim.keymap.set('n', '<space>', 'za')

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
