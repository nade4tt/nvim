local keymap = require("narat.core.utils").keymap

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
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

		vim.keymap.set({ "n", "i" }, "<F8>", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, { desc = "Toggle inlay hints" })

		vim.lsp.inlay_hint.enable(true)

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
		vim.lsp.enable({
			"python_ls",
			"lua_ls",
			"go_ls",
			"cpp_ls",
			"bash_ls",
		})
	end,
}
