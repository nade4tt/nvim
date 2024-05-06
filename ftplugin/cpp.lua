if vim.fn.has("win32") then
	vim.keymap.set("n", "<leader>R", "<cmd>!g++ -std=c++17 --debug % -o out && out.exe<CR>", { noremap = true })
else
	vim.keymap.set("n", "<leader>R", "<cmd>!clang++ -std=c++17 --debug % -o out && ./out<CR>", { noremap = true })
end
