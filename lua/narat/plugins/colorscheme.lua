return {
	"catppuccin/nvim",
	priority = 1000,
	config = function()
		-- vim.cmd([[colorscheme tokyonight-storm]])
		-- vim.cmd([[colorscheme rose-pine-moon]])
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

		-- Bold text in markdown
		-- vim.api.nvim_set_hl(0, "@markup.strong", { fg = "#ff9e64", bold = true })
	end,
}
