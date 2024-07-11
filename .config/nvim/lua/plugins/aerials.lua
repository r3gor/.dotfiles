return {
  "stevearc/aerial.nvim",
  event = "LazyFile",
  enabled = true,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
    "folke/edgy.nvim",
  },
  opts = {
    backends = { "lsp", "markdown", "man" },
    lsp = {
      priority = {
        eslint = 10,
        tsserver = 9,
      },
    },
    -- avaiable SymbolKinds
    -- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#symbolKind
    filter_kind = {
      -- typescriptreact = { "Constant", "Module" },
      -- javascriptreact = { "Constant" },
      typescriptreact = false,
      javascriptreact = false,
      javascript = false,
    },
  },
}
