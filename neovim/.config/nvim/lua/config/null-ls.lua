local M = {}

function M.setup()
	local null_ls = require("null-ls")
	null_ls.setup({
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
				condition = function()
					return vim.fn.exepath("markdownlint") ~= ""
				end,
			}),

			null_ls.builtins.diagnostics.proselint.with({
				condition = function()
					return vim.fn.exepath("proselint") ~= ""
				end,
			}),

			-- Lua
			-- cargo install stylua
			-- add ~/.cargo/bin to PATH
			null_ls.builtins.formatting.stylua.with({
				condition = function()
					return vim.fn.exepath("stylua") ~= ""
				end,
			}),

			-- Spell checking
			null_ls.builtins.diagnostics.codespell.with({
				args = { "--builtin", "clear,rare,code", "-" },
				condition = function()
					return vim.fn.exepath("codespell") ~= ""
				end,
			}),

			-- sh
			null_ls.builtins.diagnostics.codespell.with({
				condition = function()
					return vim.fn.exepath("shellcheck") ~= ""
				end,
			}),
		},
	})
end

return M
