-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Moving Lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv'", { desc = "Moves lines down in visual mode"})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv'", { desc = "Moves lines up in visual mode"})

-- remember yanked
vim.keymap.set("v", "p", '"_dp', opts)

--- Splits ------------------------------------------------------------

-- Split vertically
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })

vim.keymap.set("n", "<C-/>", "<C-w>v<C-w>l", { desc = "Split window vertically" })

-- split window horizontally
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })

-- tab stuff
vim.keymap.set("n", "<C-t>", "<cmd>tabnew %<CR>")   --open new tab
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>") --close current tab
vim.keymap.set("n", "<C-n>", "<cmd>tabn<CR>")     --go to next

--- Setting tabs via Alt + number
for i = 1, 9 do
  vim.keymap.set("n", "<A-" .. i .. ">", i .. "gt", { noremap = true, silent = true })
end

-- Lsp 
vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, {buffer = 0, desc = 'Hover'})
vim.keymap.set("n", "<leader>gD", vim.lsp.buf.definition, {buffer = 0, desc = 'Get definition'})
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.declaration, {buffer = 0, desc = 'Get declaration'})
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {buffer = 0, desc = 'Get references'})
vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, {buffer = 0, desc = 'Get implemenation'})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {buffer = 0, desc = 'Code action'})
vim.keymap.set("n", "<leader>df", vim.diagnostic.goto_next, {buffer = 0, desc ='Go to next'})
vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, {buffer = 0, desc ='Go to previous'})
vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", {buffer = 0, desc ='Get telescope diagnostics'})
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {buffer = 0, desc ='Rename'})
vim.keymap.set("n", "<leader>fr", require("telescope.builtin").lsp_references, {buffer = 0, desc = 'Get references' })

-- Neo Tree 
vim.keymap.set("n", "<C-b>", ":Neotree filesystem reveal right<CR>", {desc = 'Open/Close filesystem'}) --open neotree
vim.keymap.set("n", "<C-b>",":Neotree toggle right<CR>", { noremap = true, silent = true }) --close neotree

-- Open terminal in a vertical split with Ctrl-`
vim.keymap.set("n", "<leader>ot", function()
  vim.cmd("split | term")
end, { noremap = true, silent = true, desc = "Open vertical terminal" })

-- Make <Esc> return to Normal mode in terminal
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

-- Select All with Ctrl + a
vim.keymap.set("n","<C-a>", "ggVG", {desc = "Select All"})

--- Telescope 
local builtin = require("telescope.builtin") 
vim.keymap.set("n", "<C-p>", builtin.find_files, {desc = 'Find files'})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = 'Live grep'})
vim.keymap.set("n", "<leader>fo", builtin.buffers, { desc = 'Old files'})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = 'Help tags'})


