return {
	"simrat39/rust-tools.nvim",
	ft = { "rust" },
	config = function()
		local rt = require("rust-tools")

		rt.setup({
			server = {
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				on_attach = function(_, bufnr)
					vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
					vim.keymap.set("n", "<Leader>ca", rt.code_action_group.code_action_group, { buffer = bufnr })
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
