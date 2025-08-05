-- This file can be loaded by calling `lua require('plugins')` from your init.vim

return {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate'
  },
  'ellisonleao/gruvbox.nvim',
  {
    'jiaoshijie/undotree',
    dependencies = 'nvim-lua/plenary.nvim',
    config = true
  },
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim'
    },
    config = true
  },
  'stevearc/oil.nvim',
  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'Saghen/blink.cmp',
  'L3MON4D3/LuaSnip',
  'rafamadriz/friendly-snippets',
  'mfussenegger/nvim-dap',
  'jay-babu/mason-nvim-dap.nvim',
  'stevearc/conform.nvim',
  'mfussenegger/nvim-lint',
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  'folke/neodev.nvim',
}
