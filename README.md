```
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀
⠀⠀⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⠀⠀
⠀⠀⣿⣿⣿⣿⡟⠛⠛⠛⠛⣿⣿⣿⣿⣿⣿⣿⣿⠛⠛⠛⠛⢻⣿⣿⣿⣿⠀⠀
⠀⠀⣿⣿⡟⠛⠃⠀⠀⠀⠀⠛⠛⣿⣿⣿⣿⠛⠛⠀⠀⠀⠀⠘⠛⢻⣿⣿⠀⠀
⣶⣶⣿⣿⡇⠀⠀⠀⢸⣿⣷⣶⠀⣿⣿⣿⣿⠀⠀⠀⠀⣿⣿⣶⡆⢸⣿⣿⣶⣶
⣿⣿⣿⣿⡇⠀⠀⠀⢸⣿⠿⠿⠀⣿⣿⣿⣿⠀⠀⠀⠀⣿⣿⠿⠇⢸⣿⣿⣿⣿
⣿⣿⣿⣿⣧⣤⡄⠀⠀⠀⠀⣤⣤⣿⣿⣿⣿⣤⣤⠀⠀⠀⠀⢠⣤⣼⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣧⣤⣤⣤⣤⣿⣿⣿⣿⣿⣿⣿⣿⣤⣤⣤⣤⣼⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⠀⢹⣿⣿⣿⣿⣿⣿⡇⠀⠀⠘⣿⣿⣿⣿⣿⣿⡇⠀⣿⣿⣿⣿⣿
⣿⣿⡏⠀⠀⠀⠀⠀⢹⣿⣿⣿⣿⠁⠀⠀⠀⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⢻⣿⣿
```

# Neovim Configuration

This is a personalized Neovim configuration.

## Installation

This configuration is designed for modern Neovim (0.8.0 or later, ideally nightly for the latest features) and uses `lazy.nvim` as its plugin manager.

### Prerequisites

Before you begin, ensure you have the following installed:

*   **Neovim**: Version 0.8.0 or higher. Nightly builds are recommended.
*   **Git**: For cloning the repository and managing plugins.
*   **Nerd Font**: Many UI elements and plugins use icons that require a Nerd Font to be installed and configured in your terminal.
*   **Ripgrep (`rg`)**: Used by Telescope for fast searching.
*   **Make**: Required for building the `telescope-fzf-native` extension for Telescope.
*   **(Optional but Recommended) C Compiler**: For building `telescope-fzf-native` and potentially other native extensions for plugins. (e.g., `build-essential` on Debian/Ubuntu, `Xcode Command Line Tools` on macOS).

### Steps

1.  **Backup your existing Neovim configuration** (if any):
    ```bash
    # Backup your current nvim configuration
    mv ~/.config/nvim ~/.config/nvim.bak
    # Backup your local nvim data (optional, but can be useful)
    mv ~/.local/share/nvim ~/.local/share/nvim.bak
    ```

2.  **Clone this repository** into your Neovim configuration directory:
    ```bash
    git clone https://github.com/your-username/your-nvim-repo.git ~/.config/nvim
    ```
    *(Replace `https://github.com/your-username/your-nvim-repo.git` with the actual repository URL if this is a template or fork.)*

3.  **Start Neovim**:
    ```bash
    nvim
    ```
    The `lazy.nvim` plugin manager should automatically bootstrap itself (clone its own code) if it's not already installed. It will then proceed to install all the configured plugins.

4.  **Plugin Installation**:
    When you first start Neovim, `lazy.nvim` will open its UI and show the progress of plugin installation. This might take a few minutes.

    If the UI doesn't open automatically or you need to manage plugins later, you can use these commands:
    *   `:Lazy` or `:LazyVim`: Opens the lazy.nvim interface.
    *   `:Lazy sync`: Synchronizes your configuration (installs missing plugins, cleans unused ones).
    *   `:Lazy update`: Updates installed plugins.

5.  **Post-installation**:
    *   After all plugins are installed, it's a good idea to run `:Lazy sync` one more time and then restart Neovim.
    *   Some LSP servers, linters, and formatters are managed by `mason.nvim`. You can open Mason with `:Mason` to view installed tools or install new ones. Many are configured to install automatically (see `lua/plugins/lsp/lsp.lua` and `lua/plugins/lsp/none-ls.lua`).
    *   If you encounter issues with `telescope-fzf-native`, ensure `make` and a C compiler are correctly installed and try running `:Lazy build telescope-fzf-native.nvim`.

