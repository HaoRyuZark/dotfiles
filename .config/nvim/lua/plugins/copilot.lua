return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            {"zbirenbaum/copilot.lua"},
            {"nvim-lua/plenary.nvim", branch ="master"},
        },
        build = "make tiktoken",
        opts = {

        },
        keys = {
            {"<leader>zc", ":CopilotChat<CR>", mode ="n", desc = "Chat with Copilot"},
            {"<leader>ze", ":CopilotChatExplain<CR>", mode ="v", desc = "Explain code"},
            {"<leader>zr", ":CopilotChatReview<CR>", mode ="v", desc = "Review code"},
            {"<leader>zf", ":CopilotChatFix<CR>", mode ="v", desc = "Fix code"},
            {"<leader>zo", ":CopilotChatOptimize<CR>", mode ="v", desc = "Optimize code"},
            {"<leader>zd", ":CopilotChatDocs<CR>", mode ="v", desc = "Generate docs"},
            {"<leader>zt", ":CopilotChatTests<CR>", mode ="v", desc = "Generate tests"},
            {"<leader>zm", ":CopilotChatCommit<CR>", mode ="v", desc = "Generate commit message"},
            {"<leader>zs", ":CopilotChatCommit<CR>", mode ="v", desc = "Generate commit for selection"},
        },
    },
}
