return {
	"mfussenegger/nvim-dap",

	config = function()
		-- check if current operating system is windows and return empty
		if vim.fn.has("win32") == 1 then
			return
		end

		local dap = require("dap")
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
        args = {}
			},
		}
		-- visual
		vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "DapBreakpoint" })
		vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "DapBreakpoint" })
		vim.fn.sign_define("DapStopped", { text = "🛑", texthl = "DapStopped" })
		vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#ff0000" })
		vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef" })
		vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379" })
	end,
}
