local set = vim.opt

local indent = 4
local scroll_margin = 4

set.fileencoding = "utf-8"    -- File content encoding for the buffer
set.spelllang = "en"          -- Support US english
set.spell = true              -- Show spelling mistakes
set.mouse = "a"               -- Enable mouse support
set.signcolumn = "yes"        -- Always show the sign column
set.foldmethod = "manual"     -- Create folds manually
set.completeopt = { "menu", "menuone", "noselect" }
set.backup = false            -- Disable making a backup file
set.background = "dark"
set.expandtab = true          -- Use spaces instead of tabs
set.hlsearch = true           -- Highlight all matches of search pattern
set.ignorecase = true         -- Case insensitive searching
set.smartcase = true          -- Case sensitive when pattern has uppercase
set.showmode = false          -- Disable showing modes in command line
set.smartindent = true        -- Auto indent when starting a new line
set.splitbelow = true         -- Split new window below the current one
set.splitright = true         -- Split new window to the right of the current one
set.swapfile = false          -- Disable swapfile for the buffer
set.termguicolors = true      -- Enable 24-bit RGB color in the TUI
set.undofile = true           -- Enable persistent undo
set.writebackup = false       -- Disable making a backup before overwriting a file
set.cursorline = true         -- Highlight the text line of the cursor
set.number = true             -- Show line numbers
set.wrap = false              -- Disable wrapping of lines longer than window width
set.cmdheight = 1             -- Number of screen lines to use for the command line
set.shiftwidth = indent       -- Number of spaces inserted for indentation
set.tabstop = indent          -- Number of spaces a tab counts for
set.scrolloff = scroll_margin -- Number of lines to keep above and below the cursor
set.sidescrolloff = scroll_margin -- Number of columns to keep at the sides of the cursor
set.pumheight = 10            -- Height of the pop up menu
set.history = 100             -- Number of commands to remember in a history table
set.timeoutlen = 700          -- Length of time to wait for a mapped sequence
set.updatetime = 500          -- Length of time to wait before triggering the plugin (higher = fewer LSP CursorHold requests)
set.winborder = "rounded"     -- Border style for floating windows

