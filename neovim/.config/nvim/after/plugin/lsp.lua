-- LSP settings
local nvim_lsp_exists, nvim_lsp = pcall(require, "lspconfig")
local lsp_installer_exists, lsp_installer = pcall(require, "nvim-lsp-installer")

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
  buf_set_keymap("n", "<leader>lwa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<leader>lwd", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap(
    "n",
    "<leader>lwl",
    "<cmd>lua <cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    opts
  )
  buf_set_keymap("n", "<leader>sy", "", opts)

  vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})

  vim.o.updatetime = 250

  local lspLineDiagnosticsGroup = vim.api.nvim_create_augroup("LspLineDiagnostics", { clear = true })
  vim.api.nvim_create_autocmd("CursorHold", {
    group = lspLineDiagnosticsGroup,
    pattern = "*",
    callback = function() vim.diagnostic.open_float(0, { scope = "line", focusable = false }) end,
  })

  -- local lspLocDiagnosticsGroup = vim.api.nvim_create_augroup("LspLocDiagnostics", { clear = true })
  -- vim.api.nvim_create_autocmd({ "BufWrite", "BufEnter" }, {
  --   group = lspLocDiagnosticsGroup,
  --   pattern = "*",
  --   callback = function() vim.diagnostic.setloclist({ open = false }) end,
  -- })

  if client.resolved_capabilities.documentFormattingProvider then
    vim.api.nvim_set_hl(0, 'LspReferenceRead', { link = 'SpecialKey' })
    vim.api.nvim_set_hl(0, 'LspReferenceText', { link = 'SpecialKey' })
    vim.api.nvim_set_hl(0, 'LspReferenceWrite', { link = 'SpecialKey' })

    local lspDocumentHighlightGroup = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })
    vim.api.nvim_create_autocmd({ "CursorHold" }, {
      group = lspDocumentHighlightGroup,
      callback = function() vim.lsp.buf.document_highlight() end,
      buffer = 0
    })
    vim.api.nvim_create_autocmd({ "CursorMoved" }, {
      group = lspDocumentHighlightGroup,
      callback = function() vim.lsp.buf.clear_references() end,
      buffer = 0
    })
  end

  if client.resolved_capabilities.codeLensProvider then
    local lspCodeLensGroup = vim.api.nvim_create_augroup("LspCodeLens", { clear = true })
    vim.api.nvim_create_autocmd({ "CursorHold", "BufEnter", "InsertLeave" }, {
      group = lspCodeLensGroup,
      callback = function() vim.lsp.codelens.refresh() end,
      buffer = 0
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
