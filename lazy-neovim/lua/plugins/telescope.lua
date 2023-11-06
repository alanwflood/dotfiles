local action_layout = require("telescope.actions.layout")

return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        layout_config = {
          prompt_position = "top",
        },
        mappings = {
          n = {
            ["p"] = action_layout.toggle_preview,
          },
        },
      },
    },
  },
}
