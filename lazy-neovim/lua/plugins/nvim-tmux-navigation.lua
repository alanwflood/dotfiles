return {
  {
    "alexghergh/nvim-tmux-navigation",
    cond = os.getenv("TMUX"),
    event = "VeryLazy",
    config = function()
      require("nvim-tmux-navigation").setup({})
    end,
  },
}
