return {
    
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },

    config = function()
    
    
    require("neo-tree").setup({
        filesystem = {
            filtered_items = {
                visible = true,
                hide_dot_files = false,
                hide_git_ignore = false,
            },
        }
    })    
    
    vim.keymap.set("n", "<leader>e", ":Neotree filesystem reveal right<CR>", {desc = 'Open/Close filesystem'}) --open neotree
    vim.keymap.set("n", "<leader>e",":Neotree toggle right<CR>", { noremap = true, silent = true }) --close neotree


   end,

}
