local packer_status_ok, packer = pcall(require, "packer")
if not packer_status_ok then
  print "Packer not installed"
  return
end

packer.startup {
  function(use)
    -- note tracker
    -- https://github.com/oberblastmeister/neuron.nvim
    -- https://github.com/vimwiki/vimwiki
    -- https://github.com/nvim-neorg/neorg

    -- Plugin manager
    use "wbthomason/packer.nvim"

    -- Lua functions
    use "nvim-lua/plenary.nvim"

    -- Popup API
    use "nvim-lua/popup.nvim"

    -- Undotree
    use {
      "mbbill/undotree",
    }

    -- Icons
    use {
      "kyazdani42/nvim-web-devicons",
      -- config = function()
      --   require("configs.icons").config()
      -- end,plu
    }

    -- File explorer
    use {
      "kyazdani42/nvim-tree.lua",
      -- config = function()
      --   require("configs.nvim-tree").config()
      -- end,
    }

    -- Statusline
    use {
      "nvim-lualine/lualine.nvim",
      -- config = function()
      --   require("configs.lualine").config()
      -- end,
    }

    use "rcarriga/nvim-dap-ui"
    use "theHamsta/nvim-dap-virtual-text"
    use "mfussenegger/nvim-dap"

    -- Tree sitter
    use "nvim-treesitter/nvim-treesitter"
    use "JoosepAlviste/nvim-ts-context-commentstring"
    use "windwp/nvim-ts-autotag"
    use "nvim-treesitter/playground"
    use "nvim-treesitter/nvim-treesitter-context"
    use "nvim-treesitter/nvim-treesitter-textobjects"

    -- Snippet engine
    use "L3MON4D3/LuaSnip"
    use "rafamadriz/friendly-snippets"


    -- Completion engine
    use "hrsh7th/nvim-cmp"

    -- Snippet completion source
    use "saadparwaiz1/cmp_luasnip"

    -- Buffer completion source
    use "hrsh7th/cmp-buffer"

    -- Path completion source
    use "hrsh7th/cmp-path"

    -- Pictorgrams for lsp
    use "onsails/lspkind-nvim"

    -- LSP completion source
    use "hrsh7th/cmp-nvim-lsp"

    -- LSP
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'simrat39/rust-tools.nvim'
    use "neovim/nvim-lspconfig"

    -- Fuzzy finder
    use "nvim-telescope/telescope.nvim"

    -- Fuzzy finder syntax support
    use { "nvim-telescope/telescope-fzy-native.nvim", run = "make", }

    -- Git integration
    use "lewis6991/gitsigns.nvim"

    -- Autopairs
    use "windwp/nvim-autopairs"

    -- Commenting
    use "numToStr/Comment.nvim"

    -- File switcher
    use "milosavljevicoa/switcher.nvim"

    -- Harpoon
    use "ThePrimeagen/harpoon"

    use {
      "folke/zen-mode.nvim",
      config = function()
        require("zen-mode").setup {
          window = {
            backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
            width = 0.7
            -- height and width can be:
            -- * an absolute number of cells when > 1
            -- * a percentage of the width / height of the editor when <= 1
            -- * a function that returns the width or
          }
        }
      end
    }

    use "folke/tokyonight.nvim"

    use "sindrets/diffview.nvim"

    -- Git like magit
    use "TimUntersberger/neogit"

    -- Merge conflicts
    use "akinsho/git-conflict.nvim"

    -- Jump around
    use 'phaazon/hop.nvim'

    use 'ThePrimeagen/vim-be-good'

  end,
}
