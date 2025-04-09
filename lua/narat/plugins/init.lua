return {
	"nvim-lua/plenary.nvim",
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				max_lines = 5, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to show for a single context
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			})
		end,
	},

	"tree-sitter/tree-sitter-embedded-template",

	-- Utils
	"tpope/vim-surround",
	"tpope/vim-commentary",
	"github/copilot.vim",
	"tpope/vim-repeat",
	"vim-utils/vim-man",
	"jiangmiao/auto-pairs",
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					-- Defaults
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = false, -- Auto close on trailing </
				},
				-- Also override individual filetype configs, these take priority.
				-- Empty by default, useful if one of the "opts" global settings
				-- doesn't work well in a specific filetype
				per_filetype = {
					["html"] = {
						enable_close = false,
					},
				},
			})
		end,
	},

	-- Git
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	"lewis6991/gitsigns.nvim",

	-- Visual
	"lukas-reineke/indent-blankline.nvim",
	"nvim-tree/nvim-web-devicons",
	"mtdl9/vim-log-highlighting",
	"nvim-lualine/lualine.nvim",
	"romgrk/barbar.nvim",
	"brenoprata10/nvim-highlight-colors",
	"kwkarlwang/bufresize.nvim",
	"folke/todo-comments.nvim",

	-- Themes
	"morhetz/gruvbox",
	"sainnhe/gruvbox-material",
	"shaunsingh/nord.nvim",
	"joshdick/onedark.vim",
	{ "folke/tokyonight.nvim", name = "tokyonight", priority = 1000 },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "rose-pine/neovim", name = "rose-pine", priority = 1000 },

	-- quickfix list
	"romainl/vim-qf",

	-- linting
	"mfussenegger/nvim-lint",
	"neovim/nvim-lspconfig",
	"MunifTanjim/prettier.nvim",
	"rshkarin/mason-nvim-lint",

	-- CMP
	"hrsh7th/cmp-buffer", -- source for text in buffer
	"hrsh7th/cmp-path", -- source for file in system paths
	"L3MON4D3/LuaSnip", -- snippet engine

	-- tagbar
	"preservim/tagbar",

	-- oil
	"stevearc/oil.nvim",

	-- Markdown
	"mzlogin/vim-markdown-toc",

	-- Undotree
	"mbbill/undotree",
}
