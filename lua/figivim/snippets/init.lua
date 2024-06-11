local ls              = require("luasnip")
local s, i, t         = ls.s, ls.insert_node, ls.text_node
local fmt             = require('luasnip.extras.fmt').fmt
local c               = ls.choice_node
local f               = ls.function_node
local d               = ls.dynamic_node
local sn              = ls.sn

local get_test_result = function(position)
  return d(position, function()
    local nodes = {}
    table.insert(nodes, t ' ')
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    for _, line in ipairs(lines) do
      if line:match("anyhow::Result") then
        table.insert(nodes, t " -> Result<()> ")
        break
      end
    end
    return sn(nil, c(1, nodes))
  end, {})
end

ls.add_snippets("all", {
  s("ternary", i(1, "cond"), t " ? ", i(2, "then"), t " : ", i(3, "else")),
})

ls.add_snippets("lua", {
  s("lsreq", fmt([[local {} = require "{}"]],
    { f(function(import_name)
      local parts = vim.split(import_name[1][1], '.')
      return parts[#parts] or ""
    end, { 1 }), i(1) }))
})

ls.add_snippets("go", {
  s("struct", fmt([[type {} struct {}]], { i(1), i(2) })),
})

ls.add_snippets("rust", {
  -- Rust: adding a test case
  s(
    "test",
    fmt(
      [[
          #[test]
          fn {}(){}{{
            {}
          }}
        ]],
      {
        i(1, "testname"),
        get_test_result(2),
        i(0),
      }
    )
  ),

  s(
    "modtest",
    fmt(
      [[
          #[cfg(test)]
          mod test {{
          {}

            {}
          }}
        ]],
      {
        c(1, { t "  use super::*;", t "" }),
        i(0)
      }
    )
  ),
})
