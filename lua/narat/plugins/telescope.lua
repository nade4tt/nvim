return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-lua/popup.nvim",
		"princejoogie/dir-telescope.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
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
		local action_state = require("telescope.actions.state")
		local file_ignore_patterns =
			{ "node%_modules/.*", "package.json", "package%-lock.json", "%.csproj", "%.png", "%.ttf", "%.lock" }

		local insert_mode_mappings = {
			["<C-k>"] = actions.move_selection_previous,
			["<C-j>"] = actions.move_selection_next,
			["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
			["<C-n>"] = actions.cycle_history_next,
			["<C-p>"] = actions.cycle_history_prev,
		}

		local normal_mode_mappings = {
			["<C-k>"] = actions.move_selection_previous,
			["<C-j>"] = actions.move_selection_next,
			["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
			["<C-n>"] = actions.cycle_history_next,
			["<C-p>"] = actions.cycle_history_prev,
			["<C-r>"] = function(prompt_bufnr)
				-- Close the Telescope picker
				actions.close(prompt_bufnr)
				-- Obtain filepath from the entry
				local filepath = action_state.get_selected_entry().value
				-- Create presentable name
				local presentable_name = CreatePresentableName(filepath)
				local reference_link = string.format("- [%s](%s)", presentable_name, filepath)
				vim.api.nvim_put({ reference_link }, "l", true, true)
			end,
		}

		local layout_config = {
			horizontal = {
				preview_width = 0.6,
				width = 0.9,
			},
			vertical = {
				preview_height = 0.5,
				height = 0.9,
			},
			center = {
				width = 0.8,
				preview_cutoff = 40,
			},
		}

		local function layout_strategy()
			-- Get current window dimensions
			local width = vim.fn.winwidth(0)
			local height = vim.fn.winheight(0)

			-- Choose strategy based on window size
			if width > 160 and height > 40 then
				return "horizontal" -- Large windows
			elseif width > 120 then
				return "vertical" -- Medium width windows
			else
				return "center" -- Small windows (like splits)
			end
		end

		telescope.setup({
			defaults = {
				smart_case = true,
				prompt_prefix = " >",
				color_devicons = true,
				layout_strategy = layout_strategy(),
				layout_config = layout_config,
				initial_mode = "insert",
				file_ignore_patterns = file_ignore_patterns,
				mappings = {
					i = insert_mode_mappings,
					n = normal_mode_mappings,
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
					file_ignore_patterns = file_ignore_patterns,
				},
				file_browser = {
					-- theme = "ivy",
					-- disables netrw and use telescope-file-browser in its place
					hijack_netrw = true,
					mappings = {
						i = insert_mode_mappings,
						n = normal_mode_mappings,
					},
					file_ignore_patterns = file_ignore_patterns,
				},
				telescope_dir = {
					hidden = false, -- Show hidden files
					follow_symlinks = false, -- Do not follow symlinks
					file_ignore_patterns = file_ignore_patterns, -- Ignore patterns for files
					show_preview = true, -- Disable preview
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("file_browser")

		local builtin = require("telescope.builtin")
		local keymap = require("narat.core.utils").keymap
		keymap("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in working directory" })
		keymap("n", "<leader>fb", builtin.buffers, { desc = "Fuzzy find buffers" })
		keymap("n", "<leader>fB", function()
			require("telescope").extensions.file_browser.file_browser({
				cwd = vim.fn.expand("%:p:h"),
			})
		end, { desc = "File browser (current buffer dir)" })
		-- keymap("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
		keymap("n", "<leader>fw", builtin.grep_string, { desc = "Grep string under cursor" })
		keymap("n", "<leader>fd", builtin.diagnostics, { desc = "Fuzzy find diagnostics" })
		keymap("n", "<leader>fr", builtin.oldfiles, { desc = "Fuzzy find recent files" })
		keymap("n", "<leader>fc", "<cmd>lua TelescopeCurrentBufferGrep()<CR>", { desc = "Live grep current file" })

		keymap("n", "<leader>Ff", "<cmd>Telescope dir find_files<CR>", { noremap = true, silent = true })
		keymap("n", "<leader>Fg", "<cmd>Telescope dir live_grep<CR>", { noremap = true, silent = true })

		keymap("n", "<leader>fs", function()
			builtin.lsp_document_symbols({
				-- symbols = {
				-- 	"Class",
				-- 	"Function",
				-- 	"Method",
				-- 	"Component",
				-- 	"Hook",
				-- },
			})
		end, { desc = "Find Symbols" })

		local telescope_last = 0
		function TelescopeResume()
			if telescope_last == 0 then
				telescope_last = 1
				builtin.live_grep()
			else
				builtin.resume()
			end
		end
		keymap("n", "<leader>fh", TelescopeResume)

		local function find_files_relpath()
			require("telescope.builtin").find_files({
				cwd = vim.fn.expand("%:p:h"), -- Start from current file's directory
				prompt_title = "Files (Relative Path)",
				path_display = function(_, path)
					-- Strip the leading path components
					local relpath = vim.fn.fnamemodify(path, ":.")
					-- Handle files in current directory
					if relpath == "." then
						return vim.fn.fnamemodify(path, ":t") -- Just show filename
					end
					return relpath
				end,
			})
		end

		-- Key mapping example
		keymap("n", "<leader>fr", find_files_relpath, { desc = "[F]ind files [R]elative path" })
	end,
}
