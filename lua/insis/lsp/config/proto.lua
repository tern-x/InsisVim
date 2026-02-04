local common = require("insis.lsp.common-config")

-- 核心配置参数（保留业务逻辑，适配新版 API）
local config = {
  capabilities = common.capabilities,
  flags = common.flags,
  on_attach = function(client, bufnr)
    -- common.disableFormat(client)
    common.keyAttach(bufnr)
  end,
  -- buf LSP 根目录识别规则
  root_dir = require("lspconfig.util").root_pattern(
    "buf.yaml",
    "buf.lock",
    "proto",
    ".git",
    "go.mod",
    "package.json"
  ),
  -- buf LSP 专属配置
  settings = {
    buf = {
      lint = {
        enable = true,
        ignore = {}
      },
      format = {
        enable = true
      }
    }
  },
  -- 指定 LSP 服务名称（新版必备）
  name = "buf",
  filetypes = { "proto" },
  -- 指定 LSP 命令路径（新版规范）
  cmd = { "buf", "language-server", "--stdio" }
}

-- 新版 on_setup 函数：使用 vim.lsp 相关 API
return {
  on_setup = function(_server)
    vim.lsp.config("buf_ls", config)
    vim.lsp.enable("buf_ls")
  end
}
