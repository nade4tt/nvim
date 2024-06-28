return {
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    vim.cmd [[colorscheme tokyonight]]
    -- vim.cmd [[colorscheme catppuccin]]
    vim.opt.background = "dark"
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.g.tokyonight_dark_float = true
    vim.cmd "set guicursor=a:blinkon40"
    vim.cmd("highlight LineNr guifg=#ffffff")
    vim.cmd("highlight CursorLineNr guifg=#00ffff")
    vim.cmd("highlight Pmenu guibg=NONE")
  end,
}
