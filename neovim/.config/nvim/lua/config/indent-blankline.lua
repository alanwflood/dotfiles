local M = {}

function M.setup()
	require("indent_blankline").setup({
		indentLine_enabled = 1,
		char = "┊",
		filetype_exclude = {
			"help",
			"terminal",
			"dashboard",
			"packer",
			"lspinfo",
			"TelescopePrompt",
			"TelescopeResults",
			"nvchad_cheatsheet",
			"",
		},
		buftype_exclude = { "terminal", "nofile" },
		show_trailing_blankline_indent = false,
		show_first_indent_level = false,
	})
end

return M
