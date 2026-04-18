local lazy_ok, lazy = pcall(require, "lazy")
if not lazy_ok then
  print("lazy.nvim not installed")
  return
end

lazy.setup({
  -- Lua functions
  { "nvim-lua/plenary.nvim" },

  -- Undotree
  { "mbbill/undotree" },

  -- Icons
  { "nvim-tree/nvim-web-devicons" },

  -- File explorer
  { "nvim-tree/nvim-tree.lua" },

  -- Statusline
  { "nvim-lualine/lualine.nvim" },

  -- DAP
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
      "theHamsta/nvim-dap-virtual-text",
    },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "windwp/nvim-ts-autotag",
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("configs.treesitter")
    end,
  },

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "onsails/lspkind-nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzy-native.nvim", build = "make" },
    },
  },

  -- Git
  { "lewis6991/gitsigns.nvim" },
  { "sindrets/diffview.nvim" },
  { "NeogitOrg/neogit" },
  { "akinsho/git-conflict.nvim" },

  -- Autopairs
  { "windwp/nvim-autopairs" },

  -- Commenting
  { "numToStr/Comment.nvim" },

  -- File switcher
  { "milosavljevicoa/switcher.nvim" },

  -- Harpoon
  { "ThePrimeagen/harpoon" },

  -- Zen mode
  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {
        window = {
          backdrop = 0.95,
          width = 0.7,
        },
      }
    end,
  },

  -- Symbol outline
  { "stevearc/aerial.nvim" },

  -- Colorschemes
  { "folke/tokyonight.nvim" },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("kanagawa-wave")
    end,
  },

  -- Jump around
  { "smoka7/hop.nvim" },

  -- Practice
  { "ThePrimeagen/vim-be-good" },
})
