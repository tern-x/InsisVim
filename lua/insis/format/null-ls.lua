local null_ls = pRequire("null-ls")

if not null_ls then
  return
end

null_ls.setup({
  debug = false,
  sources = require("insis.env").getNulllsSources(),
  diagnostics_format = "[#{s}] #{m}",
  on_attach = function(client, bufnr)
    if vim.bo[bufnr].filetype == "proto" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            async = false,
            filter = function(c)
              return c.name == "null-ls" -- 仅调用 null-ls 格式化
            end,
          })
        end,
        desc = "Auto format proto file on save",
      })
    end
  end,
})
