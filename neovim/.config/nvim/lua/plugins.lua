-- Install packer
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({
	"nvim-lua/plenary.nvim",
	{ "tweekmonster/startuptime.vim", cmd = "StartupTime" },
	{
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
	},
	"kyazdani42/nvim-web-devicons",
	{
		"Darazaki/indent-o-matic",
		event = "BufRead",
		config = function()
			require("indent-o-matic").setup({
				max_lines = 2048,
				standard_widths = { 2, 4, 8 },
			})
		end,
	},
	{
		"echasnovski/mini.bufremove",
		config = function()
			require("mini.bufremove").setup({})
		end,
	},
	-- Useful shortcuts for commands
	{ "tpope/vim-unimpaired", event = "VimEnter" },
	-- "gc" to comment visual regions/lines
	{
		"numToStr/Comment.nvim",
		event = "BufRead",
		config = function()
			require("config.comment").setup()
		end,
	},

	-- Lots of helpers for string manipulation
	{
		"tpope/vim-abolish",
		cmd = { "Abolish", "S", "Subvert" },
	},

	-- UI to select things (files, grep results, open buffers...)
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.3",
		config = function()
			require("config.telescope").setup()
		end,
	},
	{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	"debugloop/telescope-undo.nvim",

	-- Fancier statusline
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("config.statusline").setup()
		end,
	},

	-- Transparency for all!
	{
		"xiyaowong/nvim-transparent",
		cmd = { "TransparentToggle", "TransparentEnable", "TransparentEnable" },
	},

	-- Add indentation guides even on blank lines
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = "BufRead",
		config = function()
			require("config.indent-blankline").setup()
		end,
	},

	-- Git utils {{{
	{
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
	},

	-- Git Diff View for files
	{ "sindrets/diffview.nvim", cmd = { "DiffviewOpen" } },

	-- Add git related info in the signs columns and popups
	{
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
		config = function()
			require("config.gitsigns").setup()
		end,
	},

	{
		"akinsho/git-conflict.nvim",
		config = function()
			require("git-conflict").setup({})
		end,
	},
	-- }}}

	-- Highlight, edit, and navigate code using a fast incremental parsing library
	{
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
		dependencies = {
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
	},

	{
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
	},

	-- Better Quick Fix window
	{ "kevinhwang91/nvim-bqf", ft = "qf" },
	{
		"ten3roberts/qf.nvim",
		config = function()
			require("qf").setup({})
		end,
	},
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		config = function()
			require("trouble").setup()
		end,
	},

	-- Collection of configurations for built-in LSP client
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "VonHeikemen/lsp-zero.nvim" },
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
				tag = "legacy",
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
			"nvimtools/none-ls.nvim",
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
	},

	-- Better LSP hover windows
	{
		"Fildo7525/pretty_hover",
		config = function()
			require("pretty_hover").setup()
		end,
	},

	-- Installs snippets for multiple languages
	{
		"rafamadriz/friendly-snippets",
		module = { "cmp", "cmp_nvim_lsp" },
		event = "InsertEnter",
	},

	-- Snippets plugin
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		config = function()
			require("luasnip.loaders.from_lua").lazy_load()
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_snipmate").lazy_load()
		end,
	},

	-- Autocompletion plugin
	{
		"hrsh7th/nvim-cmp",
		config = function()
			require("config.completion").setup()
		end,
		dependencies = {
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
			{ "tzachar/cmp-tabnine", build = "./install.sh" },
		},
	},

	-- Auto closes elements
	{
		"windwp/nvim-autopairs",
		after = "nvim-cmp",
		config = function()
			require("config.autopairs").setup()
		end,
	},

	{
		"editorconfig/editorconfig-vim",
		config = function()
			vim.g.EditorConfig_exclude_patterns = { "fugitive://.*", "scp://.*" }
		end,
	},

	-- Surround plugins
	{
		"echasnovski/mini.surround",
		config = function()
			require("mini.surround").setup()
		end,
	},

	-- Make nvim easier to use inside tmux
	{
		"christoomey/vim-tmux-navigator",
		opt = true,
		cond = function()
			return vim.env.TMUX ~= nil
		end,
		config = function()
			require("config.nvim-tmux-navigation").setup()
		end,
	},

	-- Bufferline
	{
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
	},

	-- Show buffer names by each window
	{
		"b0o/incline.nvim",
		config = function()
			require("incline").setup({
				hide = {
					cursorline = true,
					only_win = true,
				},
			})
		end,
	},

	{
		"kyazdani42/nvim-tree.lua",
		config = function()
			require("config.nvim-tree").setup()
		end,
	},

	-- Time tracking files
	{
		"wakatime/vim-wakatime",
		event = "VimEnter",
	},

	-- emacs style which key
	{
		"folke/which-key.nvim",
		event = "VimEnter",
		config = function()
			require("config.which-key").setup()
		end,
	},

	-- DAP {{{
	--[[ use("mfussenegger/nvim-dap") ]]
	--[[ use("rcarriga/nvim-dap-ui") ]]
	--[[ use("theHamsta/nvim-dap-virtual-text") ]]
	-- }}}

	-- Themes
	-- use("joshdick/onedark.vim") -- Theme inspired by Atom
	"sainnhe/everforest",
	"RRethy/nvim-base16",
	{
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({
				theme = "wave", -- Load "wave" theme when 'background' option is not set
				background = { -- map the value of 'background' option to a theme
					dark = "dragon", -- try "dragon" !
					light = "lotus",
				},
			})
		end,
	},
	{ "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } }, -- Retro style
	-- use({ "rose-pine/neovim", as = "rose-pine" })
	-- use("ful1e5/onedark.nvim")
	-- use("EdenEast/nightfox.nvim")
	-- use("folke/tokyonight.nvim")
	-- use("bluz71/vim-nightfly-guicolors")
})
