-- leap.nvim moved off GitHub (the github repo was wiped); it now lives on Codeberg.
local M = {
  url = 'https://codeberg.org/andyg/leap.nvim',
}

M.config = function()
  -- `add_default_mappings()` no longer exists; these are the recommended
  -- starter mappings from the current README.
  vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
  vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')
  vim.keymap.set({ 'n', 'x', 'o' }, 'gs', '<Plug>(leap-visit)')
end

return M
