-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Moving Lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv'", { desc = "Moves lines down in visual mode"})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv'", { desc = "Moves lines up in visual mode"})


 -- the how it be paste
vim.keymap.set("x", "<leader>p", [["_dP]])

-- remember yanked
vim.keymap.set("v", "p", '"_dp', opts)

-- Copies or Yank to system clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]], opts)


--Stars new tmux session from in here
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Splits
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
-- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
-- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
-- close current split window
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- tab stuff
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>")   --open new tab
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>") --close current tab
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>")     --go to next
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>")     --go to pre
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>") --open current tab in new tab

vim.keymap.set("n", "<leader>cd", vim.cmd.Ex, { desc = "Opens the netrw File Explorer"})

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
