return {
  "tadaa/vimade",
  event = "VeryLazy",
  config = function()
    require("vimade").setup({
      fadelevel = function(style, state)
        if style.win.buf_opts.syntax == "nerdtree" then
          return 0.8
        else
          return 0.6
        end
      end,
    })
  end,
}
