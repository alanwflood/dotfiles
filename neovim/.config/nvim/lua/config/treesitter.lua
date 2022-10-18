local M = {}

function M.setup()
	local treesitter = require("nvim-treesitter.configs")

	vim.wo.foldmethod = "expr"
	vim.o.foldexpr = "nvim_treesitter#foldexpr()"
	-- can be enabled directly in opened file - using 'zi' - toggle fold
	vim.wo.foldenable = false

	treesitter.setup({
	  auto_install = true,
		matchup = { enable = true },
		rainbow = {
			enable = true,
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
