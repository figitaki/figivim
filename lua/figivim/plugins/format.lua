local M = {
  "stevearc/conform.nvim",
}

local jsFromatters = { "prettierd", "prettier" }

M.config = function()
  require("conform").setup({
    formatters_by_ft = {
      -- Use a sub-list to run only the first available formatter
      javascript = jsFromatters,
      javascriptreact = jsFromatters,
      typescript = jsFromatters,
      typescriptreact = jsFromatters,
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
