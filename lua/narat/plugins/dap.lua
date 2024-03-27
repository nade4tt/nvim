return {
  "mfussenegger/nvim-dap",

  config = function()
    local dap = require "dap"

    for _, lanugage in ipairs { "javascript", "typescript" } do
      dap.configurations[lanugage] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        },
      }
    end
  end,
}
