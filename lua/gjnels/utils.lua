local M = {}

--@param plugin string
function M.has(plugin)
  return require('lazy.core.config').plugins[plugin] ~= nil
end

--@param name 'autocmds' | 'keymaps' | 'options'
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

return M
