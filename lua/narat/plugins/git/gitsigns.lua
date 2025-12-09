return {
	"lewis6991/gitsigns.nvim",
	config = function()
		local gitsigns = require("gitsigns")

		gitsigns.setup({
			signs = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signs_staged = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signs_staged_enable = true,
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir = {
				follow_files = true,
			},
			auto_attach = true,
			attach_to_untracked = false,
			current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = false,
				virt_text_priority = 100,
				use_focus = true,
			},
			current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- Use default
			max_file_length = 40000, -- Disable if file is longer than this (in lines)
			preview_config = {
				-- Options passed to nvim_open_win
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
		})

		local keymap = require("narat.core.utils").keymap
		keymap("n", "]h", "<Cmd>Gitsigns next_hunk<CR>")
		keymap("n", "[h", "<Cmd>Gitsigns prev_hunk<CR>")

		keymap("n", "<leader>hs", gitsigns.stage_hunk)
		keymap("n", "<leader>hr", gitsigns.reset_hunk)

		keymap("v", "<leader>hs", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end)

		keymap("v", "<leader>hr", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end)

		keymap("n", "<leader>hS", gitsigns.stage_buffer)
		keymap("n", "<leader>hR", gitsigns.reset_buffer)
		keymap("n", "<leader>hp", gitsigns.preview_hunk)
		keymap("n", "<leader>hi", gitsigns.preview_hunk_inline)

		keymap("n", "<leader>hb", function()
			gitsigns.blame_line({ full = true })
		end)

		keymap("n", "<leader>hd", gitsigns.diffthis)

		keymap("n", "<leader>hD", function()
			gitsigns.diffthis("~")
		end)

		keymap("n", "<leader>hQ", function()
			gitsigns.setqflist("all")
		end)
		keymap("n", "<leader>hq", gitsigns.setqflist)

		-- Toggles
		keymap("n", "<leader>tb", gitsigns.toggle_current_line_blame)
		keymap("n", "<leader>tw", gitsigns.toggle_word_diff)

		-- Text object
		keymap({ "o", "x" }, "ih", gitsigns.select_hunk)
	end,
}
