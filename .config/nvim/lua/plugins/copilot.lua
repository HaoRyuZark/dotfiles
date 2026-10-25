return {
	-- GitHub Copilot: inline code suggestions
	{
		"github/copilot.vim",

		init = function()
			-- Prevent Copilot's default Tab mapping from conflicting
			-- with other completion plugins.
			-- vim.g.copilot_no_tab_map = true
		end,

		-- Setup / management commands:
		-- :Copilot setup          Authenticate with GitHub Copilot
		-- :Copilot status         Check authentication and status
		-- :Copilot enable         Enable inline suggestions
		-- :Copilot disable        Disable inline suggestions
		-- :Copilot panel          Open the suggestion panel
		-- :Copilot signout        Sign out of GitHub Copilot
		--
		-- Functionality:
		-- - Inline code completions as you type
		-- - Accept suggestions with your configured key
		-- - Dismiss suggestions and navigate alternatives
		--
		-- Note:
		-- Configure a custom suggestion-acceptance key if needed.
		-- Tab completion is disabled above to avoid key conflicts.
	},

	-- CopilotChat: interactive AI assistant and tool calling
	{
		"CopilotC-Nvim/CopilotChat.nvim",

		dependencies = {
			"nvim-lua/plenary.nvim",
		},

		build = "make tiktoken",

		opts = {
			-- Use the plugin defaults initially.
			-- Customize prompts, models, and window settings here.
			window = {
				layout = "vertical",
				width = 0.5,
			},
		},

		keys = {
			-- Chat
			{
				"<leader>zc",
				"<cmd>CopilotChatToggle<CR>",
				mode = "n",
				desc = "Toggle Copilot Chat",
			},

			-- Explain selected code
			{
				"<leader>ze",
				"<cmd>CopilotChatExplain<CR>",
				mode = "v",
				desc = "Explain Selected Code",
			},

			-- Review selected code
			{
				"<leader>zr",
				"<cmd>CopilotChatReview<CR>",
				mode = "v",
				desc = "Review Selected Code",
			},

			-- Fix selected code
			{
				"<leader>zf",
				"<cmd>CopilotChatFix<CR>",
				mode = "v",
				desc = "Fix Selected Code",
			},

			-- Optimize selected code
			{
				"<leader>zo",
				"<cmd>CopilotChatOptimize<CR>",
				mode = "v",
				desc = "Optimize Selected Code",
			},

			-- Generate documentation
			{
				"<leader>zd",
				"<cmd>CopilotChatDocs<CR>",
				mode = "v",
				desc = "Document Selected Code",
			},

			-- Generate tests
			{
				"<leader>zt",
				"<cmd>CopilotChatTests<CR>",
				mode = "v",
				desc = "Generate Tests",
			},
		},

		-- Setup / management commands:
		-- :CopilotChat              Open a chat session
		-- :CopilotChatToggle        Toggle the chat window
		-- :CopilotChatPrompts       Browse available prompts
		-- :CopilotChatModels        Select an available model
		-- :CopilotChatStop          Stop the current response
		-- :CopilotChatReset         Reset the current conversation
		-- :CopilotChatSave          Save the conversation
		--
		-- Functionality:
		-- - Ask questions about code and project context
		-- - Explain, review, fix, and optimize code
		-- - Generate documentation and tests
		-- - Work with buffer contents and Git diffs
		-- - Use supported tools for file operations and commands
		-- - Review proposed changes and approve tool calls
		--
		-- Setup:
		-- 1. Install/build plugins with your lazy.nvim setup.
		-- 2. Run :Copilot setup to authenticate if necessary.
		-- 3. Run :checkhealth copilot to diagnose Copilot issues.
		-- 4. Open chat with <leader>zc.
	},
}
