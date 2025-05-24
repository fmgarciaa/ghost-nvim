-- This file configures the CopilotChat.nvim plugin, which provides an interactive chat
-- interface with GitHub Copilot.

-- Define a table of pre-defined prompts for common tasks.
-- These prompts can be quickly accessed within the chat interface.
local prompts = {
  SmartCommit = 'Generate a concise commit message using the Conventional Commits format (e.g., feat, fix, chore). Use only the staged and unstaged Git changes as context.',
  BetterNames = 'Suggest clearer and more meaningful names for the variables and functions in the selected code. Return only the improved names as suggestions.',
  AddLogging = 'Insert logging or debugging statements into the selected code to help trace execution or capture errors. Use conventions appropriate for the language.',
  TypeHints = 'Analyze the selected code and add or suggest type annotations if the language supports them. Improve clarity without changing behavior.',
  ComplexityReport = 'Analyze the cyclomatic complexity and structure of the selected code. Identify any overly complex sections and suggest simplifications.',
  SecurityReview = 'Perform a security review of the selected code. Highlight any risky patterns or missing validations and suggest improvements.',
  RefactorToFunction = 'Refactor the selected block of code into a well-named reusable function or method. Maintain the same behavior and include documentation.',
  Pseudocode = 'Convert the selected code into clear and concise pseudocode that describes what the code is doing in plain language, step by step.',
  TranslateToEnglish = 'Explain what the selected code does in plain English. Assume the reader is familiar with programming basics but not this specific language.',
  RegexExplain = 'Explain what this regular expression does, including the meaning of each part. Return only the explanation in natural language.',
}

-- Return the plugin specification for lazy.nvim.
return {
  {
    'CopilotC-Nvim/CopilotChat.nvim', -- The plugin's repository name.
    dependencies = { -- List of plugins that CopilotChat.nvim depends on.
      { 'nvim-lua/plenary.nvim' }, -- Plenary provides utility functions.
    },
    opts = { -- Configuration options for CopilotChat.nvim.
      question_header = ' Me ', -- Header prefix for user questions in the chat. (Icon requires a Nerd Font)
      answer_header = ' Copilot ', -- Header prefix for Copilot's answers. (Icon requires a Nerd Font)
      error_header = ' Error ', -- Header prefix for error messages. (Icon requires a Nerd Font)
      model = 'gpt-4o', -- Specifies the underlying AI model to be used by Copilot Chat.
      prompts = prompts, -- Passes the pre-defined prompts table to the plugin.
      window = { -- Configuration for the chat window.
        layout = 'float', -- Use a floating window for the chat.
        border = 'rounded', -- Use rounded borders for the window.
        title = 'Copilot Chat  ', -- Title of the chat window. (Icon requires a Nerd Font)
        width = 0.75, -- Width of the window as a fraction of the editor width.
        height = 0.75, -- Height of the window as a fraction of the editor height.
      },
    },
    cmd = { -- List of commands that trigger loading of the plugin.
      'CopilotChatCommitSmart',
      'CopilotChatVisualPrompt',
      'CopilotChatBufferPrompt',
      'CopilotChatReset',
      'CopilotChatModels',
      'CopilotChatAgents',
    },
    config = function(_, opts) -- Function to run after the plugin is loaded.
      local chat = require 'CopilotChat' -- Load the main module of the plugin.
      chat.setup(opts) -- Initialize the plugin with the specified options.

      local select = require 'CopilotChat.select' -- Load the selection module for context.

      -- Define a custom user command for generating smart commit messages.
      vim.api.nvim_create_user_command('CopilotChatCommitSmart', function()
        -- Ask Copilot Chat using the 'SmartCommit' prompt and Git context.
        chat.ask(prompts.SmartCommit, {
          context = { 'git:staged', 'git:unstaged' }, -- Provide staged and unstaged changes as context.
        })
      end, {})

      -- Define a custom user command for prompting with visual selection.
      vim.api.nvim_create_user_command('CopilotChatVisualPrompt', function()
        -- Open a prompt selection UI with the visually selected text as context.
        chat.select_prompt {
          context = { 'visual' }, -- Use the visually selected text.
        }
      end, { nargs = '*', range = true }) -- `range = true` allows the command to work with visual selections.

      -- Define a custom user command for prompting with the entire buffer content.
      vim.api.nvim_create_user_command('CopilotChatBufferPrompt', function()
        -- Open a prompt selection UI with the entire buffer content as context.
        chat.select_prompt {
          selection = select.buffer, -- Use the entire buffer content.
        }
      end, {})

      -- Autocommand to configure Copilot Chat buffers when they are entered.
      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = 'copilot-*', -- Apply to buffers whose names start with 'copilot-'.
        callback = function()
          -- Set local options for Copilot Chat buffers.
          vim.opt_local.relativenumber = true -- Show relative line numbers.
          vim.opt_local.number = true -- Show absolute line numbers.
          -- Specific settings for the main chat buffer.
          if vim.bo.filetype == 'copilot-chat' then
            vim.bo.filetype = 'markdown' -- Set filetype to markdown for syntax highlighting.
            vim.opt_local.conceallevel = 2 -- Conceal markdown syntax elements.
            vim.opt_local.concealcursor = 'nc' -- Don't conceal in normal and command mode lines.
          end
        end,
      })
    end,

    keys = { -- Key mappings for CopilotChat.nvim.
      {
        '<leader>ac', -- Key sequence (e.g., <Space>ac).
        '<cmd>CopilotChatCommitSmart<cr>', -- Command to execute.
        desc = 'CopilotChat - Smart Commit message', -- Description for which-key.
      },
      {
        '<leader>av',
        ':CopilotChatVisualPrompt<cr>',
        mode = 'x', -- Visual mode.
        desc = 'CopilotChat - Select prompt for visual selection',
      },
      {
        '<leader>ab',
        ':CopilotChatBufferPrompt<cr>',
        mode = 'n', -- Normal mode.
        desc = 'CopilotChat - Select prompt for entire buffer',
      },
      {
        '<leader>al',
        '<cmd>CopilotChatReset<cr>',
        desc = 'CopilotChat - Clear buffer and chat history',
      },
      {
        '<leader>a?',
        '<cmd>CopilotChatModels<cr>',
        desc = 'CopilotChat - Select Models',
      },
      {
        '<leader>aa',
        '<cmd>CopilotChatAgents<cr>',
        desc = 'CopilotChat - Select Agents',
      },
      {
        '<leader>ao',
        '<cmd>CopilotChat<cr>',
        desc = 'CopilotChat - Open chat window',
      },
      {
        -- Key mapping for asking Copilot with manual input for visual selection.
        '<leader>ai',
        function()
          local input = vim.fn.input 'Ask Copilot   (visual): ' -- Prompt user for input.
          if input ~= '' then -- If input is not empty.
            require('CopilotChat').ask(input, { -- Send the input to Copilot.
              context = { 'visual' }, -- Use visual selection as context.
            })
          end
        end,
        mode = 'x', -- Visual mode.
        desc = 'CopilotChat - Ask with manual prompt (visual)',
      },
      {
        -- Key mapping for asking Copilot with manual input for the entire buffer.
        '<leader>ai',
        function()
          local input = vim.fn.input 'Ask Copilot   (buffer): ' -- Prompt user for input.
          if input ~= '' then -- If input is not empty.
            require('CopilotChat').ask(input, { -- Send the input to Copilot.
              context = { 'buffer' }, -- Use the entire buffer as context.
            })
          end
        end,
        mode = 'n', -- Normal mode.
        desc = 'CopilotChat - Ask with manual prompt (buffer)',
      },
    },
  },
}
