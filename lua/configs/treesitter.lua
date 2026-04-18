local status_ok, treesitter = pcall(require, "nvim-treesitter")
if not status_ok then
  print("---Could not load nvim-treesitter---")
  return
end

treesitter.setup()

-- Install parsers if missing
local parsers = { "lua", "typescript", "javascript", "tsx", "css", "scss", "python", "go", "json", "yaml", "html", "query", "rust", "markdown" }
treesitter.install(parsers)

-- Textobjects
local status_to_ok, textobjects = pcall(require, "nvim-treesitter-textobjects")
if status_to_ok then
  textobjects.setup({
    select = {
      lookahead = true,
      include_surrounding_whitespace = true,
      selection_modes = {
        ["@parameter.outer"] = "v",
        ["@function.outer"] = "V",
        ["@class.outer"] = "<c-v>",
      },
    },
    move = {
      set_jumps = true,
    },
  })

  local map = vim.keymap.set
  local opts = { noremap = true, silent = true }

  map("n", "]f", function() require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer") end, opts)
  map("n", "]F", function() require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer") end, opts)

  map("n", "[f", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer") end, opts)
  map("n", "[F", function() require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer") end, opts)

  map("n", "]c", function() require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer") end, opts)
  map("n", "[c", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer") end, opts)

  map("n", "]C", function() require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer") end, opts)
  map("n", "[C", function() require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer") end, opts)

  map("n", "]]", function() require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner") end, opts)
  map("n", "[[", function() require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner") end, opts)

  map({ "x", "o" }, "af", function() require("nvim-treesitter-textobjects.select").select_textobject("@function.outer") end, opts)
  map({ "x", "o" }, "if", function() require("nvim-treesitter-textobjects.select").select_textobject("@function.inner") end, opts)
  map({ "x", "o" }, "ac", function() require("nvim-treesitter-textobjects.select").select_textobject("@class.outer") end, opts)
  map({ "x", "o" }, "ic", function() require("nvim-treesitter-textobjects.select").select_textobject("@class.inner") end, opts)
end

-- Context commentstring
local status_ts_comment_ok, ts_comment = pcall(require, "ts_context_commentstring")
if status_ts_comment_ok then
  ts_comment.setup({ enable_autocmd = false })
end

-- Treesitter context
local status_ts_c_ok, treesitter_context = pcall(require, "treesitter-context")
if status_ts_c_ok then
  treesitter_context.setup({
    enable = true,
    max_lines = 0,
    trim_scope = "outer",
    mode = "cursor",
    zindex = 20,
    separator = nil,
  })
end
