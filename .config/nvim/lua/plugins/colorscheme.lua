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
      style = "day",
      transparent = false,
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
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "tokyonight-night",
      -- colorscheme = "gruvbox",
      colorscheme = "solarized-osaka",
      -- colorscheme = "catppuccin-mocha",
    },
  },
}
