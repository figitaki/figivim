local M = {
  'f3fora/nvim-texlabconfig',
  config = function()
    require('texlabconfig').setup {}
  end,
  build = "go build"
}

return M
