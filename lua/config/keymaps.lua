local keymap = require("utils").keymap

vim.g.mapleader = " "

-- Search: highlight word under cursor without jumping
keymap("n", "*", [[:let @/ = '\<' . expand('<cword>') . '\>'<CR>:set hlsearch<CR>]])
keymap("n", "<C-l>", ":noh<return>")
keymap("n", "cl", "s")

-- Vertical movement
keymap({ "n", "v" }, "<C-d>", "15jzz")
keymap({ "n", "v" }, "<C-u>", "15kzz")

-- Yank line content (no leading/trailing whitespace)
keymap("n", "<leader>y", "^yg_")

-- Command mode (Emacs-style shortcuts)
keymap("c", "<C-a>", "<Home>")
keymap("c", "<C-e>", "<End>")
keymap("c", "<C-b>", "<Left>")
keymap("c", "<C-d>", "<Del>")
keymap("c", "<A-b>", "<C-Left>")
keymap("c", "<A-f>", "<C-Right>")

-- Split resize
keymap("n", "<C-Up>", ":resize -2<CR>")
keymap("n", "<C-Down>", ":resize +2<CR>")
keymap("n", "<C-Left>", ":vertical resize -2<CR>")
keymap("n", "<C-Right>", ":vertical resize +2<CR>")

-- Buffer navigation (barbar)
keymap("n", "<leader>.", "<Cmd>BufferNext<CR>")
keymap("n", "<leader>,", "<Cmd>BufferPrevious<CR>")
keymap("n", "<leader>bc", "<Cmd>BufferClose<CR>")
keymap("n", "<leader>ba", "<Cmd>BufferCloseAllButVisible<CR>")

-- Quickfix list navigation
keymap("n", "<leader>]", "<cmd>cnext<CR>")
keymap("n", "<leader>[", "<cmd>cprev<CR>")

-- Move selected lines up/down
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- Paste without overwriting register
keymap("x", "<leader>p", '"_dP')

-- File operations
keymap("n", "<leader>q", "<CMD>q<CR>")
keymap("n", "<leader>Q", "<CMD>q!<CR>")
keymap("n", "<leader>ss", "<CMD>w<CR>")

-- Terminal: exit with double ESC
keymap("t", "<esc><esc>", "<C-\\><C-n>")

-- Undotree
keymap("n", "<leader>u", "<CMD>Undotree<CR>")

-- Copilot
keymap({ "n", "i" }, "<F3>", "<CMD>CopilotToggle<CR>")
keymap("i", "<C-j>", "<Plug>(copilot-next)")
keymap("i", "<C-k>", "<Plug>(copilot-previous)")
keymap("i", "<C-\\>", "<Plug>(copilot-dismiss)")

-- Tagbar
keymap("n", "<F2>", "<CMD>TagbarToggle<CR>")

-- ZenMode
keymap("n", "<leader>z", "<CMD>ZenMode<CR>")

-- Scratchpad
keymap("n", "<leader>=", function()
	require("utils.scratchpad").toggle()
end, { desc = "Toggle scratchpad" })

-- Keymap picker
keymap("n", "<leader>?", function()
	require("utils.keymaps_picker").show_keymaps()
end, { desc = "Show all keymaps" })

-- Focus: close all splits and center the active buffer
keymap("n", "<leader>M", function()
	vim.cmd("only")
	local width = vim.o.columns
	local win_width = math.floor(width * 0.6)
	local pad = math.floor((width - win_width) / 2)
	vim.cmd("topleft vsplit")
	vim.api.nvim_win_set_width(0, pad)
	vim.cmd("enew")
	vim.cmd("setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile")
	vim.cmd("wincmd l")
	vim.cmd("wincmd l")
	vim.cmd("vsplit")
	vim.api.nvim_win_set_width(0, pad)
	vim.cmd("enew")
	vim.cmd("setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile")
	vim.cmd("wincmd h")
end, { desc = "Center active split" })
