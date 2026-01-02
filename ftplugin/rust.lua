local function compile_rust()
	vim.api.nvim_create_autocmd("TermOpen", {
		once = true,
		callback = function()
			vim.cmd("normal! G")
		end,
	})

	vim.cmd("botright split | resize 30 | terminal cargo run")
end
require("narat.core.utils").keymap({ "n", "t" }, "<F9>", compile_rust)
