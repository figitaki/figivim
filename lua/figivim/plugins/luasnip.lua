local M = {
  "L3MON4D3/LuaSnip",
  -- follow latest release.
  -- install jsregexp (optional!).
  build = "make install_jsregexp",
}

M.config = function()
  local types = require("luasnip.util.types")
  require 'luasnip'.setup {
    history = true,
    enable_autosnippets = true,
    updateevents = "TextChanged,TextChangedI",
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { " Choice", "SpecialKey" } }
        }
      }
    }
  }
  require('luasnip').filetype_extend("javascriptreact", { "html" })
  require('luasnip').filetype_extend("typescriptreact", { "html" })
end

return M
