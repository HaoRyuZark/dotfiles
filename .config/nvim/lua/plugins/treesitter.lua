return  {
        "https://github.com/nvim-treesitter/nvim-treesitter",

        branch = "main", -- necessary for nvim version after .12 > due to a complete rewrite of the API
        build = ":TSUpdate",
        event = "VeryLazy",
        
        opts = {
            ensure_installed = {
                    "nix",
                    "json",
                    "c",
                    "cpp",
                    'prolog',
                    'haskell',
                    "java",
                    "regex",
                    "python",
                    "rust",
                    "bash",
                    "asm",
                    "typescript",
                    "javascript",
                    "vimdoc",
                    "bash",
                    "regex",
                    "html",
                    "css",
                    "yaml",
                    "markdown",
                    "latex",
                    "http",
                    "markdown_inline",
                    "vim",
                    "php",
                },
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
                auto_install = true,
        },
}
 
