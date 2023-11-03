-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local cmd = vim.api.nvim_create_user_command

local has_neogit, neogit = pcall(require, "neogit")
if has_neogit then
  cmd("G", function()
    neogit.open({ kind = "auto" })
  end, { bang = true, desc = "Open Neogit" })
end

-- Handle my most incorrect commands
local function handleCommand(command, vimCommand)
  cmd(command, function()
    vim.cmd(vimCommand)
  end, {})
end

handleCommand("WQ", "wq")
handleCommand("Wq", "wq")
handleCommand("Wqa", "wqa")
handleCommand("WQa", "wqa")
handleCommand("W", "w")
handleCommand("Q", "q")
handleCommand("Qa", "qa")

cmd("Light", function()
  vim.opt.background = "light"
end, { bang = true, desc = "set light theme" })

cmd("Dark", function()
  vim.opt.background = "dark"
end, { bang = true, desc = "set dark theme" })
