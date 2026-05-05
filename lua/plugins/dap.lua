vim.pack.add({
	{ src = "https://github.com/mfussenegger/nvim-dap", name = "nvim-dap" },
	{ src = "https://github.com/rcarriga/nvim-dap-ui", name = "nvim-dap-ui" },
	{ src = "https://github.com/nvim-neotest/nvim-nio", name = "nvim-nio" }, -- required by dap-ui
	{ src = "https://github.com/mfussenegger/nvim-dap-python", name = "nvim-dap-python" },
})

local dap = require("dap")
local dapui = require("dapui")

-- ── UI ────────────────────────────────────────────────────────────────────────

dapui.setup({
	icons = { expanded = "", collapsed = "", current_frame = "" },
	layouts = {
		{
			elements = {
				{ id = "scopes", size = 0.4 },
				{ id = "breakpoints", size = 0.2 },
				{ id = "stacks", size = 0.2 },
				{ id = "watches", size = 0.2 },
			},
			size = 40,
			position = "left",
		},
		{
			elements = {
				{ id = "repl", size = 0.5 },
				{ id = "console", size = 0.5 },
			},
			size = 12,
			position = "bottom",
		},
	},
	floating = { border = "rounded" },
})

-- Auto-open/close UI with DAP session
dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

-- ── Signs ─────────────────────────────────────────────────────────────────────

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DiagnosticHint" })
vim.fn.sign_define("DapLogPoint", { text = "◎", texthl = "DiagnosticInfo" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticOk", linehl = "CursorLine" })

-- ── Adapters ──────────────────────────────────────────────────────────────────

-- codelldb: used for C, C++, and Rust
local codelldb_path = vim.fn.stdpath("data") .. "/mason/bin/codelldb"

dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = codelldb_path,
		args = { "--port", "${port}" },
	},
}

-- debugpy: used for Python
require("dap-python").setup(require("utils").get_python_path() or "python3")

-- ── Configurations ────────────────────────────────────────────────────────────

-- C / C++
dap.configurations.c = {
	{
		name = "Launch (codelldb)",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}
dap.configurations.cpp = dap.configurations.c

-- Rust: rustaceanvim handles its own DAP config via rust-analyzer,
-- but we also expose a plain codelldb config as fallback.
dap.configurations.rust = {
	{
		name = "Launch (codelldb)",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}

-- ── Keymaps ───────────────────────────────────────────────────────────────────

local keymap = require("utils").keymap

-- Session control
keymap("n", "<F6>", dap.continue, { desc = "DAP: continue" })
keymap("n", "<F10>", dap.step_over, { desc = "DAP: step over" })
keymap("n", "<F11>", dap.step_into, { desc = "DAP: step into" })
keymap("n", "<F12>", dap.step_out, { desc = "DAP: step out" })
keymap("n", "<F9>", dap.terminate, { desc = "DAP: terminate" })

-- Breakpoints
keymap("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: toggle breakpoint" })
keymap("n", "<leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Condition: "))
end, { desc = "DAP: conditional breakpoint" })
keymap("n", "<leader>dl", function()
	dap.set_breakpoint(nil, nil, vim.fn.input("Log message: "))
end, { desc = "DAP: log point" })
keymap("n", "<leader>dC", dap.clear_breakpoints, { desc = "DAP: clear all breakpoints" })

-- UI
keymap("n", "<leader>du", dapui.toggle, { desc = "DAP: toggle UI" })
keymap("n", "<leader>de", function()
	dapui.eval(nil, { enter = true })
end, { desc = "DAP: eval expression" })
keymap("v", "<leader>de", function()
	dapui.eval(nil, { enter = true })
end, { desc = "DAP: eval selection" })

-- REPL
keymap("n", "<leader>dr", dap.repl.toggle, { desc = "DAP: toggle REPL" })

-- Python-specific
keymap("n", "<leader>dm", function()
	require("dap-python").test_method()
end, { desc = "DAP: debug test method (Python)" })
keymap("n", "<leader>dc", function()
	require("dap-python").test_class()
end, { desc = "DAP: debug test class (Python)" })
