local M = {}

function M.setup()
	local treesitter = require("nvim-treesitter.configs")

	treesitter.setup({
		auto_install = true,
		ensure_installed = {
			"bash",
			"comment",
			"css",
			"cpp",
			"dockerfile",
			"embedded_template", -- ERB, EJS, etc…
			"fish",
			"gitignore",
			"go",
			"html",
			"java",
			"javascript",
			"jsdoc",
			"json",
			"json5",
			"jsonc",
			"lua",
			"make",
			"markdown",
			"markdown_inline",
			"python",
			"regex",
			"rust",
			"tsx",
			"typescript",
			"vue",
			"vim",
			"yaml",
		},
		matchup = { enable = true },
		rainbow = {
			enable = false,
			extended_mode = true,
			max_file_lines = 1000,
		},
		autopairs = { enable = true },
		highlight = {
			enable = true, -- false will disable the whole extension
			additional_vim_regex_highlighting = true,
		},
		indent = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<CR>",
				scope_incremental = "<CR>",
				node_incremental = "<TAB>",
				node_decremental = "<S-TAB>",
			},
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
					["aC"] = "@conditional.outer",
					["iC"] = "@conditional.inner",
				},
			},
			swap = {
				enable = true,
				swap_next = {
					["]r"] = "@parameter.inner",
				},
				swap_previous = {
					["[r"] = "@parameter.inner",
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]m"] = "@function.outer",
					["]]"] = "@class.outer",
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]["] = "@class.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[["] = "@class.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[]"] = "@class.outer",
				},
			},
		},
	})
end

return M
