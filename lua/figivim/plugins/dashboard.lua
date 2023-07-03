local M = {
  'goolord/alpha-nvim',
  version = '*',
  event = "VimEnter",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}

M.config = function()
  local dashboard = require("alpha.themes.dashboard")

  local buttons = {
    type = 'group',
    val = {
      { type = "text",    val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
      { type = "padding", val = 1 },
      dashboard.button("e", "  New file", "<cmd>ene<CR>"),
      dashboard.button("SPC f f", "󰈞  Find file"),
      dashboard.button("SPC f g", "󰊄  Live grep"),
      dashboard.button("c", "  Configuration", "<cmd>cd ~/.config/nvim/ <CR>"),
      dashboard.button("u", "  Update plugins", "<cmd>Lazy sync<CR>"),
      dashboard.button("q", "󰅚  Quit", "<cmd>qa<CR>"),
    },
    position = "center",
  }

  require('alpha').setup {
    opts = {
      margin = 5
    },
    layout = {
      { type = "padding", val = "2" },
      {
        type = "text",
        val = {
          [[                                       ]],
          [[⠘⢿⣶⣶⣤⣤⣀⣀⣀                     ⢀⣀⣀⣠⣤⣴⣶⣾⠟]],
          [[  ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟ ]],
          [[   ⠈⠛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛   ]],
          [[     ⠛⠛⠛⠛⠛⠛⣿⣿⣿⠿⠿⠿⠿⣿⣿⣿⠿⠿⠿⠿⠿⣿⣿⣿⠛⠛⠛⠛⠛⠃    ]],
          [[           ⢸⣿     ⣿⣿⣿     ⢸⣿           ]],
          [[     ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿    ]],
          [[      ⠉⠉⠉⠉⠉⢻⣿⡟⠉⠉⠉⠛⠛⠛⠛⠛⠛⠉⠉⠉⢻⣿⡟⠉⠉⠉⠉      ]],
          [[           ⢸⣿⡇            ⢸⣿⡇          ]],
          [[           ⢸⣿⡇            ⢸⣿⡇          ]],
          [[           ⢸⣿⡇            ⢸⣿⡇          ]],
          [[           ⢸⣿⡇            ⢸⣿⡇          ]],
          [[           ⣿⣿⣿            ⣿⣿⣿          ]],
          [[           ⣿⣿⣿            ⣿⣿⣿          ]],
          [[           ⣿⣿⣿            ⣿⣿⣿          ]],
        },
        opts = {
          position = "center",
          hl = "Type",
          -- wrap = "overflow";
        },
      },
      { type = "padding", val = 2 },
      buttons,
    }
  }
end

return M
