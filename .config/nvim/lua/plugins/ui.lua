return {
  {
    "akinsho/bufferline.nvim",
    enabled = false,
    keys = {
      { "[b", "<cmd>BufferLineMovePrev<cr>", desc = "Move prev buffer" },
      { "]b", "<cmd>BufferLineMoveNext<cr>", desc = "Move next buffer" },
    },
    opts = {
      options = {
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "center",
          },
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "center",
          },
        },
        separator_style = "slant",
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      enabled = true,
      timeout = 10000,
      render = "wrapped-compact",
      stages = "fade_in_slide_out",
      top_down = false,
      background_colour = "#000000",
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        enabled = true,
        view = "cmdline",
        ---@type table<string, CmdlineFormat>
        format = {
          -- cmdline = { pattern = "^:", icon = "", lang = "vim", conceal = false },
          cmdline = { pattern = "^:", icon = "❯", lang = "vim", conceal = false },
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex", conceal = false },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex", conceal = false },
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash", conceal = false },
          lua = {
            pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
            icon = "",
            lang = "lua",
            conceal = false,
          },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "", conceal = false },
          input = { view = "cmdline_input", icon = "󰥻 ", conceal = false }, -- Used by input()
        },
      },
      popupmenu = {
        enabled = true,
        ---@type 'nui'|'cmp' -- con cmp hay un error de que solo funciona la primera vez
        backend = "nui",
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
  },
  {
    "b0o/incline.nvim",
    -- enabled = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    event = "BufReadPre",
    priority = 1200,
    opts = {
      -- highlight = {
      --   groups = {
      --     InclineNormal = { guibg = "#a5a02a", guifg = "#1a1a1a" },
      --     InclineNormalNC = { guifg = "#5B6E74", guibg = "#1A1B26" },
      --   },
      -- },
      -- window = { margin = { vertical = 0, horizontal = 1 } },
      hide = {
        cursorline = true,
      },
      -- render = function(props)
      --   local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
      --   if vim.bo[props.buf].modified then
      --     filename = "[+] " .. filename
      --   end
      --
      --   -- local icon, color = require("nvim-web-devicons").get_icon_color(filename)
      --   -- return { { icon, guifg = color }, { " " }, { filename } }
      --   return { {}, { " " }, { filename } }
      -- end,

      -- Version 2
      window = {
        padding = 0,
        margin = {
          horizontal = 0,
          vertical = 0,
        },
        placement = {
          -- vertical = "top",
          -- horizontal = "right",
          vertical = "bottom",
          horizontal = "right",
        },
        width = "fill",
      },
      highlight = {
        groups = {
          InclineNormal = {
            -- guifg = "#1e222a", -- Color de texto activo
            -- guibg = "#5f87af", -- Color de fondo activo
            -- guifg = "#bbc2cf", -- Color de texto inactivo
            guifg = "#fff", -- Color de texto inactivo
            guibg = "#282c34", -- Color de fondo inactivo
            gui = "bold",
          },
          InclineNormalNC = {
            guifg = "#5c6370", -- Color de texto inactivo
            guibg = "#282c34", -- Color de fondo inactivo
          },
        },
      },
      render = function(props)
        local devicons = require("nvim-web-devicons")
        local helpers = require("incline.helpers")

        local full_path = vim.api.nvim_buf_get_name(props.buf)
        local relative_path = vim.fn.fnamemodify(full_path, ":.")
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if filename == "" then
          filename = "[No Name]"
        end

        if vim.bo[props.buf].modified then
          relative_path = "[+] " .. relative_path
        end
        local ft_icon, ft_color = devicons.get_icon_color(filename)
        local modified = vim.bo[props.buf].modified

        local function get_diagnostic_label()
          local icons = { error = " ", warn = " ", info = " ", hint = "󰛨 " }
          local label = {}

          for severity, icon in pairs(icons) do
            local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
            if n > 0 then
              table.insert(label, { icon .. "" .. n .. " ", group = "DiagnosticSign" .. severity })
            end
          end
          if #label > 0 then
            -- table.insert(label, 1, { ' ┊ ' })
            table.insert(label, 1, { " | " })
          end
          return label
        end

        -- Insertar espacios para empujar los diagnósticos al final
        local padding = string.rep(" ", vim.api.nvim_win_get_width(0) - #relative_path - 20) -- Ajusta el número según el ancho disponible

        return {
          ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
          -- ft_icon and { " ", ft_icon, " " } or "",
          " ",
          { relative_path, gui = modified and "italic" or "" },
          " ",
          -- { padding }, -- Añadir padding para empujar los diagnósticos al final
          unpack(get_diagnostic_label()), -- Diagnósticos al final
        }
      end,
    },
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      local logo1 = [[
                  ______________                                
            ,===:'.,            `-._                            
                  `:.`---.__         `-._                       
                    `:.     `--.         `.                     
                      \.        `.         `.                   
              (,,(,    \.         `.   ____,-`.,                
          (,'     `/   \.   ,--.___`.'                          
      ,  ,'  ,--.  `,   \.;'         `                          
        `{D, {    \  :    \;                                    
          V,,'    /  /    //                                    
          j;;    /  ,' ,-//.    ,---.      ,                    
          \;'   /  ,' /  _  \  /  _  \   ,'/                    
                \   `'  / \  `'  / \  `.' /                     
                `.___,'   `.__,'   `.__,'                       
                                                                
                        @rogrp6                                 

      ]]

      local logo2 = [[
                                            ________
    ______________ _______ _________________ __  ___/
    __  ___/_  __ \__  __ `/__  ___/___  __ \_  __ \ 
    _  /    / /_/ /_  /_/ / _  /    __  /_/ // /_/ / 
    /_/     \____/ _\__, /  /_/     _  .___/ \____/  
                  /____/           /_/              

      ]]

      local logo4 = [[
~ reggi6 ~
      ]]

      local logo = string.rep("\n", 4) .. logo4 .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
        -- stylua: ignore
        center = {
            { action = 'lua require("persistence").load()',                      desc = " Restore Session", icon = " ", key = "s" },
            -- { action = require("lazyvim").pick.telescope("files"),               desc = " Find File",       icon = " ", key = "f" },
          -- { action = "ene | startinsert",                                        desc = " New File",        icon = " ", key = "n" },
          -- { action = "Telescope oldfiles",                                       desc = " Recent Files",    icon = " ", key = "r" },
          { action = "Telescope live_grep",                                      desc = " Find Text",       icon = " ", key = "g" },
          { action = [[lua LazyVim.telescope.config_files()()]], desc = " Config",          icon = " ", key = "c" },
          -- { action = "LazyExtras",                                               desc = " Lazy Extras",     icon = " ", key = "x" },
          -- { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l" },
          { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
        },
          footer = {},
        },
      }

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end,
  },
  {
    "karb94/neoscroll.nvim",
    opts = {
      easing_function = "quadratic",
      -- stop_eof = false,
      -- respect_scrolloff = true,
    },
    config = true,
  },
  {
    "Aasim-A/scrollEOF.nvim",
    event = { "CursorMoved", "WinScrolled" },
    opts = {
      insert_mode = true,
      floating = false,
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      -- PERF: we don't need this lualine require madness 🤷
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local icons = LazyVim.config.icons

      vim.o.laststatus = vim.g.lualine_laststatus

      local opts = {
        options = {
          theme = "auto",
          -- globalstatus = vim.o.laststatus == 3,
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter" } },
          -- component_separators = { left = "|", right = "|" },
          -- section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },

          lualine_c = {
            LazyVim.lualine.root_dir(),
            -- {
            --   "diagnostics",
            --   symbols = {
            --     error = icons.diagnostics.Error,
            --     warn = icons.diagnostics.Warn,
            --     info = icons.diagnostics.Info,
            --     hint = icons.diagnostics.Hint,
            --   },
            -- },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            -- { LazyVim.lualine.pretty_path() },
            -- { "filename", path = 1 },
          },
          lualine_x = {
        -- stylua: ignore
        {
          function() return require("noice").api.status.command.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
          color = function() return LazyVim.ui.fg("Statement") end,
        },
        -- stylua: ignore
        {
          function() return require("noice").api.status.mode.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
          color = function() return LazyVim.ui.fg("Constant") end,
        },
        -- stylua: ignore
        {
          function() return "  " .. require("dap").status() end,
          cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
          color = function() return LazyVim.ui.fg("Debug") end,
        },
        -- stylua: ignore
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = function() return LazyVim.ui.fg("Special") end,
        },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function()
              return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
              -- return vim.fn.getcwd()
            end,
          },
        },
        extensions = { "neo-tree", "lazy" },
        -- winbar = {
        --   lualine_a = {
        --     { "filename", path = 1 },
        --   },
        -- },
        -- tabline = {
        --   lualine_c = {},
        --   lualine_x = {
        --     { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        --     { "filename", path = 1 },
        --   },
        --   lualine_z = { { "tabs" }, },
        -- },
      }

      -- do not add trouble symbols if aerial is enabled
      if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
        local trouble = require("trouble")
        local symbols = trouble.statusline
          and trouble.statusline({
            mode = "symbols",
            groups = {},
            title = false,
            filter = { range = true },
            format = "{kind_icon}{symbol.name:Normal}",
            hl_group = "lualine_c_normal",
          })
        table.insert(opts.sections.lualine_c, {
          symbols and symbols.get,
          cond = symbols and symbols.has,
        })
      end

      return opts
    end,
  },
  {
    "uga-rosa/ccc.nvim",
    config = true,
  },
  {
    "folke/edgy.nvim",
    enabled = false,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    opts = function()
      local tsc = require("treesitter-context")

      LazyVim.toggle.map("<leader>ut", {
        name = "Treesitter Context",
        get = tsc.enabled,
        set = function(state)
          if state then
            tsc.enable()
          else
            tsc.disable()
          end
        end,
      })

      return {
        mode = "topline",
        separator = "-",
        trim_scope = "inner",
        max_lines = 3,
      }
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
    config = function()
      -- local highlight = {
      --   "RainbowOrange",
      --   "RainbowRed",
      --   "RainbowYellow",
      --   "RainbowBlue",
      --   "RainbowGreen",
      --   "RainbowViolet",
      --   "RainbowCyan",
      -- }
      --
      -- local hooks = require("ibl.hooks")
      -- -- create the highlight groups in the highlight setup hook, so they are reset
      -- -- every time the colorscheme changes
      -- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      --   vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
      --   vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
      --   vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
      --   vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
      --   vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
      --   vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      --   vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      -- end)

      require("ibl").setup({
        scope = {
          priority = 9999,
          highlight = { "Function", "Label" },
          show_exact_scope = false,
        },
      })
    end,
  },
  {
    "shellRaining/hlchunk.nvim",
    enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = true,
        },
      })
    end,
  },
}
