local function compile_rust()
	vim.cmd("botright split | resize 15 | terminal cargo run")
end

require("narat.core.utils").keymap({ "n", "t" }, "<F9>", compile_rust)
