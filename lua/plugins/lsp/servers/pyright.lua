-- ~/.config/nvim/lua/lsp/servers/python.lua

require("lspconfig").pyright.setup({
	settings = {
		python = {
			analysis = {
				-- Basic configurations
				typeCheckingMode = "basic",   -- "strict", "basic" or "off"
				autoSearchPaths = true,       -- Automatic path search
				diagnosticMode = "openFilesOnly", -- Only analyzes open files
				useLibraryCodeForTypes = true, -- Use type hints from external libraries

				-- Performance optimization
				memory = true,        -- Memory caching for faster analysis
				logLevel = "Information", -- Logging level (Information/Warning/Error)

				-- Additional features
				autoImportCompletions = true, -- Auto-completion for imports

				-- Directory exclusions
				exclude = {
					"**/node_modules/**",
					"**/__pycache__/**",
					"**/.venv/**",
					"**/venv/**" -- Common addition for virtual environments
				}
			}
		}
	},
	-- Optional: Server performance settings
	flags = {
		debounce_text_changes = 150 -- Milliseconds before re-analyzing after changes
	}
})
