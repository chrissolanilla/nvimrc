return {
  "m-demare/hlargs.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("hlargs").setup()
    vim.api.nvim_set_hl(0, "Hlargs", { link = "@parameter" })
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        vim.api.nvim_set_hl(0, "Hlargs", { link = "@parameter" })
      end,
    })
  end,
}

-- return {
--   "m-demare/hlargs.nvim",
--   dependencies = { "nvim-treesitter/nvim-treesitter" },
--   config = function()
--     require("hlargs").setup({
--       -- ignore common python receiver names so they keep their original color
--       excluded_argnames = { "self", "cls" },  -- (some versions call this 'ignored_argument_names')
--     })
--
--     -- keep hlargs color aligned with @parameter
--     vim.api.nvim_set_hl(0, "Hlargs", { link = "@parameter" })
--     vim.api.nvim_create_autocmd("ColorScheme", {
--       callback = function()
--         vim.api.nvim_set_hl(0, "Hlargs", { link = "@parameter" })
--       end,
--     })
--   end,
-- }
--
