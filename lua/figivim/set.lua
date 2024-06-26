vim.g.mapleader = ','

vim.opt.laststatus = 2

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
