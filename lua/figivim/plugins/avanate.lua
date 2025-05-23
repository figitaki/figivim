local function check_internet_connection()
  local handle = io.popen("ping -c 1 google.com | grep '1 packets'")
  if not handle then
    return false
  end
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
      windows = {
        position = "bottom"
      },
      provider = check_internet_connection() and "claude" or "ollama",
      cursor_applying_provider = 'fastapply',
      -- behaviour = {
      --   enable_cursor_planning_mode = true,
      -- },
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-7-sonnet-20250219",
        temperature = 0,
        max_tokens = 4096,
      },
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "o1-mini",
        timeout = 30000,
        temperature = 0,
        max_tokens = 4096,
      },
      vendors = {
        ---@type AvanteProvider
        fastapply = {
          __inherited_from = 'openai',
          api_key_name = '',
          endpoint = 'http://localhost:11434/v1',
          model = 'hf.co/Kortix/FastApply-7B-v1.0_GGUF:Q4_K_M',
        },
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
    "hrsh7th/nvim-cmp",            -- autocompletion for avante commands and mentions
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
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
