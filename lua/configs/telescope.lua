local opts = { noremap = true, silent = true }
local map = vim.keymap.set

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  print("Telescope not found")
  return
end

local actions = require "telescope.actions"
telescope.load_extension "fzy_native"
local previewers = require "telescope.previewers"

telescope.setup {
  pickers = {
    lsp_references = {
      fname_width = 100,
      show_line = true, -- false if not to show line reference
      trix_text = true,
    },

    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
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
    layout_strategy = 'vertical',
    layout_config = { height = 0.95, width = 0.9 },
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

map("n", "<leader>tg", "<cmd>Telescope live_grep<CR>", opts)
map("n", "<leader>tc", "<cmd>Telescope grep_string<CR>", opts)
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
map("n", "<leader>bl", "<cmd>Telescope buffers<CR>", opts)
map("n", "<leader>tr", "<cmd>Telescope resume<CR>", opts)
map("n", "<leader>td", "<cmd>Telescope diagnostics<CR>", opts)

map("n", "<leader>htg", "<cmd>Telescope help_tags<CR>", opts)

map("n", "<leader>ttg", function()
  require("telescope.builtin").live_grep({
    prompt_title = "Live grep from pwd:",
    cwd = vim.fn.expand('%:p:h'),
  })
end, opts)
map("n", "<leader>tff", function()
  require("telescope.builtin").find_files({
    prompt_title = "Find siblings and child files:",
    cwd = vim.fn.expand('%:p:h'),
  })
end, opts)

map("n", "<leader>tp", function()
  require("telescope.builtin").spell_suggest({
    prompt_title = "Spell Suggest",
    layout_strategy = 'cursor',
    layout_config = { height = 0.3, width = 0.2 },
  })
end, opts)


map("n", "<leader>gr", "<cmd>Telescope lsp_references<CR>", opts)
map("n", "<leader>o", "<cmd>Telescope lsp_document_symbols<CR>", opts)
map("n", "<leader>fg", "<cmd>Telescope lsp_workplace_symbols<CR>", opts)
map("n", "<leader>n", "<cmd>Telescope git_status<CR>", opts)
