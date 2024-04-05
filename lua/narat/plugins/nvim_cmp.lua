local border = {
  { "╭", "CmpBorder" },
  { "─", "CmpBorder" },
  { "╮", "CmpBorder" },
  { "│", "CmpBorder" },
  { "╯", "CmpBorder" },
  { "─", "CmpBorder" },
  { "╰", "CmpBorder" },
  { "│", "CmpBorder" },
}

local lsp = vim.lsp

lsp.handlers["textDocument/hover"] = lsp.with(vim.lsp.handlers.hover, {
  border = border,
})

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter", -- Plugin only loads when we enter insert mode
  dependencies = {
    "saadparwaiz1/cmp_luasnip", -- source for snippets
    "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim", -- vs-code like pictograms
  },
  config = function()
    local cmp = require "cmp"
    local luasnip = require "luasnip"
    local lspkind = require "lspkind"
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup {
      completion = {
        completeopt = "menu,menuone,noinsert,noselect",
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-Space>"] = cmp.mapping.complete(),
        -- ["<C-Space>"] = cmp.mapping.complete { reason = cmp.ContextReason.Auto },
        ["<C-y>"] = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        -- { name = "buffer" },
        { name = "path" },
      },
      formatting = {
        format = lspkind.cmp_format {
          maxwidth = 50,
          ellipsis_char = "...",
        },
      },
      window = {
        completion = { -- rounded border; thin-style scrollbar
          border = border,
          scrollbar = "║",
        },
        documentation = { -- rounded border; thin-style scrollbar
          border = border,
          scrollbar = "║",
        },
      },
    }
  end,
}
