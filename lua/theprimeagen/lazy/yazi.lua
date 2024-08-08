return {
    "chrissolanilla/yazi.nvim",
    event = "VeryLazy",
    keys = {
        {
            "<leader>a",
            function()
                require("yazi").yazi()
            end,
            desc = "Open the file manager",
        },
        {
            "<leader>cw",
            function()
                require("yazi").yazi(nil, vim.fn.getcwd())
            end,
            desc = "Open the file manager in nvim's working directory",
        },
        {
            '<c-up>',
            function()
                require('yazi').toggle()
            end,
            desc = "Resume the last yazi session",
        },
    },
    opts = {
        open_for_directories = false,
        use_ya_for_events_reading = false,
        use_yazi_client_id_flag = false,
        keymaps = {
            show_help = '<f1>',
        },
    },
    config = function()
        local yazi = require("yazi")
        yazi.setup({
            -- Add your yazi configuration here
        })

        -- Function to render images
        local function render_image_preview(file)
            local image_api = require("image")
            if file:match("%.png$") or file:match("%.jpg$") or file:match("%.jpeg$") or file:match("%.gif$") or file:match("%.webp$") or file:match("%.avif$") then
                local img = image_api.from_file(file, { inline = true })
                img:render()
            end
        end

        -- Autocommand to render images when an image file is highlighted in yazi
        vim.api.nvim_create_autocmd("CursorHold", {
            pattern = "*.png,*.jpg,*.jpeg,*.gif,*.webp,*.avif",
            callback = function()
                local file = vim.fn.expand("<afile>")
                render_image_preview(file)
            end,
        })

        -- Clear image preview when leaving the buffer
        vim.api.nvim_create_autocmd("BufLeave", {
            pattern = "*.png,*.jpg,*.jpeg,*.gif,*.webp,*.avif",
            callback = function()
                local image_api = require("image")
                image_api.clear()
            end,
        })
    end,
}
