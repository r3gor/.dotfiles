return {
  { "folke/flash.nvim", enabled = false },
  { "echasnovski/mini.pairs", enabled = false },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
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
    },
  },
}
