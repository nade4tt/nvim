local function save_to_avl_pc(opts)
	local src_file = vim.fn.expand("%:p")
	local dst_file = src_file:gsub("^/home/narat/avl/", "/mnt/c/github/")
	vim.cmd("w! " .. dst_file)
	print("Saved to: " .. dst_file)
end

vim.api.nvim_create_user_command("SaveToAvlPC", save_to_avl_pc, {})
-- require("narat.core.utils").keymap({ "n", "t" }, "<F9>", save_to_avl_pc)
