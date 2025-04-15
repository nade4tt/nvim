return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- Shared setup
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local mason_lspconfig = require("mason-lspconfig")

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local mappings = {
					["gR"] = { "<cmd>Telescope lsp_references<CR>", "Show LSP references" },
					["gD"] = { vim.lsp.buf.declaration, "Go to declaration" },
					["gd"] = { "<cmd>Telescope lsp_definitions<CR>", "Show LSP definitions" },
					["gi"] = { "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations" },
					["gt"] = { "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions" },
					["<leader>ca"] = { vim.lsp.buf.code_action, "See available code actions", mode = { "n", "v" } },
					["<leader>rn"] = { vim.lsp.buf.rename, "Smart rename" },
					["<leader>D"] = { "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics" },
					["<leader>d"] = { vim.diagnostic.open_float, "Show line diagnostics" },
					["K"] = { vim.lsp.buf.hover, "Show documentation" },
					["<leader>rs"] = { ":LspRestart<CR>", "Restart LSP" },
					["<leader>do"] = { vim.diagnostic.open_float, "Open diagnostics" },
					["]d"] = {
						function()
							vim.diagnostic.jump({ count = 1, float = true })
						end,
						"Go to next diagnostic",
					},
					["[d"] = {
						function()
							vim.diagnostic.jump({ count = -1, float = true })
						end,
						"Go to previous diagnostic",
					},
				}

				local opts = { noremap = true, silent = false, buffer = ev.buf }

				for keys, mapping in pairs(mappings) do
					local mode = mapping.mode or "n"
					opts.desc = mapping[2]
					vim.keymap.set(mode, keys, mapping[1], opts)
				end
			end,
		})

		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Diagnostic signs
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.INFO] = "󰋼 ",
					[vim.diagnostic.severity.HINT] = "󰌵 ",
				},
				numhl = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "",
					[vim.diagnostic.severity.INFO] = "",
				},
			},
		})

		mason_lspconfig.setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			lspconfig["pyright"].setup({
				capabilities = capabilities,
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							extraPaths = { "C:\\github\\platform-sdt-test" },
						},
					},
				},
			}),
			lspconfig["lua_ls"].setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					},
				},
			}),
			lspconfig["omnisharp"].setup({
				capabilities = capabilities,
				cmd = { "omnisharp", "--languageserver" },
			}),
			lspconfig["gopls"].setup({
				capabilities = capabilities,
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				root_dir = lspconfig.util.root_pattern("go.mod", ".git", "go.work"),
				settings = {
					gopls = {
						completeUnimported = true,
						usePlaceholders = true,
						analyses = { unusedparams = true },
					},
				},
			}),
			lspconfig["clangd"].setup({
				capabilities = capabilities,
				filetypes = { "c", "cpp", "objc", "objcpp" },
				root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
				settings = { clangd = { fallbackFlags = { "-std=c++17" } } },
				flags = { debounce_text_changes = 150 },
			}),
		})
	end,
}
