return {
	"FeiyouG/commander.nvim",

	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	keys = {
		{ "<leader>:", "<CMD>Telescope commander<CR>", mode = { "n", "i" } },
	},
	config = function()
		local commander = require("commander")

		commander.setup({
			auto_load = false,
			prompt_title = "Commander",
			auto_replace_desc_with_cmd = true,
			merge = false,
			separator = " ",

			components = {
				"DESC",
				"KEYS",
				"CMD",
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
					enable = false,
					set_plugin_name_as_cat = false,
				},
			},
		})

		commander.add({
			{
				desc = "🔭 Telescope dir find_files",
				cmd = "<cmd>Telescope dir find_files<CR>",
				keys = { "n", "<leader>Df" },
			},
			{
				desc = "🔎 Grep in dir",
				cmd = "<cmd>Telescope dir live_grep<CR>",
				keys = { "n", "<leader>Dg" },
			},
			{
				desc = "Search inside current buffer fuzzy",
				cmd = "<CMD>Telescope current_buffer_fuzzy_find<CR>",
				keys = { "n", "<leader>fl" },
			},
			{
				desc = "🔎 Grep current file",
				cmd = "<CMD>lua TelescopeCurrentBufferGrep()<CR>",
				keys = { "n", "<leader>fc" },
			},
			{
				desc = "🔎 Grep for files",
				cmd = "<CMD>lua TelescopeGrepFiles()<CR>",
			},
			{
				desc = "🔭 Show document symbols",
				cmd = "<CMD>Telescope lsp_document_symbols<CR>",
			},
			{
				desc = "🔭 Telescope file browser",
				cmd = "<CMD>Telescope file_browser<CR>",
			},
			{
				desc = "Close non visible buffers",
				cmd = "<cmd>BufferCloseAllButVisible<CR>",
				keys = { "n", "<leader>ba" },
			},
			{
				desc = "Markdown reference file",
				cmd = "<CMD>lua CreateMdReferenceFile()<CR>",
			},
			{
				desc = "Insert current file PATH at cursor",
				cmd = function()
					local filepath = vim.fn.expand("%")
					vim.api.nvim_put({ filepath }, "", false, true)
				end,
			},
			{
				desc = "Insert current file NAME at cursor",
				cmd = function()
					local filename = vim.fn.expand("%:t")
					vim.api.nvim_put({ filename }, "", false, true)
				end,
			},

			{
				desc = "TODO comments",
				cmd = "<cmd>TodoTelescope<CR>",
			},
		})
	end,
}
