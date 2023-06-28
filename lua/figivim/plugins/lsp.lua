local M = {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  priority = 100,
  dependencies = {
    -- LSP Support
    { 'neovim/nvim-lspconfig' }, -- Required
    {                            -- Optional
      'williamboman/mason.nvim',
      build = function()
        pcall(vim.cmd, 'MasonUpdate')
      end,
    },
    { 'williamboman/mason-lspconfig.nvim' }, -- Optional

    -- Autocompletion
    { 'hrsh7th/nvim-cmp' },     -- Required
    { 'hrsh7th/cmp-nvim-lsp' }, -- Required
    { 'L3MON4D3/LuaSnip' },     -- Required
  },
}

M.config = function()
  local lsp = require('lsp-zero').preset({
    name = 'recommended',
  })

  lsp.ensure_installed({
    'denols',
    'tsserver',
    'eslint',
    'rust_analyzer'
  })

  lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({
      buffer = bufnr,
      preserve_mappings = false,
    })

    -- HACK: prevent tsserver from competing with denols
    if require "lspconfig".util.root_pattern("deno.json", "deno.jsonc")(vim.fn.getcwd()) then
      if client.name == "tsserver" then
        client.stop()
        return
      end
    end

    lsp.buffer_autoformat()
  end)

  require 'lspconfig'.denols.setup {}
  require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

  lsp.setup()

  local cmp = require('cmp')
  local cmp_action = require('lsp-zero').cmp_action()

  cmp.setup({
    preselect = 'item',
    completion = {
      completeopt = 'menu,menuone,noinsert'
    },
    mapping = cmp.mapping.preset.insert({
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<C-f>'] = cmp_action.luasnip_jump_forward(),
      ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    })
  })
end

return M
