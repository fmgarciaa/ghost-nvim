require("lspconfig").ruff.setup({
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	init_options = {
		settings = {
			configurationPreference = "editorOnly",
			exclude = { "**/tests/**", ".venv", "venv", "env", "__pycache__", "migrations", ".pytest_cache", ".git" },
			lineLength = 125,
			organizeImports = false,
			showSyntaxErrors = true,
			logFile = "~/ruff.log",
			logLevel = "debug",

			-- all lint/format rules live under `configuration`
			configuration = {
				lint = {
					-- enable specific rule codes
					select = { "E", "F", "B", "Q", "I", "PL", "D", "AIR", "PL", "ARG", "ERA", "FAST", "DJ", "ANN" },
					ignore = { "D102", "D107", "D100" },
				},
				format = {
					["quote-style"] = "double",
					["docstring-code-format"] = true,
				},
			},
		},
	},
})
