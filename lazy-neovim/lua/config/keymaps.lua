-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local Util = require("lazyvim.util")

local telescope_builtin = require("telescope.builtin")
map("n", "<leader>s/", telescope_builtin.search_history, { desc = "Last searches" })

local has_neogit, neogit = pcall(require, "neogit")
if has_neogit then
  map("n", "<leader>gg", function()
    neogit.open({ cwd = Util.root() })
  end, { desc = "Open Neogit (root)" })
  map("n", "<leader>gG", function()
    neogit.open()
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
  map("n", "<leader>gS", agitator.search_in_added, { desc = "Search in added lines" })
end
