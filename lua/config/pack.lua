-- Built-in plugins
vim.cmd.packadd("nvim.undotree")
vim.cmd.packadd("nvim.difftool")

local URL = "https://github.com/"

vim.pack.add({
	-- Essential
	{ src = URL .. "nvim-lua/plenary.nvim" },

	-- Editing utilities
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

	-- Quickfix list
	{ src = URL .. "romainl/vim-qf" },
})

-- Colorscheme
vim.cmd.colorscheme("catppuccin-mocha")
vim.opt.background = "dark"

-- Transparent background
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })

-- Cursor and line number highlights
vim.opt.guicursor = "a:blinkon40"
vim.api.nvim_set_hl(0, "LineNr", { fg = "#ffffff" })
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#ffffff" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#ffffff" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#00ffff" })
