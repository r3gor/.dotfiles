return {
  "declancm/maximize.nvim",
  event = "BufEnter",
  opts = {
    default_keymaps = false,
  },
  config = true,
  keys = {
    { "<C-w>m", "<cmd>lua require('maximize').toggle()<CR>", desc = "Maximize/minimize a split" },
  },
  enabled = false,
}
