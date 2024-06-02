return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-fzf-native.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
    },

    keys = {
        {
            "<leader>sf",
            function()
                local telescope = require("telescope")

                local function telescope_buffer_dir()
                    return vim.fn.expand("%:p:h")
                end

                telescope.extensions.file_browser.file_browser({
                    path = "%:p:h",
                    cwd = telescope_buffer_dir(),
                    respect_gitignore = false,
                    hidden = true,
                    grouped = true,
                    previewer = false,
                    initial_mode = "normal",
                    layout_config = { height = 40 },
                })
            end,
            desc = "Open File Browser with the path of the current buffer",
        },
        {
            "<leader>pf",
            function()
                require("telescope.builtin").find_files({
                    no_ignore = false,
                    hidden = true,
                })
            end,
            desc = "Lists files in your current working directory, respects .gitignore",
        },
        {
            "<C-p>",
            function()
                require("telescope.builtin").git_files()
            end,
            desc = "Search through Git files",
        },
        {
            "<leader>pws",
            function()
                local word = vim.fn.expand("<cword>")
                require("telescope.builtin").grep_string({ search = word })
            end,
            desc = "Search for the word under the cursor in the current working directory",
        },
        {
            "<leader>pWs",
            function()
                local word = vim.fn.expand("<cWORD>")
                require("telescope.builtin").grep_string({ search = word })
            end,
            desc = "Search for the WORD under the cursor in the current working directory",
        },
        {
            "<leader>ps",
            function()
                require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
            end,
            desc = "Prompt for a string and search in the current working directory",
        },
        {
            "<leader>vh",
            function()
                require("telescope.builtin").help_tags()
            end,
            desc = "Lists available help tags",
        },
    },

    config = function(_, opts)
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local fb_actions = require("telescope").extensions.file_browser.actions

        opts = opts or {}
        opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
            wrap_results = true,
            layout_strategy = "horizontal",
            layout_config = { prompt_position = "top" },
            sorting_strategy = "ascending",
            winblend = 0,
            mappings = {
                n = {},
            },
        })
        opts.pickers = vim.tbl_deep_extend("force", opts.pickers or {}, {
            diagnostics = {
                theme = "ivy",
                initial_mode = "normal",
                layout_config = {
                    preview_cutoff = 9999,
                },
            },
        })
        opts.extensions = vim.tbl_deep_extend("force", opts.extensions or {}, {
            file_browser = {
                theme = "dropdown",
                hijack_netrw = true,
                mappings = {
                    ["n"] = {
                        ["N"] = fb_actions.create,
                        ["h"] = fb_actions.goto_parent_dir,
                        ["<C-u>"] = function(prompt_bufnr)
                            for i = 1, 10 do
                                actions.move_selection_previous(prompt_bufnr)
                            end
                        end,
                        ["<C-d>"] = function(prompt_bufnr)
                            for i = 1, 10 do
                                actions.move_selection_next(prompt_bufnr)
                            end
                        end,
                    },
                },
            },
        })

        telescope.setup(opts)
        telescope.load_extension("fzf")
        telescope.load_extension("file_browser")
    end,
}
