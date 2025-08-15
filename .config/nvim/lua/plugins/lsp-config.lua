return {
  
 {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    ensure_installed = {
        "bashls",         -- Bash
        "pyright",        -- Python
        "lua_ls",         -- Lua
        "texlab",         -- LaTeX
        "asm_lsp",        -- Assembly
        "cmake",          -- CMake (common for C/C++/Rust)
      },
    },
   },

   {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = "single" }
      )

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require("lspconfig")
 
      -- Keybindings
      local lsp_keymaps = function ()
          vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, {buffer = 0, desc = 'Hover'})
          vim.keymap.set("n", "<leader>gD", vim.lsp.buf.definition, {buffer = 0, desc = 'Get definition'})
          vim.keymap.set("n", "<leader>gd", vim.lsp.buf.declaration, {buffer = 0, desc = 'Get declaration'})
          vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {buffer = 0, desc = 'Get references'})
          vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, {buffer = 0, desc = 'Get implemenation'})
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {buffer = 0, desc = 'Code action'})
          vim.keymap.set("n", "<leader>df", vim.diagnostic.goto_next, {buffer = 0, desc ='Go to next'})
          vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, {buffer = 0, desc ='Go to previous'})
          vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", {buffer = 0, desc ='Get telescope diagnostics'})
          vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {buffer = 0, desc ='Rename'})
          vim.keymap.set("n", "<leader>fr", require("telescope.builtin").lsp_references, {buffer = 0, desc = 'Get references' })
      end
 
    lspconfig.pyright.setup({
      capabilities = capabilities,
        on_attach = lsp_keymaps,
    })

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
        on_attach = lsp_keymaps,
    })
    lspconfig.asm_lsp.setup({
      capabilities = capabilities,
        on_attach = lsp_keymaps,
    })

    lspconfig.bashls.setup({
      capabilities = capabilities,
        on_attach = lsp_keymaps,
    })

    lspconfig.cmake.setup({
      capabilities = capabilities,
        on_attach = lsp_keymaps,
    })
    
    lspconfig.texlab.setup({
      capabilities = capabilities,
        on_attach = lsp_keymaps,
    })
    end
    },
}

