vim.g.mapleader = " "

-- open go to ex
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- Move selected line/block of text down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- Move selected line/block of text up in visual mode
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Join lines and maintain cursor position in normal mode
vim.keymap.set("n", "J", "mzJ`z")

-- Scroll half a screen down and center the cursor in normal mode
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Scroll half a screen up and center the cursor in normal mode
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Move to the next search match and center the cursor in normal mode
vim.keymap.set("n", "n", "nzzzv")

-- Move to the previous search match and center the cursor in normal mode
vim.keymap.set("n", "N", "Nzzzv")

-- Paste over selected text without yanking it in visual mode
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Paste over selected text from clipboard
vim.keymap.set("x", "<leader>P", '"+p')

-- Yank to system clipboard in normal and visual modes
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])

-- Yank the current line to system clipboard in normal mode
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete text without yanking it in normal and visual modes
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Disable Ex mode
vim.keymap.set("n", "Q", "<nop>")

-- Format code using LSP in normal mode
vim.keymap.set("n", "<leader>m", vim.lsp.buf.format)

-- Move to the next item in the quickfix list and center the cursor in normal mode
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")

-- Move to the previous item in the quickfix list and center the cursor in normal mode
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

-- Move to the next item in the location list and center the cursor in normal mode
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")

-- Move to the previous item in the location list and center the cursor in normal mode
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Search and replace the word under the cursor in the entire file in normal mode
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make the current file executable in normal mode
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Print (paste) from default register in normal mode
vim.keymap.set("n", "p", "p")

-- Print (paste) from system clipboard in normal mode
vim.keymap.set("n", "<leader>P", [["+p"]])

-- for reference: remaps from the lsp.lua file
--
--  -- Go to definition: Navigates to the definition of the symbol under the cursor
--  vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
--
--  -- Hover: Displays hover information about the symbol under the cursor
--  vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
--
--  -- Workspace symbol: Searches for a symbol in the workspace and displays the results
--  vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
--
--  -- Diagnostic float: Opens a floating window with diagnostic information at the current cursor position
--  vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
--
--  -- Next diagnostic: Jumps to the next diagnostic in the buffer
--  vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
--
--  -- Previous diagnostic: Jumps to the previous diagnostic in the buffer
--  vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
--
--  -- Code action: Displays a list of code actions available at the current cursor position
--  vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
--
--  -- References: Lists all references to the symbol under the cursor
--  vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
--
--  -- Rename: Renames all references to the symbol under the cursor
--  vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
--
--  -- Signature help: Displays signature information about the function or method at the current cursor position
--  vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
--
--    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
--    ['<C-Space>'] = cmp.mapping.complete(),
--
