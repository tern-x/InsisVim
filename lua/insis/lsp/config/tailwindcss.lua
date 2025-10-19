-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#tailwindcss

local common = require("insis.lsp.common-config")
local opts = {

  on_attach = function(_, bufnr)
    common.keyAttach(bufnr)
  end,
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "classList", "ngClass" },
      includeLanguages = {
        eelixir = "html-eex",
        eruby = "erb",
        htmlangular = "html",
        templ = "html",
      },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning",
      },
      validate = true,
    },
  },
}
return {
  on_setup = function(_)
    vim.lsp.config("tailwindcss", opts)
    vim.lsp.enable("tailwindcss")
  end,
}