Your Neovim setup should now be ready!

## Usage

This Neovim configuration is built to be both powerful and easy to use once set up. Here's an overview of its core components and how to interact with them:

### Plugin Management (`lazy.nvim`)

*   **Automatic Setup**: `lazy.nvim` handles the installation and loading of all plugins. When you first launch Neovim after cloning this configuration, it will automatically install everything.
*   **Interface**: You can manage plugins using the `:Lazy` command, which opens up an interface to update, clean, sync, or inspect plugins.

### Key Features & Plugins

*   **Fuzzy Finding (`Telescope`)**:
    *   Purpose: Quickly find files, text within files (live grep), buffers, help tags, Git commits, and more.
    *   Usage: Most Telescope pickers are mapped under the `<leader>f` prefix (e.g., `<leader>ff` for files, `<leader>fg` for live grep). Check the "Keybindings" section or `lua/plugins/search/telescope.lua` for more.

*   **LSP & Code Intelligence (`nvim-lspconfig`, `mason.nvim`, `none-ls.nvim`)**:
    *   Purpose: Provides features like auto-completion, go to definition, find references, hover information, diagnostics (errors/warnings), and formatting.
    *   `mason.nvim` (`:Mason`): Manages the installation of LSP servers, linters, and formatters. Many common ones are set to install automatically.
    *   `none-ls.nvim`: Integrates linters and formatters (like Prettier, Stylua, iSort, Ruff, Shellcheck) that don't have native LSP servers.
    *   **Auto-formatting on save** is enabled for supported filetypes via both LSP and `none-ls`.

*   **Completion (`nvim-cmp`)**:
    *   Purpose: Advanced auto-completion engine.
    *   Features: Integrates multiple sources, including LSP, snippets (LuaSnip), buffer content, file paths, and AI code assistants (GitHub Copilot, Codeium). Use `<Tab>` and `<S-Tab>` to navigate suggestions, `<CR>` to confirm.

*   **Syntax Highlighting & More (`nvim-treesitter`)**:
    *   Purpose: Provides faster and more accurate syntax highlighting, indentation, and advanced text objects (e.g., select function, class).
    *   Parsers for common languages are installed automatically.

*   **Git Integration**:
    *   `gitsigns.nvim`: Shows Git change markers (added, modified, deleted lines) in the signcolumn. Provides keymaps under `<leader>g` for hunk operations (stage, reset, preview) and blame.
    *   `lazygit.nvim`: A powerful terminal UI for Git. Toggle it with `<leader>gg`.

*   **Appearance & UI**:
    *   **Themes**: Catppuccin (`frappe` flavour) is the default. Gruvbox and Nord are also configured and can be enabled by changing `lua/plugins/themes/catpuccin.lua` and uncommenting the `colorscheme` command in the respective theme file (e.g., `lua/plugins/themes/gruvbox.lua`).
    *   **Dashboard (`alpha-nvim`)**: A welcoming dashboard screen on startup with quick shortcuts.
    *   **Statusline (`lualine.nvim`)**: A detailed and informative statusline at the bottom.
    *   **Bufferline (`bufferline.nvim`)**: Improved tab-like display for open buffers at the top.
    *   **File Explorer (`neo-tree.nvim`)**: A modern file explorer, toggle with `<leader>e`. It can also display buffers, Git status, and document symbols.
    *   **Notifications & UI (`noice.nvim`)**: Overhauls Neovim's default UI for messages, command line, and LSP popups for a cleaner look.

*   **Terminals (`toggleterm.nvim`)**:
    *   Purpose: Provides easy access to toggleable terminal windows.
    *   Usage:
        *   `<C-_>` (Control + Underscore): Toggles the main terminal.
        *   `<leader>tf`: Opens a floating terminal.
        *   `<leader>tr`: Runs the current file in a dedicated floating terminal (for Python, Lua, Shell scripts).

