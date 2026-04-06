-- Built in plugins
vim.cmd("packadd nvim.undotree")
vim.cmd("packadd nvim.difftool")

local URL = "https://github.com/"

vim.pack.add({
	-- {src = URL .. "neovim/nvim-lspconfig"},
	-- {src = URL .. "nvim-treesitter/nvim-treesitter"},

	-- Utils
	{ src = URL .. "kylechui/nvim-surround" },
	{ src = URL .. "tpope/vim-commentary" },
	{ src = URL .. "tpope/vim-repeat" },
	{ src = URL .. "vim-utils/vim-man" },
	{ src = URL .. "jiangmiao/auto-pairs" },

	-- Visual
	{ src = URL .. "lukas-reineke/indent-blankline.nvim" },
	{ src = URL .. "nvim-tree/nvim-web-devicons" },
	{ src = URL .. "mtdl9/vim-log-highlighting" },
	{ src = URL .. "nvim-lualine/lualine.nvim" },
	{ src = URL .. "romgrk/barbar.nvim" },
	{ src = URL .. "brenoprata10/nvim-highlight-colors" },
	{ src = URL .. "kwkarlwang/bufresize.nvim" },
	{ src = URL .. "norcalli/nvim-colorizer.lua" },

	-- Colorschemes
	{ src = URL .. "catppuccin/nvim" },
	{ src = URL .. "folke/tokyonight.nvim" },
	{ src = URL .. "sainnhe/gruvbox-material" },
	{ src = URL .. "shaunsingh/nord.nvim" },
	{ src = URL .. "joshdick/onedark.vim" },
	{ src = URL .. "rose-pine/neovim" },

	-- quickfix list
	{ src = URL .. "romainl/vim-qf" },

	-- other
	{ src = URL .. "nvim-lua/plenary.nvim" },

	-- Copilot
	-- { src = URL .. "github/copilot.vim"},
})

vim.cmd([[colorscheme catppuccin-mocha]])
vim.opt.background = "dark"
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.cmd("set guicursor=a:blinkon40")
vim.cmd("highlight LineNr guifg=#ffffff")
vim.cmd("highlight LineNrAbove guifg=#ffffff")
vim.cmd("highlight LineNrBelow guifg=#ffffff")
vim.cmd("highlight CursorLineNr guifg=#00ffff")
vim.cmd("highlight Pmenu guibg=NONE")
