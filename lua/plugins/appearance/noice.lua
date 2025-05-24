-- This file configures the folke/noice.nvim plugin, which aims to overhaul
-- Neovim's UI by replacing the command line, messages, and popups with
-- more modern and consistent interfaces.

-- Return the plugin specification for lazy.nvim.
return {
  'folke/noice.nvim', -- The plugin's repository name.
  event = 'VeryLazy', -- Load the plugin very late in the startup sequence, as UI elements are often needed last.
  dependencies = { -- List of plugins that Noice depends on or integrates with.
    'MunifTanjim/nui.nvim', -- Nui provides UI components that Noice uses for its views.
    'rcarriga/nvim-notify', -- Noice can use nvim-notify as a backend for displaying notifications.
  },
  opts = { -- Configuration options passed to Noice's setup function.
    cmdline = { -- Configuration for the command line replacement.
      enabled = true, -- If true, Noice will replace the default Neovim command line.
      view = 'cmdline_popup', -- The view to use for the command line. 'cmdline_popup' shows it as a floating popup.
                               -- Other options include 'cmdline' (more traditional) or custom views.
    },
    messages = { -- Configuration for how messages (e.g., from :echo) are displayed.
      enabled = true, -- If true, Noice will handle displaying messages.
      view = 'notify', -- The default view for messages. 'notify' uses nvim-notify or Noice's internal notifier.
      view_error = 'notify', -- View specifically for error messages.
      view_warn = 'notify', -- View specifically for warning messages.
    },
    lsp = { -- Configuration for LSP (Language Server Protocol) integration.
      progress = { -- Configuration for LSP progress indicators (e.g., "Indexing...").
        enabled = false, -- If true, Noice will handle LSP progress display. Disabled here.
                         -- This might be handled by another plugin like lualine or fidget.
      },
      override = { -- Override default LSP handlers with Noice's versions.
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true, -- Use Noice's markdown conversion.
        ['vim.lsp.util.stylize_markdown'] = true, -- Use Noice's markdown stylization.
        ['cmp.entry.get_documentation'] = true, -- Use Noice for displaying documentation in nvim-cmp.
      },
    },
    presets = { -- Pre-configured option sets for common UI behaviors.
      bottom_search = false, -- If true, search results (incsearch) are shown at the bottom. False means likely top or popup.
      command_palette = true, -- If true, enables a command palette-like interface for cmdline.
      long_message_to_split = true, -- If true, very long messages will be split into multiple displayable chunks.
      lsp_doc_border = false, -- If true, LSP hover documentation will have a border. False means no border.
    },
  },
  config = function(_, opts) -- Function to run after the plugin is loaded.
    require('noice').setup(opts) -- Initialize Noice with the specified options.

    -- Configuration for nvim-notify, which Noice can use as a backend.
    -- This setup is conditional on Noice actually using nvim-notify (e.g., view = 'notify').
    require('notify').setup {
      stages = 'slide', -- Animation style for notifications: 'slide', 'fade', 'static'.
      timeout = 2500, -- Default timeout in milliseconds for notifications before they disappear.
      top_down = false, -- If true, notifications appear from the top; otherwise, from the bottom.
    }

    -- Set nvim-notify as the default handler for vim.notify().
    -- This ensures that calls to vim.notify() throughout the Neovim config or other plugins
    -- will use nvim-notify, which is now configured and potentially integrated with Noice.
    vim.notify = require 'notify'
  end,
}
