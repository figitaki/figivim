local M = {
  "stevearc/conform.nvim",
}

M.config = function()
  require("conform").setup({
    formatters_by_ft = {
      -- Use a sub-list to run only the first available formatter
      javascript = { { "prettierd", "prettier" } },
      javascriptreact = { { "prettierd", "prettier" } },
      typescript = { { "prettierd", "prettier" } },
      typescriptreact = { { "prettierd", "prettier" } },
    },
  })

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
      require("conform").format({ bufnr = args.buf, lsp_format = "fallback" })
    end,
  })
end

return M
