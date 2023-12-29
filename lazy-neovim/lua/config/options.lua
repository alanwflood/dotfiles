-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

--Save undo history
vim.opt.backupdir = os.getenv("HOME") .. "/.vim/backupdir"
vim.opt.directory = os.getenv("HOME") .. "/.vim/swapdir"
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- I like having a separate clipboard for vim things
vim.opt.clipboard = ""

vim.opt.relativenumber = false

-- additional filetypes
vim.filetype.add({
  extension = {
    templ = "templ",
  },
})
