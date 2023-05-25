local servers = {
  cssls = {},
  html = {},
  jsonls = {},
  lua_ls = {
    settings = {
      Lua = {
        hint = {
          enable = true,
          arrayIndex = 'Disable', -- "Enable", "Auto", "Disable"
          await = true,
          paramName = 'Disable', -- "All", "Literal", "Disable"
          paramType = false,
          semicolon = 'Disable', -- "All", "SameLine", "Disable"
          setType = true,
        },
        runtime = {
          version = 'LuaJIT',
          special = {
            reload = 'require',
          },
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          checkThirdParty = false,
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = false,
            [vim.fn.stdpath('config') .. '/lua'] = false,
          },
        },
        completion = {
          callSnippet = 'Replace',
          autoRequire = true,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
  tsserver = {
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
      javascript = {
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },
}

return servers
