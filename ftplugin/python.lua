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
