local keymap = require("utils").keymap

-- require("nvim-tree").setup {
--   diagnostics = {
--     enable = false,
--   },
-- }
-- function SaveOnRemote()
-- 	local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p")
-- 	local newPath = filename:gsub("C:\\", "\\\\SIMARWD010080\\")
-- 	vim.cmd("w! " .. newPath)
-- end

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.textwidth = 0

vim.opt.formatoptions:remove({ "t", "c", "a" })

local function save_to_avl_pc()
	local src_file = vim.fn.expand("%:p")
	local dst_file = src_file:gsub("^/home/narat/avl/", "/mnt/c/github/")
	vim.cmd("w! " .. dst_file)
	print("Saved to: " .. dst_file)
end

keymap({ "n", "t" }, "<F9>", save_to_avl_pc)
