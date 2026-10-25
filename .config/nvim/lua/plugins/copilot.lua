return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      -- See Configuration section for options
    },
    keys = {
      {"<leader>zc", ":CopilotChat<CR>", mode="n", desc="Open Copilot Chat"},
      {"<leader>ze", ":CopilotExplain<CR>", mode="v", desc="Explain Code"},
      {"<leader>zr", ":CopilotChatReview<CR>", mode="v", desc="Review Code"},
      {"<leader>zf", ":CopilotChatFix<CR>", mode="v", desc="Fix Code Issues"},
      {"<leader>zo", ":CopilotChatOptimize<CR>", mode="v", desc="Optimize Code"},
      {"<leader>zd", ":CopilotChatDocs<CR>", mode="v", desc="Generate Docs"},
      {"<leader>zt", ":CopilotChatTests<CR>", mode="v", desc="Generate Tests"},
    },
  },
  -- To set upt run: CopilotChat setup
  {
    "github/copilot.vim",
  },
  -- To set upt run: Copilot setup
  -- :Copilot disable        Globally disable GitHub Copilot inline suggestions.
  -- :Copilot enable         Re-enable GitHub Copilot after :Copilot disable.
}
