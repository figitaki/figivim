local M = {
  'ggandor/leap.nvim',
  version = '*'
}

M.config = function()
  require('leap').add_default_mappings()
end

return M
