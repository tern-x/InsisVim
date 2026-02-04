--- @param config InsisProtoConfig
return function(config)
  return {
    getFormatOnSavePattern = function()
      if config.format_on_save then
        return { "*.proto" } -- 确保 proto 文件触发保存格式化
      end
      return {}
    end,

    getTSEnsureList = function()
      return { "proto" }
    end,

    getLSPEnsureList = function()
      if config.lsp == "buf_ls" then
        return { "buf_ls" }
      end
      return {}
    end,

    getLSPConfigMap = function()
      if config.lsp == "buf_ls" then
        return {
          buf = require("insis.lsp.config.proto"),
        }
      end
      return {}
    end,

    getToolEnsureList = function()
      -- 替换为 clang-format，移除 buf
      if config.formatter == "clang-format" then
        return { "clang-format" }
      end
      return {}
    end,

    getNulllsSources = function()
      local null_ls = pRequire("null-ls")
      if not null_ls then
        return {}
      end
      local list = {}

      -- 核心修改：替换 buf 为 clang-format（适配 proto 文件）
      if config.formatter == "clang-format" then
        table.insert(
          list,
          null_ls.builtins.formatting.clang_format.with({
            filetypes = { "proto" }, -- 关联 proto 文件
            -- 自定义 clang-format 参数（可选，适配 proto 格式）
            args = {
              -- "--style={BasedOnStyle: Google, IndentWidth: 2}", -- 自定义风格
              "--style={BasedOnStyle: Google, IndentWidth: " .. config.indent .. "}", -- 自定义风格
              "--assume-filename=.proto"                                              -- 强制识别为 proto 格式
            },
            -- 可选：指定 mason 安装的 clang-format 路径（避免系统路径冲突）
            -- command = vim.fn.stdpath("data") .. "/mason/bin/clang-format",
          })
        )
      end

      -- 可选：保留 buf lint 做语法检查（格式化用 clang-format，检查用 buf）
      if config.linter == "buf" then
        table.insert(
          list,
          null_ls.builtins.diagnostics.buf.with({
            filetypes = { "proto" },
          })
        )
      end
      return list
    end,
    getNeotestAdapters = function()
      return {}
    end,
  }
end
