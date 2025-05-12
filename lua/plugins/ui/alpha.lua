return {
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- Adds icons support to the dashboard
	},

	config = function()
		local alpha = require("alpha")                    -- Load alpha-nvim
		local dashboard = require("alpha.themes.dashboard") -- Load the dashboard theme

		-- Set the header (ASCII art or text)
		dashboard.section.header.val = {
			[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀]],
			[[⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀]],
			[[⠀⠀⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⠀⠀]],
			[[⠀⠀⣿⣿⣿⣿⡟⠛⠛⠛⠛⣿⣿⣿⣿⣿⣿⣿⣿⠛⠛⠛⠛⢻⣿⣿⣿⣿⠀⠀]],
			[[⠀⠀⣿⣿⡟⠛⠃⠀⠀⠀⠀⠛⠛⣿⣿⣿⣿⠛⠛⠀⠀⠀⠀⠘⠛⢻⣿⣿⠀⠀]],
			[[⣶⣶⣿⣿⡇⠀⠀⠀⢸⣿⣷⣶⠀⣿⣿⣿⣿⠀⠀⠀⠀⣿⣿⣶⡆⢸⣿⣿⣶⣶]],
			[[⣿⣿⣿⣿⡇⠀⠀⠀⢸⣿⠿⠿⠀⣿⣿⣿⣿⠀⠀⠀⠀⣿⣿⠿⠇⢸⣿⣿⣿⣿]],
			[[⣿⣿⣿⣿⣧⣤⡄⠀⠀⠀⠀⣤⣤⣿⣿⣿⣿⣤⣤⠀⠀⠀⠀⢠⣤⣼⣿⣿⣿⣿]],
			[[⣿⣿⣿⣿⣿⣿⣧⣤⣤⣤⣤⣿⣿⣿⣿⣿⣿⣿⣿⣤⣤⣤⣤⣼⣿⣿⣿⣿⣿⣿]],
			[[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
			[[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
			[[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
			[[⣿⣿⣿⣿⣿⠀⢹⣿⣿⣿⣿⣿⣿⡇⠀⠀⠘⣿⣿⣿⣿⣿⣿⡇⠀⣿⣿⣿⣿⣿]],
			[[⣿⣿⡏⠀⠀⠀⠀⠀⢹⣿⣿⣿⣿⠁⠀⠀⠀⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⢻⣿⣿]],
		}

		-- Define custom buttons
		dashboard.section.buttons.val = {
			dashboard.button("f", "󰈞  Find file", ":Telescope find_files<CR>"),
			dashboard.button("g", " Find text", ":Telescope live_grep<CR>"),
			dashboard.button("r", "󱋡 find used files", ":Telescope oldfiles<CR>"),
			dashboard.button("t", "  Find tags", ":Telescope help_tags<CR>"),
			dashboard.button("c", "  Find git commits", ":Telescope git_commits<CR>"),
			dashboard.button("b", " Find git branches", ":Telescope git_branches<CR>"),
			dashboard.button("s", "  Settings", ":e $MYVIMRC<CR>"),
			dashboard.button("q", "󰩈  Quit Neovim", ":qa<CR>"),
		}

		local function get_current_date()
			return os.date(" Today is %A, %B %d, %Y")
		end

		local function welcome_user()
			local username = os.getenv("USER") or os.getenv("USERNAME")
			return string.format("󱠢 Welcome back, %s!", username)
		end

		dashboard.section.footer.val = {
			welcome_user(),
			get_current_date(),
		}
		-- Configure the layout to center the content
		dashboard.opts.layout = {
			{ type = "padding", val = 1 }, -- Add 5 empty lines at the top (to center vertically)
			dashboard.section.header,   -- Display the header (ASCII art)
			{ type = "padding", val = 2 }, -- Add 2 lines of padding after the header
			dashboard.section.buttons,  -- Display the custom buttons
			dashboard.section.footer,   -- Placeholder for footer text
		}

		alpha.setup(dashboard.opts)
	end,
}
