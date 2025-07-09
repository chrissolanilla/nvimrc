-- return {
--   "RayenMnif/tgpt.nvim",
--   cmd = { "Chat", "RateMyCode", "CheckForBugs" },
--   keys = {
--     { "<leader>ai", "<cmd>Chat<cr>", desc = "TGPT: Interactive Chat" },
--     { "<leader>ar", "<cmd>RateMyCode<cr>", desc = "TGPT: Rate My Code" },
--     { "<leader>ab", "<cmd>CheckForBugs<cr>", desc = "TGPT: Check for Bugs" },
--   },
--   config = function()
--     require("tgpt").setup()
--   end
-- }
--
--
return {
  dir = "~/Desktop/tgpt.nvim",  -- points to your local version
  config = function()
    require("tgpt").setup()
  end,
  cmd = { "Chat" },
  keys = {
    { "<leader>ai", "<cmd>Chat<CR>", desc = "Chat with tgpt" },
	{ "<leader>ar", "<cmd>RateMyCode<cr>", desc = "TGPT: Rate My Code" },
    { "<leader>ab", "<cmd>CheckForBugs<cr>", desc = "TGPT: Check for Bugs" },

  },
}

