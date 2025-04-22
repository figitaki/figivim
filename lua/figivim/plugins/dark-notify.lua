local M = { 'cormacrelf/dark-notify' }

M.config = function()
  local dn = require('dark_notify')
  dn.run {
    dark = "onedark",
    light = "catppuccin-latte"
  }
end

return M
