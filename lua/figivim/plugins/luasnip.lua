local M = {
  "L3MON4D3/LuaSnip",
  -- follow latest release.
  version = "<CurrentMajor>.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  -- install jsregexp (optional!).
  build = "make install_jsregexp",
  opts = {
    history = true,
    enable_autosnippets = true,
    updateevents = "TextChanged,TextChangedI",
    ext_opts = {
      ["types.choiceNode"] = {
        active = {
          virt_text = { { "", "Choice" } }
        }
      }
    }
  },
}

return M
