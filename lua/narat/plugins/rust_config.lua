return {
	"mrcjkb/rustaceanvim",
	version = "^6", -- Recommended
	lazy = false, -- This plugin is already lazy

	config = function()
		vim.g.rustaceanvim = {
			tools = {
				inlay_hints = {
					auto = true,
					only_current_line = false,
				},
			},
			lsp = {
				settings = {
					["rust-analyzer"] = {
						diagnostics = {
							-- disabled = { "obfuscated_if_else" }, -- disable this warning
						},
					},
				},
			},
		}
	end,
}
