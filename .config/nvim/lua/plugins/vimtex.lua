return {
	"lervag/vimtex",
	-- VimTeX must not be lazy loaded.
	lazy = false,
	init = function()
		vim.g.tex_flavor = "latex"
		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_quickfix_mode = 0
		vim.g.vimtex_quickfix_open_on_warning = 0
		vim.g.vimtex_mappings_enabled = 1
		vim.g.vimtex_syntax_enabled = 1

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("user-vimtex", { clear = true }),
			pattern = "tex",
			callback = function(event)
				vim.opt_local.conceallevel = 2
				vim.opt_local.wrap = false
				vim.opt_local.linebreak = true

				local ok, wk = pcall(require, "which-key")
				if ok then
					wk.add({ { "<localleader>l", group = "LaTeX (VimTeX)", buffer = event.buf } })
				end
			end,
		})
	end,
}
