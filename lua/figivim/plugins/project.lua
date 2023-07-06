local M = {
  'ahmedkhalf/project.nvim',
  version = '*',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = function()
    require('project_nvim').setup {}
    require('telescope').load_extension('projects')
  end
}

return M
