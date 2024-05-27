if vim.fn.has("linux") then
	-- Compile (Fast)
	vim.keymap.set(
		"n",
		"<F8>",
		"<cmd>!clang++ -std=c++17 -Wshadow -Wall -O2 -Wno-unused-result -Wunused-variable % -o out && ./out<CR>",
		{ noremap = true }
	)
	-- Build (Slow but safe)
	vim.keymap.set(
		"n",
		"<F9>",
		"<cmd>!clang++ -std=c++17 -Wshadow -Wall -g -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG % -o out && ./out<CR>",
		{ noremap = true }
	)
else
	-- print("TODO")
end
