return {
  {
    "vhyrro/luarocks.nvim",
    priority = 10019999, -- this plugin needs to run before anything else
    opts = {
      rocks = { "magick" },
      luarocks_build_args = {
        "--lua-version=5.3",
      },
    },
    config = true,
    enabled = false,
  },
  {
    "3rd/image.nvim",
    dependencies = { "luarocks.nvim" },
    config = true,
    enabled = false,
  },
}
