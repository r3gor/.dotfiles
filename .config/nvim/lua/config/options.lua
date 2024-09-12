-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- folding
vim.o.foldcolumn = "0"
vim.o.foldlevel = 9999 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 9999
vim.o.foldenable = true
vim.o.spell = false

-- wrap enabled by default
vim.opt.wrap = true

-- autoformat disabled by default
vim.g.autoformat = false

-- enable local configs
vim.o.exrc = true

vim.o.list = false

vim.o.signcolumn = "no"
vim.opt.fillchars:append({ eob = "~" })

-- WSL nvim options
if os.getenv("WSL_DISTRO_NAME") then
  print("RUNNING ON WSL")
end

if vim.fn.has("nvim") == 1 and vim.fn.executable("nvr") == 1 then
  vim.env.GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
end

-- let g:lazygit_floating_window_winblend = 0 " transparency of floating window
-- let g:lazygit_floating_window_scaling_factor = 0.9 " scaling factor for floating window

vim.g.lazygit_floating_window_scaling_factor = 1 -- scaling factor for floating window
vim.g.lazygit_floating_window_winblend = 1 -- transparency of floating window

-- local node_18 = "/home/rogrp/.nvm/versions/node/v18.19.0/bin"
-- local updated_path = node_18 .. ":" .. os.getenv("PATH")
-- print(updated_path)
-- os.execute("export PATH=" .. updated_path)
-- print(os.getenv("PATH", updated_path))
--

-- vim.g.node_host_prog = "~/.nvm/versions/node/v18.19.0/lib/node_modules"
-- vim.g.copilot_node_command = "~/.nvm/versions/node/v18.19.0/bin/node"

vim.o.showtabline = 1
vim.o.laststatus = 3
