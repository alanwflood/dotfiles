local M = {}

function M.setup()
	local null_ls = require("null-ls")

	null_ls.config({
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
		sources = {
			-- Adds gitsigns staging actions to code actions
			null_ls.builtins.code_actions.gitsigns,

			-- Python
			-- null_ls.builtins.formatting.autopep8,
			-- null_ls.builtins.formatting.isort,
			-- null_ls.builtins.diagnostics.flake8,

			-- JS yaml html markdown
			null_ls.builtins.formatting.prettier,

			-- C/C++
			-- Formatting is handled by clangd language server
			-- null_ls.builtins.formatting.clang_format,

			-- Markdown
			null_ls.builtins.diagnostics.markdownlint.with({
				condition = function(utils)
					return vim.fn.exepath("markdownlint") ~= ""
				end,
			}),

			-- Lua
			-- cargo install stylua
			-- add ~/.cargo/bin to PATH
			null_ls.builtins.formatting.stylua,

			-- Spell checking
			null_ls.builtins.diagnostics.codespell.with({
				args = { "--builtin", "clear,rare,code", "-" },
				condition = function(utils)
					return vim.fn.exepath("codespell") ~= ""
				end,
			}),

			-- sh
			null_ls.builtins.diagnostics.shellcheck,
		},
	})
	require("lspconfig")["null-ls"].setup({
		on_attach = function()
			vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
		end,
	})
end

return M
