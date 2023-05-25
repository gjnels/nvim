local M = {}

---@param plugin string
function M.has(plugin)
  return require('lazy.core.config').plugins[plugin] ~= nil
end

---@param name 'autocmds' | 'keymaps' | 'options'
function M.load(name)
  local util = require('lazy.core.util')
  local mod = 'gjnels.core.' .. name
  util.try(function()
    require(mod)
  end, {
    msg = 'Failed loading ' .. mod,
    on_error = function(msg)
      local modpath = require('lazy.core.cache').find(mod)
      if modpath then
        util.error(msg)
      end
    end,
  })
end

---@param name string
function M.opts(name)
  local plugin = require('lazy.core.config').plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require('lazy.core.plugin')
  return Plugin.values(plugin, 'opts', false)
end

---@param on_attach fun(client, buffer)
function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

function M.capabilities(ext)
  -- get default capabilites from cmp_nvim_lsp if installed
  local cmp_nvim_lsp_capabilities = {}
  if M.has('cmp_nvim_lsp') then
    cmp_nvim_lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
  end

  return vim.tbl_deep_extend(
    'force',
    {},
    ext or {},
    cmp_nvim_lsp_capabilities,
    { textDocument = { foldingRange = { dynamicRegistration = false, lineFoldingOnly = true } } }
  )
end

-- Run function on VeryLazy event
---@param fn fun()
function M.on_very_lazy(fn)
  vim.api.nvim_create_autocmd('User', {
    pattern = 'VeryLazy',
    callback = function()
      fn()
    end,
  })
end

return M
