require('neogit').setup({})
vim.keymap.set("n", "<leader>gs", function() require('neogit').open() end)
