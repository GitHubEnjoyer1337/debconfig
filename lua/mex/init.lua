require("mex.remap")
require("mex.packer")

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
vim.cmd("colorscheme gruvbox")
