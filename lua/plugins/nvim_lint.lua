vim.pack.add({{src = 'https://github.com/mfussenegger/nvim-lint', name = 'nvim_lint'}})

local lint = require("lint")

lint.linters_by_ft = {
  cpp = { "cpplint" },
  css = { "stylelint" },
  markdown = { "markdownlint" },
  sh = { "shellcheck" },
  -- lua = { "luacheck" }
  -- python = { "pylint" },
  -- javascript = { "eslint_d" },
  -- javascriptreact = { "eslint_d" },
  -- typescript = { "eslint_d" },
  -- typescriptreact = { "eslint_d" },
}

-- Set up autocmd to lint on save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    lint.try_lint()
  end,
})
