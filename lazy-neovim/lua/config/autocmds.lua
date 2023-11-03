-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
local has_neogit, neogit = pcall(require, "neogit")
if has_neogit then
  vim.api.nvim_create_user_command("G", function()
    neogit.open({ kind = "auto" })
  end, { bang = true, desc = "Open Neogit" })
end
