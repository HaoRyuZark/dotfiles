return {
	-- Inline suggestions; <Tab> accept is handled in blink-cmp.lua
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			suggestion = {
				enabled = true,
				auto_trigger = true,
				hide_during_completion = false,
				debounce = 75,
				keymap = {
					accept = false,
					accept_word = "<C-Right>",
					accept_line = false,
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
			},
			panel = {
				enabled = true,
				auto_refresh = true,
				layout = { position = "right", ratio = 0.4 },
				keymap = { open = "<M-CR>" },
			},
			filetypes = {
				markdown = true,
				gitcommit = true,
				yaml = true,
				help = false,
				["."] = false,
			},
		},
		keys = {
			{
				"<leader>zT",
				function()
					require("copilot.suggestion").toggle_auto_trigger()
				end,
				desc = "Toggle Copilot Suggestions",
			},
		},
	},

	-- Chat panel (VSCode-like, right side). Prompts are also commands: :CopilotChat<Prompt>
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"zbirenbaum/copilot.lua",
		},
		build = "make tiktoken",
		cmd = {
			"CopilotChat",
			"CopilotChatOpen",
			"CopilotChatClose",
			"CopilotChatToggle",
			"CopilotChatStop",
			"CopilotChatReset",
			"CopilotChatSave",
			"CopilotChatLoad",
			"CopilotChatPrompts",
			"CopilotChatModels",
			"CopilotChatExplain",
			"CopilotChatReview",
			"CopilotChatFix",
			"CopilotChatOptimize",
			"CopilotChatDocs",
			"CopilotChatTests",
			"CopilotChatCommit",
		},
		opts = {
			window = {
				layout = "vertical",
				width = 0.4,
				title = "Copilot Chat",
			},
			auto_insert_mode = true,
			insert_at_end = true,
			show_help = true,
		},
		keys = {
			{ "<leader>zc", "<cmd>CopilotChatToggle<cr>", mode = { "n", "x" }, desc = "Toggle Copilot Chat" },
			{ "<C-A-i>", "<cmd>CopilotChatToggle<cr>", mode = { "n", "x", "i" }, desc = "Toggle Copilot Chat" },
			{
				"<leader>zq",
				function()
					-- Leave visual mode so the '< '> marks used as default context are set
					if vim.fn.mode():match("[vV\22]") then
						vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "nx", false)
					end
					vim.ui.input({ prompt = "Quick Chat: " }, function(input)
						if input and input ~= "" then
							require("CopilotChat").ask(input)
						end
					end)
				end,
				mode = { "n", "x" },
				desc = "Quick Chat",
			},
			{ "<leader>zm", "<cmd>CopilotChatModels<cr>", desc = "Select Chat Model" },
			{ "<leader>zp", "<cmd>CopilotChatPrompts<cr>", mode = { "n", "x" }, desc = "Select Chat Prompt" },
			{ "<leader>zx", "<cmd>CopilotChatReset<cr>", desc = "Reset Chat" },
			{ "<leader>zs", "<cmd>CopilotChatStop<cr>", desc = "Stop Chat Output" },
			{
				"<leader>zS",
				function()
					vim.ui.input({ prompt = "Save chat as: " }, function(name)
						if name and name ~= "" then
							require("CopilotChat").save(name)
						end
					end)
				end,
				desc = "Save Chat",
			},
			{ "<leader>ze", "<cmd>CopilotChatExplain<cr>", mode = "x", desc = "Explain Selected Code" },
			{ "<leader>zr", "<cmd>CopilotChatReview<cr>", mode = "x", desc = "Review Selected Code" },
			{ "<leader>zf", "<cmd>CopilotChatFix<cr>", mode = "x", desc = "Fix Selected Code" },
			{ "<leader>zo", "<cmd>CopilotChatOptimize<cr>", mode = "x", desc = "Optimize Selected Code" },
			{ "<leader>zd", "<cmd>CopilotChatDocs<cr>", mode = "x", desc = "Document Selected Code" },
			{ "<leader>zt", "<cmd>CopilotChatTests<cr>", mode = "x", desc = "Generate Tests" },
			{ "<leader>zC", "<cmd>CopilotChatCommit<cr>", desc = "Generate Commit Message" },
		},
	},
}
