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
local function get_total_splits()
  return vim.fn.winnr('$')
end

local function get_current_split()
  return vim.fn.winnr()
end

local function cycle_split(direction)
  local current_split = get_current_split()
  local total_splits = get_total_splits()

  if direction == 'h' or direction == 'l' then
    if direction == 'h' then
      if current_split == 1 then
        vim.cmd(total_splits .. 'wincmd w')
      else
        vim.cmd('wincmd h')
      end
    elseif direction == 'l' then
      if current_split == total_splits then
        vim.cmd('1wincmd w')
      else
        vim.cmd('wincmd l')
      end
    end
  elseif direction == 'j' or direction == 'k' then
    if direction == 'j' then
      vim.cmd('wincmd j')
    elseif direction == 'k' then
      vim.cmd('wincmd k')
    end
  end
end

vim.keymap.set("n", "<leader>h", function() cycle_split('h') end, { noremap = true })
vim.keymap.set("n", "<leader>j", function() cycle_split('j') end, { noremap = true })
vim.keymap.set("n", "<leader>k", function() cycle_split('k') end, { noremap = true })
vim.keymap.set("n", "<leader>l", function() cycle_split('l') end, { noremap = true })

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
vim.keymap.set("n", "<F3>", "<CMD>CopilotToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-n>", "<Plug>(copilot-next)", { silent = true })
vim.keymap.set("i", "<C-p>", "<Plug>(copilot-previous)", { silent = true })
vim.keymap.set("i", "<C-\\>", "<Plug>(copilot-dismiss)", { silent = true })

local opts = { noremap = true, silent = true }
-- Move to previous/next
vim.api.nvim_set_keymap("n", "<leader>.", "<Cmd>BufferNext<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>,", "<Cmd>BufferPrevious<CR>", opts)

-- Dap
vim.keymap.set("n", "<leader>dt", "<cmd>lua require'dapui'.toggle()<CR>", { noremap = true })
vim.keymap.set("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { noremap = true })
vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", { noremap = true })
vim.keymap.set("n", "<leader>di", "<cmd>lua require'dap'.step_into()<CR>", { noremap = true })
-- vim.keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_over()<CR>", { noremap = true })
vim.keymap.set("n", "<leader>ds", "<cmd>lua require'dap'.close()<CR>", { noremap = true })

-- Tagbar
vim.keymap.set("n", "<F2>", "<cmd>TagbarToggle<CR>", { noremap = true })

-- Search without jumping
vim.api.nvim_set_keymap("n", "<Leader>/", ":lua SearchWithoutJump()<CR>", { noremap = true, silent = true })
