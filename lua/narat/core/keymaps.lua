vim.g.mapleader = " "
local keymap = vim.keymap.set
local keymap_options = { noremap = true, silent = true }

-- keymap("n", "*", "*``", options)
keymap("n", "*", ":let @/ = '<c-r><c-w>'<CR>:set hlsearch<CR>", keymap_options)
keymap("n", "//", ":noh<return>", keymap_options)

-- vertical movement
keymap("n", "<C-d>", "<C-d>zz", keymap_options)
keymap("n", "<C-u>", "<C-u>zz", keymap_options)

-- yank
keymap("n", "<leader>y", "^yg_", keymap_options)

-- split navigations
keymap("n", "<leader>h", "<C-w>h", keymap_options)
keymap("n", "<leader>j", "<C-w>j", keymap_options)
keymap("n", "<leader>k", "<C-w>k", keymap_options)
keymap("n", "<leader>l", "<C-w>l", keymap_options)

-- split resize
keymap("n", "<C-Up>", ":resize -2<CR>", keymap_options)
keymap("n", "<C-Down>", ":resize +2<CR>", keymap_options)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", keymap_options)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", keymap_options)

-- buffers
keymap("n", "<leader>.", "<Cmd>BufferNext<CR>", keymap_options)
keymap("n", "<leader>,", "<Cmd>BufferPrevious<CR>", keymap_options)

-- indentations
keymap("v", "<", "<gv", keymap_options)
keymap("v", ">", ">gv", keymap_options)

-- nvim-tree
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", keymap_options)

--quickfixlist
keymap("n", "<C-]>", "<cmd>cnext<CR>", keymap_options)
keymap("n", "<C-[>", "<cmd>cprev<CR>", keymap_options)

-- move text up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", keymap_options)
keymap("v", "K", ":m '<-2<CR>gv=gv", keymap_options)
keymap("n", "<A-j>", ":m .+1<CR>==", keymap_options)
keymap("n", "<A-k>", ":m .-2<CR>==", keymap_options)

-- fancy
keymap("x", "<leader>p", '"_dP', keymap_options)

--copilot
keymap("n", "<F3>", "<CMD>CopilotToggle<CR>", keymap_options)
keymap("i", "<leader>]", "<Plug>(copilot-next)", keymap_options)
keymap("i", "<leader>[", "<Plug>(copilot-previous)", keymap_options)
keymap("i", "<C-\\>", "<Plug>(copilot-dismiss)", keymap_options)

-- Dap
keymap("n", "<leader>dt", "<cmd>lua require'dapui'.toggle()<CR>", keymap_options)
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", keymap_options)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", keymap_options)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<CR>", keymap_options)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<CR>", keymap_options)
keymap("n", "<leader>ds", "<cmd>lua require'dap'.close()<CR>", keymap_options)

-- Tagbar
keymap("n", "<F2>", "<cmd>TagbarToggle<CR>", keymap_options)

-- Functions
keymap("n", "<Leader>/", ":lua SearchWithoutJump()<CR>", keymap_options)
