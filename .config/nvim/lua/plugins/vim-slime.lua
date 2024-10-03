return {
  "jpalardy/vim-slime",
  config = function()
    -- let g:slime_target = "screen"
    vim.g.slime_target = "tmux"
  end,
}
