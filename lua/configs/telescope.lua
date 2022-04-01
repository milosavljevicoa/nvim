local M = {}

function M.config()
  local status_ok, telescope = pcall(require, "telescope")
  if not status_ok then
    return
  end

  local actions = require "telescope.actions"
  telescope.load_extension "fzy_native"
  local previewers = require "telescope.previewers"

  telescope.setup {
    pickers = {
      buffers = {
        show_all_buffers = true,
        sort_lastused = true,
        previewer = false,
        mappings = {
          i = {
            ["<C-x>"] = "delete_buffer",
          },
          n = {
            ["<C-x>"] = "delete_buffer",
          }
        },
      },
    },
    defaults = {
      prompt_prefix = " ",
      selection_caret = "❯ ",
      path_display = { "truncate" },
      file_ignore_patterns = { 'build', 'tags', 'autoload', 'git', 'plugged', 'node_modules', "README" },
      file_sorter = require("telescope.sorters").get_fzy_sorter,
      file_previewer = previewers.vim_buffer_cat.new,
      grep_previewer = previewers.vim_buffer_vimgrep.new,
      qflist_previewer = previewers.vim_buffer_qflist.new,
      layout_config = { height = 0.9, width = 0.9 },
      mappings = {
        i = {
          ["<C-c>"] = actions.close,
          ["<Esc>"] = actions.close,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        },
        n = {
          ["<C-c>"] = actions.close,
          ["<Esc>"] = actions.close,
          ["<C-x>"] = false,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        },
      },
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
    },
  }
end

M.search_nvim = function()
  require("telescope.builtin").find_files({
    prompt_title = "< VimRC >",
    cwd =  "~/AppData/Local/nvim/",
    hidden = true,
  })
end

function M.mappings(map, opts)
  map("n", "<leader>tf", "<cmd>Telescope live_grep<CR>", opts)
  map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
  map("n", "<leader>bl", "<cmd>Telescope buffers<CR>", opts)
  map("n", "<leader>ts", "<cmd>Telescope current_buffer_fuzzy_find<CR>", opts)
  map("n", "<leader>fj", "<cmd>Telescope jumplist<CR>", opts)
  map("n", "<leader>vrc", "<cmd>lua require('configs.telescope').search_nvim()<CR>", opts)
end

return M
