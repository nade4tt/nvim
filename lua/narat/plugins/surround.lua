return {
	"kylechui/nvim-surround",
	version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	config = function()
		require("nvim-surround").setup({
			keymaps = {
				normal = "ys",
				normal_cur = "yss", -- surround current line (like vim-surround)
				normal_line = "yS",
				normal_cur_line = "ySS",
				visual = "S",
				delete = "ds",
				change = "cs",
			},
		})
	end,
}
