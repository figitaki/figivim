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
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-nvim-lsp' }, -- Required
    { 'hrsh7th/cmp-nvim-lua' },
    { 'L3MON4D3/LuaSnip' },     -- Required
    { 'rafamadriz/friendly-snippets' },

    { 'glepnir/lspsaga.nvim' },
    { 'f3fora/nvim-texlabconfig' },

    { 'github/copilot.vim' },

    { 'sigmaSd/deno-nvim' }
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

  require('lspconfig.configs').sourcekit = {
    default_config = {
      cmd = { 'sourcekit-lsp' },
      filetypes = { 'swift', 'c', 'cpp', 'objective-c', 'objective-cpp' },
      root_dir = require('lspconfig.util')
          .root_pattern('Package.swift', 'buildServer.json', 'compile_commands.json',
            '.git'),
    }
  }
  require('lspconfig').sourcekit.setup({})
  require('lspconfig').texlab.setup {
    settings = {
      texlab = {
        forwardSearch = {
          executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
          args = { "-g", "%l", "%p", "%f" },
        },
        auxDirectory = "build/default/",
        build = {
          executable = "tectonic",
          onSave = true,
          forwardSearchAfter = true,
          filename = "default.pdf",
          args = {
            "-X",
            "build",
            "--keep-logs",
            "--keep-intermediates"
          }
        }
      }
    }
  }

  lsp.setup()

  -- Completion configuration
  local cmp = require('cmp')
  local ls = require('luasnip')

  require("luasnip.loaders.from_vscode").lazy_load()
  require("figivim.snippets")

  require('cmp_nvim_lsp').setup()

  cmp.setup({
    preselect = cmp.PreselectMode.None,
    completion = {
      completeopt = 'menu,menuone,noselect,noinsert'
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'neorg' },
      { name = 'nvim_lua' },
      { name = 'luasnip' }
    }, {
      { name = 'buffer' },
    }),
    snippet = {
      expand = function(args)
        require 'luasnip'.lsp_expand(args.body)
      end
    },
    mapping = {
      ['<Tab>'] = cmp.config.disable,
      ['<S-Tab>'] = cmp.config.disable,
      ['<CR>'] = cmp.mapping.confirm(),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<C-j>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif ls.choice_active() then
          ls.change_choice(1)
        else
          local copilot_text = vim.fn['copilot#Accept']()
          if copilot_text ~= "" then
            vim.cmd([[call copilot#Next()]])
          else
            fallback()
          end
        end
      end, { 'i' }),
      ['<C-k>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif ls.choice_active() then
          ls.change_choice(-1)
        else
          fallback()
        end
      end, { 'i' }),
      ['<C-l>'] = cmp.mapping(function(fallback)
        if ls.jumpable() then
          ls.jump(1)
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<C-h>'] = cmp.mapping(function(fallback)
        if ls.jumpable(-1) then
          ls.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' })
    }
  })

  -- lspsaga config
  require('lspsaga').setup({})
  vim.keymap.set('n', 'gh', '<cmd>Lspsaga lsp_finder')
end

return M
