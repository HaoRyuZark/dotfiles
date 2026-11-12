return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  },
  cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer", "DBUIRenameBuffer", "DBUILastQueryInfo" },
  keys = {
    { "<C-A-d>", "<cmd>DBUIToggle<cr>", desc = "Toggle Database UI" },
    { "<leader>Du", "<cmd>DBUIToggle<cr>", desc = "Toggle DB UI" },
    { "<leader>Da", "<cmd>DBUIAddConnection<cr>", desc = "Add Connection" },
    { "<leader>Df", "<cmd>DBUIFindBuffer<cr>", desc = "Find DB Buffer" },
    { "<leader>Dr", "<cmd>DBUIRenameBuffer<cr>", desc = "Rename DB Buffer" },
    { "<leader>Dl", "<cmd>DBUILastQueryInfo<cr>", desc = "Last Query Info" },
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_show_database_icon = 1
    vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
    vim.g.db_ui_execute_on_save = 0
    vim.g.db_ui_win_position = "left"
    vim.g.db_ui_use_nvim_notify = 1

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("user_dadbod", { clear = true }),
      pattern = { "sql", "mysql", "plsql" },
      callback = function(ev)
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, remap = true, desc = desc })
        end
        map("n", "<leader>De", "<Plug>(DBUI_ExecuteQuery)", "Execute Query (file)")
        map("x", "<leader>De", "<Plug>(DBUI_ExecuteQuery)", "Execute Selection")
        map("n", "<leader>Ds", "<Plug>(DBUI_SaveQuery)", "Save Query")
      end,
    })
  end,
}
