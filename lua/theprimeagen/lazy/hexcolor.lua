return {
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
        require 'colorizer'.setup({
            '*',                      -- Highlight all files
            css = { rgb_fn = true, }, -- Enable parsing rgb(...) functions in css files
            html = { names = false, } -- Disable parsing "names" like Blue or Gray in html files
        }, { mode = 'background' })
    end
}
