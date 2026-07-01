-- Moving Lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv'", { desc = "Moves lines down in visual mode"})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv'", { desc = "Moves lines up in visual mode"})
vim.keymap.set("v", ">", ">gv", {desc = "Indents the line"})
vim.keymap.set("v", "<", "<gv", {desc = "Un-indents the line"})

-- Remember yanked after pasting
vim.keymap.set("v", "p", '"_dp')

-- Clear search results
vim.keymap.set("n", "<C-c>", ":nohl<CR>", {desc = "Clear search hl", silent = true})

-- Format code 
vim.keymap.set("n", "<S-A-f>", vim.lsp.buf.format)

-- Replace the word cursor is on globally
vim.keymap.set("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word cursor is on globally" })

-- Executes shell command from in here making file executable
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "makes file executable" })

-- Copy filepath to the clipboard
vim.keymap.set("n", "<leader>fp", function()
    local filePath = vim.fn.expand("%:~")
    vim.fn.setreg("+", filePath)
    print("File path copied to clipboard: " .. filePath)
end, { desc = "Copy file path to clipboard" })

-- Tab stuff ----------------------------------------------------------

vim.keymap.set("n", "<C-t>", "<cmd>tabnew %<CR>")   --open new tab
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>") --close current tab
vim.keymap.set("n", "<C-n>", "<cmd>tabn<CR>")     --go to next

--- Setting tabs via Alt + number
for i = 1, 9 do
  vim.keymap.set("n", "<A-" .. i .. ">", i .. "gt", { noremap = true, silent = true })
end

-- LSP keymaps are set buffer-locally in lua/plugins/nvim-lsp.lua via LspAttach.
-- See that file for the full list: gd, gD, gr, gI, K, <leader>rn, <leader>ca,
-- <S-A-f>, ]d/[d, ]e/[e, <leader>e, <leader>q, <leader>ds, <leader>ws, <F2>, etc.
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


