local action = require("telescope.actions")
local action_layout = require("telescope.actions.layout")

return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        sorting_strategy = "ascending",
        layout_strategy = "flex",
        layout_config = {
          prompt_position = "top",
        },
        mappings = {
          n = {
            ["p"] = action_layout.toggle_preview,
            ["-"] = action.delete_buffer,
          },
        },
      },
    },
  },
}
