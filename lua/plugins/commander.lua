vim.pack.add({ { src = "https://github.com/FeiyouG/commander.nvim", name = "commander" } })

local commander = require("commander")
local fns = require("config.functions")

commander.setup({
	auto_load = false,
	prompt_title = "Commander",
	auto_replace_desc_with_cmd = true,
	merge = false,
	separator = " ",
	components = { "DESC", "KEYS", "CMD", "CAT" },
	sort_by = { "DESC", "KEYS", "CAT", "CMD" },
	integration = {
		telescope = { enable = true },
		lazy = { enable = false, set_plugin_name_as_cat = false },
	},
})

commander.add({
	{
		desc = "Find files in dir",
		cmd = "<cmd>Telescope dir find_files<CR>",
		keys = { "n", "<leader>Df" },
	},
	{
		desc = "Grep in dir",
		cmd = "<cmd>Telescope dir live_grep<CR>",
		keys = { "n", "<leader>Dg" },
	},
	{
		desc = "Search current buffer (fuzzy)",
		cmd = "<CMD>Telescope current_buffer_fuzzy_find<CR>",
		keys = { "n", "<leader>fl" },
	},
	{
		desc = "Grep current file",
		cmd = fns.telescope_current_buffer_grep,
		keys = { "n", "<leader>fc" },
	},
	{
		desc = "Grep for files",
		cmd = fns.telescope_grep_files,
	},
	{
		desc = "Show document symbols",
		cmd = "<CMD>Telescope lsp_document_symbols<CR>",
	},
	{
		desc = "Telescope file browser",
		cmd = "<CMD>Telescope file_browser<CR>",
	},
	{
		desc = "Close non-visible buffers",
		cmd = "<cmd>BufferCloseAllButVisible<CR>",
		keys = { "n", "<leader>ba" },
	},
	{
		desc = "Git Branches",
		cmd = "<Cmd>Telescope git_branches<CR>",
		keys = { "n", "<leader>gb" },
	},
	{
		desc = "Git Commits",
		cmd = "<Cmd>Telescope git_commits<CR>",
		keys = { "n", "<leader>gc" },
	},
	{
		desc = "Git Buffer Commits",
		cmd = "<Cmd>Telescope git_bcommits<CR>",
	},
	{
		desc = "Insert current file path at cursor",
		cmd = function()
			vim.api.nvim_put({ vim.fn.expand("%") }, "", false, true)
		end,
	},
	{
		desc = "Yank file path",
		cmd = function()
			vim.fn.setreg("+", vim.fn.expand("%:p"))
		end,
	},
	{
		desc = "Yank file name",
		cmd = function()
			vim.fn.setreg("+", vim.fn.expand("%:t"))
		end,
	},
	{
		desc = "Insert current file name at cursor",
		cmd = function()
			vim.api.nvim_put({ vim.fn.expand("%:t") }, "", false, true)
		end,
	},
	{
		desc = "TODO comments",
		cmd = "<cmd>TodoTelescope<CR>",
	},
})

require("utils").keymap("n", "<leader>:", "<CMD>Telescope commander<CR>", { noremap = true })
