vim.pack.add({ { src = "https://github.com/mrcjkb/rustaceanvim", name = "rustaceanvim" } })

local codelldb_path = vim.fn.stdpath("data") .. "/mason/bin/codelldb"

vim.g.rustaceanvim = {
	dap = {
		adapter = {
			type = "server",
			port = "${port}",
			executable = {
				command = codelldb_path,
				args = { "--port", "${port}" },
			},
		},
	},
	server = {
		on_attach = function(_, _) end,
		default_settings = {
			["rust-analyzer"] = {
				checkOnSave = true,
				procMacro = { enable = true },
				diagnostics = {
					enable = true,
					disabled = { "unresolved-proc-macro" },
				},
			},
		},
	},
}
