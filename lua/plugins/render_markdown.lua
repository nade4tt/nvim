vim.pack.add({ { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim", name = "render-markdown.nvim" } })

require("render-markdown").setup({
	file_types = { "markdown" }, -- filetypes this plugin will run on
	render_modes = { "n", "c" }, -- only render in normal/command mode, show raw text while editing
	completions = {
		-- keep this plugin purely visual, don't hook into completion engines
		blink = { enabled = false },
		coq = { enabled = false },
		lsp = { enabled = false },
	},
	latex = { enabled = false }, -- requires external converter, skip to keep setup dependency free
})
