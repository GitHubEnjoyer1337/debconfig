
--now used to open oil formerly used for ex (netrw)
-- vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

--open oil
vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>")

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
vim.keymap.set("n", "<leader>m", function() require("conform").format({ async = true, lsp_fallback = true }) end)

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



-- DAP keybindings
vim.keymap.set('n', '<leader>b', ':DapToggleBreakpoint<CR>') -- Toggle breakpoint
vim.keymap.set('n', '<leader>dc', ':DapContinue<CR>') -- Continue debugging
vim.keymap.set('n', '<leader>dn', ':DapStepOver<CR>') -- Step over
vim.keymap.set('n', '<leader>di', ':DapStepInto<CR>') -- Step into
vim.keymap.set('n', '<leader>do', ':DapStepOut<CR>') -- Step out



