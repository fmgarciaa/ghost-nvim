return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		{ "williamboman/mason.nvim", version = "1.11.0" },
		"jay-babu/mason-null-ls.nvim",
		"gbprod/none-ls-shellcheck.nvim",
	},
	config = function()
		require("mason").setup()

		require("mason-null-ls").setup({
			ensure_installed = {
				"stylua",    -- Lua formatter
				"isort",     -- Python formatter (import sorting)
				"sql-formatter", -- SQL formatter
				"sqlfluff",  -- SQL lintern
				"prettier",
				"yamllint",  -- YAML linter
				"shfmt",     -- bash formatter
				"shellcheck", -- bash lintern
			},
			automatic_installation = true,
		})

		-- Configure none-ls
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics

		-- Sources (adapted to null-ls names)
		local sources = {
			formatting.stylua,
			formatting.isort,
			formatting.sql_formatter.with({
				extra_args = { "--language", "postgresql", "--keyword-case", "upper", "--indent", "4" },
			}),
			diagnostics.sqlfluff.with({ extra_args = { "--dialect", "postgres" } }),
			formatting.prettier.with({
				filetypes = {
					"json",
					"yaml",
					"yml",
					"markdown",
					"html",
					"javascript",
					"typescript",
					"dockerfile",
				},
			}),
			diagnostics.yamllint,
			formatting.shfmt,
			require("none-ls-shellcheck.diagnostics"),
		}

		-- Group for auto-formatting
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		null_ls.setup({
			sources = sources,
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end,
		})
	end,
}
