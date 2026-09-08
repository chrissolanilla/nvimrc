return {
  "lewis6991/gitsigns.nvim",

  opts = {
    signs = {
      add          = { text = "┃" },
      change       = { text = "┃" },
      delete       = { text = "_" },
      topdelete    = { text = "‾" },
      changedelete = { text = "~" },
      untracked    = { text = "┆" },
    },

    current_line_blame = false,

    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",
      delay = 0,
    },
  },

  keys = {
    {
      "<leader>cl",
      "<cmd>Gitsigns toggle_current_line_blame<CR>",
      desc = "Toggle current line blame",
    },
  },
}