*   **AI Code Assistance**:
    *   **GitHub Copilot**: Integrated via `copilot.lua` (for suggestions, often triggered automatically or via cmp) and `CopilotChat.nvim` (for interactive chat, commands under `<leader>a`).
    *   **Codeium**: Integrated via `windsurf.nvim`, providing suggestions through `nvim-cmp`.

*   **Session Management & Quality of Life**:
    *   `persistence.nvim`: Automatically saves and restores your Neovim sessions (open files, window layout). Keymaps under `<leader>p`.
    *   `vim-lastplace`: Remembers the cursor position when you reopen a file.
    *   `nvim-autopairs`: Automatically inserts closing pairs for brackets, quotes, etc.
    *   `vim-better-whitespace`: Highlights and automatically strips trailing whitespace on save.
    *   `todo-comments.nvim`: Highlights `TODO:`, `FIXME:`, etc., in comments.

### Custom Functionalities

*   **Smart Commit Message (`CopilotChat`)**: Use `<leader>ac` to generate a commit message based on staged changes using AI.
*   **File Runner (`toggleterm`)**: As mentioned, `<leader>tr` runs the current file (Python, Lua, Shell) in a terminal.

This configuration aims to provide a comprehensive development environment. Explore the `lua/plugins/` directory and the "Keybindings" section below to discover more.

## Keybindings

This configuration uses `<Space>` as the leader key.

### General & Navigation (`lua/core/keymaps.lua`)

*   **Leader Key**: `Space`
*   `<C-s>` (Normal, Insert): Save file
*   `<C-q>` (Normal): Quit current window
*   `<leader>sn` (Normal): Save file without auto-formatting
*   `<C-a>` (Normal): Select all text in buffer
*   `H` (Normal): Go to the first non-blank character of the current line
*   `L` (Normal): Go to the end of the current line
*   `x` (Normal): Delete character under cursor (without yanking)
*   `<C-d>` / `<C-u>` (Normal): Scroll down/up, keeping cursor centered
*   `n` / `N` (Normal): Next/Previous search result, keeping cursor centered
*   `<M-Up>` / `<M-Down>` (Normal): Resize window height
*   `<M-Left>` / `<M-S-Right>` (Normal): Resize window width
*   `<Tab>` (Normal): Switch to the next buffer
*   `<S-Tab>` (Normal): Switch to the previous buffer
*   `<leader>x` (Normal): Close current buffer
*   `<leader>b` (Normal): Create a new empty buffer
*   `<leader>v` (Normal): Split window vertically
*   `<leader>h` (Normal): Split window horizontally
*   `<leader>se` (Normal): Make split windows equal width & height
*   `<leader>xs` (Normal): Close current split window
*   `<leader>l` (Normal): Switch focus to the next split window
*   `<C-k>` / `<C-j>` / `<C-h>` / `<C-l>` (Normal): Navigate between window splits (Up/Down/Left/Right)
*   `<leader>lw` (Normal): Toggle line wrapping
*   `<` / `>` (Visual): Indent/Unindent selected lines and reselect
*   `p` (Visual): Paste without losing the last yanked text (replaces selection with yanked text)

### Diagnostics (`lua/core/keymaps.lua` & `lua/plugins/coding/trouble.lua`)

*   `[d` (Normal): Go to previous diagnostic message
*   `]d` (Normal): Go to next diagnostic message
*   `<leader>dd` (Normal): Open floating diagnostic message under cursor
*   `<leader>dt` (Normal): Toggle Trouble window for diagnostics
*   `<leader>ds` (Normal): Toggle Trouble window for document symbols

### Telescope (Fuzzy Finding - `lua/plugins/search/telescope.lua`)

*   `<leader>fh`: Find Help tags
*   `<leader>fk`: Find Keymaps
*   `<leader>ff`: Find Files
*   `<leader>fs`: Find/Select Telescope built-in pickers
*   `<leader>fw`: Find Word under cursor (grep string)
*   `<leader>fg`: Find by Grep (live grep)
*   `<leader>fd`: Find Diagnostics
*   `<leader>fr`: Resume last Telescope picker
*   `<leader>f.`: Find Recent Files (oldfiles)
*   `<leader><leader>`: Find existing buffers
*   `<leader>/`: Fuzzily search in current buffer (dropdown theme)
*   `<leader>f/`: Live Grep in Open Files
*   **Inside Telescope Prompt (Insert Mode)**:
    *   `<C-k>`: Move selection to previous result
    *   `<C-j>`: Move selection to next result
    *   `<C-l>`: Open selected item / confirm selection

