local M = {
  "nvim-neorg/neorg",
  dependencies = { "luarocks.nvim" },
  lazy = false,  -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  version = "*", -- Pin Neorg to the latest stable release
}

local remap = function(keybinds)
  keybinds.map(
    "norg", "n", "<C-l>o",
    "<cmd>Neorg keybind all core.looking-glass.magnify-code-block<cr>"
  )
  keybinds.map(
    "norg", "n", "<C-m>h",
    "<cmd>Neorg mode traverse-heading<cr>"
  )
  keybinds.map(
    "norg", "n", "<C-m>n",
    "<cmd>Neorg mode norg<cr>"
  )
  keybinds.remap("norg", "n", "<Leader>n", "core.neorgcmd.commands.return")
end

M.config = function()
  require('neorg').setup {
    load = {
      ["core.defaults"] = {}, -- Loads default behaviour
      ["core.keybinds"] = {
        config = {
          hook = remap,
        },
      },
      ["core.completion"] = { config = { engine = "nvim-cmp" } },
      ["core.concealer"] = {
        config = {
          icons = {
            todo = {
              pending = {
                icon = "-"
              }
            }
          }
        }
      }, -- Adds pretty icons to your documents
      ["core.esupports.indent"] = {},
      ["core.esupports.metagen"] = {},
      ["core.presenter"] = {
        config = {
          zen_mode = "truezen",
        },
      },
      -- ["core.integrations.telescope"] = {},
      ["core.export"] = {},
      ["core.export.markdown"] = {},
      ["core.dirman"] = { -- Manages Neorg workspaces
        config = {
          workspaces = {
            notes = "~/notes",
          },
        },
      },
    },
  }

  local neorg_callbacks = require("neorg.core.callbacks")

  neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
    -- Map all the below keybinds only when the "norg" mode is active
    keybinds.map_event_to_mode("norg", {
      n = { -- Bind keys in normal mode
        { "<C-p>", "core.integrations.telescope.find_linkable" },
      },

      i = { -- Bind in insert mode
        { "<C-l>", "core.integrations.telescope.insert_link" },
      },
    }, {
      silent = true,
      noremap = true,
    })
  end)

  vim.keymap.set('n', '<leader>n', ':Neorg workspace notes<CR>')
end

return M
