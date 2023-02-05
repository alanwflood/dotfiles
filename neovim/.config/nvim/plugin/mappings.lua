-- From https://bitbucket.org/sjl/dotfiles/src/tip/vim/vimrc
-- The `zzzv` keeps search matches in the middle of the window.
-- and make sure n will go forward when searching with ? or #
-- https://vi.stackexchange.com/a/2366/4600
vim.keymap.set("n", "zzzv", [[(v:searchforward ? 'n' : 'N')]], { expr = true, noremap = true })
vim.keymap.set("n", "zzzv", [[(v:searchforward ? 'N' : 'n')]], { expr = true, noremap = true })

-- Movement
-------------------

-- highlight last inserted text
vim.keymap.set("n", "gV", [[`[v`]']], {})

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Quick pane rotate
vim.keymap.set("n", "<leader>wh", "<C-w>t<C-w>K<CR>", { noremap = true })
vim.keymap.set("n", "<leader>wv", "<C-w>t<C-w>H<CR>", { noremap = true })

-- https://github.com/mhinz/vim-galore#dont-lose-selection-when-shifting-sidewards
vim.keymap.set("x", "<", "<gv", { noremap = true })
vim.keymap.set("x", ">", ">gv", { noremap = true })

-- qq to record, Q to replay
vim.keymap.set("n", "Q", "@@", { noremap = true })

-- For neovim terminal :term, escape insert mode with esc
vim.keymap.set("t", "<esc>", [["\<c-\>\<c-n>"]], { expr = true })

vim.api.nvim_create_augroup("TerminalSetup", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
	group = "TerminalSetup",
	pattern = "*",
	callback = function()
		vim.opt_local.filetype = "terminal"
		vim.opt_local.number = false
		vim.opt_local.signcolumn = "no"
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	group = "TerminalSetup",
	pattern = "term://*",
	command = "startinsert",
})

vim.api.nvim_create_autocmd("TermClose", {
	group = "TerminalSetup",
	pattern = "term://*",
	command = "stopinsert",
})

-- Allows you to visually select a section and then hit @ to run a macro on all lines
-- https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db#.3dcn9prw6
vim.cmd([[function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction]])

vim.keymap.set("x", "@", ":<C-u>call ExecuteMacroOverVisualRange()<CR>", { noremap = true })
