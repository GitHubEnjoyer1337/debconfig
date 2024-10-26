-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

-- Automatically install and setup packer if it's not already installed
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    vim.cmd 'packadd packer.nvim'
end

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    -- Add Telescope.nvim for fuzzy finding
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Treesitter for better syntax highlighting
    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

    use { 'morhetz/gruvbox' }
    use { 'mbbill/undotree' }
    use { 'tpope/vim-fugitive' }
    use { 'stevearc/oil.nvim' }

    -- LSP and autocompletion related plugins
    use {
        'neovim/nvim-lspconfig',          -- Collection of configurations for built-in LSP client
        'williamboman/mason.nvim',        -- Portable package manager for Neovim
        'williamboman/mason-lspconfig.nvim', -- Extension to bridge mason.nvim with nvim-lspconfig
        'hrsh7th/nvim-cmp',               -- Completion plugin
        'hrsh7th/cmp-nvim-lsp',           -- LSP source for nvim-cmp
        'hrsh7th/cmp-path',               -- Path completion source for nvim-cmp
        'hrsh7th/cmp-buffer',             -- Buffer completion source for nvim-cmp
        'L3MON4D3/LuaSnip',               -- Snippets plugin
        'saadparwaiz1/cmp_luasnip',       -- Snippets source for nvim-cmp
        'rafamadriz/friendly-snippets'    -- Snippets collection
    }
end)


-- this is a test in packer
-- test from github
-- one last test bruh
