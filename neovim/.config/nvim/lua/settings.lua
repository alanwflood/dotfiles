-- bash is way faster than using fish for vim
vim.opt.shell = "/bin/bash"

-- spaces per tab
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- spaces per tab (when shifting)
vim.opt.shiftwidth = 2

-- always use spaces instead of tabs
vim.opt.expandtab = true

-- don't bother updating screen during macro playback
vim.opt.lazyredraw = true

-- show trailing whitespace
vim.opt.list = true
vim.opt.listchars = {
	tab = "………",
	nbsp = "░",
	extends = "»",
	precedes = "«",
	trail = "·",
}

vim.opt.ruler = true

--Set highlight on search
vim.o.hlsearch = false

--Make line numbers default
vim.wo.number = true

--Enable mouse mode
vim.o.mouse = "a"

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 2
vim.o.background = "dark" -- or "light" for light mode

local colorscheme = "gruvbox"
vim.api.nvim_command(("colorscheme %s"):format(colorscheme))
vim.g.transparent_enabled = true

--Remap space as leader key
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Highlight on yank
vim.api.nvim_exec(
	[[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
	false
)

-- Sets :vimgrep to use ripgrep
vim.opt.grepprg = "rg --hidden --vimgrep --smart-case --"
