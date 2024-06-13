local M = {
  'rcarriga/nvim-dap-ui',
  dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }
}

M.config = function()
  local dap, dapui = require("dap"), require("dapui")

  -- adapters

  dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/local/opt/llvm/bin/lldb-dap',
    env = {
      LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
    },
    name = "lldb"
  }

  -- configurations

  dap.configurations.c = {
    {
      name = "Launch",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      args = {}
    }
  }
  dap.configurations.cpp = dap.configurations.c
  dap.configurations.rust = dap.configurations.c
  dap.configurations.zig = dap.configurations.c

  -- dapui config

  dapui.setup()

  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end

  -- keymaps

  vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
  vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
  vim.keymap.set('n', '<Leader>lp',
    function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
  vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
  vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
  vim.keymap.set('n', '<Leader>dc', function() require('dap').continue() end)
  vim.keymap.set('n', '<leader>dt', function() require("dapui").toggle() end)
end

return M
