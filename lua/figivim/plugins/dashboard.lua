local M = {
  'goolord/alpha-nvim',
  version = '*',
  event = "VimEnter",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    layout = { {
      type = "text",
      val = {
        [[                                  __]],
        [[     ___     ___    ___   __  __ /\_\    ___ ___]],
        [[    / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\]],
        [[   /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \]],
        [[   \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        [[    \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
      },
      opts = {
        position = "center",
        hl = "Type",
        -- wrap = "overflow";
      },
    }
    }
  }
}

return M
