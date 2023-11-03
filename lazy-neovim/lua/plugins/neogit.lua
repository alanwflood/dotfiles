return {
  {
    "emmanueltouzery/agitator.nvim",
  },
  {
    "sindrets/diffview.nvim",
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim", -- optional
      "ibhagwan/fzf-lua", -- optional
    },
    config = function()
      require("neogit").setup({
        disable_hint = true,
        integrations = {
          telescope = true,
          diffview = true,
          fzf_lua = true,
        },
      })
    end,
  },
}
