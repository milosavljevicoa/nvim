local M = {}

function M.config()
  local status_ok, telescope = pcall(require, "telescope")
  if not status_ok then
    error("Telescope not found")
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
            ["<C-d>"] = "delete_buffer",
          },
          n = {
            ["<C-d>"] = "delete_buffer",
          }
        },
      },
    },
    defaults = {
      prompt_prefix = " ",
      selection_caret = "❯ ",
      path_display = { "truncate" },
      file_ignore_patterns = { 'build', 'tags', 'autoload', "\\.git", 'plugged', 'node_modules' },
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
          ["q"] = actions.close,
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


function M.mappings(map, opts)
  map("n", "<leader>tf", "<cmd>Telescope live_grep<CR>", opts)
  map("n", "<leader>tt", "<cmd>Telescope grep_string<CR>", opts)
  map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
  map("n", "<leader>bl", "<cmd>Telescope buffers<CR>", opts)
  map("n", "<leader>ts", "<cmd>Telescope current_buffer_fuzzy_find<CR>", opts)
  map("n", "<leader>fs", "<cmd>Telescope git_status<CR>", opts)
  map("n", "<leader>htg", "<cmd>Telescope help_tags<CR>", opts)
  map("n", "<leader>tr", "<cmd>Telescope resume<CR>", opts)
  map("n", "<leader>te", "<cmd>Telescope diagnostics<CR>", opts)
  map("n", "<leader>tg", function ()
    require("telescope.builtin").find_files({
      prompt_title = "Find siblings and child files",
      cwd = vim.fn.expand('%:p:h'),
    })
  end, opts)

  -- nmap("<leader>fc", M.find_siblings_child_files, opts)
  -- nmap("<leader>vrc", M.search_nvim(), opts)
end

return M
