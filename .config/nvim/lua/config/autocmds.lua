-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Turn off paste mode when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- Configura conceallevel según tus necesidades
    -- vim.cmd("setlocal conceallevel=0")
    -- vim.cmd("setlocal conceallevel=2") -- para obsidian.nvim

    -- Configuración para el método de plegado usando Treesitter
    require("ufo").detach()
    vim.cmd("setlocal foldexpr=nvim_treesitter#foldexpr()")
    vim.cmd("setlocal foldmethod=expr")
  end,
})

-- NvimTree auto close
-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close#background
vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    local tree_wins = {}
    local floating_wins = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:match("NvimTree_") ~= nil then
        table.insert(tree_wins, w)
      end
      if vim.api.nvim_win_get_config(w).relative ~= "" then
        table.insert(floating_wins, w)
      end
    end
    if 1 == #wins - #floating_wins - #tree_wins then
      -- Should quit, so we close all invalid windows.
      for _, w in ipairs(tree_wins) do
        vim.api.nvim_win_close(w, true)
      end
    end
  end,
})

-- Crea un autocomando que se ejecuta después de que se lea un buffer de quickfix
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "quickfix",
  callback = function()
    -- Define el mapeo <CR> en el buffer local de la ventana de quickfix
    vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<CR>", { noremap = true, silent = true })
  end,
})

-- disable spell check lazyvim
vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- -- Función para agregar líneas vacías al final del buffer
-- local function add_empty_lines_at_eob()
--   local line_count = vim.api.nvim_buf_line_count(0) -- Cuenta las líneas actuales
--   local target_line_count = line_count + 2 -- Cambia el número 2 a cuantas líneas extras quieras
--
--   -- Agrega líneas vacías si el número de líneas es menor que el objetivo
--   if vim.api.nvim_buf_get_lines(0, line_count - 1, line_count, false)[1] ~= "" then
--     vim.api.nvim_buf_set_lines(0, line_count, line_count, false, { "", "" })
--   end
-- end
--
-- -- Comando autocomando para agregar líneas vacías al abrir buffers
-- vim.api.nvim_create_autocmd("BufReadPost", {
--   callback = add_empty_lines_at_eob,
-- })
