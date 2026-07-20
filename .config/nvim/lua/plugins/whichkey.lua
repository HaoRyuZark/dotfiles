return {

	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
	  spec = {
		-- Groups
		{ "<leader>f",  group = "Find" },
		{ "<leader>h",  group = "Gitsigns" },
		{ "<leader>ht", group = "Toggle" },
		{ "<leader>g",  group = "LSP" },
		{ "<leader>z",  group = "Copilot" },
		{ "<leader>o",  group = "Terminal" },
		{ "<leader>t",  group = "Tabs" },
		{ "<leader>s",  group = "Noice" },
		{ "<leader>sn", group = "Noice" },
		{ "<leader>r",  group = "Replace" },
		{ "<leader>l",  group = "LaTeX" },
		{ "<leader>c",  group = "All Commands" },

		-- Find / Telescope
		{ "<leader>fg", desc = "Live Grep" },
		{ "<leader>fo", desc = "Open Buffers" },
		{ "<leader>fh", desc = "Help Tags" },
		{ "<leader>fp", desc = "Copy File Path" },
		{ "<leader>fr", desc = "LSP References" },

		-- Gitsigns — Actions
		{ "<leader>hs",  desc = "Stage Hunk",            mode = { "n", "v" } },
		{ "<leader>hr",  desc = "Reset Hunk",            mode = { "n", "v" } },
		{ "<leader>hS",  desc = "Stage Buffer" },
		{ "<leader>hu",  desc = "Undo Stage Hunk" },
		{ "<leader>hR",  desc = "Reset Buffer" },
		{ "<leader>hp",  desc = "Preview Hunk" },
		{ "<leader>hb",  desc = "Blame Line" },
		{ "<leader>hd",  desc = "Diff Against Index" },
		{ "<leader>hD",  desc = "Diff Against Last Commit" },
		{ "<leader>htb", desc = "Toggle Blame Line" },
		{ "<leader>htD", desc = "Toggle Show Deleted" },

		-- LSP
		{ "<leader>gd",  desc = "Go to Definition" },
		{ "<leader>gD",  desc = "Go to Declaration" },
		{ "<leader>gr",  desc = "Go to References" },
		{ "<leader>gi",  desc = "Go to Implementation" },
		{ "<leader>gt",  desc = "Go to Type Definition" },
		{ "<leader>gs",  desc = "Document Symbols" },
		{ "<leader>gws", desc = "Workspace Symbols" },
		{ "<leader>gT",  desc = "Toggle Inlay Hints" },
		{ "<leader>e",   desc = "Show Line Diagnostics" },
		{ "<leader>q",   desc = "Diagnostics to Loclist" },

		-- Copilot
		{ "<leader>zc", desc = "Open Copilot Chat" },
		{ "<leader>ze", desc = "Explain Code",    mode = "v" },
		{ "<leader>zr", desc = "Review Code",     mode = "v" },
		{ "<leader>zf", desc = "Fix Code Issues", mode = "v" },
		{ "<leader>zo", desc = "Optimize Code",   mode = "v" },
		{ "<leader>zd", desc = "Generate Docs",   mode = "v" },
		{ "<leader>zt", desc = "Generate Tests",  mode = "v" },

		-- Terminal
		{ "<leader>ot", desc = "Open Terminal" },

		-- Tabs
		{ "<leader>tc", desc = "Close Tab" },

		-- Noice
		{ "<leader>snl", desc = "Noice Last Message" },
		{ "<leader>snh", desc = "Noice History" },
		{ "<leader>sna", desc = "Noice All" },
		{ "<leader>snd", desc = "Dismiss All" },
		{ "<leader>snt", desc = "Noice Picker" },

		-- Replace
		{ "<leader>rr", desc = "Replace Word Under Cursor" },
		{ "<leader>rn", desc = "Rename Symbol" },

		-- Misc
		{ "<leader>X",  desc = "Make File Executable" },

		-- Split Resizing
		{ "<C-D-Left>",  desc = "Vertical Resize -2" },
		{ "<C-D-Right>", desc = "Vertical Resize +2" },
		{ "<C-D-Up>",    desc = "Horizontal Resize +2" },
		{ "<C-D-Down>",  desc = "Horizontal Resize -2" },

		-- Visual Mode
		{ "J", desc = "Move Lines Down",    mode = "v" },
		{ "K", desc = "Move Lines Up",      mode = "v" },
		{ ">", desc = "Indent",             mode = "v" },
		{ "<", desc = "Un-indent",          mode = "v" },
		{ "p", desc = "Paste (Keep Yank)",  mode = "v" },

		-- General
		{ "<C-c>",   desc = "Clear Search Highlight" },
		{ "<C-a>",   desc = "Select All" },
		{ "<C-p>",   desc = "Find Files" },
		{ "<C-b>",   desc = "Toggle File Explorer" },
		{ "<C-t>",   desc = "Open New Tab" },
		{ "<C-n>",   desc = "Next Tab" },

		{ "<S-A-f>", desc = "Format Code" },
		{ "<Esc>",   desc = "Normal Mode", mode = "t" },

		-- Alt + Number → Switch Tab
		{ "<A-1>", desc = "Go to Tab 1" },
		{ "<A-2>", desc = "Go to Tab 2" },
		{ "<A-3>", desc = "Go to Tab 3" },
		{ "<A-4>", desc = "Go to Tab 4" },
		{ "<A-5>", desc = "Go to Tab 5" },
		{ "<A-6>", desc = "Go to Tab 6" },
		{ "<A-7>", desc = "Go to Tab 7" },
		{ "<A-8>", desc = "Go to Tab 8" },
		{ "<A-9>", desc = "Go to Tab 9" },
	  },
	},

	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = true })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
