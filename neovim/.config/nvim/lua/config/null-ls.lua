local M = {}

function M.setup()
	local null_ls_mason_exists, null_ls_mason = pcall(require, "mason-null-ls")

	if not null_ls_mason_exists then
		return
	end

	null_ls_mason.setup({
		ensure_installed = { "stylua", "markdownlint", "proselint", "codespell", "shellcheck" },
		automatic_installation = false,
		handlers = {},
	})

	local null_ls_exists, null_ls = pcall(require, "null-ls")
	if not null_ls_exists then
		return
	end

	-- Check supported formatters
	-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
	local formatting = null_ls.builtins.formatting

	-- Check supported linters
	-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
	-- local diagnostics = null_ls.builtins.diagnostics
	local code_actions = null_ls.builtins.code_actions

	null_ls.setup({
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
		sources = {
			code_actions.gitsigns,
			formatting.prettier,
		},
	})
end

return M
