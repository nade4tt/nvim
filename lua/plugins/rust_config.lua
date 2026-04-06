vim.pack.add({ { src = "https://github.com/mrcjkb/rustaceanvim", name = "rustaceanvim" } })
vim.g.rustaceanvim = {
	tools = {
		inlay_hints = {
			auto = true,
			show_parameter_hints = true,
			only_current_line = false,
		},
	},
	server = {
		on_attach = function(_, _) end,
		default_settings = {
			["rust-analyzer"] = {
				checkOnSave = true,
				procMacro = {
					enable = true,
				},
				diagnostics = {
					enable = true,
					disabled = { "unresolved-proc-macro" }, -- Common annoyance
				},
			},
		},
	},
}
