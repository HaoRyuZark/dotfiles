return {

    "nvim-treesitter/nvim-treesitter", 
    build = ":TSUpdate",

    config = function() 
    --Treesitter
    local config = require("nvim-treesitter.configs")
    config.setup({
	
    highlight = {
    enable = true,
    additional_vim_regex_highlighting=true,
    },

    ident = { enable = true },

    rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
    },

    auto_install = true,
    ensure_installed = { "lua", "haskell", "clojure", 
                         "bash", "yaml", "java", "json", "vim", "make", 
                         "asm", "nix", "rust", "toml", "cpp", "c", 
                         "python", "java", "html", "css", "regex"},
    })


    end
}
