local map = vim.keymap.set
local opts = { noremap = true, silent = true}

-- Resizing Splits

map("n", "<C-D-Left>",  "<Cmd>vertical resize -2<CR>", opts)
map("n", "<C-D-Right>", "<Cmd>vertical resize +2<CR>", opts)

-- Resize horizontal splits
map("n", "<C-D-Up>",    "<Cmd>resize +2<CR>", opts)
map("n", "<C-D-Down>",  "<Cmd>resize -2<CR>", opts)

-- Moving Lines in visual mode
map("v", "J", ":m '>+1<CR>gv=gv'", { desc = "Moves lines down in visual mode"})
map("v", "K", ":m '<-2<CR>gv=gv'", { desc = "Moves lines up in visual mode"})
map("v", ">", ">gv", {desc = "Indents the line"})
map("v", "<", "<gv", {desc = "Un-indents the line"})

-- Remember yanked after pasting
map("v", "p", '"_dp')

-- Clear search results
map("n", "<C-c>", ":nohl<CR>", {desc = "Clear search hl", silent = true})

-- Format code 
map("n", "<S-A-f>", vim.lsp.buf.format)

-- Replace the word cursor is on globally
map("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word cursor is on globally" })

-- Executes shell command from in here making file executable
map("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "makes file executable" })

-- Copy filepath to the clipboard
map("n", "<leader>fp", function()
    local filePath = vim.fn.expand("%:~")
    vim.fn.setreg("+", filePath)
    print("File path copied to clipboard: " .. filePath)
end, { desc = "Copy file path to clipboard" })

-- Tab stuff ----------------------------------------------------------

map("n", "<C-t>", "<cmd>tabnew %<CR>")   --open new tab
map("n", "<leader>tc", "<cmd>tabclose<CR>") --close current tab
map("n", "<C-n>", "<cmd>tabn<CR>")     --go to next

--- Setting tabs via Alt + number
for i = 1, 9 do
  map("n", "<A-" .. i .. ">", i .. "gt", { noremap = true, silent = true })
end

-- LSP keymaps are set buffer-locally in lua/plugins/nvim-lsp.lua via LspAttach.
-- See that file for the full list: gd, gD, gr, gI, K, <leader>rn, <leader>ca,
-- <S-A-f>, ]d/[d, ]e/[e, <leader>e, <leader>q, <leader>ds, <leader>ws, <F2>, etc.
map("n", "<leader>fr", require("telescope.builtin").lsp_references, {buffer = 0, desc = 'Get references' })

-- Neo Tree 
map("n", "<C-b>", ":Neotree filesystem reveal right<CR>", {desc = 'Open/Close filesystem'}) --open neotree
map("n", "<C-b>",":Neotree toggle right<CR>", { noremap = true, silent = true }) --close neotree

-- Open terminal in a vertical split with Ctrl-`
map("n", "<leader>ot", function()
  vim.cmd("split | term")
end, { noremap = true, silent = true, desc = "Open vertical terminal" })

-- Make <Esc> return to Normal mode in terminal
map("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

-- Select All with Ctrl + a
map("n","<C-a>", "ggVG", {desc = "Select All"})

--- Telescope 
local builtin = require("telescope.builtin") 
map("n", "<C-p>", builtin.find_files, {desc = 'Find files'})
map("n", "<leader>fg", builtin.live_grep, { desc = 'Live grep'})
map("n", "<leader>fo", builtin.buffers, { desc = 'Old files'})
map("n", "<leader>fh", builtin.help_tags, { desc = 'Help tags'})


