-- LSP settings
local has_lsp, nvim_lsp = pcall(require, 'lspconfig');
local has_lspsaga = pcall(require, 'lspsaga')
local utils = require 'utils'

if not has_lsp then
  utils.notify 'LSP config failed to setup'
  return
end


local on_attach = function(client, bufnr)
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'single' }
  )

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'single' }
  )

  -- ---------------
  -- GENERAL
  -- ---------------
  client.config.flags.allow_incremental_sync = true
  local lsd_signature_loaded = pcall(function()
    require('lsp_signature').on_attach()
  end)

  if not lsd_signature_loaded then
    utils.notify 'LSP Signature failed to set up'
  end

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  local default_mappings = {
    ['<leader>a'] = { '<Cmd>lua vim.lsp.buf.code_action()<CR>' },
    ['<leader>f'] = { '<cmd>lua vim.lsp.buf.references()<CR>' },
    ['<leader>r'] = { '<cmd>lua vim.lsp.buf.rename()<CR>' },
    ['K'] = { '<Cmd>lua vim.lsp.buf.hover()<CR>' },
    ['<leader>ld'] = { '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})<CR>', },
    ['[d'] = { '<cmd>lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = "single" }})<cr>', },
    [']d'] = { '<cmd>lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = "single" }})<CR>', },
    ['<C-]>'] = { '<Cmd>lua vim.lsp.buf.definition()<CR>' },
    ['<leader>D'] = { '<Cmd>lua vim.lsp.buf.declaration()<CR>' },
    ['<leader>i'] = { '<cmd>lua vim.lsp.buf.implementation()<CR>' },
    ['<leader>so'] = { "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>" },
  }

  local lspsaga_mappings = {
    ['<leader>d'] = { "<Cmd>lua require'lspsaga.provider'.preview_definition()<CR>", },
    ['<leader>a'] = {
      "<Cmd>lua require'lspsaga.codeaction'.code_action()<CR>",
      "<Cmd>'<,'>lua require'lspsaga.codeaction'.range_code_action()<CR>",
    },
    ['<leader>f'] = { "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>" },
    ['<leader>s'] = { "<cmd>lua require'lspsaga.signaturehelp'.signature_help()<CR>", },
    ['<leader>r'] = { "<cmd>lua require'lspsaga.rename'.rename()<CR>" },
    ['<leader>ld'] = { "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>", },
    ['[d'] = { "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", },
    [']d'] = { "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", },
    ['<C-f>'] = { "<cmd>lua require('lspsaga.hover').smart_scroll_hover(1)<cr>" },
    ['<C-b>'] = { "<cmd>lua require('lspsaga.hover').smart_scroll_hover(-1)<CR>" },
  }
 
  local mappings = vim.tbl_extend(
    'force',
    default_mappings,
    has_lspsaga and lspsaga_mappings or {}
  )

  for lhs, rhs in pairs(mappings) do
    if lhs == 'K' then
      if vim.api.nvim_buf_get_option(0, 'filetype') ~= 'vim' then
        vim.api.nvim_buf_set_keymap(bufnr, 'n', lhs, rhs[1], opts)
      end
    else
      vim.api.nvim_buf_set_keymap(bufnr, 'n', lhs, rhs[1], opts)
      if #rhs == 2 then
        vim.api.nvim_buf_set_keymap(bufnr, 'n', lhs, rhs[2], opts)
      end
    end
  end



  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]


  vim.api.nvim_exec([[
    augroup lsp_line_diagnostics
    autocmd!
    autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()
    augroup END
  ]], true)

    -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
    augroup lsp_document_highlight
    autocmd!
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]], true)
  end

  if client.resolved_capabilities.code_lens then
    vim.api.nvim_exec([[
    augroup lsp_codelense
    autocmd!
    autocmd CursorHold <buffer> lua vim.lsp.codelens.refresh()
    autocmd BufEnter <buffer> lua vim.lsp.codelens.refresh()
    autocmd InsertLeave <buffer> lua vim.lsp.codelens.refresh()
    augroup END
    ]], true)
  end

