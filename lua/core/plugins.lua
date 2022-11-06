local M = {}

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
      config = function()
        require("configs.icons").config()
      end,
    }

    -- File explorer
    use {
      "kyazdani42/nvim-tree.lua",
      config = function()
        require("configs.nvim-tree").config()
      end,
    }

    -- Statusline
    use {
      "nvim-lualine/lualine.nvim",
      config = function()
        require("configs.lualine").config()
      end,
    }

    -- use {
    --   "mfussenegger/nvim-dap",
    --   config = function()
    --     require("configs.nvim-dap").config()
    --   end,
    -- }

    -- Debugger
    -- [TODO]: Test out how does this work
    use {
      "rcarriga/nvim-dap-ui",
      -- "nvim-dap-python",
      requires = {
        "mfussenegger/nvim-dap"
      }
    }

    -- Tree sitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      event = "BufRead",
      config = function()
        require("configs.treesitter").config()
      end,
      requires = {
        {
          -- Better comments for jsx/tsx
          "JoosepAlviste/nvim-ts-context-commentstring",
          after = "nvim-treesitter",
        },
        {
          -- Use treesitter to auto close and auto rename html tag
          "windwp/nvim-ts-autotag",
          after = "nvim-treesitter",
        },
        {
          -- Treesitter Playground
          "nvim-treesitter/playground",
          after = "nvim-treesitter",
        },
        {
          -- Code context
          "nvim-treesitter/nvim-treesitter-context",
          after = "nvim-treesitter",
          config = function()
            require("configs.treesitter.context").config()
          end
        },
        {
          -- Text objects
          "nvim-treesitter/nvim-treesitter-textobjects",
          after = "nvim-treesitter",
        }
      },
    }

    -- Snippet engine
    use {
      "L3MON4D3/LuaSnip",
      config = function()
        require("configs.luasnip").config()
      end,
      requires = {
        -- Snippet collections
        "rafamadriz/friendly-snippets",
      },
    }

    -- TabNine
    -- https://github.com/tzachar/cmp-tabnine

    -- Completion engine
    use {
      "hrsh7th/nvim-cmp",
      event = "BufRead",
      config = function()
        require("configs.cmp").config()
      end,
    }

    -- Snippet completion source
    use {
      "saadparwaiz1/cmp_luasnip",
      after = "nvim-cmp",
    }

    -- Buffer completion source
    use {
      "hrsh7th/cmp-buffer",
      after = "nvim-cmp",
    }

    -- Path completion source
    use {
      "hrsh7th/cmp-path",
      after = "nvim-cmp",
    }

    -- Pictorgrams for lsp
    use "onsails/lspkind-nvim"

    -- LSP completion source
    use "hrsh7th/cmp-nvim-lsp"

    -- LSP
    use {
      -- "williamboman/nvim-lsp-installer",
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'simrat39/rust-tools.nvim',
      'glepnir/lspsaga.nvim',
      {
        "neovim/nvim-lspconfig",
        config = function()
          require("configs.lsp")
        end,
      }
    }

    -- Formatting and linting
    -- use {
    --   "jose-elias-alvarez/null-ls.nvim",
    --   event = "BufRead",
    --   config = function()
    --     require("configs.null-ls").config()
    --   end,
    -- }

    -- Fuzzy finder
    use {
      "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      config = function()
        require("configs.telescope").config()
      end,
    }

    -- Fuzzy finder syntax support
    use {
      "nvim-telescope/telescope-fzy-native.nvim",
      run = "make",
    }

    -- Git integration
    use {
      "lewis6991/gitsigns.nvim",
      event = "BufRead",
      config = function()
        require("configs.gitsigns").config()
      end,
    }

    -- Autopairs
    use {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function()
        require("configs.autopairs").config()
      end,
    }

    -- Commenting
    use {
      "numToStr/Comment.nvim",
      event = "BufRead",
      config = function()
        require("configs.comment").config()
      end,
    }

    -- File switcher
    use "milosavljevicoa/switcher.nvim"

    -- Harpoon
    use {
      "ThePrimeagen/harpoon",
      config = function()
        require("configs.harpoon").config()
      end,
    }

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


    use {
      "catppuccin/nvim",
      as = "catppuccin",
      config = function()
        require("configs.catppuccin").config()
      end
    }

  use {
      "sindrets/diffview.nvim",
      requires = "nvim-lua/plenary.nvim",
    }

    -- Git like magit
    use {
      "TimUntersberger/neogit",
      config = function()
        require("configs.neogit").config()
      end,
      requires = {
        "sindrets/diffview.nvim"
      },
    }

    -- Merge conflicts
    use {
      "akinsho/git-conflict.nvim",
      config = function()
        require("git-conflict").setup()
      end
    }

    -- Jump around
    use {
      'phaazon/hop.nvim',
      config = function()
        require("configs.hop").config()
      end
    }

    use {
      'ThePrimeagen/vim-be-good'
    }

  end,
}

return M
