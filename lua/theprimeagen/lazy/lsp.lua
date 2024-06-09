return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        "hrsh7th/cmp-emoji",
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "tsserver",
                "clangd",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
                ["clangd"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.clangd.setup {
                        capabilities = capabilities,
                        cmd = {
                            "clangd",
                            "--header-insertion=never",
                            "--clang-tidy",
                            "--completion-style=detailed",
                            "--log=verbose",
                        },
                        init_options = {
                            clangdFileStatus = true,
                        },
                        root_dir = function()
                            return vim.loop.cwd()
                        end,
                        on_attach = function(client, bufnr)
                            local function buf_set_option(...)
                                vim.api.nvim_buf_set_option(bufnr, ...)
                            end
                            buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
                            local opts = { noremap = true, silent = true }
                            vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
                            vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
                            vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>",
                                opts)
                            vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>",
                                opts)
                            vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>wa",
                                "<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
                            vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>wr",
                                "<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
                            vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>wl",
                                "<Cmd>lua vim.lsp.buf.list_workspace_folders()<CR>", opts)
                            vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>D",
                                "<Cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
                            vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>",
                                opts)
                            vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>",
                                opts)
                            vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
                            vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>e",
                                "<Cmd>lua vim.diagnostic.open_float()<CR>", opts)
                            vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "<Cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
                            vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<Cmd>lua vim.diagnostic.goto_next()<CR>", opts)
                            vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>q",
                                "<Cmd>lua vim.diagnostic.setloclist()<CR>", opts)
                            vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
                        end,
                        settings = {
                            clangd = {
                                compilationDatabaseDirectory = ".",
                                fallbackFlags = {
                                    "-std=c++14",
                                    "-I/home/chrissolanilla/raylib/src",
                                    "-I/home/chrissolanilla/raylib/src/external"
                                },
                            },
                        },
                    }
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
                { name = 'codeium' }, -- adds codeium
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}

