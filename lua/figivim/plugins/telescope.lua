local M = {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
}

local jj_files = function(opts)
  local pickers = require 'telescope.pickers'
  local utils = require 'telescope.utils'
  local make_entry = require "telescope.make_entry"

  if opts.is_bare then
    utils.notify("builtin.git_files", {
      msg = "This operation must be run in a work tree",
      level = "ERROR",
    })
    return
  end

  local show_untracked = vim.F.if_nil(opts.show_untracked, false)
  local recurse_submodules = vim.F.if_nil(opts.recurse_submodules, false)
  if show_untracked and recurse_submodules then
    utils.notify("jj_files", {
      msg = "jjdoes not support both --others and --recurse-submodules",
      level = "ERROR",
    })
    return
  end

  -- By creating the entry maker after the cwd options,
  -- we ensure the maker uses the cwd options when being created.
  opts.entry_maker = vim.F.if_nil(opts.entry_maker, make_entry.gen_from_file(opts))

  pickers
      .new(opts, {
        prompt_title = "jj Files",
        __locations_input = true,
        finder = finders.new_oneshot_job(
          utils.flatten {
            { "jj", "file", "list" },
          },
          opts
        ),
        previewer = conf.grep_previewer(opts),
        sorter = conf.file_sorter(opts),
      })
      :find()
end

M.config = function()
  local builtin = require('telescope.builtin')

  vim.keymap.set('n', '<C-p>', builtin.git_files, {})
  vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
  vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
end

return M
