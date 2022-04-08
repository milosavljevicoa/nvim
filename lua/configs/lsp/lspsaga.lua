local M = {}

function M.config()
  local status_ok, lspsaga = pcall(require, "lspsaga")
  if not status_ok then
    return
  end

  lspsaga.setup {
    debug = false,
    use_saga_diagnostic_sign = true,
    -- Diagnostics
    error_sign = "",
    warn_sign = "",
    hint_sign = "",
    infor_sign = "",
    diagnostic_header_icon = "   ",
    -- Code actions
    code_action_icon = " ",
    code_action_prompt = {
      enable = true,
      sign = true,
      sign_priority = 40,
      virtual_text = true,
    },
    finder_definition_icon = "  ",
    finder_reference_icon = "  ",
    max_preview_lines = 10,
    finder_action_keys = {
      open = "o",
      vsplit = "s",
      split = "i",
      quit = "q",
      scroll_down = "<C-f>",
      scroll_up = "<C-b>",
    },
    code_action_keys = {
      quit = "q",
      exec = "<CR>",
    },
    rename_action_keys = {
      quit = "<Esc>",
      exec = "<CR>",
    },
    definition_preview_icon = "  ",
    border_style = "round",
    rename_prompt_prefix = "➤ ",
    server_filetype_map = {},
    diagnostic_prefix_format = "%d. ",
  }
end

function M.mappings(map, opts)
  map("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
  map("n", "CA", "<cmd>Lspsaga code_action<CR>", opts)
  map("n", "GD", "<cmd>Lspsaga preview_definition<CR>", opts)
  map("n", "rn", "<cmd>Lspsaga rename<CR>", opts)

  map("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
  map("n", "gK", "<cmd>Lspsaga signature_help<CR>", opts)

  map("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
  map("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)

  map("n", "<C-f>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts)
  map("n", "<C-b>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", opts)
end

return M
