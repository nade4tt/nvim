if vim.fn.has("win32") then
  -- Compile (Fast)
  vim.keymap.set("n", "<F8>", "<cmd>!clang++ -std=c++17 -Wshadow -Wall -O2 -Wno-unused-result -Wunused-variable % -o out.exe<CR>", { noremap = true })
  -- Build (Slow but safe)
  vim.keymap.set("n", "<F9>", "<cmd>!clang++ -std=c++17 -Wshadow -Wall -g -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG % -o out.exe<CR>", { noremap = true })
else
  -- Compile (Fast)
  vim.keymap.set("n", "<F8>", "<cmd>!clang++ -std=c++17 -Wshadow -Wall -O2 -Wno-unused-result % -o out<CR>", { noremap = true })
  -- Build (Slow but safe)
  vim.keymap.set("n", "<F9>", "<cmd>!clang++ -std=c++17 -Wshadow -Wall -g -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG % -o out<CR>", { noremap = true })
end
