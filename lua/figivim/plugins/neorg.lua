local M = {
  'nvim-neorg/neorg',
  build = ':Neorg sync-parsers',
  dependencies = { 'nvim-lua/plenary.nvim', { "nvim-neorg/neorg-telescope" } },
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
      },                                  -- Adds pretty icons to your documents
      ["core.integrations.truezen"] = {}, -- Adds support for true-zen integration
      ["core.integrations.telescope"] = {},
      ["core.dirman"] = {                 -- Manages Neorg workspaces
        config = {
          workspaces = {
            notes = "~/notes",
            lassie = "~/src/lassie/notes"
          },
        },
      },
    },
  }

  local neorg_callbacks = require("neorg.callbacks")

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
