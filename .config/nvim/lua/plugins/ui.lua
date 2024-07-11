return {
  { "lukas-reineke/indent-blankline.nvim", enabled = true },
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
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        view = "cmdline",
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
      highlight = {
        groups = {
          InclineNormal = { guibg = "#a5a02a", guifg = "#1a1a1a" },
          InclineNormalNC = { guifg = "#5B6E74", guibg = "#1A1B26" },
        },
      },
      window = { margin = { vertical = 0, horizontal = 1 } },
      hide = {
        cursorline = true,
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if vim.bo[props.buf].modified then
          filename = "[+] " .. filename
        end

        -- local icon, color = require("nvim-web-devicons").get_icon_color(filename)
        -- return { { icon, guifg = color }, { " " }, { filename } }
        return { {}, { " " }, { filename } }
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
    },
    config = true,
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
          globalstatus = vim.o.laststatus == 3,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter" } },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },

          lualine_c = {
            LazyVim.lualine.root_dir(),
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { LazyVim.lualine.pretty_path() },
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
}
