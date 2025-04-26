return {
	"uga-rosa/ccc.nvim",
	config = function()
		require("ccc").setup({
			highlighter = {
				auto_enable = true,
				lsp = true,
			},
			pickers = {
				["color"] = {
					-- default color picker
					cmd = "pick",

					-- default color format
					format = "hex",
					-- default color format for `pick` command
					pick_format = "hex",
				},
			},
			-- default color format
			format = "hex",
			-- default color format for `pick` command
			pick_format = "hex",
			-- default color format for `pick` command
		})
	end,
}
