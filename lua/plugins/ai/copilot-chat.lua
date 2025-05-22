local prompts = {
  -- Code related prompts
  Explain = 'Please explain how the following code works.',
  Review = 'Please review the following code and provide suggestions for improvement.',
  Tests = 'Please explain how the selected code works, then generate unit tests for it.',
  Refactor = 'Please refactor the following code to improve its clarity and readability.',
  FixCode = 'Please fix the following code to make it work as intended.',
  FixError = 'Please explain the error in the following text and provide a solution.',
  BetterNamings = 'Please provide better names for the following variables and functions.',
  Documentation = 'Please provide documentation for the following code.',
  SwaggerApiDocs = 'Please provide documentation for the following API using Swagger.',
  SwaggerJsDocs = 'Please write JSDoc for the following API using Swagger.',
  -- Text related prompts
  Summarize = 'Please summarize the following text.',
  Spelling = 'Please correct any grammar and spelling errors in the following text.',
  Wording = 'Please improve the grammar and wording of the following text.',
  Concise = 'Please rewrite the following text to make it more concise.',
  -- New Smart Commit prompt
  SmartCommit = 'Generate a concise commit message using the Conventional Commits format (e.g., feat, fix, chore). Use only the staged and unstaged Git changes as context.',
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
      debug = false,
      show_help = true,
      prompts = prompts,
      window = {
        layout = 'float',
        border = 'rounded',
      },
    },
    cmd = { 'CopilotChat', 'CopilotChatVisual' },
    config = function(_, opts)
      local chat = require 'CopilotChat'
      chat.setup(opts)

      local select = require 'CopilotChat.select'

      vim.api.nvim_create_user_command('CopilotChatVisual', function(args)
        chat.ask(args.args, { selection = select.visual })
      end, { nargs = '*', range = true })

      vim.api.nvim_create_user_command('CopilotChatInline', function(args)
        chat.ask(args.args, {
          selection = select.visual,
          window = {
            layout = 'float',
            relative = 'cursor',
            width = 1,
            height = 0.4,
            row = 1,
          },
        })
      end, { nargs = '*', range = true })

      vim.api.nvim_create_user_command('CopilotChatBuffer', function(args)
        chat.ask(args.args, { selection = select.buffer })
      end, { nargs = '*', range = true })

      -- SmartCommit: generate commit message from staged + unstaged diffs only
      vim.api.nvim_create_user_command('CopilotChatCommitSmart', function()
        chat.ask(prompts.SmartCommit, {
          context = { 'git:staged', 'git:unstaged' },
        })
      end, {})

      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = 'copilot-*',
        callback = function()
          vim.opt_local.relativenumber = true
          vim.opt_local.number = true
          if vim.bo.filetype == 'copilot-chat' then
            vim.bo.filetype = 'markdown'
          end
        end,
      })
    end,
    keys = {
      {
        '<leader>ap',
        function()
          require('CopilotChat').select_prompt { context = { 'buffers' } }
        end,
        desc = 'CopilotChat - Prompt actions',
      },
      {
        '<leader>ap',
        function()
          require('CopilotChat').select_prompt()
        end,
        mode = 'x',
        desc = 'CopilotChat - Prompt actions',
      },
      { '<leader>ae', '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat - Explain code' },
      { '<leader>at', '<cmd>CopilotChatTests<cr>', desc = 'CopilotChat - Generate tests' },
      { '<leader>ar', '<cmd>CopilotChatReview<cr>', desc = 'CopilotChat - Review code' },
      { '<leader>aR', '<cmd>CopilotChatRefactor<cr>', desc = 'CopilotChat - Refactor code' },
      { '<leader>an', '<cmd>CopilotChatBetterNamings<cr>', desc = 'CopilotChat - Better Naming' },
      { '<leader>av', ':CopilotChatVisual<cr>', mode = 'x', desc = 'CopilotChat - Open in vertical split' },
      { '<leader>ax', ':CopilotChatInline<cr>', mode = 'x', desc = 'CopilotChat - Inline chat' },
      {
        '<leader>ai',
        function()
          local input = vim.fn.input 'Ask Copilot: '
          if input ~= '' then
            vim.cmd('CopilotChat ' .. input)
          end
        end,
        desc = 'CopilotChat - Ask input',
      },
      { '<leader>am', '<cmd>CopilotChatCommit<cr>', desc = 'CopilotChat - Generate commit message for all changes' },
      {
        '<leader>aq',
        function()
          local input = vim.fn.input 'Quick Chat: '
          if input ~= '' then
            vim.cmd('CopilotChatBuffer ' .. input)
          end
        end,
        desc = 'CopilotChat - Quick chat',
      },
      { '<leader>af', '<cmd>CopilotChatFixError<cr>', desc = 'CopilotChat - Fix Diagnostic' },
      { '<leader>al', '<cmd>CopilotChatReset<cr>', desc = 'CopilotChat - Clear buffer and chat history' },
      { '<leader>a?', '<cmd>CopilotChatModels<cr>', desc = 'CopilotChat - Select Models' },
      { '<leader>aa', '<cmd>CopilotChatAgents<cr>', desc = 'CopilotChat - Select Agents' },
      { '<leader>ac', '<cmd>CopilotChatCommitSmart<cr>', desc = 'CopilotChat - Smart Commit message' },
    },
  },
}
