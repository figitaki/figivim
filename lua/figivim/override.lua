local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
vim.api.nvim_set_hl(0, "WinBar", { fg = normal.fg, bg = "#181b20" })
vim.api.nvim_set_hl(0, "WinBarNC", { fg = normal.fg, bg = "#181b20" })
