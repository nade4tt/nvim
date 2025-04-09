return {
	"simrat39/rust-tools.nvim",
	ft = { "rust" },
	config = function()
		local rt = require("rust-tools")

		rt.setup({
			-- capabilities = {
			-- 	positionEncodings = { "utf-16" }, -- Explicit capability declaration
			-- },
			server = {
				on_attach = function(client, bufnr)
					-- Hover actions
					vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
					-- Code action groups
					vim.keymap.set("n", "<Leader>ca", rt.code_action_group.code_action_group, { buffer = bufnr })
				end,
			},
			dap = {
				adapter = {
					type = "executable",
					command = "lldb-vscode",
					name = "rt_lldb",
				},
			},
		})
	end,
}
