local M = {}

function M.config()
  local status_ok, npairs = pcall(require, "nvim-autopairs")
  if not status_ok then
    return
  end

  npairs.setup {
    check_ts = true,
    ts_config = {
      lua = { "string", "source" },
      javascript = { "string", "template_string" },
      java = false,
    },
    disable_filetype = { "TelescopePrompt", "spectre_panel" },
    enable_check_bracket_line = false,
    fast_wrap = {
      map = "<c-b>",
      chars = { "{", "[", "(", '"', "'", "`" },
      pattern = string.gsub([[ [%'%"%)%>%]%)%}%`%,] ]], "%s+", ""),
      offset = 0,
      end_key = "b",
      keys = "tnshaoeudfgcrlqmwvz",
      check_comma = true,
      highlight = "Search",
      highlight_grey = "Comment",
    }
  }
end

return M
