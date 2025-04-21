return {
	"simrat39/rust-tools.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"mfussenegger/nvim-dap",
	},
	ft = { "rust" },
	config = function()
		local rt = require("rust-tools")
		rt.setup({
			server = {
				-- capabilities = require("cmp_nvim_lsp").default_capabilities(),
				on_attach = function(_, bufnr)
					local keymap = require("narat.core.utils").keymap
					keymap("n", "<Leader>k", function()
						rt.hover_actions.hover_actions()
					end, { buffer = bufnr })
					keymap("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
				end,
			},
			tools = {
				hover_actions = {
					auto_focus = true,
				},
			},
		})
	end,
}
