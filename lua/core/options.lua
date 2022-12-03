local set = vim.opt

local numberOfLines = 4


set.cursorline = true -- Highlight the current line
local group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
local set_cursorline = function(event, value, pattern)
  vim.api.nvim_create_autocmd(event, {
    group = group,
    pattern = pattern,
    callback = function()
      vim.opt_local.cursorline = value
    end,
  })
end
set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("FileType", false, "TelescopePrompt")

set.fileencoding = "utf-8" -- File content encoding for the buffer
set.spelllang = "en" -- Support US english
set.mouse = "a" -- Enable mouse support
set.signcolumn = "yes" -- Always show the sign column
set.foldmethod = "manual" -- Create folds manually
set.completeopt = { "menu", "menuone", "noselect" } -- Options for insert mode completion
set.colorcolumn = "99999" -- Fix for the indentline problem
set.backup = false -- Disable making a backup file
set.background = "dark"
set.expandtab = true -- Enable the use of space in tab
set.hidden = true -- Ignore unsaved buffers
set.hlsearch = true -- Highlight all the matches of search pattern
set.ignorecase = true -- Case insensitive searching
set.smartcase = true -- Case sensitivie searching
set.spell = false -- Disable spelling checking and highlighting
set.showmode = false -- Disable showing modes in command line
set.smartindent = true -- Do auto indenting when starting a new line
set.splitbelow = true -- Splitting a new window below the current one
set.splitright = true -- Splitting a new window at the right of the current one
set.swapfile = false -- Disable use of swapfile for the buffer
set.termguicolors = true -- Enable 24-bit RGB color in the TUI
set.undofile = true -- Enable persistent undo
set.writebackup = false -- Disable making a backup before overwriting a file
set.cursorline = true -- Highlight the text line of the cursor
set.number = true -- Show numberline
set.relativenumber = true -- Show relative numberline
set.wrap = false -- Disable wrapping of lines longer than the width of window
set.conceallevel = 0 -- Show text normally
set.cmdheight = 1 -- Number of screen lines to use for the command line
set.shiftwidth = numberOfLines -- Number of space inserted for indentation
set.tabstop = numberOfLines -- Number of space in a tab
set.scrolloff = numberOfLines -- Number of lines to keep above and below the cursor
set.sidescrolloff = numberOfLines -- Number of columns to keep at the sides of the cursor
set.pumheight = 10 -- Height of the pop up menu
set.history = 100 -- Number of commands to remember in a history table
set.timeoutlen = 700 -- Length of time to wait for a mapped sequence
set.updatetime = 300 -- Length of time to wait before triggering the plugin
