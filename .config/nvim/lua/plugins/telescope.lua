return {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim", },
        config = function()
          require("telescope").setup({
            defaults = {
              vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--hidden",
                "--follow",    -- follow symlinks
                "--smart-case",
                "--glob",
                "!.git/",
              },
            },
            pickers = {
                find_files = {
                    hidden = true, 
                    find_command = {
                      "fd",
                      "--type", "f",
                      "--hidden",
                      "--follow",   -- follow symlinks
                      "--exclude", 
                      ".git",
                },
              },
            },
          })
        end,
}
