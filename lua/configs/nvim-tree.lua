local M = {}

function M.config()
  local status_ok, nvimtree = pcall(require, "nvim-tree")
  if not status_ok then
    return
  end

  local g = vim.g

  g.nvim_tree_indent_markers = 1

  g.nvim_tree_icons = {
    default = "",
    symlink = "",
    git = {
      deleted = "",
      ignored = "◌",
      renamed = "➜",
      staged = "✓",
      unmerged = "",
      unstaged = "✗",
      untracked = "★",
    },
    folder = {
      default = "",
      empty = "",
      empty_open = "",
      open = "",
      symlink = "",
      symlink_open = "",
    },
  }

  nvimtree.setup {
    filters = {
      dotfiles = false,
      custom = {
        ".git",
        "node_modules",
        ".cache",
      },
    },
    disable_netrw = true,
    hijack_netrw = true,
    ignore_ft_on_setup = {
      "dashboard",
      "startify",
      "alpha",
    },
    auto_close = false,
    open_on_tab = false,
    quit_on_open = false,
    hijack_cursor = true,
    hide_root_folder = true,
    update_cwd = true,
    update_focused_file = {
      enable = true,
      update_cwd = true,
      ignore_list = {},
    },
    diagnostics = {
      enable = false,
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      },
    },
    view = {
      width = 25,
      height = 30,
      side = "left",
      allow_resize = true,
      hide_root_folder = false,
      number = false,
      relativenumber = false,
      signcolumn = "yes",
    },
    git = {
      enable = true,
      ignore = false,
      timeout = 500,
    },
    show_icons = {
      git = 1,
      folders = 1,
      files = 1,
      folder_arrows = 0,
      tree_width = 30,
    },
    actions = {
      open_file = {
        quit_on_open = true,
      }
    }
  }

end

function M.mappings(map, opts)
  map("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>", opts)
end

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

return M
