local M = {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
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
    { 'hrsh7th/cmp-nvim-lua' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'L3MON4D3/LuaSnip' }, -- Required
    { 'rafamadriz/friendly-snippets' },

    { 'glepnir/lspsaga.nvim' },
    { 'f3fora/nvim-texlabconfig' },

    { 'github/copilot.vim' },

    { 'windwp/nvim-autopairs' },
  },
}

M.config = function()
  local lsp = require('lsp-zero').preset({
    name = 'recommended',
  })

  -- TODO: move these to the mason config
  -- lsp.ensure_installed({
  --   'eslint',
  --   'prettierd',
  --   'lua_ls',
  --   'tailwindcss',
  --   'ts_ls',
  --   'rust_analyzer'
  -- })

  lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({
      buffer = bufnr,
      preserve_mappings = false,
    })

    -- Diagnostic configuration
    vim.diagnostic.config({
      underline = true,
      virtual_text = false,
      signs = false,
      update_in_insert = false,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "if_many",
        header = "",
        prefix = "",
      }
    })

    -- HACK: prevent ts_ls from competing with denols
    if vim.fs.root(vim.fn.getcwd(), { "deno.json", "deno.jsonc" }) then
      if client.name == "ts_ls" or client.name == "tsserver" then
        client:stop()
        return
      end
    else
      if client.name == "denols" then
        client:stop()
        return
      end
    end
  end)

  require('mason').setup({})
  -- mason-lspconfig v2 automatically runs vim.lsp.enable() for every installed
  -- server (the old `handlers` option is gone). Per-server tweaks go through
  -- vim.lsp.config() instead of require('lspconfig').<server>.setup().
  require('mason-lspconfig').setup({})

  vim.lsp.config('*', {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
  })

  vim.lsp.config('lua_ls', lsp.nvim_lua_ls())

  vim.lsp.config('sourcekit', {
    filetypes = { 'swift', 'c', 'cpp', 'objective-c', 'objective-cpp' },
    root_markers = { 'Package.swift', 'buildServer.json', 'compile_commands.json', '.git' },
  })

  vim.lsp.config('texlab', {
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
  })

  -- not managed by mason, so enable explicitly
  vim.lsp.enable({ 'sourcekit', 'texlab' })

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
      completeopt = 'menu,menuone,noinsert'
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
        ls.lsp_expand(args.body)
      end
    },
    mapping = {
      ['<Tab>'] = cmp.config.disable,
      ['<S-Tab>'] = cmp.config.disable,
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
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

  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
  )

  -- lspsaga config
  require('lspsaga').setup({
    lightbulb = {
      enable = false,
    }
  })
  vim.keymap.set('n', 'gh', '<cmd>Lspsaga lsp_finder<cr>')
  vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<cr>')
  vim.keymap.set('n', '<leader>cd', '<cmd>Lspsaga show_workspace_diagnostics<cr>')
end

return M
