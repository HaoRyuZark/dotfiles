return {
        "https://github.com/ibhagwan/fzf-lua",
        dependencies = {
            "https://github.com/elanmed/fzf-lua-frecency.nvim",
        },
        event = "VeryLazy",
        config = function()
            require("fzf-lua").setup({
                "max-perf",
                winopts = {
                    height = 0.5,
                    width = 1,
                    row = 1,
                },
            })
            require("fzf-lua").register_ui_select()
            require("fzf-lua-frecency").setup({
                display_score = false,
            })
        end,
}
