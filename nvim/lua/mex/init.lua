local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
require("lazy").setup("mex.plugins")
require("mex.remap")
require("mex.dap")
require("gruvbox").setup({})

-- Enable line numbers and relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Set scrolloff
vim.opt.scrolloff = 10

-- Use spaces instead of tabs
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- Enable smart indentation
vim.opt.smartindent = true

-- Enable autoindentation
vim.opt.autoindent = true

-- highlighted search
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.updatetime = 50

-- colorscheme
vim.opt.background = "dark"
vim.cmd.colorscheme("gruvbox")
