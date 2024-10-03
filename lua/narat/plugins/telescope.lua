return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-lua/popup.nvim",
		"princejoogie/dir-telescope.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			config = function()
				require("telescope").load_extension("fzf")
			end,
		},
	},
	config = function()
		local actions = require("telescope.actions")
		local telescope = require("telescope")

		telescope.setup({
			defaults = {
				smart_case = true,
				prompt_prefix = " >",
				color_devicons = true,
				layout_strategy = "horizontal",
				layout_config = { height = 0.95 },
				initial_mode = "insert",
				file_ignore_patterns = { "node%_modules/.*", "package.json", "package%-lock.json" },
				mappings = {
					i = { -- Insert mode
						["<C-h>"] = "which_key",
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
						["<C-n>"] = actions.cycle_history_next,
						["<C-p>"] = actions.cycle_history_prev,
					},
					n = { -- normal mode
						["<C-h>"] = "which_key",
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
						["<C-n>"] = actions.cycle_history_next,
						["<C-p>"] = actions.cycle_history_prev,
					},
				},
			},
			pickers = {},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "ignore_case", -- or "ignore_case" or "respect_case"
					only_sort_tags = true, -- sort the tags only when the filetype is already set to something I like
					file_ignore_patterns = { "node%_modules/.*", "package.json", "package%-lock.json" },
				},
			},
		})

		telescope.load_extension("fzf")

		-- telescope-dir
		require("dir-telescope").setup({
			-- these are the default options set
			hidden = true,
			no_ignore = false,
			show_preview = true,
			follow_symlinks = false,
		})

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in working directory" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Fuzzy find buffers" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
		vim.keymap.set("n", "<leader>fs", builtin.grep_string, { desc = "Grep string under cursor" })
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Fuzzy find diagnostics" })
		vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Fuzzy find recent files" })

		vim.keymap.set("n", "<leader>Df", "<cmd>Telescope dir find_files<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>Dg", "<cmd>Telescope dir live_grep<CR>", { noremap = true, silent = true })

		local telescope_last = 0
		function TelescopeResume()
			if telescope_last == 0 then
				telescope_last = 1
				builtin.live_grep()
			else
				builtin.resume()
			end
		end
		vim.keymap.set("n", "<leader>fh", TelescopeResume)
	end,
}
