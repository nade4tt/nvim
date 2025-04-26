vim.api.nvim_set_hl(0, "Breakpoint", { fg = "#FFFFFF", bg = "#FF0000", bold = true }) -- Red & bold

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = "*",
	callback = function()
		vim.fn.matchadd("Breakpoint", ".*breakpoint().*", 1)
		vim.fn.matchadd("Breakpoint", '.*print("breakpoint").*', 1)
	end,
})
