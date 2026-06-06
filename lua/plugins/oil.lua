vim.pack.add({ { src = "https://github.com/stevearc/oil.nvim", name = "oil" } })
require("oil").setup({
	view_options = {
		show_hidden = true,
	},
	win_options = {
		winbar = "%{v:lua.require('oil').get_current_dir()}",
	},
	win_config = {
		width = 40,
		height = 20,
	},
	skip_confirm_for_simple_edits = true,
	prompt_save_on_select_new_entry = false,
})
require("utils").keymap("n", "<leader>o", "<cmd>Oil<CR>", { noremap = true })
