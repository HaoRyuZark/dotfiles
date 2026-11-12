-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Spacing
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Row numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#51B3EC", bold = true })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#ea8648", bold = true })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#ea8648", bold = true })

-- Auto indent
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = false

-- Swaps Backupds and Undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Mouse Support
vim.opt.mouse = "a"

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Visuals
vim.opt.termguicolors = true
vim.opt.showmatch = true
vim.opt.background = "dark"
vim.opt.scrolloff = 10 -- Lines visible below the cursor
vim.opt.signcolumn = "yes" -- keeps signcolumn on

-- Show substitutions on a split view
vim.opt.inccommand = "split"

-- SHow cursor line
vim.opt.cursorline = true

vim.opt.confirm = true

-- Uniform configuration
vim.g.editorconfig = true

-- Syntax highlighting
vim.cmd("syntax enable")
vim.opt.fillchars:append({ eob = " " })

-- File type recognition
vim.cmd("filetype plugin on")

-- Cursor
vim.opt.concealcursor = ""

vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
vim.opt.shortmess = vim.opt.shortmess + { c = true }

-- Faster CursorHold (diagnostic float, LSP document highlight)
vim.opt.updatetime = 250

-- Show diagnostics on hold, unless another float (hover, peek, ...) is open
vim.api.nvim_create_autocmd("CursorHold", {
	group = vim.api.nvim_create_augroup("user-diagnostic-float", { clear = true }),
	callback = function()
		for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
			if vim.api.nvim_win_get_config(win).relative ~= "" then
				return
			end
		end
		vim.diagnostic.open_float(nil, { focusable = false, scope = "cursor" })
	end,
})

-- Spell Checker for Markdown, tex, text, env and git commit files
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text", "tex", "gitcommit" },
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.spelllang = "en_us"
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})
