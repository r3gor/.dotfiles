-- force node 18 for nvim (for plugin compatibility)
local node_18 = "/home/rogrp/.nvm/versions/node/v18.19.0/bin"
vim.env.PATH = node_18 .. ":" .. os.getenv("PATH")

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
