return {
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse", "Gedit" },
    keys = {
      { "<C-S-g>", "<cmd>Git<cr>", desc = "Git Status (fugitive)" },
      { "<leader>Gg", "<cmd>Git<cr>", desc = "Git Status (fugitive)" },
      { "<leader>Gc", "<cmd>Git commit<cr>", desc = "Git Commit" },
      { "<leader>Gp", "<cmd>Git push<cr>", desc = "Git Push" },
      { "<leader>GP", "<cmd>Git pull --rebase<cr>", desc = "Git Pull (rebase)" },
      { "<leader>Gb", "<cmd>Git blame<cr>", desc = "Git Blame" },
      { "<leader>Gw", "<cmd>Gwrite<cr>", desc = "Stage File (Gwrite)" },
      { "<leader>Gr", "<cmd>Gread<cr>", desc = "Checkout File (Gread)" },
      { "<leader>Gs", "<cmd>Gvdiffsplit<cr>", desc = "Diff vs Index (Gvdiffsplit)" },
    },
  },
  {
    "rbong/vim-flog",
    dependencies = { "tpope/vim-fugitive" },
    cmd = { "Flog", "Flogsplit", "Floggit" },
    keys = {
      { "<leader>Gl", "<cmd>Flog<cr>", desc = "Git Log Graph" },
      { "<leader>GL", "<cmd>Flog -path=%<cr>", desc = "File Log Graph" },
    },
  },
}
