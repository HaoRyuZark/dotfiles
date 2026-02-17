-- Spacing
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Syntax highlighting
vim.cmd("syntax enable")

-- Row numbers
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.fillchars:append {eob = " "}

-- File type recognition
vim.cmd('filetype plugin on')

-- Inline hints
vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())

-- Visuals
vim.opt.termguicolors = true
vim.opt.showmatch = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = false

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Mouse Support
vim.opt.mouse = "a"

-- Lines visible below the cursor 
vim.opt.scrolloff = 10

-- gets rid of line with white spaces
vim.g.editorconfig = true

-- Auto indent
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = false

-- Cursor
vim.opt.concealcursor = ""

vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 300)

-- Show diagnostics
vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- Spell Checker for Markdown, tex, text and env files
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "md", "env", "tex", "txt" },
    callback = function(opts)
        vim.opt.spell = true
        vim.opt.spelllang = "en_us"
    end,
})

vim.g.autoformat = false
