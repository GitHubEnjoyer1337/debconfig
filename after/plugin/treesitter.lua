-- Treesitter configuration
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "rust", "svelte", "bash" },  -- list of languages you want treesitter to support
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,               -- false will disable the whole extension
    additional_vim_regex_highlighting = false, -- disable vim regex highlighting
  },
}
