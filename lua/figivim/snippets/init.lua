local ls      = require("luasnip")

-- some shorthands...
local s, i, t = ls.s, ls.insert_node, ls.text_node
local fmt     = require('luasnip.extras.fmt').fmt
local c       = ls.choice_node
local f       = ls.function_node

ls.add_snippets(nil, {
  lua = {
    s("lsreq", fmt([[local {} = require "{}"]],
      { f(function(import_name)
        local parts = vim.split(import_name[1][1], '.', true)
        return parts[#parts] or ""
      end, { 1 }), i(1) }))
  },
  rust = {
    s("custmodtest", fmt([[
      #[cfg(test)]
      mod test {{
      {}

        {}
      }}
    ]],
      {
        c(1, { t "  use super::*", t "" }),
        i(0)
      }))
  }
}, { key = "figisnips" })
