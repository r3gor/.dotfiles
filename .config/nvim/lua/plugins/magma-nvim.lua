return {
  {
    "dccsillag/magma-nvim",
    build = ":UpdateRemotePlugins",
    ft = { "ipynb" },
    lazy = false,
    config = function()
      -- Configuración para el soporte de Python 3
      -- vim.g.python3_host_prog = vim.fn.exepath("python3")
      vim.g.python3_host_prog = "/home/rogrp/anaconda3/bin/python3"
      vim.g.loaded_python3_provider = nil
    end,
  },
  {
    "GCBallesteros/jupytext.nvim",
    lazy = false,
    ft = { "ipynb" },
    config = function(_, opts)
      -- Llama a la configuración predeterminada del plugin
      require("jupytext").setup(opts)

      -- Configuración adicional del intérprete de Python
      vim.g.python3_host_prog = "/home/rogrp/anaconda3/bin/python3"
      vim.g.loaded_python3_provider = nil
    end,
  },
}
