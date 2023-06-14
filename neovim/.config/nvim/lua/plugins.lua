-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

return require("packer").startup({
	function(use)
		-- Package manager
		use({ "wbthomason/packer.nvim" })

		-- Optimiser
		use({ "lewis6991/impatient.nvim" })

		use({
			"nvim-lua/plenary.nvim",
			module = "plenary",
		})

		use({
			"tweekmonster/startuptime.vim",
			cmd = "StartupTime",
		})

		use({
			"max397574/better-escape.nvim",
			event = "InsertEnter",
			config = function()
				require("better_escape").setup({
					mapping = { "jk", "jj", "kj" },
					timeout = vim.o.timeoutlen,
					clear_empty_lines = true,
					keys = "<Esc>",
				})
			end,
		})

		use({ "kyazdani42/nvim-web-devicons" })

		-- Indent detection
		use({
			"Darazaki/indent-o-matic",
			event = "BufRead",
			config = function()
				require("indent-o-matic").setup({
					max_lines = 2048,
					standard_widths = { 2, 4, 8 },
				})
			end,
		})

		-- Better buffer closing
		use({
			"famiu/bufdelete.nvim",
			cmd = { "Bdelete", "Bwipeout" },
		})

		-- Useful shortcuts for commands
		use({
			"tpope/vim-unimpaired",
			event = "VimEnter",
		})

		-- "gc" to comment visual regions/lines
		use({
			"numToStr/Comment.nvim",
			event = "BufRead",
			config = function()
				require("config.comment").setup()
			end,
		})

		-- Lots of helpers for string manipulation
		use({
			"tpope/vim-abolish",
			cmd = { "Abolish", "S", "Subvert" },
		})

		-- UI to select things (files, grep results, open buffers...)
		use({
			'nvim-telescope/telescope.nvim',
			tag = '0.1.1',
			cmd = "Telescope",
			module = "telescope",
			requires = {
				{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
				{ "debugloop/telescope-undo.nvim" },
			},
			config = function()
				require("config.telescope").setup()
			end,
		})

		-- Fancier statusline
		use({
			"nvim-lualine/lualine.nvim",
			config = function()
				require("config.statusline").setup()
			end,
		})

		-- Transparency for all!
		use({
			"xiyaowong/nvim-transparent",
			cmd = { "TransparentToggle", "TransparentEnable", "TransparentEnable" },
		})

		-- Add indentation guides even on blank lines
		use({
			"lukas-reineke/indent-blankline.nvim",
			event = "BufReadPre",
			config = function()
				require("config.indent-blankline").setup()
			end,
		})

		-- Git utils {{{
		use({
			"tpope/vim-fugitive",
			cmd = {
				"Git",
				"Gstatus",
				"Gblame",
				"Gpush",
				"Gpull",
				"Gclog",
				"G",
				"Gedit",
				"Gsplit",
				"Gdiffsplit",
				"Gvdiffsplit",
				"Ggrep",
				"Ggrep",
				"GRename",
				"GMove",
				"GRemove",
				"GDelete",
				"GBrowse",
			},
		})

		-- Git Diff View for files
		use({ "sindrets/diffview.nvim", cmd = { "DiffviewOpen" } })

		-- Add git related info in the signs columns and popups
		use({
			"lewis6991/gitsigns.nvim",
			event = "BufRead",
			config = function()
				require("config.gitsigns").setup()
			end,
		})

		use({
			"akinsho/git-conflict.nvim",
			config = function()
				require("git-conflict").setup({})
			end,
		})
		-- }}}

		-- Highlight, edit, and navigate code using a fast incremental parsing library
		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			event = "BufRead",
			cmd = {
				"TSInstall",
				"TSInstallInfo",
				"TSInstallSync",
				"TSUninstall",
				"TSUpdate",
				"TSUpdateSync",
				"TSDisableAll",
				"TSEnableAll",
			},
			config = function()
				require("config.treesitter").setup()
			end,
			requires = {
				{
					-- Additional textobjects for treesitter
					"nvim-treesitter/nvim-treesitter-textobjects",
					after = "nvim-treesitter",
				},
				{
					-- Context based commenting
					"JoosepAlviste/nvim-ts-context-commentstring",
					after = "nvim-treesitter",
				},
				-- Annotation generator
				{
					"danymat/neogen",
					config = function()
						require("neogen").setup({ snippet_engine = "luasnip" })
					end,
				},
			},
		})

		use({
			"echasnovski/mini.hipatterns",
			config = function()
				local hipatterns = require("mini.hipatterns")
				hipatterns.setup({
					highlighters = {
						fixme = {
							pattern = "%f[%w]()FIXME()%f[%W]",
							group = "MiniHipatternsFixme",
						},
						bug = {
							pattern = "%f[%w]()BUG()%f[%W]",
							group = "MiniHipatternsFixme",
						},
						hack = {
							pattern = "%f[%w]()HACK()%f[%W]",
							group = "MiniHipatternsHack",
						},
						todo = {
							pattern = "%f[%w]()TODO()%f[%W]",
							group = "MiniHipatternsTodo",
						},
						note = {
							pattern = "%f[%w]()NOTE()%f[%W]",
							group = "MiniHipatternsNote",
						},

						-- Highlight hex color strings (`#rrggbb`) using that color
						hex_color = hipatterns.gen_highlighter.hex_color(),
					},
				})
			end,
		})

		-- Better Quick Fix window
		use({ "kevinhwang91/nvim-bqf", ft = "qf" })
		use({
			"ten3roberts/qf.nvim",
			config = function()
				require("qf").setup({})
			end,
		})
		use({
			"folke/trouble.nvim",
			cmd = 'Trouble',
			config = function()
				require("trouble").setup()
			end,
		})

		-- Collection of configurations for built-in LSP client
		use({
			"neovim/nvim-lspconfig",
			requires = {
				-- LSP Installer
				{
					"williamboman/mason.nvim",
					config = function()
						require("mason").setup()
					end,
				},
				-- Bridges Mason with LSP config
				{
					"williamboman/mason-lspconfig.nvim",
					config = function()
						require("mason-lspconfig").setup()
					end,
				},
				-- LSP loading status
				{
					"j-hui/fidget.nvim",
					config = function()
						require("fidget").setup({
							window = {
								relative = "editor", -- where to anchor the window, either `"win"` or `"editor"`
								blend = 0, -- `&winblend` for the window
							},
							text = {
								spinner = "dots",
							},
						})
					end,
				},
				{
					"folke/neodev.nvim",
					config = function()
						require("neodev").setup()
					end,
				},
				"jose-elias-alvarez/null-ls.nvim",
				{
					"jayp0521/mason-null-ls.nvim",
					config = function()
						require("config.null-ls").setup()
					end,
				},
				-- LSP enhancer
				{
					"tami5/lspsaga.nvim",
					event = "BufRead",
					config = function()
						require("config.lspsaga").config()
					end,
				},
				-- JSON Schemas
				{ "b0o/SchemaStore.nvim" },
			},
		})

		-- Better LSP hover windows
		use({
			"Fildo7525/pretty_hover",
			config = function()
				require("pretty_hover").setup()
			end,
		})

		-- Installs snippets for multiple languages
		use({
			"rafamadriz/friendly-snippets",
			module = { "cmp", "cmp_nvim_lsp" },
			event = "InsertEnter",
		})

		-- Snippets plugin
		use({
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			tag = "v<CurrentMajor>.*",
			-- install jsregexp (optional!:).
			run = "make install_jsregexp",
			config = function()
				require("luasnip.loaders.from_lua").lazy_load()
				require("luasnip.loaders.from_vscode").lazy_load()
				require("luasnip.loaders.from_snipmate").lazy_load()
			end,
			wants = "friendly-snippets",
			after = "nvim-cmp",
		})

		-- Autocompletion plugin
		use({
			"hrsh7th/nvim-cmp",
			config = function()
				require("config.completion").setup()
			end,
			requires = {
				{ "andersevenrud/cmp-tmux" },
				{ "f3fora/cmp-spell" },
				{ "hrsh7th/cmp-buffer" },
				{ "hrsh7th/cmp-calc" },
				{ "hrsh7th/cmp-cmdline" },
				{ "hrsh7th/cmp-emoji" },
				{ "hrsh7th/cmp-nvim-lsp" },
				{ "hrsh7th/cmp-nvim-lsp-signature-help" },
				{ "hrsh7th/cmp-path" },
				{ "onsails/lspkind-nvim" },
				{ "saadparwaiz1/cmp_luasnip", after = "LuaSnip" },
				{ "tzachar/cmp-tabnine", run = "./install.sh" },
			},
		})

		-- Auto closes elements
		use({
			"windwp/nvim-autopairs",
			after = "nvim-cmp",
			config = function()
				require("config.autopairs").setup()
			end,
		})

		use({
			"editorconfig/editorconfig-vim",
			config = function()
				vim.g.EditorConfig_exclude_patterns = { "fugitive://.*", "scp://.*" }
			end,
		})

		-- Surround plugins
		use({
			"echasnovski/mini.surround",
			config = function()
				require("mini.surround").setup()
			end,
		})

		-- Make nvim easier to use inside tmux
		use({
			"christoomey/vim-tmux-navigator",
			opt = true,
			cond = function()
				return vim.env.TMUX ~= nil
			end,
			config = function()
				require("config.nvim-tmux-navigation").setup()
			end,
		})

		-- Bufferline
		use({
			"akinsho/bufferline.nvim",
			config = function()
				require("bufferline").setup({
					options = {
						mode = "tabs",
						separator_style = "thick",
						always_show_bufferline = false,
					},
				})
			end,
		})

		-- Show buffer names by each window
		use({
			"b0o/incline.nvim",
			config = function()
				require("incline").setup({
					hide = {
						cursorline = true,
						only_win = true,
					},
				})
			end,
		})

		use({
			"kyazdani42/nvim-tree.lua",
			config = function()
				require("config.nvim-tree").setup()
			end,
		})

		-- Time tracking files
		use({
			"wakatime/vim-wakatime",
			event = "VimEnter",
		})

		-- emacs style which key
		use({
			"folke/which-key.nvim",
			event = "VimEnter",
			config = function()
				require("config.which-key").setup()
			end,
		})

		-- DAP {{{
		--[[ use("mfussenegger/nvim-dap") ]]
		--[[ use("rcarriga/nvim-dap-ui") ]]
		--[[ use("theHamsta/nvim-dap-virtual-text") ]]
		-- }}}

		-- Themes
		-- use("joshdick/onedark.vim") -- Theme inspired by Atom
		use("sainnhe/everforest")
		use("RRethy/nvim-base16")
		use({ "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } }) -- Retro style
		-- use({ "rose-pine/neovim", as = "rose-pine" })
		-- use("ful1e5/onedark.nvim")
		-- use("EdenEast/nightfox.nvim")
		-- use("folke/tokyonight.nvim")
		-- use("bluz71/vim-nightfly-guicolors")
	end,
})
