-- lsp config


vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('user_lsp_attach', {clear = true}),
  callback = function(event)
    local opts = {buffer = event.buf}

  -- Go to definition: Navigates to the definition of the symbol under the cursor
  vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)

  -- Hover: Displays hover information about the symbol under the cursor
  vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)

  -- Workspace symbol: Searches for a symbol in the workspace and displays the results
  vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)

  -- Diagnostic float: Opens a floating window with diagnostic information at the current cursor position
  vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)

  -- Next diagnostic: Jumps to the next diagnostic in the buffer
  vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)

  -- Previous diagnostic: Jumps to the previous diagnostic in the buffer
  vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)

  -- Code action: Displays a list of code actions available at the current cursor position
  vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)

  -- References: Lists all references to the symbol under the cursor
  vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)

  -- Rename: Renames all references to the symbol under the cursor
  vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)

  -- Signature help: Displays signature information about the function or method at the current cursor position
  vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
  end,
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'vtsls', 'rust_analyzer', 'pyright', 'html', 'lua_ls' },
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({
        capabilities = lsp_capabilities,
      })
    end,
    lua_ls = function()
      require('lspconfig').lua_ls.setup({
        capabilities = lsp_capabilities,
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT'
            },
            diagnostics = {
              globals = {'vim'},
            },
            workspace = {
              library = {
                vim.env.VIMRUNTIME,
              }
            }
          }
        }
      })
    end,
  }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

-- this is the function that loads the extra snippets to luasnip
-- from rafamadriz/friendly-snippets
require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  window = {
    documentation = cmp.config.disable,
  },
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'luasnip', keyword_length = 2},
    {name = 'buffer', keyword_length = 3},
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})
