local M = {
  'nvim-neorg/neorg',
  build = ':Neorg sync-parsers',
  dependencies = { 'nvim-lua/plenary.nvim' },
}

M.config = function()
  require('neorg').setup {
    load = {
      ["core.defaults"] = {}, -- Loads default behaviour
      ["core.keybinds"] = {
        config = {
          hook = function(keybinds)
            keybinds.map(
              "norg", "n", "<C-l>o",
              "<cmd>Neorg keybind all core.looking-glass.magnify-code-block"
            )
            keybinds.remap("norg", "n", "<Leader>n", "core.neorgcmd.commands.return")
          end,
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

  vim.keymap.set('n', '<leader>n', ':Neorg workspace notes<CR>')
end


return M
