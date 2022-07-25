local M = {}

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = true, -- adds help for operators like d, y, ...
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
		spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	window = {
		border = "single", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
	},
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
}

local leader = {
	mappings = {
		["<space>"] = { "<cmd>lua require('telescope.builtin').buffers { sort_lastused = true}<CR>", "Buffers" },
		["<C-space>"] = { "<cmd>lua require('telescope.builtin').resume()<CR>", "Last Search" },
		p = {
			name = "Packer",
			C = { "<cmd>PackerClean<CR>", "Packer Clean" },
			S = { "<cmd>PackerStatus<CR>", "Packer Status" },
			c = { "<cmd>PackerCompile<CR>", "Packer Compile" },
			i = { "<cmd>PackerInstall<CR>", "Packer Install" },
			s = { "<cmd>PackerSync<CR>", "Packer Sync" },
			u = { "<cmd>PackerUpdate<CR>", "Packer Update" },
		},
		s = {
			-- Telescope
			name = "Search",
			b = { "<cmd>lua require('telescope.builtin').buffers { sort_lastused = true }<CR>", "Buffers" },
			c = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", "In current buffer" },
			f = { "<cmd>lua require('telescope.builtin').find_files()<CR>", "Files" },
			F = { "<cmd>lua require('telescope.builtin').find_files { hidden = true }<CR>", "All files" },
			g = { "<cmd>lua require('telescope.builtin').live_grep({ prompt_prefix='🔍 ' })<CR>", "Grep" },
			l = { "<cmd>lua require('telescope.builtin').resume()<CR>", "Last Search" },
			L = { "<cmd>lua require('telescope.builtin').search_history()<CR>", "Last Searches" },
			m = { "<cmd>lua require('telescope.builtin').marks()<CR>", "Marks list" },
			q = { "<cmd>lua require('telescope.builtin').quickfix()<CR>", "Quickfix list" },
			Q = { "<cmd>lua require('telescope.builtin').loclist()<CR>", "Location list" },
			r = { "<cmd>lua require('telescope.builtin').registers()<CR>", "Registers" },
			o = { "<cmd>lua require('telescope.builtin').oldfiles()<CR>", "Recent files" },
			s = {
				"<cmd>lua require('telescope.builtin').grep_string({ prompt_prefix='🔍 ' })<CR>",
				"Grep under cursor",
			},
			y = {
				"<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>",
				"Document Symbols",
			},
			t = { "<cmd>lua require('telescope.builtin').tags()<CR>", "Tags" },
			T = {
				"<cmd>lua require('telescope.builtin').tags { only_current_buffer = true }<CR>",
				"Tags in current buffer",
			},
			[";"] = { "<cmd>lua require('telescope.builtin').colorscheme()<CR>", "Color Schemes" },
			["+"] = { "<cmd>lua require('telescope.builtin').pickers()<CR>", "More Pickers" },
			["?"] = { "<cmd>lua require('telescope.builtin').help_tags()<CR>", "Help tags" },
			["/"] = { "<cmd>lua require('telescope.builtin').man_pages()<CR>", "Man pages" },
		},
		l = {
			-- Most are set in lsp.lua
			name = "LSP",
			a = { "<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>", "Code Action" },
			d = { "Go to definition" },
			D = { "Go to declaration" },
			e = { "Show diagnostics" },
			f = { "Format buffer" },
			i = { "Go to implementation" },
			I = { "<cmd>LspInstallInfo<CR>", "Installer Info" },
			l = { "Diagnostics list" },
			p = { "Preview definition" },
			r = { "Rename" },
			R = { "<cmd>lua require('telescope.builtin').lsp_references()<CR>", "List References" },
			s = { "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", "Document Symbols" },
			S = { "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>", "Workspace Symbols" },
			w = {
				name = "Workspace",
				a = { "Add workspace" },
				d = { "Delete workspace" },
				l = { "List workspaces" },
			},
			t = {
				name = "Trouble",
				t = { "<cmd>Trouble<cr>", "Toggle" },
				w = { "<cmd>Trouble workspace_diagnostics<cr>", "Toggle Workspace diagnostics" },
				d = { "<cmd>Trouble workspace_diagnostics<cr>", "Toggle Document diagnostics" },
				l = { "<cmd>Trouble loclist<cr>", "Toggle Loclist" },
				q = { "<cmd>Trouble quickfix<cr>", "Toggle Quickfix" },
				r = { "<cmd>Trouble lsp_references<cr>", "Toggle References" },
			},
		},
		g = {
			name = "Git",
			g = { "<cmd>Git<CR>", "Open Fugitive" },
			b = { "Blame line" },
			o = { "<cmd>lua require('telescope.builtin').git_status<CR>", "Open changed file" },
			B = { "<cmd>lua require('telescope.builtin').git_branches<CR>", "Checkout branch" },
			c = { "<cmd>lua require('telescope.builtin').git_commits<CR>", "Checkout commit" },
			C = { "<cmd>lua require('telescope.builtin').git_bcommits<CR>", "Checkout commit (for current file)" },
			h = {
				name = "Hunk",
				s = { "Stage hunk" },
				u = { "Undo stage hunk" },
				r = { "Reset hunk" },
				R = { "Reset buffer" },
				p = { "Preview hunk" },
				S = { "Stage buffer" },
				U = { "Reset buffer index" },
			},
		},
		f = {
			name = "File Tree",
			t = { "<cmd>NvimTreeToggle<CR>", "Toggle file tree" },
			r = { "<cmd>NvimTreeRefresh<CR>", "Refresh file tree" },
			f = { "<cmd>NvimTreeFindFile<CR>", "Find file in tree" },
		},
		t = {
			name = "Terminal",
			f = { "<cmd>ToggleTerm direction=float<CR>", "Float" },
			h = { "<cmd>ToggleTerm size=10 direction=horizontal<CR>", "Horizontal" },
			v = { "<cmd>ToggleTerm size=80 direction=vertical<CR>", "Vertical" },
		},
	},
	opts = {
		mode = "n", -- NORMAL mode
		prefix = "<leader>",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = true, -- use `nowait` when creating keymaps
	},
}

