return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- Shared setup
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = vim.keymap

		-- Diagnostic signs
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- Keymaps
		local on_attach = function(_, bufnr)
			local opts = { noremap = true, silent = true, buffer = bufnr }

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

			for keys, mapping in pairs(mappings) do
				local mode = mapping.mode or "n"
				opts.desc = mapping[2]
				keymap.set(mode, keys, mapping[1], opts)
			end
		end

		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Server configurations
		local servers = {
			pyright = {
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							extraPaths = {},
						},
					},
				},
			},
			lua_ls = {
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
			},
			omnisharp = { cmd = { "omnisharp", "--languageserver" } },
			gopls = {
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				root_dir = lspconfig.util.root_pattern("go.mod", ".git", "go.work"),
				settings = {
					gopls = {
						completeUnimported = true,
						usePlaceholders = true,
						analyses = { unusedparams = true },
					},
				},
			},
			clangd = {
				filetypes = { "c", "cpp", "objc", "objcpp" },
				root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
				settings = { clangd = { fallbackFlags = { "-std=c++17" } } },
				flags = { debounce_text_changes = 150 },
			},
			svelte = {
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePost", {
						pattern = { "*.js", "*.ts" },
						callback = function(ctx)
							if client.name == "svelte" then
								client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
							end
						end,
					})
				end,
			},
		}

		-- Basic servers without special configuration
		local basic_servers = {
			"html",
			"ts_ls",
			"cssls",
			"cssmodules_ls",
			"tailwindcss",
			"rust_analyzer",
			"jsonls",
			"bashls",
			"vimls",
			"sqls",
		}

		-- Setup all servers
		for server, config in pairs(servers) do
			config.capabilities = capabilities
			config.on_attach = config.on_attach or on_attach
			lspconfig[server].setup(config)
		end

		for _, server in ipairs(basic_servers) do
			lspconfig[server].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end
	end,
}
