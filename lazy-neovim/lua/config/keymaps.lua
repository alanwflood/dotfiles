-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local Util = require("lazyvim.util")

local telescope_builtin = require("telescope.builtin")
map("n", "<leader>sl", telescope_builtin.resume, { desc = "Last search" })
map("n", "<leader>s/", telescope_builtin.search_history, { desc = "Last searches" })

-- nvim-tmux-navigator
local has_nvim_tmux_nav, nvim_tmux_nav = pcall(require, "nvim-tmux-navigation")
if os.getenv("TMUX") and has_nvim_tmux_nav then
  map("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
  map("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
  map("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
  map("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
  map("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
end

local has_neogit, neogit = pcall(require, "neogit")
if has_neogit then
  map("n", "<leader>gg", function()
    neogit.open({ cwd = Util.root(), kind = "auto" })
  end, { desc = "Open Neogit (root)" })
  map("n", "<leader>gG", function()
    neogit.open({ kind = "auto" })
  end, { desc = "Open Neogit (cwd)" })
end

local has_gitsigns, gitsigns = pcall(require, "gitsigns")
if has_gitsigns then
  map("n", "<leader>ghB", gitsigns.toggle_current_line_blame, { desc = "Toggle current blame line" })
end

local has_agitator, agitator = pcall(require, "agitator")
if has_agitator then
  map("n", "<leader>gt", function()
    agitator.git_time_machine({
      use_current_win = true,
    })
  end, { desc = "Open time machine" })
  map("n", "<leader>gb", agitator.git_blame_toggle, { desc = "Toggle blame view" })
end
