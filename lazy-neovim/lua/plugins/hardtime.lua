return {
  "m4xshen/hardtime.nvim",
  lazy = false,
  dependencies = { "MunifTanjim/nui.nvim" },
  config = {
    restriction_mode = "hint",
    disabled_keys = {
      ["<Up>"] = false,
      ["<Down>"] = false,
      ["<Left>"] = false,
      ["<Right>"] = false,
    },
    disable_mouse = false,
  },
}
