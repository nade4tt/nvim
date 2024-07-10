return {
	"nvim-lua/plenary.nvim",
	"nvim-treesitter/nvim-treesitter-context",
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
	"preservim/tagbar",

	-- Themes
	"morhetz/gruvbox",
	"sainnhe/gruvbox-material",
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

	-- Markdown
	"mzlogin/vim-markdown-toc",
}
