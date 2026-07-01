return  {
        "https://github.com/nvim-treesitter/nvim-treesitter",
        branch = "main", -- necessary for nvim version after .12 > due to a complete rewrite of the API
        build = ":TSUpdate",
        event = "VeryLazy",

        config = function()
            require("nvim-treesitter.config").setup({
                ensure_installed = {
                    "nix",
                    "json",
                    "c",
                    "cpp",
                    'prolog',
                    'haskell',
                    "java", 
                    "python",
                    "rust",
                    "bash",
                    "asm",
                    "typescript",
                    "javascript",
                    "vimdoc",
                    "regex",
                    "html", 
                    "css", 
                    "yaml",
                    "markdown",
                    "latex"
                },
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
            })
        end,
}
 
