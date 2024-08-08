return {
    "3rd/image.nvim",
    event = "VeryLazy",
    cond = function()
        return vim.fn.has("win32") ~= 1
    end,
    dependencies = {
        "leafo/magick",
    },
    opts = {
        backend = "kitty", -- Specify the backend if needed
    },
}

