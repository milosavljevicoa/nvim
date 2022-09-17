local M = {}

function M.config()
  local status_ok, lualine = pcall(require, "lualine")
  if not status_ok then
    return
  end

  lualine.setup({
    options = {
      icons_enabled = true,
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = {},
      always_divide_middle = true,
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff' },
      lualine_c = {
        {
          'diagnostics',

          -- Table of diagnostic sources, available sources are:
          --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
          sources = { 'nvim_lsp' },

          -- Displays diagnostics for the defined severity types
          sections = { 'error', 'warn', 'info', 'hint' },

          diagnostics_color = {
            -- Same values as the general color option can be used here.
            error = 'DiagnosticError', -- Changes diagnostics' error color.
            warn  = 'DiagnosticWarn', -- Changes diagnostics' warn color.
            info  = 'DiagnosticInfo', -- Changes diagnostics' info color.
            hint  = 'DiagnosticHint', -- Changes diagnostics' hint color.
          },
          symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
          colored = true, -- Displays diagnostics status in color if set to true.
          update_in_insert = false, -- Update diagnostics in insert mode.
          always_visible = true, -- Show diagnostics even if there are none.
        },
        {
          'filename',
          file_status = true,
          newfile_status = true,
          -- 0: Just the filename 1: Relative path 2: Absolute path 3: Absolute path, with tilde as the home directory
          path = 1,
          -- Shortens path to leave 40 spaces in the window
          --[[ shorting_target = 40, ]]
          symbols = {
            modified = ' ', -- Text to show when the file is modified.
            readonly = ' ', -- Text to show when the file is non-modifiable or readonly.
            unnamed = '[No Name]', -- Text to show for unnamed buffers.
            newfile = ' ', -- Text to show for new created file before first writting
          }
        }
      },
      lualine_x = {},
      lualine_y = { 'filetype' },
      lualine_z = { 'progress' },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    extensions = {}
  })
end

return M
