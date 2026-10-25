return {
	"hyperb1iss/silkcircuit",
	lazy = false,
	priority = 1000,
	config = function()
		require("silkcircuit").setup({
			transparent = false,
			terminal_colors = true,
			dim_inactive = false,
			variant = "glow", -- "neon" | "vibrant" | "soft" | "glow" | "dawn"

			styles = {
				comments = { italic = true },
				keywords = { bold = true },
				functions = { bold = true, italic = true },
				variables = {},
				strings = { italic = true },
			},

			integrations = {
				telescope = true, -- all 39 ship enabled; set one false to skip it
				neotree = true,
				notify = true,
				cmp = true,
				mini = true,
			},
		})
		vim.cmd.colorscheme("silkcircuit")
	end,
}
