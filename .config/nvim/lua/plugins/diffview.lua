return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  opts = {
    enhanced_diff_hl = true,
    view = {
      merge_tool = { layout = "diff3_mixed" },
    },
  },
  keys = {
    {
      "<leader>Gd",
      function()
        if require("diffview.lib").get_current_view() then
          vim.cmd("DiffviewClose")
        else
          vim.cmd("DiffviewOpen")
        end
      end,
      desc = "Diffview Toggle (VSCode-like changes)",
    },
    { "<leader>Gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
    { "<leader>Gh", ":DiffviewFileHistory<cr>", mode = "x", desc = "Range History" },
    { "<leader>GH", "<cmd>DiffviewFileHistory<cr>", desc = "Repo History" },
    { "<leader>Gm", "<cmd>DiffviewOpen<cr>", desc = "Resolve Conflicts" },
  },
}
