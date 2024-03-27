return {
  "tell-k/vim-autopep8",
  config = function()
    vim.g["autopep8_pep8_passes"] = 100
    vim.g["autopep8_max_line_length"] = 200
    vim.g["autopep8_on_save"] = 0
    vim.g["autopep8_disable_show_diff"] = 0
    vim.g["autopep8_diff_type"] = "horizontal"
  end,
}
