return {
	"tpope/vim-fugitive",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"tpope/vim-rhubarb",
	},
	config = function()
		local keymap = require("narat.core.utils").keymap
		keymap("n", "<leader>G", "<Cmd>G<CR>")
		keymap("n", "<leader>gs", "<Cmd>Telescope git_status<CR>")
		keymap("n", "<leader>gb", "<Cmd>Telescope git_branches<CR>")
		keymap("n", "<leader>gc", "<Cmd>Telescope git_commits<CR>")
	end,
}
