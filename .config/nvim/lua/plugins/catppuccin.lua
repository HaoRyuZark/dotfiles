return { 

    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,

      config = function()
        require('catppuccin').setup {
          -- leave this setup function empty for default config
          -- or refer to the configuration section
          -- for configuration options
            flavour = "mocha",
        }
      end,

      -- optionally set the colorscheme within lazy config
      init = function()
        vim.cmd("colorscheme catppuccin-mocha")
      end

}
