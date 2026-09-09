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
		capabilities = vim.tbl_deep_extend(
			"force",
			vim.lsp.protocol.make_client_capabilities(),
			require("blink.cmp").get_lsp_capabilities()
		),
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
