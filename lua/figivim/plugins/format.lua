local M = {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "isort", "black" },
      -- Use a sub-list to run only the first available formatter
      javascript = { { "npx prettier", "prettierd", "prettier" } },
    },
  },
}

M.config = function()
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
      require('conform').format({ bufnr = args.buf, lsp_fallback = true })
    end
  })
end

return M
