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

  local cmp_autopairs_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
  if not cmp_autopairs_ok then
    error("nvim-autopairs.completion.cmp not loaded")
    return
  end

  local cmp_status_ok, cmp = pcall(require, "cmp")
  if not cmp_status_ok then
    error("cmp not loaded")
    return
  end
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
end

return M
