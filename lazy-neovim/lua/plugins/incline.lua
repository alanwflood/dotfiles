return {
  {
    "b0o/incline.nvim",
    config = function()
      require("incline").setup({
        hide = {
          cursorline = true,
          only_win = true,
        },
      })
    end,
  },
}
