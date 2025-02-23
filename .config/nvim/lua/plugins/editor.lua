return {
  { "folke/flash.nvim", enabled = false },
  { "echasnovski/mini.pairs", enabled = false },
  {
    -- lo malo de este plugin es que no muestra el numero de linea
    -- osea que dificulta hacer el jx kx (j10, j4, k2) para moverse
    -- exatamente en la linea que queremos
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    opts = {
      window = {
        mappings = {
          -- ["a"] = {
          --   "add",
          --   -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
          --   -- some commands may take optional config options, see `:h neo-tree-mappings` for details
          --   config = {
          --     show_path = "relative", -- "none", "relative", "absolute"
          --   },
          -- },
          -- ["a"] = function(state)
          --   local cc = require("neo-tree.sources.common.commands")
          --   local fs = require("neo-tree.sources.filesystem")
          --   local utils = require("neo-tree.utils")
          --
          --   -- Print contents of `tbl`, with indentation.
          --   -- `indent` sets the initial level of indentation.
          --   function tprint(tbl, indent)
          --     if not indent then
          --       indent = 0
          --     end
          --     for k, v in pairs(tbl) do
          --       formatting = string.rep("  ", indent) .. k .. ": "
          --       if type(v) == "table" then
          --         print(formatting)
          --         tprint(v, indent + 1)
          --       elseif type(v) == "boolean" then
          --         print(formatting .. tostring(v))
          --       else
          --         print(formatting .. v)
          --       end
          --     end
          --   end
          --
          --   cc.add(state, utils.wrap(fs.show_new_children, state))
          --
          --   tprint(state, 2)
          --
          -- ---Gets the node parent folder
          -- ---@param s table to look for nodes
          -- ---@return table? node
          -- local function get_folder_node(s)
          --   local tree = s.tree
          --   local node = tree:get_node()
          --   local last_id = node:get_id()
          --
          --   while node do
          --     local insert_as_local = s.config.insert_as
          --     local insert_as_global = require("neo-tree").config.window.insert_as
          --     local use_parent
          --     if insert_as_local then
          --       use_parent = insert_as_local == "sibling"
          --     else
          --       use_parent = insert_as_global == "sibling"
          --     end
          --
          --     local is_open_dir = node.type == "directory" and (node:is_expanded() or node.empty_expanded)
          --     if use_parent and not is_open_dir then
          --       return tree:get_node(node:get_parent_id())
          --     end
          --
          --     if node.type == "directory" then
          --       return node
          --     end
          --
          --     local parent_id = node:get_parent_id()
          --     if not parent_id or parent_id == last_id then
          --       return node
          --     else
          --       last_id = parent_id
          --       node = tree:get_node(parent_id)
          --     end
          --   end
          -- end
          --
          -- local node = get_folder_node(state)
          -- local in_directory = node:get_id()
          -- print(node)
          -- print(in_directory)
          -- local using_root_directory = get_using_root_directory(state)
          -- fs_actions.create_node(in_directory, callback, using_root_directory)
          -- end,
        },
      },
      filesystem = {
        root_config = {
          use_git = 0,
        },
        filtered_items = {
          -- visible = true,
          -- hide_dotfiles = false,
          -- hide_gitignored = true,
        },
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every time
          --               -- the current file is changed while the tree is open.
          leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
      },
    },
    enabled = false,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      view = {
        cursorline = true,
        width = 30,
        relativenumber = true,
        signcolumn = "no",
      },
      renderer = {
        indent_width = 1,
        icons = {
          web_devicons = {
            folder = {
              enable = true,
              color = true,
            },
          },
          git_placement = "signcolumn",
          modified_placement = "after",
          diagnostics_placement = "after",
          bookmarks_placement = "signcolumn",
          glyphs = {
            git = {
              untracked = "",
              ignored = "",
              unstaged = "✱", --✱
              staged = "", -- "✚",
              unmerged = "",
              renamed = "➜",
              deleted = "✖",
            },
          },
        },
      },
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        git_ignored = false,
      },
      update_focused_file = {
        enable = true,
      },
      diagnostics = { enable = true },
      modified = { enable = true },
    },
    config = function(_, opts)
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      local keymap = vim.keymap
      keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
      keymap.set(
        "n",
        "<leader>ef",
        "<cmd>NvimTreeFindFileToggle<CR>",
        { desc = "Toggle file explorer on current file" }
      )
      keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
      keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })

      require("nvim-tree").setup(opts)
    end,
    enabled = false,
  },
  {
    "lewis6991/gitsigns.nvim",
    enabled = true,
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "|" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      numhl = true,
      max_file_length = 10000,
      current_line_blame = true,
      word_diff = false,
      current_line_blame_opts = {
        virt_text = true,
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    },
    keys = {
      { "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>", desc = "Hunk Preview" },
      { "<leader>hi", "<cmd>Gitsigns preview_hunk_inline<CR>", desc = "Hunk Preview Inline" },
      { "<leader>hd", "<cmd>Gitsigns toggle_deleted<CR>", desc = "Hunk Toggle Deleted" },
      { "<leader>hw", "<cmd>Gitsigns toggle_word_diff<CR>", desc = "Toggle word diff" },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      local action_state = require("telescope.actions.state")
      local actions = require("telescope.actions")

      local focus_preview = function(prompt_bufnr)
        local picker = action_state.get_current_picker(prompt_bufnr)
        local prompt_win = picker.prompt_win
        local previewer = picker.previewer
        local winid = previewer.state.winid
        local bufnr = previewer.state.bufnr
        vim.keymap.set("n", "<S-Tab>", function()
          vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", prompt_win))
        end, { buffer = bufnr })
        vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", winid))
        -- api.nvim_set_current_win(winid)
      end

      require("telescope").setup({
        defaults = {
          layout_strategy = "bottom_pane",
          border = true,
          layout_config = {
            width = vim.o.columns,
            prompt_position = "bottom",
          },
          borderchars = {
            prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            results = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          },
          -- prompt_title = "",
          -- results_title = "",
          -- preview_title = "",
          mappings = {
            i = {
              ["<S-Tab>"] = focus_preview,
              ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            },
            n = {
              ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            },
          },
        },
      })
    end,
    keys = {
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files({
            hidden = true,
            no_ignore = true,
            file_ignore_patterns = { "node%_modules/.*", ".next/.*", ".git/.*", ".husky/.*" },
          })
        end,
        desc = "Find All Files (root dir)",
      },
      {
        "<leader>fc",
        function()
          require("telescope").extensions.file_browser.file_browser()
        end,
      },
      {
        "<leader><leader>",
        function()
          require("telescope").extensions.file_browser.file_browser({
            path = "%:p:h",
            select_buffer = true, -- init telescope with current
            -- buffer selected
          })
        end,
      },

      {
        "<leader>fd", -- Nuevo mapeo para buscar archivos y carpetas con preview
        function()
          require("telescope.pickers")
            .new({}, {
              prompt_title = "Find Files and Directories",
              finder = require("telescope.finders").new_oneshot_job({
                "fdfind",
                "--type",
                "f",
                "--type",
                "d",
                "--hidden",
                "--exclude",
                ".git",
              }, {}),
              sorter = require("telescope.config").values.generic_sorter({}),
              previewer = require("telescope.previewers").new_termopen_previewer({
                get_command = function(entry)
                  local path = entry.path or entry[1]
                  -- Si es un directorio, usa `tree`, si es un archivo, usa `cat`
                  local lfs = vim.loop.fs_stat(path)
                  if lfs and lfs.type == "directory" then
                    return { "tree", "-C", "--noreport", "-L", "2", path }
                  else
                    return { "cat", path }
                  end
                end,
              }),
              attach_mappings = function(_, map)
                map("i", "<CR>", function(prompt_bufnr)
                  local action_state = require("telescope.actions.state")
                  local actions = require("telescope.actions")
                  local entry = action_state.get_selected_entry()
                  local path = entry[1] -- Obtén la ruta seleccionada

                  actions.close(prompt_bufnr) -- Cierra Telescope

                  local lfs = vim.loop.fs_stat(path)
                  if lfs and lfs.type == "directory" then
                    require("oil").open(path) -- Abre carpetas con Oil
                  else
                    vim.cmd("edit " .. vim.fn.fnameescape(path)) -- Abre archivos en el buffer actual
                  end
                end)
                return true
              end,
            })
            :find()
        end,
        desc = "Find Files and Directories (with Oil and Tree Preview)",
      },
      -- {
      --   "<leader>fd", -- Nuevo mapeo para buscar carpetas con fdfind y mostrar preview
      --   function()
      --     require("telescope.pickers")
      --       .new({}, {
      --         prompt_title = "Find Directories",
      --         finder = require("telescope.finders").new_oneshot_job({
      --           "fdfind",
      --           "--type",
      --           "d",
      --           "--hidden",
      --           "--exclude",
      --           ".git",
      --         }, {}),
      --         sorter = require("telescope.config").values.generic_sorter({}),
      --         previewer = require("telescope.previewers").new_termopen_previewer({
      --           get_command = function(entry)
      --             return { "tree", "-C", "--noreport", "-L", "1", entry.path or entry[1] }
      --           end,
      --         }),
      --         attach_mappings = function(_, map)
      --           map("i", "<CR>", function(prompt_bufnr)
      --             local action_state = require("telescope.actions.state")
      --             local actions = require("telescope.actions")
      --             local entry = action_state.get_selected_entry()
      --             local path = entry[1] -- Obtén la ruta del directorio
      --
      --             actions.close(prompt_bufnr) -- Cierra Telescope
      --             require("oil").open(path) -- Abre la carpeta con Oil
      --           end)
      --           return true
      --         end,
      --       })
      --       :find()
      --   end,
      --   desc = "Find Directories (with Oil and Tree Preview)",
      -- },
    },
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "petertriho/nvim-scrollbar",
    config = false,
  },
  {
    "Bekaboo/deadcolumn.nvim",
    config = function()
      vim.opt.colorcolumn = "100"
      require("deadcolumn").setup({
        modes = { "i", "ic", "ix", "R", "Rc", "Rx", "Rv", "Rvc", "Rvx", "n" },
        scope = "line",
      })
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>G", "<cmd>LazyGit<cr>", desc = "Open lazy git" },
    },
  },
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = true,
      cleanup_delay_ms = nil,
      buf_options = {
        buflisted = true,
        -- buftype = "",
        bufhidden = "hide",
      },
      restore_buffers = true,
      win_options = {
        winbar = "%{v:lua.require('oil').get_current_dir()}",
      },
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["|"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
        ["-"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
        -- ["<Space><Tab>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-r>"] = "actions.refresh",
        ["<Backspace>"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory", mode = "n" },
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },
      use_default_keymaps = false,

      view_options = {
        show_hidden = true,
      },
    },
    -- config = function(opts)
    --   local keymap = vim.keymap
    --   keymap.set("n", "<leader>e", "<cmd>vsplit | Oil<CR>", { desc = "Open Oil" })
    --   require("oil").setup(opts)
    -- end,
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    keys = {
      {
        "<leader>ee",
        "<cmd>Oil<CR>",
        desc = "Open Oil",
      },
      {
        "<leader>e<tab>",
        "<cmd>tabnew +Oil<CR>",
        desc = "Open Oil",
      },
      {
        "<leader>e|",
        -- vert vs vsplit ??
        "<cmd>vsplit +Oil<CR>",
        desc = "Open Oil",
      },
      {
        "<leader>e-",
        "<cmd>split +Oil<CR>",
        desc = "Open Oil",
      },
    },
  },
  -- {
  --   "dosimple/workspace.vim",
  -- },
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      -- add options here
      -- or leave it empty to use the default settings
    },
    keys = {
      { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
  },
  {
    "junegunn/vim-easy-align",
  },
}
