local M = {}

local g = vim.g

function M.bootstrap()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
      "git", "clone", "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)
end

function M.disabled_builtins()
  g.loaded_gzip = false
  g.loaded_netrwPlugin = false
  g.loaded_netrwSettngs = false
  g.loaded_netrwFileHandlers = false
  g.loaded_tar = false
  g.loaded_tarPlugin = false
  g.zipPlugin = false
  g.loaded_zipPlugin = false
  g.loaded_2html_plugin = false
  g.loaded_remote_plugins = false
end

function M.getPathConcatenator()
  local sysname = string.lower((vim.uv or vim.loop).os_uname().sysname)
  if string.match(sysname, 'windows') then
    return '\\'
  else
    return '/'
  end
end

function M.makePath(paths)
  local concatonator = M.getPathConcatenator()
  local returnPath = ""
  for _, path in ipairs(paths) do
    returnPath = returnPath .. concatonator .. path
  end
  return returnPath
end

return M
