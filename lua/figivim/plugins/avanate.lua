local function check_internet_connection()
  local handle = io.popen("ping -c 1 google.com | grep '1 packets'")
  local result = handle:read("*a")
  handle:close()
  local good = "1 packets transmitted, 1 packets received"
  return result:sub(1, #good) == good
end

local M = {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- set this if you want to always pull the latest change
  config = function()
    require("avante").setup({
      provider = check_internet_connection() and "copilot" or "ollama",
      vendors = {
        ---@type AvanteProvider
        ollama = {
          __inherited_from = "openai",
          api_key_name = "",
          endpoint = "127.0.0.1:11434/v1",
          model = "qwen2.5-coder",
        },
      }
    })
  end,
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}

return M
