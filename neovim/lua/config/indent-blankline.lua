local M = {}

local highlight = {
	"CursorColumn",
	"Whitespace",
}

function M.setup()
	require("ibl").setup({
		indent = { highlight = highlight, char = "┊" },
		whitespace = { highlight = highlight, remove_blankline_trail = false },
		scope = { enabled = false },
		exclude = {
			filetypes = {
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
			buftypes = { "terminal", "nofile" },
		},
	})
end

return M
