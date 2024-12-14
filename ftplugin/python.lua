-- require("nvim-tree").setup {
--   diagnostics = {
--     enable = false,
--   },
-- }
-- function SaveOnRemote()
--     local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p")
--     local newPath = filename:gsub("C:\\", "\\\\SIMARWD010080\\")
--     vim.cmd("w! ".. newPath)
-- end
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

if vim.fn.has("win32") == 1 then
	vim.keymap.set("n", "<leader>r", ":!python.exe %<CR>", { noremap = true })
else
	vim.keymap.set("n", "<leader>r", ":!python %<CR>", { noremap = true })
end
