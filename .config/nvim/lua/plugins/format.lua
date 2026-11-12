return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  cmd = 'ConformInfo',
  keys = {
    {
      '<S-A-f>',
      function()
        require('conform').format({ async = true })
      end,
      mode = { 'n', 'x' },
      desc = 'Format Code',
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },

      -- Conform will run multiple formatters sequentially
      python = { "isort", "black" },

      -- You can customize some of the format options for the filetype (:help conform.format)
      rust = { "rustfmt", lsp_format = "fallback" },

      -- Conform will run the first available formatter
      javascript = { "prettierd", "prettier", stop_after_first = true },
    },
    default_format_opts = { lsp_format = "fallback" },
    format_on_save = { timeout_ms = 1000, lsp_format = "fallback" },
  },
}
