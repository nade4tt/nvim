return {
	"stevearc/oil.nvim",
	config = function()
		require("oil").setup({
			view_options = {
				show_hidden = true,
			},
			win_config = {
				width = 40,
				height = 20,
			},
		})
	end,
}
