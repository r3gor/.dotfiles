return {
  {
    "craftzdog/solarized-osaka.nvim",
    branch = "osaka",
    lazy = true,
    priority = 1000,
    opts = function()
      return {
        transparent = false,
        --- You can override specific color groups to use other groups or a hex color
        --- function will be called with a ColorScheme table
        ---@param colors ColorScheme
        on_colors = function(colors)
          colors.bg = "#101010"
        end,
      }
    end,
    enabled = true,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      style = "moon",
      transparent = true,
      on_colors = function(colors)
        colors.border = "#737aa2"
        colors.bg_visual = "#123456"
        colors.bg = "#15151e"
        colors.bg_dark = "#0a0b0f"
        colors.bg_float = "#0a0b0f"
        colors.bg_popup = "#0a0b0f"
        colors.bg_sidebar = "#0a0b0f"
        colors.bg_statusline = "#0a0b0f"
        -- colors.bg = "#1a1b26" -- default
        -- colors.bg = "#000000"
        -- colors.bg_visual = "#0041c2"
      end,
      on_highlights = function(highlights, colors)
        highlights.EndOfBuffer = { fg = "#606060" }
      end,
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    enabled = true,
    opts = {
      color_overrides = {
        mocha = {
          base = "#101010",
          mantle = "#000000",
          crust = "#000000",
        },
      },
    },
  },
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      contrast = "hard",
      dim_inactive = false,
      transparent_mode = true,
      overrides = {
        -- SignColumn = {bg = "#ff9900"},
        -- WinSeparator = { fg = "#3e4a5b", bg = "#282c34" },
        WinSeparator = { fg = "#282c34", bg = "#282c34" },
      },
    },
  },
  {
    "EdenEast/nightfox.nvim",
    opts = {
      options = {
        -- transparent = true,
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "italic,bold",
        },
      },
      groups = {
        nightfox = {
          EndOfBuffer = { fg = "#3e4a5b" },
          -- WinSeparator = { fg = "#3e4a5b", bg = "#282c34" },
          -- WinSeparator = { fg = "#282c34", bg = "#282c34" },
          WinSeparator = { fg = "#282c34", bg = "" },
        },
      },
    },
  },
  {
    "projekt0n/github-nvim-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("github-theme").setup({
        options = {
          transparent = true,
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "italic,bold",
          },
        },
        groups = {
          all = {
            WinSeparator = { fg = "#303037" },
            EndOfBuffer = { fg = "#3e4a5b" },
            TreesitterContextSeparator = { fg = "#4d4d4d" },
            NoicePopupBorder = { fg = "#4d4d4d" },
          },
        },
      })
      -- vim.cmd("colorscheme github_dark")
    end,
  },
  {
    "metalelf0/base16-black-metal-scheme",
    lazy = false,
    config = function()
      -- Aplicar el esquema de colores
      -- vim.cmd("colorscheme base16-black-metal")
      -- vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
      -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
      -- vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
    end,
  },
  {
    "gmr458/cold.nvim",
    lazy = false,
  },
  {
    "zenbones-theme/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = { "rktjmp/lush.nvim" },
    lazy = false,
    priority = 1000,
  },
  {
    "aktersnurra/no-clown-fiesta.nvim",
    lazy = false,
    config = function()
      require("cold").setup()
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          vim.cmd([[highlight NonText guifg=#3a3a3c]])
          vim.cmd([[highlight LineNr guifg=#cccccc]])
          vim.cmd([[highlight Visual guibg=#1a4db3]])
          -- vim.cmd("highlight CursorLineNr guifg=#ffcc00")
        end,
      })
      require("no-clown-fiesta").setup({
        transparent = true, -- Enable this to disable the bg color
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "nightfox",
      -- colorscheme = "tokyonight-night",
      -- colorscheme = "tokyonight",
      -- colorscheme = "gruvbox",
      -- colorscheme = "base16-black-metal",
      -- colorscheme = "cold",
      colorscheme = "no-clown-fiesta",
      -- colorscheme = "zenwritten",
      -- colorscheme = "solarized-osaka",
      -- colorscheme = "catppuccin-mocha",
      -- colorscheme = "github_dark",
      -- colorscheme = "github_dark_high_contrast",
      -- colorscheme = "github_dark_default",
    },
  },
}
