local M = {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      -- Use a sub-list to run only the first available formatter
      -- javascript = { "prettier" },
    },
  },
}

M.config = function()
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
      require('conform').format({ bufnr = args.buf, lsp_fallback = false })
    end
  })
end

return M
