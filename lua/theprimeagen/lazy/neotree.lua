return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
        require('neo-tree').setup({})

        -- vim.keymap.set('n', '<leader>pd', , {})a
        vim.keymap.set('n', '<C-j>', '<Cmd>Neotree right<CR>')
        vim.keymap.set('n', '<C-n>', '<Cmd>Neotree close<CR>')
        vim.keymap.set('n', '<C-k>', '<Cmd>Neotree left<CR>')
    end
}
