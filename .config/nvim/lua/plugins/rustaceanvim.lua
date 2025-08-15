return {
  
  'mrcjkb/rustaceanvim',
  version = '^5', -- Use the latest stable version
  ft = { 'rust' },
  config = function()
    vim.g.rustaceanvim = {
      server = {
        on_attach = function(_, bufnr)
          -- Keybinding to toggle inlay hints
          vim.keymap.set('n', '<Leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, { buffer = bufnr })
        end,
        settings = {
          ['rust-analyzer'] = {
            cargo = { allFeatures = true },
            checkOnSave = { command = 'clippy' },
            inlayHints = {
              enable = true,               -- Enable inlay hints
              typeHints = true,            -- Show type hints
              parameterHints = true,       -- Show parameter hints
              chainingHints = true,        -- Show hints for chained method calls
              closingBraceHints = true,    -- Show closing brace hints
              maxLength = 30,              -- Max length of the hints
            },
          },
        },
      },
    }
  end
}


