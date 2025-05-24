-- This file configures the alpha-nvim plugin, which provides a customizable start screen (dashboard) for Neovim.

-- Return the plugin specification for lazy.nvim.
return {
  'goolord/alpha-nvim', -- The plugin's repository name.
  dependencies = { -- List of plugins that alpha-nvim depends on.
    'nvim-tree/nvim-web-devicons', -- Adds file type icons to the dashboard buttons if configured.
  },

  config = function() -- Function to run after the plugin is loaded.
    local alpha = require 'alpha' -- Load the main alpha-nvim module.
    local dashboard = require 'alpha.themes.dashboard' -- Load the pre-configured dashboard theme.

    -- Set the header section of the dashboard.
    -- This uses ASCII art to display a logo or welcome message.
    -- Each string in the table represents a line of the header.
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

    -- Define custom buttons for the dashboard.
    -- Each button has a key, an icon with text, and a command to execute.
    -- Icons typically require a Nerd Font to be displayed correctly.
    dashboard.section.buttons.val = {
      dashboard.button('f', '󰈞  Find file', ':Telescope find_files<CR>'), -- Button 'f' to find files using Telescope.
      dashboard.button('g', ' Find text', ':Telescope live_grep<CR>'), -- Button 'g' to live grep text using Telescope.
      dashboard.button('r', '󱋡 find used files', ':Telescope oldfiles<CR>'), -- Button 'r' to find recently used files with Telescope.
      dashboard.button('t', '  Find tags', ':Telescope help_tags<CR>'), -- Button 't' to find help tags with Telescope.
      dashboard.button('c', '  Find git commits', ':Telescope git_commits<CR>'), -- Button 'c' to find Git commits with Telescope.
      dashboard.button('b', ' Find git branches', ':Telescope git_branches<CR>'), -- Button 'b' to find Git branches with Telescope.
      dashboard.button('s', '  Settings', ':e $MYVIMRC<CR>'), -- Button 's' to edit the Neovim configuration file.
      dashboard.button('q', '󰩈  Quit Neovim', ':qa<CR>'), -- Button 'q' to quit Neovim.
    }

    -- Function to get the current date formatted.
    local function get_current_date()
      return os.date ' Today is %A, %B %d, %Y' -- Format: Icon Day, Month Date, Year
    end

    -- Function to create a personalized welcome message.
    local function welcome_user()
      local username = os.getenv 'USER' or os.getenv 'USERNAME' -- Get username from environment variables.
      return string.format('󱠢 Welcome back, %s!', username) -- Format: Icon Welcome back, Username!
    end

    -- Set the footer section of the dashboard.
    -- Displays the welcome message and current date.
    dashboard.section.footer.val = {
      welcome_user(),
      get_current_date(),
    }

    -- Configure the layout of the dashboard items.
    -- This controls the order and spacing of sections.
    dashboard.opts.layout = {
      { type = 'padding', val = 1 }, -- Add 1 empty line at the top for padding.
      dashboard.section.header, -- Display the header (ASCII art).
      { type = 'padding', val = 2 }, -- Add 2 lines of padding after the header.
      dashboard.section.buttons, -- Display the custom buttons.
      dashboard.section.footer, -- Display the footer text.
    }

    -- Initialize alpha-nvim with the configured dashboard options.
    alpha.setup(dashboard.opts)
  end,
}
