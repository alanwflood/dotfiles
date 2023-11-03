return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        mappings = {
          ["l"] = "open_with_window_picker",
          ["h"] = "close_node",
        },
      },
    },
    keys = {
      {
        "-",
        function()
          local Util = require("lazyvim.util")
          require("neo-tree.command").execute({ toggle = true, dir = Util.root() })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
    },
  },
}
