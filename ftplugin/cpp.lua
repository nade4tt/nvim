vim.keymap.set("n", "<leader>R", "<cmd>!clang++ -std=c++17 --debug % -o out && ./out<CR>", { noremap = true })
