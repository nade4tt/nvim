return {
	"FeiyouG/commander.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	keys = {
		{ "<leader>:", "<CMD>Telescope commander<CR>", mode = "n" },
	},
	config = function()
		local commander = require("commander")

		commander.setup({
			components = {
				"DESC",
				"KEYS",
				"CAT",
			},
			sort_by = {
				"DESC",
				"KEYS",
				"CAT",
				"CMD",
			},
			integration = {
				telescope = {
					enable = true,
				},
				lazy = {
					enable = true,
					set_plugin_name_as_cat = true,
				},
			},
		})

		commander.add({
			{
				desc = "Telecope dir find_files",
				cmd = "<cmd>Telescope dir find_files<CR>",
				keys = { "n", "<leader>Df" },
			},
			{
				desc = "Telecope dir live_grep",
				cmd = "<cmd>Telescope dir live_grep<CR>",
				keys = { "n", "<leader>Dg" },
			},
			{
				desc = "Search inside current buffer",
				cmd = "<CMD>Telescope current_buffer_fuzzy_find<CR>",
				keys = { "n", "<leader>fl" },
			},
			{
				desc = "Show document symbols",
				cmd = "<CMD>Telescope lsp_document_symbols<CR>",
				-- keys = {
				-- 	{ "n", "<leader>ss", { noremap = true } },
				-- },
			},
			{
				desc = "My favorite key sequence",
				cmd = "A brane banane",
				-- keys = { "n", "<leader>Ac" },
			},
			{
				-- NOTE: binding lua funciton to a keymap requires nvim >= 0.7
				desc = "Run lua function",
				cmd = function()
					print("ANONYMOUS LUA FUNCTION")
				end,
				-- keys = { "n", "<leader>alf" },
			},
		})
	end,
}
