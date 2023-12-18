local opts = { noremap = true, silent = true }
local map = vim.keymap.set

local status_ok, nvimtree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

nvimtree.setup {
  auto_reload_on_write = true,
  disable_netrw = true,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  open_on_tab = false,
  sort_by = "name",
  update_cwd = false,
  view = {
    width = 100,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
  },
  renderer = {
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
    }
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = false,
    update_cwd = false,
    ignore_list = {},
  },
  system_open = {
    cmd = "",
    args = {},
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 400,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    open_file = {
      quit_on_open = true,
      resize_window = false,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help", ".git" },
        },
      },
    },
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      diagnostics = false,
      git = false,
      profile = false,
    },
  },
}

map("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>", opts)

--[[
actions

<CR>    or o on the root folder will cd in the above directory
<C-]>   will cd in the directory under the cursor
<BS>    will close current opened directory or parent
a       to add a file. Adding a directory requires leaving a leading / at the end of the path.
          you can add multiple directories by doing foo/bar/baz/f and it will add foo bar and baz directories and f as a file
r       to rename a file
<C-r>   to rename a file and omit the filename on input
x       to add/remove file/directory to cut clipboard
c       to add/remove file/directory to copy clipboard
y       will copy name to system clipboard
Y       will copy relative path to system clipboard
gy      will copy absolute path to system clipboard
p       to paste from clipboard. Cut clipboard has precedence over copy (will prompt for confirmation)
d       to delete a file (will prompt for confirmation)
D       to trash a file (configured in setup())
]c      to go to next git item
[c      to go to prev git item
-       to navigate up to the parent directory of the current file/directory
s       to open a file with default system application or a folder with default file manager (if you want to change the command used to do it see :h nvim-tree.setup under system_open)
if      the file is a directory, <CR> will open the directory otherwise it will open the file in the buffer near the tree
if      the file is a symlink, <CR> will follow the symlink (if the target is a file)
<C-v>   will open the file in a vertical split
<C-x>   will open the file in a horizontal split
<C-t>   will open the file in a new tab
<Tab>    will open the file as a preview (keeps the cursor in the tree)
I       will toggle visibility of hidden folders / files
H       will toggle visibility of dotfiles (files/folders starting with a .)
R       will refresh the tree
W       will collapse the whole tree
S       will prompt the user to enter a path and then expands the tree to match the path
.       will enter vim command mode with the file the cursor is on
C-k       will toggle a popup with file infos about the file under the cursor

--]]
