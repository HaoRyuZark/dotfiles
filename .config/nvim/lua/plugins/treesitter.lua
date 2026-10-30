return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		local treesitter = require("nvim-treesitter")
		-- Prolog uses built-in syntax highlighting; upstream has no parser for it.
		local languages = {
			"nix",
			"json",
			"c",
			"cpp",
			"haskell",
			"java",
			"regex",
			"python",
			"rust",
			"bash",
			"asm",
			"typescript",
			"javascript",
			"vimdoc",
			"html",
			"css",
			"yaml",
			"markdown",
			"latex",
			"http",
			"markdown_inline",
			"vim",
			"php",
			"dockerfile",
		}

		local function enable(bufnr)
			if not vim.api.nvim_buf_is_loaded(bufnr) or vim.bo[bufnr].buftype ~= "" then
				return
			end

			local lang = vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)
			if not lang or not vim.list_contains(treesitter.get_installed("parsers"), lang) then
				return
			end

			vim.treesitter.start(bufnr, lang)
			if vim.treesitter.query.get(lang, "indents") then
				vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end
		end

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("user-treesitter", { clear = true }),
			callback = function(event)
				enable(event.buf)
			end,
		})

		-- Install missing parsers without blocking startup, then activate already-open buffers.
		treesitter.install(languages):await(vim.schedule_wrap(function(err, success)
			if err then
				vim.notify("Tree-sitter installation failed: " .. tostring(err), vim.log.levels.ERROR)
				return
			end
			if success == false then
				vim.notify("Some Tree-sitter parsers failed to install; see :messages", vim.log.levels.ERROR)
			end

			for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
				enable(bufnr)
			end
		end))
	end,
}