end

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local server_settings = {
  efm = require('config.lsp.efm'),
  typescript = {
    root_dir = function(fname)
      return nvim_lsp.util.root_pattern 'tsconfig.json'(fname)
        or nvim_lsp.util.root_pattern(
          'package.json',
          'jsconfig.json',
          '.git'
        )(fname)
        or vim.loop.cwd()
    end,
  },
  deno = {
    root_dir = function(fname)
      return nvim_lsp.util.root_pattern 'deps.ts'(fname)
        or nvim_lsp.util.root_pattern 'mod.ts'(fname)
    end,
  },
  lua = {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file('', true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    }
  },
  sourcekit = {
    filetypes = {"swift", "objective-c", "objective-cpp"}; -- we don't want c and cpp!
  },
  clangd = {
    filetypes = {"c", "cpp"}; -- we don't want objective-c and objective-cpp!
  },
  yaml = {
    settings = {
      yaml = {
        -- Schemas https://www.schemastore.org
        schemas = {
          ['http://json.schemastore.org/gitlab-ci.json'] = { '.gitlab-ci.yml' },
          ['https://json.schemastore.org/bamboo-spec.json'] = {
            'bamboo-specs/*.{yml,yaml}',
          },
          ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = {
            'docker-compose*.{yml,yaml}',
          },
          ['http://json.schemastore.org/github-workflow.json'] = '.github/workflows/*.{yml,yaml}',
          ['http://json.schemastore.org/github-action.json'] = '.github/action.{yml,yaml}',
          ['http://json.schemastore.org/prettierrc.json'] = '.prettierrc.{yml,yaml}',
          ['http://json.schemastore.org/stylelintrc.json'] = '.stylelintrc.{yml,yaml}',
          ['http://json.schemastore.org/circleciconfig'] = '.circleci/**/*.{yml,yaml}',
        },
      }
    }
  },
  json = {
    filetypes = { 'json', 'jsonc' },
    settings = {
      json = {
        -- Schemas https://www.schemastore.org
        schemas = {
          {
            fileMatch = { 'package.json' },
            url = 'https://json.schemastore.org/package.json',
          },
          {
            fileMatch = { 'tsconfig*.json' },
            url = 'https://json.schemastore.org/tsconfig.json',
          },
          {
            fileMatch = {
              '.prettierrc',
              '.prettierrc.json',
              'prettier.config.json',
            },
            url = 'https://json.schemastore.org/prettierrc.json',
          },
          {
            fileMatch = { '.eslintrc', '.eslintrc.json' },
            url = 'https://json.schemastore.org/eslintrc.json',
          },
          {
            fileMatch = { '.babelrc', '.babelrc.json', 'babel.config.json' },
            url = 'https://json.schemastore.org/babelrc.json',
          },
          {
            fileMatch = { 'lerna.json' },
            url = 'https://json.schemastore.org/lerna.json',
          },
          {
            fileMatch = { 'now.json', 'vercel.json' },
            url = 'https://json.schemastore.org/now.json',
          },
          {
            fileMatch = {
              '.stylelintrc',
              '.stylelintrc.json',
              'stylelint.config.json',
            },
            url = 'http://json.schemastore.org/stylelintrc.json',
          },
        },
      },
    },
  },
}

-- config that activates keymaps and enables snippet support
local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    },
  }

  -- nvim-cmp supports additional completion capabilities
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }
end

-- lsp-install
local function setup_servers()
  require'lspinstall'.setup()

  local config = make_config()

  -- get all installed servers
  local servers = require'lspinstall'.installed_servers()

  -- -- ... and add manually installed servers
  -- table.insert(servers, "clangd")
  -- table.insert(servers, "sourcekit")

  for _, server in pairs(servers) do
    -- :lua print(vim.lsp.get_log_path())
    local has_settings = server_settings[server] ~= nil

    require'lspconfig'[server].setup(
      vim.tbl_deep_extend(
        'force',
        has_settings and server_settings[server] or {},
        config
      )
    )
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
