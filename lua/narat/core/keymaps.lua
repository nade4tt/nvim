local keymap = require("narat.core.utils").keymap

vim.g.mapleader = " "

keymap("n", "*", ":let @/ = '<c-r><c-w>'<CR>:set hlsearch<CR>")
keymap("n", "//", ":noh<return>")

-- vertical movement
keymap({ "n", "v" }, "<C-d>", "15jzz")
keymap({ "n", "v" }, "<C-u>", "15kzz")

-- yank
keymap("n", "<leader>y", "^yg_")

-- split navigations
keymap("n", "<leader>h", "<C-w>h")
keymap("n", "<leader>j", "<C-w>j")
keymap("n", "<leader>k", "<C-w>k")
keymap("n", "<leader>l", "<C-w>l")

-- split resize
keymap("n", "<C-Up>", ":resize -2<CR>")
keymap("n", "<C-Down>", ":resize +2<CR>")
keymap("n", "<C-Left>", ":vertical resize -2<CR>")
keymap("n", "<C-Right>", ":vertical resize +2<CR>")

-- buffers
keymap("n", "<leader>.", "<Cmd>BufferNext<CR>")
keymap("n", "<leader>,", "<Cmd>BufferPrevious<CR>")
keymap("n", "<leader>bc", "<Cmd>BufferClose<CR>")
keymap("n", "<leader>ba", "<Cmd>BufferCloseAllButVisible<CR>")

-- inden--quickfixlist
keymap("n", "<leader>]", "<cmd>cnext<CR>")
keymap("n", "<leader>[", "<cmd>cprev<CR>")

-- move text up and down
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- fancy
keymap("x", "<leader>p", '"_dP')
-- km.keymap("x", "p", '"_dP')

-- Custom Functions
keymap("n", "<Leader>/", ":lua SearchWithoutJump()<CR>")

-- Exit terminal
keymap("t", "<esc><esc>", "<C-\\><C-n>")
