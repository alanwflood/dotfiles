local M = {}

local signs = {
	add = { hl = "GitSignsAdd", text = "▊", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
	change = { hl = "GitSignsChange", text = "▊", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
	delete = { hl = "GitSignsDelete", text = "▊", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
	topdelete = { hl = "GitSignsDelete", text = "▊", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
	changedelete = {
		hl = "GitSignsChange",
		text = "▊",
		numhl = "GitSignsChangeNr",
		linehl = "GitSignsChangeLn",
	},
}

local keymaps = {
	["n ]c"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'" },
	["n [c"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'" },
	["n <leader>gb"] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
	["n <leader>ghs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
	["v <leader>ghs"] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
	["n <leader>ghu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
	["n <leader>ghr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
	["v <leader>ghr"] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
	["n <leader>ghR"] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
	["n <leader>ghp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
	["n <leader>ghS"] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
	["n <leader>ghU"] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',
	-- Text objects
	["o ih"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
	["x ih"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
}

function M.setup()
	local gitsigns = require("gitsigns")

	-- Gitsigns
	gitsigns.setup({
		signs = signs,
		keymaps = keymaps,
		current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
			delay = 1000,
		},
	})
end

return M
