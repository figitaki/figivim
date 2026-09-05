-- nvim-treesitter `main` branch: the old `nvim-treesitter.configs` module system
-- is gone. Highlighting/folding are provided by neovim itself, indentation by
-- this plugin, and everything is enabled per-buffer via a FileType autocmd.
-- Parsers are compiled with the `tree-sitter` CLI (brew install tree-sitter-cli).
local M = {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
  },
}

local ensure_installed = { "javascript", "tsx", "typescript", "graphql", "vim", "lua" }

M.config = function()
  local ts = require('nvim-treesitter')
  ts.setup({})
  ts.install(ensure_installed)

  local function enable(buf, lang)
    if not vim.api.nvim_buf_is_valid(buf) then return end
    if not pcall(vim.treesitter.start, buf, lang) then return end
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end

  -- highlight + indent for every buffer that has a parser; auto-install
  -- missing parsers (replaces the old `auto_install = true`)
  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('figivim_treesitter', { clear = true }),
    callback = function(args)
      local lang = vim.treesitter.language.get_lang(args.match)
      if not lang then return end

      if vim.tbl_contains(ts.get_installed('parsers'), lang) then
        enable(args.buf, lang)
      elseif vim.tbl_contains(ts.get_available(), lang) then
        ts.install({ lang }):await(function()
          enable(args.buf, lang)
        end)
      end
    end,
  })

  -- textobjects (`main` branch: keymaps are defined by hand)
  require('nvim-treesitter-textobjects').setup({
    select = {
      lookahead = true,
    },
  })

  local function select(query)
    return function()
      require('nvim-treesitter-textobjects.select').select_textobject(query, 'textobjects')
    end
  end

  vim.keymap.set({ 'x', 'o' }, 'af', select('@function.outer'), { desc = 'a function' })
  vim.keymap.set({ 'x', 'o' }, 'if', select('@function.inner'), { desc = 'inner function' })
  vim.keymap.set({ 'x', 'o' }, 'ac', select('@class.outer'), { desc = 'a class' })
  vim.keymap.set({ 'x', 'o' }, 'ic', select('@class.inner'), { desc = 'inner class' })
end

return M
