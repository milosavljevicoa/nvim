local M = {}

local g = vim.g

function M.bootstrap()
  if pcall(require, "packer") then
    return
  end

  if vim.fn.input "Download Packer? (y for yes): " ~= "y" then
    return
  end

  local directory = string.format("%s/site/pack/packer/start/", vim.fn.stdpath "data")

  vim.fn.mkdir(directory, "p")

  local out = vim.fn.system(
    string.format("git clone %s %s", "https://github.com/wbthomason/packer.nvim", directory .. "/packer.nvim")
  )

  print(out)
  print "Downloading packer.nvim..."
  print "( You'll need to restart now )"
  vim.cmd [[qa]]
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
  local sysname = string.lower(vim.loop.os_uname().sysname)
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


--[[M.imap = function(keymap, handler, opts)
  if not opts then
    opts = {}
  end
  vim.keymap.set('i', keymap, handler, opts)
end

M.nmap = function(keymap, handler, opts)
  if not opts then
    opts = {}
  end
  vim.keymap.set('n', keymap, handler, opts)
end--]]

return M
