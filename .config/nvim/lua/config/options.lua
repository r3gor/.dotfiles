-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- folding
vim.o.foldcolumn = "0"
vim.o.foldlevel = 9999 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 9999
vim.o.foldenable = true

-- wrap enabled by default
vim.opt.wrap = true
