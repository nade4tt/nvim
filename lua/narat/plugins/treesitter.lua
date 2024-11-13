return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"windwp/nvim-ts-autotag",
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			-- configure commentstring
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
				languages = {
					typescript = "// %s",
				},
			})

			-- configure treesitter
			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				-- enable indentation
				indent = { enable = true },

				-- ensure these language parsers are installed
				ensure_installed = {
					"bash",
					"cpp",
					"c",
					"css",
					"dockerfile",
					"gitignore",
					"graphql",
					"html",
					"javascript",
					"json",
					"lua",
					"markdown",
					"markdown_inline",
					"prisma",
					"python",
					"query",
					"svelte",
					"tsx",
					"typescript",
					"vim",
					"yaml",
					"go",
					"c_sharp",
					"mermaid",
					"sql",
					"scss",
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
			})

			require("nvim-ts-autotag").setup({
				opts = {
					-- Defaults
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = false, -- Auto close on trailing </
				},
				per_filetype = {
					["html"] = {
						enable_close = true,
					},
					["javascript"] = {
						enable_close = true,
					},
					["typescript"] = {
						enable_close = true,
					},
				},
			})
		end,
	},
}
