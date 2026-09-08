-- colors.lua

function ColorMyPencils(color)
    color = color or "rose-pine"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- 👇 Put highlight overrides OUTSIDE the return
local function FixParamHighlights()
    vim.api.nvim_set_hl(0, "@lsp.type.parameter", { link = "@parameter" })
    vim.api.nvim_set_hl(0, "@variable.parameter", { link = "@parameter" })
    vim.api.nvim_set_hl(0, "@lsp.typemod.variable.parameter", { link = "@parameter" })
end

local function FixPropHighlights()
  -- Treesitter groups seen for attributes/properties
  vim.api.nvim_set_hl(0, "@property", { fg = "#9ccfd8" })       -- cyan-ish
  vim.api.nvim_set_hl(0, "@field",    { fg = "#9ccfd8" })
  vim.api.nvim_set_hl(0, "@variable.member", { fg = "#9ccfd8" })

  -- LSP semantic token equivalents
  vim.api.nvim_set_hl(0, "@lsp.type.property", { link = "@property" })
  vim.api.nvim_set_hl(0, "@lsp.typemod.property", { link = "@property" })
  vim.api.nvim_set_hl(0, "@lsp.typemod.member",   { link = "@property" })
end

FixPropHighlights()
vim.api.nvim_create_autocmd("ColorScheme", { callback = FixPropHighlights })


-- run once
FixParamHighlights()

-- run every time colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = FixParamHighlights,
})

-- plugin specs
return {
    {
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup({
                style = "storm",
                transparent = true,
                terminal_colors = true,
                styles = {
                    keywords = { italic = false },
                    sidebars = "dark",
                    floats = "dark",
                },
            })
        end
    },

    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup({
                disable_background = true,
            })

            vim.cmd("colorscheme rose-pine")
            ColorMyPencils()
        end
    },
}

