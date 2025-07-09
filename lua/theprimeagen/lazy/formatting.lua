return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters = {
				jsbeautify = {
					command = "js-beautify",
					args = { "--config", "/Users/ch862076/.jsbeautifyrc", "-r", "$FILENAME" },
					stdin = false, -- `js-beautify` does not support stdin
				},
				eslint = {
					command = "eslint",
					args = {
						"--fix",                        -- Enable fixing
						"--config", "/Users/ch862076/.eslint.config.mjs", -- Global ESLint config
						"$FILENAME",                    -- Pass the file path directly
					},
					tempfile = false,                   -- Disable tempfile (pass file path instead)
					stdin = false,                      -- Disable stdin to avoid piped input issues
				},
				stylua = {
					command = "stylua",
					args = { "-" },
					stdin = true, -- `stylua` supports stdin
				},
			},
			formatters_by_ft = {
				html = { "jsbeautify" }, -- Use `js-beautify` for HTML files
				javascript = { "eslint" },
				typescript = { "eslint" },
				javascriptreact = { "eslint" },
				typescriptreact = { "eslint" },
				svelte = { "eslint" },
				css = { "eslint" },
				json = { "eslint" },
				yaml = { "eslint" },
				markdown = { "eslint" },
				graphql = { "eslint" },
				lua = { "stylua" },
				python = { "isort", "black" },
				cpp = { "clang-format" },
				php = { "eslint" },
			},
			format_on_save = {
				-- Enable autoformatting on save
				lsp_fallback = false,
				async = false,
				timeout_ms = 1000,
			},
		})

		-- Manual formatting keymap
		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}

