local M = {}

function M._open(ext)
  local path = vim.fn.tempname() .. "." .. ext
  vim.cmd("edit " .. vim.fn.fnameescape(path))
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_create_autocmd("BufDelete", {
    buffer = bufnr,
    once = true,
    callback = function()
      vim.fn.delete(path)
    end,
  })
end

function M.create()
  vim.ui.select({ "json", "html", "other..." }, {
    prompt = "Temp file extension:",
  }, function(choice)
    if not choice then return end
    if choice == "other..." then
      vim.ui.input({ prompt = "Extension: " }, function(ext)
        if not ext or ext == "" then return end
        M._open(ext)
      end)
    else
      M._open(choice)
    end
  end)
end

return M
