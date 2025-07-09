return {
    'chrissolanilla/image_preview.nvim',
    event = 'VeryLazy',
    config = function()
        require("image_preview").setup({
            preview_key = "<leader>m" -- Your custom key binding
        })
    end
}
