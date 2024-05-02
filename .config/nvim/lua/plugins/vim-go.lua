return {
  "https://github.com/fatih/vim-go.git",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    vim.api.nvim_create_user_command("GoI", function()
      local picker = require("telescope.pickers")
      local finders = require("telescope.finders")
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      local function run_go_implements()
        return vim.fn.execute(":GoImplements")
      end

      local results = vim.split(run_go_implements(), "\n")

      picker
        .new({}, {
          prompt_title = "Go Implementations",
          -- finder = finders.new_table({
          --   results = { "reg", "reg2" },
          -- }),
          finder = finders.new_table({
            results = results,
          }),
          attach_mappings = function(_, map)
            map("i", "<cr>", function(prompt_bufrn)
              actions.close(prompt_bufrn)
              local entry = action_state.get_selected_entry()
              vim.notify(entry[1])
            end)

            return true
          end,
        })
        :find()
    end, {})
  end,
}
