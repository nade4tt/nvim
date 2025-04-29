vim.api.nvim_set_hl(0, "DEBUG", { fg = "#FFFFFF", bg = "#FF0000", bold = true })
vim.api.nvim_set_hl(0, "DEBUG", { fg = "#FFFFFF", bg = "#FF0000", bold = true })
vim.api.nvim_set_hl(0, "INFO", { fg = "#000000", bg = "#E6E600", bold = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = "*",
	callback = function()
		vim.fn.matchadd("DEBUG", ".*breakpoint().*", 1)
		vim.fn.matchadd("DEBUG", '.*print("breakpoint").*', 1)
		vim.fn.matchadd("DEBUG", ".*COF.*False.*", 1)
		vim.fn.matchadd("DEBUG", ".*am.home*", 1)
		vim.fn.matchadd("DEBUG", ".*am.topology*", 1)
		vim.fn.matchadd("DEBUG", ".*app_manip*", 1)
		vim.fn.matchadd("DEBUG", ".*app_manip as am*", 1)
		vim.fn.matchadd("INFO", [[\v.*test_CMTEST_\d+.*\n?.*line \d+, in \w+]], 1)
	end,
})
