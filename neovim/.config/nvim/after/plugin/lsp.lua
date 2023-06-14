-- LSP settings
local nvim_lsp_exists, nvim_lsp = pcall(require, "lspconfig")
local pretty_hover_exists, pretty_hover = pcall(require, "pretty_hover")

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

	local opts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "K", function()
		if pretty_hover_exists then
			pretty_hover.hover()
		end
	end, opts)
	vim.keymap.set({ "n", "i" }, "C-k", function()
		vim.lsp.signature_help()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next({ popup_opts = { border = "single" } })
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev({ popup_opts = { border = "single" } })
	end, opts)
	vim.keymap.set("n", "<leader>la", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<leader>ld", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "<leader>lD", function()
		vim.lsp.buf.declaration()
	end, opts)
	vim.keymap.set("n", "<leader>le", function()
		vim.diagnostic.open_float(0, { scope = "line", focusable = false })
	end, opts)
	vim.keymap.set("n", "<leader>lf", function()
		vim.lsp.buf.formatting()
	end, opts)
	vim.keymap.set("n", "<leader>li", function()
		vim.lsp.buf.implementation()
	end, opts)
	vim.keymap.set("n", "<leader>ll", function()
		vim.lsp.diagnostic.setloclist()
	end, opts)
	vim.keymap.set("n", "<leader>lp", function()
		vim.lsp.buf.type_definition()
	end, opts)
	vim.keymap.set("n", "<leader>lr", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("n", "<leader>ls", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "<leader>lwa", function()
		vim.lsp.buf.add_workspace_folder()
	end, opts)
	vim.keymap.set("n", "<leader>lwd", function()
		vim.lsp.buf.remove_workspace_folder()
	end, opts)
	vim.keymap.set("n", "<leader>lwl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts)

	vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})

	vim.o.updatetime = 250

	--[[ local lspFormatOnSaveGroup = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = true }) ]]
	--[[ vim.api.nvim_create_autocmd({ "BufWritePre" }, { ]]
	--[[ 	group = lspFormatOnSaveGroup, ]]
	--[[ 	callback = function() ]]
	--[[ 		vim.lsp.buf.format() ]]
	--[[ 	end, ]]
	--[[ 	buffer = bufnr, ]]
	--[[ }) ]]

	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_set_hl(0, "LspReferenceRead", { link = "SpecialKey" })
		vim.api.nvim_set_hl(0, "LspReferenceText", { link = "SpecialKey" })
		vim.api.nvim_set_hl(0, "LspReferenceWrite", { link = "SpecialKey" })

		local lspDocumentHighlightGroup = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })
		vim.api.nvim_create_autocmd({ "CursorHold" }, {
			group = lspDocumentHighlightGroup,
			callback = function()
				vim.lsp.buf.document_highlight()
			end,
			buffer = bufnr,
		})
		vim.api.nvim_create_autocmd({ "CursorMoved" }, {
			group = lspDocumentHighlightGroup,
			callback = function()
				vim.lsp.buf.clear_references()
			end,
			buffer = bufnr,
		})
	end

	if client.server_capabilities.codeLensProvider then
		local lspCodeLensGroup = vim.api.nvim_create_augroup("LspCodeLens", { clear = true })
		vim.api.nvim_create_autocmd({ "CursorHold", "BufEnter", "InsertLeave" }, {
			group = lspCodeLensGroup,
			callback = function()
				vim.lsp.codelens.refresh()
			end,
			buffer = bufnr,
		})
	end
end

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local server_settings = {
	tsserver = {
		root_dir = function(fname)
			return not nvim_lsp.util.root_pattern(".flowconfig", "deno.json", "deno.jsonc")(fname)
				and (
					nvim_lsp.util.root_pattern("tsconfig.json")(fname)
					or nvim_lsp.util.root_pattern("package.json", "jsconfig.json", ".git")(fname)
					or nvim_lsp.util.path.dirname(fname)
				)
		end,
	},
	denols = {
		root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
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
				schemas = {
					schemaStore = true,
				},
			},
		},
	},
	jsonls = {
		filetypes = { "json", "jsonc" },
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
			},
		},
	},
}

-- config that activates keymaps and enables snippet support
local function make_config()
	local capabilities = lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem = {
		documentationFormat = { "markdown", "plaintext" },
		snippetSupport = true,
		preselectSupport = true,
		insertReplaceSupport = true,
		labelDetailsSupport = true,
		deprecatedSupport = true,
		commitCharactersSupport = true,
		tagSupport = { valueSet = { 1 } },
		resolveSupport = {
			properties = {
				"documentation",
				"detail",
				"additionalTextEdits",
			},
		},
	}

	-- nvim-cmp supports additional completion capabilities
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

	return {
		-- enable snippet support
		capabilities = capabilities,
		-- map buffer local keybindings when the language server attaches
		on_attach = on_attach,
	}
end

local mason_exists, mason = pcall(require, "mason")
local mason_lspconfig_exists, mason_lspconfig = pcall(require, "mason-lspconfig")

if mason_exists then
	mason.setup()
end

if mason_lspconfig_exists then
	mason_lspconfig.setup({
		ensure_installed = {
			"bashls",
			"clangd",
			"cssls",
			"cssmodules_ls",
			"denols",
			"eslint",
			"gopls",
			"html",
			"jsonls",
			"rust_analyzer",
			"lua_ls",
			"tailwindcss",
			"tsserver",
			"vuels",
			"yamlls",
		},
		automatic_installation = true,
	})
	mason_lspconfig.setup_handlers({
		function(server_name)
			local config = make_config()
			local has_settings = server_settings[server_name] ~= nil
			local current_server_settings =
				vim.tbl_deep_extend("force", has_settings and server_settings[server_name] or {}, config)

			nvim_lsp[server_name].setup(current_server_settings)
		end,
	})
end

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"
