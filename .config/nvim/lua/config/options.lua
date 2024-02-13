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

-- autoformat disabled by default
vim.g.autoformat = false

-- enable local configs
vim.o.exrc = true

-- enable clipboard for WSL
if os.getenv("WSLENV") then
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end

-- Get folding working with vscode neovim plugin
-- if vim.fn.exists("g:vscode") then
--   vim.api.nvim_set_keymap("n", "zM", [[:call VSCodeNotify('editor.foldAll')<CR>]], { noremap = true, silent = true })
--   vim.api.nvim_set_keymap("n", "zR", [[:call VSCodeNotify('editor.unfoldAll')<CR>]], { noremap = true, silent = true })
--   vim.api.nvim_set_keymap("n", "zc", [[:call VSCodeNotify('editor.fold')<CR>]], { noremap = true, silent = true })
--   vim.api.nvim_set_keymap(
--     "n",
--     "zC",
--     [[:call VSCodeNotify('editor.foldRecursively')<CR>]],
--     { noremap = true, silent = true }
--   )
--   vim.api.nvim_set_keymap("n", "zo", [[:call VSCodeNotify('editor.unfold')<CR>]], { noremap = true, silent = true })
--   vim.api.nvim_set_keymap(
--     "n",
--     "zO",
--     [[:call VSCodeNotify('editor.unfoldRecursively')<CR>]],
--     { noremap = true, silent = true }
--   )
--   vim.api.nvim_set_keymap("n", "za", [[:call VSCodeNotify('editor.toggleFold')<CR>]], { noremap = true, silent = true })
--
--   function MoveCursor(direction)
--     if vim.fn.reg_recording() == "" and vim.fn.reg_executing() == "" then
--       return "g" .. direction
--     else
--       return direction
--     end
--   end
--
--   vim.api.nvim_set_keymap("n", "j", [[:lua MoveCursor('j')<CR>]], { noremap = true, expr = true })
--   vim.api.nvim_set_keymap("n", "k", [[:lua MoveCursor('k')<CR>]], { noremap = true, expr = true })
-- end
