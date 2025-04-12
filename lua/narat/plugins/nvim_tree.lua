return {
	"nvim-tree/nvim-tree.lua",
	config = function()
		local keymap = require("narat.core.utils").keymap
		keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")

		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		require("nvim-tree").setup({
			sort_by = "case_sensitive",
			git = {
				enable = true,
				timeout = 400,
			},
			diagnostics = {
				enable = true,
			},
			view = {
				width = 40,
				adaptive_size = true,
				relativenumber = true,
			},
			renderer = {
				group_empty = true,
			},
			filters = {
				dotfiles = false,
			},
			update_focused_file = {
				enable = true,
				update_root = true,
			},
		})
	end,
}