### Terminals (`lua/plugins/terminal/toggleterm.lua`)

*   `<C-_>` (Control + Underscore): Toggle the main persistent terminal
*   `<leader>tr` (Normal): Run the current file (Python, Lua, Shell) in a floating terminal
*   `<leader>tf` (Normal): Open a generic floating terminal

### Git (`lua/plugins/git/gitsigns.lua` & `lua/plugins/git/lazygit.lua`)

*   **Gitsigns**:
    *   `]g` / `[g` (Normal): Next/Previous Git hunk
    *   `<leader>gs` (Normal): Stage current hunk
    *   `<leader>gr` (Normal): Reset current hunk
    *   `<leader>gS` (Normal): Stage entire buffer
    *   `<leader>gR` (Normal): Reset entire buffer
    *   `<leader>gu` (Normal): Undo stage hunk
    *   `<leader>gp` (Normal): Preview hunk
    *   `<leader>gd` (Normal): Diff current buffer against Git index
    *   `<leader>gD` (Normal): Diff current buffer against HEAD
    *   `<leader>gb` (Normal): Blame current line (full commit info)
*   **LazyGit**:
    *   `<leader>gg` (Normal): Open LazyGit terminal interface

### LSP (Language Server Protocol - `lua/plugins/lsp/lsp.lua`)

*   `gd` (Normal): Go to Definition
*   `gr` (Normal): List References
*   `K` (Normal): Show Hover information
*   `<leader>rn` (Normal): Rename symbol
*   `<leader>ca` (Normal): List Code Actions

### AI (CopilotChat - `lua/plugins/ai/copilot-chat.lua`)

*   `<leader>ac` (Normal): Generate Smart Commit message
*   `<leader>av` (Visual): Select prompt for visual selection
*   `<leader>ab` (Normal): Select prompt for entire buffer
*   `<leader>al` (Normal): Clear CopilotChat buffer and history
*   `<leader>a?` (Normal): Select CopilotChat Models
*   `<leader>aa` (Normal): Select CopilotChat Agents
*   `<leader>ao` (Normal): Open CopilotChat window
*   `<leader>ai` (Visual): Ask CopilotChat with manual prompt (visual selection context)
*   `<leader>ai` (Normal): Ask CopilotChat with manual prompt (entire buffer context)

### Treesitter (`lua/plugins/coding/treesitter.lua`)

*   **Text Object Selection** (Visual / Operator-pending modes):
    *   `af` / `if`: Around/Inside function
    *   `ac` / `ic`: Around/Inside class
    *   `aa` / `ia`: Around/Inside parameter/argument
    *   `ab` / `ib`: Around/Inside block
*   **Text Object Movement** (Normal mode):
    *   `]f` / `[f`: Next/Previous function start
    *   `]c` / `[c`: Next/Previous class start
    *   `]a` / `[a`: Next/Previous parameter start
*   **Text Object Swap** (Normal mode):
    *   `<leader>sa`: Swap current parameter with next
    *   `<leader>sA`: Swap current parameter with previous
*   **LSP Interop** (Normal mode):
    *   `<leader>sf`: Peek definition of function under cursor
    *   `<leader>sc`: Peek definition of class under cursor
*   **Repeatable Movement** (Normal, Visual, Operator-pending modes):
    *   `;`: Repeat last Treesitter text object movement (next)
    *   `,`: Repeat last Treesitter text object movement (previous)

### Session Management (`lua/plugins/session/persistence.lua`)

*   `<leader>ps` (Normal): Restore session for the current directory
*   `<leader>pS` (Normal): Select a session to load from a list
*   `<leader>pl` (Normal): Load the last saved session
*   `<leader>pd` (Normal): Don't save the current session on exit

### File Explorer (`lua/plugins/appearance/neotree.lua`)

*   `<leader>e` (Normal): Toggle Neo-tree file explorer (opens on the right)
*   `<leader>ngs` (Normal): Show Git status in a floating Neo-tree window
*   *(Neo-tree has its own internal keymaps for navigation and file operations when its window is active. Use `?` in Neo-tree for help.)*
