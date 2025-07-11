return {
	"preservim/tagbar",
	config = function()
		vim.g.tagbar_width = 40
		vim.g.tagbar_sort = 0
		vim.g.tagbar_position = "leftabove vertical"
		vim.g.tagbar_autofocus = 1
		vim.g.tagbar_compact = 1
		vim.g.tagbar_show_linenumbers = 1
		vim.g.tagbar_show_preview = 1
		vim.g.tagbar_left = 1
		vim.g.tagbar_autoclose = 1
	end,
}
