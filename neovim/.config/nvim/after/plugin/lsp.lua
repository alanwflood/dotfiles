-- LSP settings
local nvim_lsp_exists, nvim_lsp = pcall(require, "lspconfig")
local lsp_installer_exists, lsp_installer = pcall(require, "nvim-lsp-installer")
local utils = require("utils")

-- Pulling out things from
local diagnostic = vim.diagnostic
local lsp = vim.lsp

if not nvim_lsp_exists then
	vim.notify("LSP config failed to setup", vim.log.levels.INFO, { title = ":: Local ::" })
	return
end

local lsp_handlers = function()
	local function lspSymbol(name, icon)
		local hl = "DiagnosticSign" .. name
		vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
	end

	lspSymbol("Error", "")
	lspSymbol("Info", "")
	lspSymbol("Hint", "")
	lspSymbol("Warn", "")

	local popup_opts = { border = "rounded", max_width = 80, silent = true, focusable = false }

	lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, popup_opts)
	lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.hover, popup_opts)

	diagnostic.config({
		virtual_text = false,
		signs = true,
		underline = true,
		severity_sort = true,
		update_in_insert = false, -- update diagnostics insert mode
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	})
end

local on_attach = function(client, bufnr)
	lsp_handlers()

	-- ---------------
	-- GENERAL
	-- ---------------
	client.config.flags.allow_incremental_sync = true

	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "C-k", "<cmd>lua vim.lsp.signature_help()", opts)
	buf_set_keymap("n", "[d", '<cmd>lua vim.diagnostic.goto_next({ popup_opts = { border = "single" }})<CR>', opts)
	buf_set_keymap("n", "]d", '<cmd>lua vim.diagnostic.goto_prev({ popup_opts = { border = "single" }})<CR>', opts)
	buf_set_keymap("n", "<leader>LD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "<leader>le", "<cmd>lua vim.diagnostic.open_float(0, { focusable = false })<CR>", opts)
	buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	buf_set_keymap("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<leader>ll", "<cmd>lua vim.lsp.diagnostic.setloclist()<CR>", opts)
	buf_set_keymap("n", "<leader>lp", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<leader>ls", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<leader>lwa", "<cmd>lua <cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<leader>lwd", "<cmd>lua <cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap(
		"n",
		"<leader>lwl",
		"<cmd>lua <cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
		opts
	)
	buf_set_keymap("n", "<leader>so", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", opts)

	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])

	vim.o.updatetime = 250

	utils.nvim_create_augroups({
		-- Show diagnostics on line hover
		lsp_line_diagnostics = {
			{ "CursorHold", "*", "lua vim.diagnostic.open_float(0, { scope = 'line', focusable = false })" },
		},

		-- Populate location list with errors
		lsp_loc_diagnostics = {
			{ "BufWrite", "*", "lua vim.diagnostic.setqflist({ open = false })" },
			{ "BufEnter", "*", "lua vim.diagnostic.setqflist({ open = false })" },
			{ "InsertLeave", "*", "lua vim.diagnostic.setqflist({ open = false })" },
		},

		-- Set autocommands conditional on server_capabilities
		lsp_document_highlight = client.resolved_capabilities.document_highlight and {
			{ "CursorHold", "<buffer>", "lua vim.lsp.buf.document_highlight()" },
			{ "CursorMoved", "<buffer>", "lua vim.lsp.buf.clear_references()" },
		} or {},

		lsp_codelense = client.resolved_capabilities.code_lens and {
			{ "CursorHold", "<buffer>", "lua vim.lsp.codelens.refresh()" },
			{ "BufEnter", "<buffer>", "lua vim.lsp.codelens.refresh()" },
			{ "InsertLeave", "<buffer>", "lua vim.lsp.codelens.refresh()" },
		} or {},
	})
end

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local server_settings = {
	tsserver = {
		root_dir = function(fname)
			return nvim_lsp.util.root_pattern("tsconfig.json")(fname)
				or nvim_lsp.util.root_pattern("package.json", "jsconfig.json", ".git")(fname)
				or vim.loop.cwd()
		end,
	},
	denols = {
		root_dir = function(fname)
			return nvim_lsp.util.root_pattern("deps.ts")(fname) or nvim_lsp.util.root_pattern("mod.ts")(fname)
		end,
	},
	sumneko_lua = {
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
					-- Setup your lua path
					path = runtime_path,
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
	},
	sourcekit = {
		filetypes = { "swift", "objective-c", "objective-cpp" }, -- we don't want c and cpp!
	},
	clangd = {
		filetypes = { "c", "cpp" }, -- we don't want objective-c and objective-cpp!
	},
	yamlls = {
		settings = {
			yaml = {
				-- Schemas https://www.schemastore.org
				schemas = {
					["http://json.schemastore.org/gitlab-ci.json"] = { ".gitlab-ci.yml" },
					["https://json.schemastore.org/bamboo-spec.json"] = {
						"bamboo-specs/*.{yml,yaml}",
					},
					["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
						"docker-compose*.{yml,yaml}",
					},
					["http://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.{yml,yaml}",
					["http://json.schemastore.org/github-action.json"] = ".github/action.{yml,yaml}",
					["http://json.schemastore.org/prettierrc.json"] = ".prettierrc.{yml,yaml}",
					["http://json.schemastore.org/stylelintrc.json"] = ".stylelintrc.{yml,yaml}",
					["http://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
				},
			},
		},
	},
	jsonls = {
		filetypes = { "json", "jsonc" },
		settings = {
			json = {
				-- Schemas https://www.schemastore.org
				schemas = {
					{
						fileMatch = { "package.json" },
						url = "https://json.schemastore.org/package.json",
					},
					{
						fileMatch = { "tsconfig*.json" },
						url = "https://json.schemastore.org/tsconfig.json",
					},
					{
						fileMatch = {
							".prettierrc",
							".prettierrc.json",
							"prettier.config.json",
						},
						url = "https://json.schemastore.org/prettierrc.json",
					},
					{
						fileMatch = { ".eslintrc", ".eslintrc.json" },
						url = "https://json.schemastore.org/eslintrc.json",
					},
					{
						fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" },
						url = "https://json.schemastore.org/babelrc.json",
					},
					{
						fileMatch = { "lerna.json" },
						url = "https://json.schemastore.org/lerna.json",
					},
					{
						fileMatch = { "now.json", "vercel.json" },
						url = "https://json.schemastore.org/now.json",
					},
					{
						fileMatch = {
							".stylelintrc",
							".stylelintrc.json",
							"stylelint.config.json",
						},
						url = "http://json.schemastore.org/stylelintrc.json",
					},
				},
			},
		},
	},
}

-- config that activates keymaps and enables snippet support
local function make_config()
	local capabilities = lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	}

	-- nvim-cmp supports additional completion capabilities
	capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

	return {
		-- enable snippet support
		capabilities = capabilities,
		-- map buffer local keybindings when the language server attaches
		on_attach = on_attach,
	}
end

if lsp_installer_exists then
	lsp_installer.on_server_ready(function(server)
		local config = make_config()
		local has_settings = server_settings[server.name] ~= nil

		server:setup(vim.tbl_deep_extend("force", has_settings and server_settings[server.name] or {}, config))
		vim.cmd([[ do User LspAttachBuffers ]])
	end)
end

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"
