local M = {
  'rmagatti/auto-session',
  version = '*',
  dependencies = {
    { 'rmagatti/session-lens' }
  },
  config = function()
    require("auto-session").setup {
      log_level = "error",
      auto_save_enabled = true,
      auto_session_enable_last_session = true,
      auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    }

    require('session-lens').setup {}

    vim.keymap.set('n', '<leader>fs', require('session-lens').search_session)
  end
}

return M
