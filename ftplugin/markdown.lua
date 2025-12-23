local keymap = require("narat.core.utils").keymap

vim.opt.linebreak = true
vim.opt.wrap = false

vim.wo.spell = true
vim.opt.spelllang = "en_us"

vim.opt.fo = "want"
vim.opt.textwidth = 80

-- Hide markups
vim.opt.conceallevel = 3
vim.opt.concealcursor = "nc"

vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt_local.foldlevel = 2

keymap("n", "<F12>", function()
	local conceal_level = vim.api.nvim_get_option_value("conceallevel", {})
	if conceal_level == 0 then
		vim.opt.conceallevel = 3
		vim.opt.concealcursor = "nc"
	else
		vim.opt.conceallevel = 0
		vim.opt.concealcursor = ""
	end
end)