-- Vim Unimpaired, Vim abolish, LSP, Gitsigns bindings
local other = {
	mappings = {
		["z="] = { "<cmd>lua require('telescope.builtin').spell_suggest()<CR>", "Spelling" },
		["<C-p>"] = { "<cmd>lua require('telescope.builtin').find_files()<CR>", "Find File" },
		[">p"] = { "Paste below and increase indent" },
		[">P"] = { "Paste above and increase indent" },
		["<p"] = { "Paste below and reduce indent" },
		["<P"] = { "Paste above and reduce indent" },
		["=p"] = { "Paste below and reindent" },
		["=P"] = { "Paste above and reindent" },
		["["] = {
			["<space>"] = { "Add [count] blank lines above" },
			a = { "Previous file" },
			A = { "First file" },
			b = { "Previous buffer" },
			B = { "First buffer" },
			l = { "Previous location list" },
			L = { "First location list" },
			["<C-L>"] = { "Previous file location list" },
			q = { "Previous Quick fix list" },
			Q = { "First Quick fix list" },
			["<C-Q>"] = { "Previous file Quick fix list" },
			t = { "Previous tag" },
			T = { "First tag" },
			["<C-T>"] = { "Previous tag preview" },
			e = { "Exchange line above [count]" },
			p = { "Paste above" },
			P = { "Paste above" },
			x = { "XML encode" },
			u = { "Url encode" },
			y = { "C String encode" },
			C = { "C string encode" },
			o = {
				name = "+enable",
				t = { "<cmd>TransparentEnable<CR>", "background transparency" },
				b = { "background dark" },
				c = { "cursorline" },
				d = { "diff" },
				h = { "hlsearch" },
				i = { "ignorecase" },
				l = { "list" },
				n = { "number" },
				r = { "relativenumber" },
				s = { "spell" },
				u = { "cursorcolumn" },
				v = { "virtualedit" },
				w = { "wrap" },
				x = { "cursorline & cursorcolumn" },
			},
			-- Gitsigns
			c = { "Previous SCM hunk" },
			f = { "Previous file in directory" },
			n = { "Previous SCM conflict" },
			d = { "Previous diagnostic" },
			-- treesitter
			r = { "Swap previous parameter" },
			m = { "Previous outer function start" },
			M = { "Previous outer function end" },
			["]"] = { "Previous outer class start" },
			["["] = { "Previous outer class end" },
		},
		["]"] = {
			["<space>"] = { "Add [count] blank lines below" },
			a = { "Next file" },
			A = { "Last file" },
			b = { "Next buffer" },
			B = { "Last buffer" },
			l = { "Next location list" },
			L = { "Last location list" },
			["<C-L>"] = { "Next file location list" },
			q = { "Next Quick fix list" },
			Q = { "Last Quick fix list" },
			["<C-Q>"] = { "Next file Quick fix list" },
			t = { "Next tag" },
			T = { "Last tag" },
			["<C-T>"] = { "Next tag preview" },
			e = { "Exchange line below [count]" },
			p = { "Paste below" },
			P = { "Paste below" },
			x = { "XML decode" },
			u = { "Url decode" },
			y = { "C string decode" },
			C = { "C string decode" },
			o = {
				name = "+disable",
				t = { "<cmd>TransparentDisable<CR>", "background transparency" },
				b = { "background light" },
				c = { "cursorline" },
				d = { "diff" },
				h = { "hlsearch" },
				i = { "ignorecase" },
				l = { "list" },
				n = { "number" },
				r = { "relativenumber" },
				s = { "spell" },
				u = { "cursorcolumn" },
				v = { "virtualedit" },
				w = { "wrap" },
				x = { "cursorline & cursorcolumn" },
			},
			-- Gitsigns
			c = { "Next SCM hunk" },
			f = { "Next file in directory" },
			n = { "Next SCM conflict" },
			d = { "Next diagnostic" },
			-- Treesitter
			r = { "Swap next parameter" },
			m = { "Next outer function start" },
			M = { "Next outer function end" },
			["]"] = { "Next outer class start" },
			["["] = { "Next outer class end" },
		},
		["y"] = {
			o = {
				name = "+toggle",
				t = { "<cmd>TransparentToggle<CR>", "background transparency" },
				b = { "dark mode" },
				c = { "cursorline" },
				d = { "diff" },
				h = { "hlsearch" },
				i = { "ignorecase" },
				l = { "list" },
				n = { "number" },
				q = { "<cmd>lua require('qf').toggle('c')<CR>", "Quickfix" },
				Q = { "<cmd>lua require('qf').toggle('l')<CR>", "Location List" },
				r = { "relativenumber" },
				s = { "spell" },
				u = { "cursorcolumn" },
				v = { "virtualedit" },
				w = { "wrap" },
				x = { "cursorline & cursorcolumn" },
				g = {
					name = "+git signs",
					b = { ":Gitsigns toggle_current_line_blame<CR>", "Toggle Inline Blame" },
					g = { ":Gitsigns toggle_signs<CR>", "Toggle Column Signs" },
					n = { ":Gitsigns toggle_numhl<CR>", "Toggle Line Number Highlight" },
					l = { ":Gitsigns toggle_linehl<CR>", "Toggle Line Highlight" },
					w = { ":Gitsigns toggle_word_diff<CR>", "Toggle Word Diff" },
				},
			},
		},
		-- vim-sandwich
		["ds"] = { "delete surrounding" },
		["cs"] = { "change surrounding" },
		["ys"] = {
			name = "add surrounding",
			s = "line",
		},
		["yS"] = { "add surrounding to line end" },
		-- vim-abolish
		["c"] = {
			r = {
				name = "Coercion",
				c = { "to camelCase" },
				m = { "to MixedCase" },
				s = { "to snake_case" },
				t = { "to TitleCase" },
				u = { "to UPPER_CASE" },
				["-"] = { "to dash-case" },
				["."] = { "to dot.case" },
				["<space>"] = { "to space case" },
			},
		},
	},
	opts = {
		silent = true,
		noremap = true,
		nowait = true,
	},
}

local visual = {
	mappings = {
		-- treesitter
		["aC"] = { "conditional" },
		["ac"] = { "class" },
		["af"] = { "function" },
		["iC"] = { "conditional" },
		["ic"] = { "class" },
		["if"] = { "function" },
		-- Matchup
		["a%"] = { "block" },
		["i%"] = { "block" },
		-- Sandwich
		["S"] = { "surround" },
	},
	opts = {
		mode = "v", -- NORMAL mode
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = true, -- use `nowait` when creating keymaps
	},
}

function M.setup()
	local wk_exists, wk = pcall(require, "which-key")

	if not wk_exists then
		return
	end

	wk.setup(setup)
	wk.register(leader.mappings, leader.opts)
	wk.register(other.mappings, other.opts)
	wk.register(visual.mappings, visual.opts)
end

return M
