local keymap = require("narat.core.utils").keymap

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

		keymap("n", "<leader>o", "<cmd>Oil<CR>", { noremap = true })
	end,
}
