vim.opt.linebreak = true
vim.opt.wrap = false

vim.wo.spell = true
vim.opt.spelllang = "en_us"

vim.opt.fo = "want"
vim.opt.textwidth = 80

-- Hide markups
vim.opt.conceallevel = 1
vim.opt.concealcursor = "" -- Conceals in normal and command-line modes

local keymap = require("narat.core.utils").keymap

-- keymap("n", "<F12>", function()
-- 	local conceal_level = vim.api.nvim_get_option_value("conceallevel", {})
-- 	vim.opt.conceallevel = conceal_level == 0 and 3 or 0
-- end)
