local M = {}

function M.setup() 
  local status_ok, tmux_navigation = pcall(require, "nvim-tmux-navigation")
  if not status_ok then
    return
  end

  tmux_navigation.setup {
    keybindings = {
        left = "<C-h>",
        down = "<C-j>",
        up = "<C-k>",
        last_active = "<C-|>",
        right = "<C-l>",
        next = "<C-Space>",
    }
  }
end

return M
