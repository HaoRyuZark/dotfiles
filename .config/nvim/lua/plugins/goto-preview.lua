-- Peek definition in a float (VSCode ctrl+space d = showDefinitionPreviewHover)
return {
	"rmagatti/goto-preview",
	dependencies = { "rmagatti/logger.nvim" },
	event = "LspAttach",
	opts = {
		border = "rounded",
		default_mappings = false,
	},
	keys = {
		{
			"<C-Space>d",
			function()
				require("goto-preview").goto_preview_definition()
			end,
			desc = "Peek Definition",
		},
		{
			"<leader>gp",
			function()
				require("goto-preview").goto_preview_definition()
			end,
			desc = "Peek Definition",
		},
		{
			"<leader>gP",
			function()
				require("goto-preview").close_all_win()
			end,
			desc = "Close Peek Windows",
		},
	},
}
