-- Define only the needed prompts
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

return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    },
    opts = {
      question_header = ' Me ',
      answer_header = ' Copilot ',
      error_header = ' Error ',
      model = 'gpt-4o',
      prompts = prompts,
      window = {
        layout = 'float',
        border = 'rounded',
        title = 'Copilot Chat  ',
        width = 0.75,
        height = 0.75,
      },
    },
    cmd = {
      'CopilotChatCommitSmart',
      'CopilotChatVisualPrompt',
      'CopilotChatBufferPrompt',
      'CopilotChatReset',
      'CopilotChatModels',
      'CopilotChatAgents',
    },
    config = function(_, opts)
      local chat = require 'CopilotChat'
      chat.setup(opts)

      local select = require 'CopilotChat.select'

      -- Smart Commit command
      vim.api.nvim_create_user_command('CopilotChatCommitSmart', function()
        chat.ask(prompts.SmartCommit, {
          context = { 'git:staged', 'git:unstaged' },
        })
      end, {})

      -- Visual selection prompt
      vim.api.nvim_create_user_command('CopilotChatVisualPrompt', function()
        chat.select_prompt {
          context = { 'visual' },
        }
      end, { nargs = '*', range = true })

      -- Buffer-wide prompt
      vim.api.nvim_create_user_command('CopilotChatBufferPrompt', function()
        chat.select_prompt {
          selection = select.buffer,
        }
      end, {})

      -- Auto config for Copilot buffers
      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = 'copilot-*',
        callback = function()
          vim.opt_local.relativenumber = true
          vim.opt_local.number = true
          if vim.bo.filetype == 'copilot-chat' then
            vim.bo.filetype = 'markdown'
            vim.opt_local.conceallevel = 2
            vim.opt_local.concealcursor = 'nc'
          end
        end,
      })
    end,

    keys = {
      {
        '<leader>ac',
        '<cmd>CopilotChatCommitSmart<cr>',
        desc = 'CopilotChat - Smart Commit message',
      },
      {
        '<leader>av',
        ':CopilotChatVisualPrompt<cr>',
        mode = 'x',
        desc = 'CopilotChat - Select prompt for visual selection',
      },
      {
        '<leader>ab',
        ':CopilotChatBufferPrompt<cr>',
        mode = 'n',
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
        '<leader>ai',
        function()
          local input = vim.fn.input 'Ask Copilot   (visual): '
          if input ~= '' then
            require('CopilotChat').ask(input, {
              context = { 'visual' },
            })
          end
        end,
        mode = 'x',
        desc = 'CopilotChat - Ask with manual prompt (visual)',
      },
      {
        '<leader>ai',
        function()
          local input = vim.fn.input 'Ask Copilot   (buffer): '
          if input ~= '' then
            require('CopilotChat').ask(input, {
              context = { 'buffer' },
            })
          end
        end,
        mode = 'n',
        desc = 'CopilotChat - Ask with manual prompt (buffer)',
      },
    },
  },
}
