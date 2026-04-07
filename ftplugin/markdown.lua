local keymap = require("utils").keymap

vim.opt.linebreak = true
vim.opt.wrap = false

vim.wo.spell = true
vim.opt.spelllang = "en_us,sl"

vim.opt.fo = "want"
vim.opt.textwidth = 80

-- Hide markups
vim.opt.conceallevel = 3
vim.opt.concealcursor = ""

keymap("n", "<F12>", function()
	local conceal_level = vim.api.nvim_get_option_value("conceallevel", {})
	if conceal_level == 0 then
		vim.opt.conceallevel = 3
		-- vim.opt.concealcursor = "nc"
		vim.opt.concealcursor = ""
	else
		vim.opt.conceallevel = 0
		vim.opt.concealcursor = ""
	end
end)

-- Toggle checkbox
keymap("n", "<CR>", function()
	local current_line = vim.api.nvim_get_current_line()
	local pattern = "^([%s-]*%[)([x%s])(%]%s)(.*)$"

	local prefix, status, mid, content = current_line:match(pattern)

	if not status then
		return
	end

	if status == " " then
		local clean_content = content:gsub("^~~", ""):gsub("~~$", "")
		vim.api.nvim_set_current_line(prefix .. "x" .. mid .. "~~" .. clean_content .. "~~")
	else
		local clean_content = content:gsub("^~~", ""):gsub("~~$", "")
		vim.api.nvim_set_current_line(prefix .. " " .. mid .. clean_content)
	end
end)
