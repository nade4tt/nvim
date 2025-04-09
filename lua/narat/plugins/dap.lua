return {
	"mfussenegger/nvim-dap",

	config = function()
		-- check if current operating system is windows and return empty
		if vim.fn.has("win32") == 1 then
			return
		end

		local dap = require("dap")

		-- Go
		dap.adapters.go = {
			type = "executable",
			command = "node",
			args = {
				os.getenv("HOME")
					.. "/.local/share/nvim/mason/packages/go-debug-adapter/extension/dist/debugAdapter.js",
			},
		}
		dap.configurations.go = {
			{
				type = "go",
				name = "Debug",
				request = "launch",
				showLog = false,
				program = "${file}",
				dlvToolPath = vim.fn.exepath(os.getenv("HOME") .. "/.local/share/nvim/mason/packages/delve/dlv"),
				args = {},
			},
		}

		-- Cpp
		-- dap.adapters.cpp = {
		-- 	id = "cppdbg",
		-- 	type = "executable",
		-- 	command = vim.fn.exepath(
		-- 		os.getenv("HOME")
		-- 			.. "/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7"
		-- 	),
		-- }

		-- dap.configurations.cpp = {
		-- 	{
		-- 		name = "Launch",
		-- 		type = "cpp",
		-- 		request = "launch",
		-- 		program = function()
		-- 			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		-- 		end,
		-- 		cwd = "${workspaceFolder}",
		-- 		args = {},
		-- 	},
		-- }

		-- JavaScript
		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = 8123,
			executable = {
				command = "js-debug-adapter",
			},
		}

		for _, language in ipairs({ "typescript", "javascript" }) do
			dap.configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
					runtimeExecutable = "node",
				},
			}
		end

		vim.diagnostic.config({
			signs = {
				active = true,
				values = {
					{ name = "DapBreakpoint", text = "" },
					{ name = "DapBreakpointCondition", text = "ﳁ" },
					{ name = "DapBreakpointRejected", text = "" },
					{ name = "DapLogPoint", text = "" },
					{ name = "DapStopped", text = "" },
				},
			},
		})

		-- visual
		-- DAP Breakpoint signs
		vim.fn.sign_define("DapBreakpoint", {
			text = "",
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
