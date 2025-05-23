vim.g.mapleader = ','

vim.opt.laststatus = 3

vim.opt.hidden = true

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.expandtab = true    -- convert tabs to spaces
vim.opt.shiftwidth = 2      -- set number for autoindent
vim.opt.softtabstop = 2     -- number of spaces per tab

vim.opt.smartindent = false -- prefer treesitter indent

vim.opt.wrap = true

vim.opt.colorcolumn = "120"

vim.opt.termguicolors = true

vim.opt.list = false
vim.opt.listchars = {
  eol = '¬',
  tab = '»-',
  space = '·'
}

vim.opt.scrolloff = 20
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.foldenable = true
vim.opt.foldlevelstart = 10
vim.opt.foldnestmax = 10
vim.opt.foldmethod = 'indent'

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. '/.vim/undodir'
vim.opt.undofile = true

vim.cmd [[ filetype plugin indent on ]]

vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Always set .tex to be ft=tex
vim.cmd([[ autocmd BufRead,BufNewFile *.tex set filetype=tex ]])

vim.copilot_no_tab_map = false

vim.opt.updatetime = 300
vim.api.nvim_create_autocmd("CursorHold", { callback = function() vim.diagnostic.open_float(nil, { focus = false }) end })

vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "red" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "yellow" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = "blue" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = "green" })

-- WinBar config
-- vim.opt.winbar = "%{%v:lua.winbar()%}"

function _G.winbar()
  local buf_clients = vim.lsp.get_clients({ bufnr = 0 })

  -- Check if any LSP client is attached
  if next(buf_clients) ~= nil then
    -- LSP attached: use lspsaga context
    local ok, context = pcall(require, 'lspsaga.symbol.winbar')
    if ok then
      return context.get_bar()
    else
      -- set simple name for no name or quickfix or terminal
      local bufnr = vim.api.nvim_get_current_buf()
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      local filename = vim.fn.fnamemodify(bufname, ":t")
      local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
      local buftype = vim.api.nvim_get_option_value("buftype", { buf = bufnr })
      local is_quickfix = buftype == "quickfix"
      local is_terminal = buftype == "terminal"
      local is_no_name = filename == "" and filetype == "" and buftype == ""
      local is_floating = vim.api.nvim_get_option_value("winblend", { win = 0 }) > 0

      if is_quickfix then
        return "Quickfix"
      elseif is_terminal then
        local term_name = vim.api.nvim_get_option_value("term_name", { buf = bufnr })
        return " Terminal: " .. term_name
      elseif is_no_name then
        return "No Name"
      elseif is_floating then
        return "Floating Window"
      else
        -- Fallback to filename if lspsaga is not available
        return " 󰈔 %f"
      end
    end
  end

  -- No LSP attached or lspsaga unavailable: fallback to filename
  return " 󰈔 %f"
end

vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter", "WinEnter" }, {
  pattern = "term://*",
  callback = function()
    -- Check that we're not already in Terminal mode
    if vim.fn.mode() ~= 't' then
      vim.cmd("startinsert")
    end
  end,
})
