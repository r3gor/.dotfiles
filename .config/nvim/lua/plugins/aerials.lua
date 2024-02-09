return {
  "stevearc/aerial.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    backends = { "lsp", "markdown", "man" },
    lsp = {
      priority = {
        eslint = 10,
        tsserver = 9,
      },
    },
    filter_kind = {
      typescriptreact = { "Constant", "Module" },
      javascriptreact = { "Constant" },
    },
  },
}
