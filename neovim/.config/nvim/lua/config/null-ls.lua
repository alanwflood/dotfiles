local M = {}

function M.setup()
  local status_ok, null_ls = pcall(require, "null-ls")
  if not status_ok then
    return
  end

  -- Check supported formatters
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
  local formatting = null_ls.builtins.formatting

  -- Check supported linters
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
  local diagnostics = null_ls.builtins.diagnostics

  local code_actions = null_ls.builtins.code_actions

  null_ls.setup({
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
    sources = {
      -- Adds gitsigns staging actions to code actions
      code_actions.gitsigns,

      -- Python
      -- formatting.autopep8,
      -- formatting.isort,
      -- diagnostics.flake8,

      -- JS yaml html markdown
      formatting.prettier,

      -- C/C++
      -- Formatting is handled by clangd language server
      -- formatting.clang_format,

      -- Markdown
      diagnostics.markdownlint.with({
        condition = function()
          return vim.fn.exepath("markdownlint") ~= ""
        end,
      }),

      diagnostics.proselint.with({
        condition = function()
          return vim.fn.exepath("proselint") ~= ""
        end,
      }),

      -- Lua
      -- cargo install stylua
      -- add ~/.cargo/bin to PATH
      formatting.stylua.with({
        condition = function()
          return vim.fn.exepath("stylua") ~= ""
        end,
      }),

      -- Spell checking
      diagnostics.codespell.with({
        args = { "--builtin", "clear,rare,code", "-" },
        condition = function()
          return vim.fn.exepath("codespell") ~= ""
        end,
      }),

      -- sh
      diagnostics.codespell.with({
        condition = function()
          return vim.fn.exepath("shellcheck") ~= ""
        end,
      }),
    },
  })
end

return M
