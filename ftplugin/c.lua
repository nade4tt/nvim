vim.api.nvim_create_autocmd("FileType", {
	print("Setting up c filetype"),
	pattern = { "c", "cpp" },
	callback = function()
		vim.bo.commentstring = "// %s"
	end,
})
