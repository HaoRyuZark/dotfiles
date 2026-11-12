local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Display all keybinds
map("n", "<leader>c", "<cmd>WhichKey<CR>", { desc = "Show Non Leader Key Commands" })

-- Resizing Splits

map("n", "<C-D-Left>", "<Cmd>vertical resize -2<CR>", opts)
map("n", "<C-D-Right>", "<Cmd>vertical resize +2<CR>", opts)
map("n", "<C-\\>", "<Cmd>vsplit<CR>", opts)
map("n", "<C-s>", "<Cmd>split<CR>", opts)

-- Resize horizontal splits
map("n", "<C-D-Up>", "<Cmd>resize +2<CR>", opts)
map("n", "<C-D-Down>", "<Cmd>resize -2<CR>", opts)

-- Moving Lines in visual mode
map("x", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Moves lines down in visual mode" })
map("x", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Moves lines up in visual mode" })
map("v", ">", ">gv", { desc = "Indents the line" })
map("v", "<", "<gv", { desc = "Un-indents the line" })

-- Remember yanked after pasting
map("x", "p", "P", { desc = "Paste without yanking" })

-- Clear search results
map("n", "<C-c>", ":nohl<CR>", { desc = "Clear search hl", silent = true })

-- Format code: <S-A-f> is defined in lua/plugins/format.lua (conform)

-- Replace the word cursor is on globally
map(
	"n",
	"<leader>rr",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace word cursor is on globally" }
)

-- Executes shell command from in here making file executable
map("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "makes file executable" })

-- Copy filepath to the clipboard
map("n", "<leader>fp", function()
	local filePath = vim.fn.expand("%:~")
	vim.fn.setreg("+", filePath)
	print("File path copied to clipboard: " .. filePath)
end, { desc = "Copy file path to clipboard" })

-- Tab stuff ----------------------------------------------------------

map("n", "<C-t>", "<cmd>tabnew %<CR>") --open new tab
map("n", "<leader>tc", "<cmd>tabclose<CR>") --close current tab
map("n", "<C-n>", "<cmd>tabn<CR>") --go to next

--- Setting tabs via Alt + number
for i = 1, 9 do
	map("n", "<A-" .. i .. ">", i .. "gt", { noremap = true, silent = true })
end

-- LSP keymaps are set buffer-locally in lua/plugins/nvim-lsp.lua via LspAttach.
-- See that file for the full list: <leader>g*, K, <C-k><C-i>, <F2>, <F12>, <S-F12>,
-- <leader>rn, ]d/[d, ]e/[e, <leader>e, <leader>q, etc.
map("n", "<leader>fr", function()
	require("telescope.builtin").lsp_references()
end, { desc = "Get references" })

-- Neo Tree
map("n", "<C-S-e>", ":Neotree toggle right<CR>", { noremap = true, silent = true, desc = "Toggle Neotree (right)" }) --toggle neotree on the right

-- Open terminal in a vertical split with Ctrl-`
map("n", "<C-`>", function()
	vim.cmd("split | term ")
	vim.cmd("startinsert")
end, { noremap = true, silent = true, desc = "Open horizontal terminal" })

-- Make <Esc> return to Normal mode in terminal
map("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

-- Select All with Ctrl + a
map("n", "<C-a>", "ggVG", { desc = "Select All" })

--- Telescope
local builtin = require("telescope.builtin")
map("n", "<C-p>", builtin.find_files, { desc = "Find files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
map("n", "<leader>fo", builtin.buffers, { desc = "Old files" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })

-- VSCode Ctrl+. : spell suggestions on a misspelled word, else LSP code action, else z=
local function spell_suggest()
	if not pcall(function()
		require("fzf-lua").spell_suggest()
	end) then
		vim.cmd.normal({ "z=", bang = true })
	end
end

map({ "n", "x" }, "<C-.>", function()
	local has_action = #vim.lsp.get_clients({ bufnr = 0, method = "textDocument/codeAction" }) > 0
	if vim.fn.mode() ~= "n" then
		if has_action then
			vim.lsp.buf.code_action()
		end
		return
	end
	if vim.wo.spell and vim.fn.spellbadword(vim.fn.expand("<cword>"))[1] ~= "" then
		spell_suggest()
	elseif has_action then
		vim.lsp.buf.code_action()
	elseif vim.wo.spell then
		spell_suggest()
	else
		vim.notify("No code actions or spell checking available", vim.log.levels.INFO)
	end
end, { desc = "Spell suggestions / Code action" })