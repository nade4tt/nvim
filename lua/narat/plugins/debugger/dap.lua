return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
	},

	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		local keymap = require("narat.core.utils").keymap
		keymap("n", "<leader>dt", dapui.toggle)
		keymap("n", "<leader>db", dap.toggle_breakpoint)
		keymap("n", "<leader>dc", dap.continue)
		keymap("n", "<leader>di", dap.step_into)
		keymap("n", "<leader>do", dap.step_over)
		keymap("n", "<leader>ds", dap.close)

		-- -- Go
		-- dap.adapters.go = {
		-- 	type = "executable",
		-- 	command = "node",
		-- 	args = {
		-- 		os.getenv("HOME")
		-- 			.. "/.local/share/nvim/mason/packages/go-debug-adapter/extension/dist/debugAdapter.js",
		-- 	},
		-- }
		-- dap.configurations.go = {
		-- 	{
		-- 		type = "go",
		-- 		name = "Debug",
		-- 		request = "launch",
		-- 		showLog = false,
		-- 		program = "${file}",
		-- 		dlvToolPath = vim.fn.exepath(os.getenv("HOME") .. "/.local/share/nvim/mason/packages/delve/dlv"),
		-- 		args = {},
		-- 	},
		-- }

		-- DAP Breakpoint signs
		vim.fn.sign_define("DapBreakpoint", {
			text = "🔴",
			texthl = "DapBreakpoint",
			linehl = "DapBreakpoint",
			numhl = "DapBreakpoint",
		})

		vim.fn.sign_define("DapBreakpointCondition", {
			text = "ﳁ",
			texthl = "DapBreakpoint",
			linehl = "DapBreakpoint",
			numhl = "DapBreakpoint",
		})

		vim.fn.sign_define("DapBreakpointRejected", {
			text = "",
			texthl = "DapBreakpoint",
			linehl = "DapBreakpoint",
			numhl = "DapBreakpoint",
		})

		vim.fn.sign_define("DapLogPoint", {
			text = "",
			texthl = "DapLogPoint",
			linehl = "DapLogPoint",
			numhl = "DapLogPoint",
		})

		vim.fn.sign_define("DapStopped", {
			text = "",
			texthl = "DapStopped",
			linehl = "DapStopped",
			numhl = "DapStopped",
		})
	end,
}
