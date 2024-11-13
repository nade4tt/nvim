return {
	"mhartington/formatter.nvim",
	config = function()
		-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
		local util = require("formatter.util")
		require("formatter").setup({
			-- Enable or disable logging
			logging = true,
			-- Set the log level
			log_level = vim.log.levels.WARN,
			-- All formatter configurations are opt-in
			filetype = {
				-- Formatter configurations for filetype "lua" go here
				-- and will be executed in order
				lua = {
					-- "formatter.filetypes.lua" defines default configurations for the
					-- "lua" filetype
					require("formatter.filetypes.lua").stylua,

					-- You can also define your own configuration
					function()
						-- Supports conditional formatting
						if util.get_current_buffer_file_name() == "special.lua" then
							return nil
						end

						-- Full specification of configurations is down below and in Vim help
						-- files
						return {
							exe = "stylua",
							args = {
								"--search-parent-directories",
								"--stdin-filepath",
								util.escape_path(util.get_current_buffer_file_path()),
								"--",
								"-",
							},
							stdin = true,
						}
					end,
				},
				sh = {
					require("formatter.filetypes.sh").prettier,
				},
				go = {
					require("formatter.filetypes.go").gofmt,
				},
				json = {
					require("formatter.filetypes.json").prettier,
				},
				html = {
					require("formatter.filetypes.html").prettier,
				},
				javascript = {
					require("formatter.filetypes.javascript").prettier,
				},
				typescript = {
					require("formatter.filetypes.typescript").prettier,
				},
				markdown = {
					require("formatter.filetypes.markdown").prettier,
				},
				typescriptreact = {
					require("formatter.filetypes.typescriptreact").prettier,
				},
				css = {
					require("formatter.filetypes.css").prettier,
				},
				scss = {
					require("formatter.filetypes.css").prettier, -- Use prettier for SCSS
					function()
						return {
							exe = "prettier",
							args = {
								"--stdin-filepath",
								util.escape_path(util.get_current_buffer_file_path()),
								"--parser",
								"scss",
							},
							stdin = true,
						}
					end,
				},

				rust = {
					require("formatter.filetypes.rust").rustfmt,
				},
				cpp = {
					require("formatter.filetypes.cpp").clangformat,
				},
				sql = {
					require("formatter.filetypes.sql").sqlformat,
				},
				c = {
					require("formatter.filetypes.c").clangformat,
				},
				-- C#
				cs = {
					require("formatter.filetypes.cs").csharpier,
				},
				python = {
					require("formatter.filetypes.python").autopep8,

					function()
						return {
							exe = "autopep8",
							args = {
								"--max-line-length",
								"200",
								"--experimental",
								"--aggressive",
								util.get_current_buffer_file_path(),
							},
							stdin = true,
						}
					end,
				},

				-- Use the special "*" filetype for defining formatter configurations on
				-- any filetype
				["*"] = {
					-- "formatter.filetypes.any" defines default configurations for any
					-- filetype
					-- require("formatter.filetypes.any").remove_trailing_whitespace,
				},
			},
		})

		vim.g["autopep8_max_line_length"] = 200

		vim.keymap.set("n", "<F5>", "<cmd>FormatWrite<CR>", { desc = "Format file" })
		-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
		--   command = "FormatWrite",
		-- })
	end,
}
