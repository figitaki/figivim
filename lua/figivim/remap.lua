-- easier split navigation
vim.keymap.set('n', '<c-j>', '<c-w><c-j>')
vim.keymap.set('n', '<c-k>', '<c-w><c-k>')
vim.keymap.set('n', '<c-l>', '<c-w><c-l>')
vim.keymap.set('n', '<c-h>', '<c-w><c-h>')

-- better C-d/u navigation, center cursor
vim.keymap.set('', '<C-d>', '<C-d>zz')
vim.keymap.set('', '<C-u>', '<C-u>zz')

-- move vertically by visual line when on a wrapped line
vim.keymap.set('', 'j', 'gj')
vim.keymap.set('', 'k', 'gk')

-- vv to generate a vertical split
vim.keymap.set('n', 'vv', '<C-w>v', { silent = true })

-- buffer navigation
vim.keymap.set('n', '<leader>]', '<cmd>bn<cr>')
vim.keymap.set('n', '<leader>[', '<cmd>bp<cr>')
vim.keymap.set('n', '<leader>x', '<cmd>bn<bar>bd#<cr>')

-- toggle search highlight
vim.keymap.set('n', '<leader><space>', '<cmd>nohlsearch<cr>')
vim.keymap.set('n', '<esc>u', '<cmd>nohlsearch<cr>')

-- folds
vim.keymap.set('n', '<space>', 'za')

vim.keymap.set('n', '<leader>rs', '<cmd>so ~/.config/nvim/lua/figivim/snippets/init.lua<cr>')

function _G.send_visual_to_terminal()
  -- Save the current visual selection to a register
  local _, ls, cs = unpack(vim.fn.getpos("'<"))
  local _, le, ce = unpack(vim.fn.getpos("'>"))

  local lines = vim.fn.getline(ls, le)
  if #lines == 0 then return end

  lines[#lines] = string.sub(lines[#lines], 1, ce)
  lines[1] = string.sub(lines[1], cs)

  -- Get the current window ID and move to the terminal (right)
  local cur_win = vim.api.nvim_get_current_win()
  vim.cmd("wincmd l") -- move right (assumes terminal is there)

  local term_win = vim.api.nvim_get_current_win()
  local term_buf = vim.api.nvim_get_current_buf()

  -- Ensure we're in terminal mode
  vim.cmd("startinsert")

  -- Send the lines
  for _, line in ipairs(lines) do
    vim.api.nvim_chan_send(vim.b.terminal_job_id, line .. "\n")
  end

  -- Return to original window
  vim.api.nvim_set_current_win(cur_win)
end

-- Map it to a key in visual mode
vim.keymap.set("v", "<leader>ts", ":<C-u>lua send_visual_to_terminal()<CR>", { noremap = true, silent = true })
