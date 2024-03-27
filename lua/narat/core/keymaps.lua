vim.g.mapleader = " "
-- vim.keymap.set("n", "*", "*``", { noremap = true })
vim.keymap.set("n", "*", ":let @/ = '<c-r><c-w>'<CR>:set hlsearch<CR>", { noremap = true })
vim.keymap.set("n", "//", ":noh<return>", { noremap = true })

-- vertical movement
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })

-- yank
vim.keymap.set("n", "<leader>y", "^yg_", { noremap = true })

-- split navigations
vim.keymap.set("n", "<leader>j", "<C-W><C-J>", { noremap = true })
vim.keymap.set("n", "<leader>k", "<C-W><C-K>", { noremap = true })
vim.keymap.set("n", "<leader>l", "<C-W><C-L>", { noremap = true })
vim.keymap.set("n", "<leader>h", "<C-W><C-H>", { noremap = true })

-- nvim-tree
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { noremap = true })

--quickfixlist
vim.api.nvim_set_keymap("n", "<leader>]", "<cmd>cnext<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>[", "<cmd>cprev<CR>", { noremap = true })

--fancy
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

--best remaps ever
vim.keymap.set("x", "<leader>p", '"_dP')

--copilot
vim.keymap.set("i", "<C-n>", "<Plug>(copilot-next)", { silent = true })
vim.keymap.set("i", "<C-p>", "<Plug>(copilot-previous)", { silent = true })
vim.keymap.set("i", "<C-\\>", "<Plug>(copilot-dismiss)", { silent = true })

local opts = { noremap = true, silent = true }
-- Move to previous/next
vim.api.nvim_set_keymap("n", "<leader>.", "<Cmd>BufferNext<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>,", "<Cmd>BufferPrevious<CR>", opts)

-- dap
vim.keymap.set("n", "<leader>dd", "<cmd>lua require'dapui'.toggle()<CR>", { noremap = true })
vim.keymap.set("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { noremap = true })
vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", { noremap = true })
vim.keymap.set("n", "<leader>di", "<cmd>lua require'dap'.step_into()<CR>", { noremap = true })
vim.keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_over()<CR>", { noremap = true })
