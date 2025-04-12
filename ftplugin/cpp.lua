local uname = vim.loop.os_uname().sysname
local keymap = require("narat.core.utils").keymap

if uname == "Linux" then
	-- Compile (Fast)
	keymap(
		"n",
		"<F8>",
		"<cmd>!clang++ -std=c++17 -Wshadow -Wall -O2 -Wno-unused-result -Wunused-variable % -o out && ./out<CR>",
		{ noremap = true }
	)
	-- Build (Slow but safe)
	keymap(
		"n",
		"<F9>",
		"<cmd>!clang++ -std=c++17 -Wshadow -Wall -g -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG % -o out && ./out<CR>",
		{ noremap = true }
	)
elseif uname:match("Windows") then
	-- Compile (Fast)
	keymap(
		"n",
		"<F8>",
		"<cmd>!clang++ -std=c++17 -Wshadow -Wall -O2 -Wno-unused-result -Wunused-variable % -o out.exe && .\\out.exe<CR>",
		{ noremap = true }
	)
	-- Build (Slow but safe)
	keymap(
		"n",
		"<F9>",
		"<cmd>!clang++ -std=c++17 -Wshadow -Wall -g -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG % -o out.exe && .\\out.exe<CR>",
		{ noremap = true }
	)
else
	print("Unsupported system: " .. uname)
end
