return {
	"mfussenegger/nvim-dap",

	config = function()
		-- local dap = require("dap")

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

		-- visual
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
