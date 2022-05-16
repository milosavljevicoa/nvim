---@diagnostic disable: undefined-global
local M = {}

local packer_status_ok, packer = pcall(require, "packer")
if not packer_status_ok then
  return
end

packer.startup {
  function(use)
    -- Plugin manager
    use "wbthomason/packer.nvim"

    -- Lua functions
    use "nvim-lua/plenary.nvim"

    -- Popup API
    use "nvim-lua/popup.nvim"

    -- Cursorhold fix
    -- use {
    --   "antoinemadec/FixCursorHold.nvim",
    --   event = "BufRead",
    --   config = function()
    --     vim.g.cursorhold_updatetime = 100
    --   end,
    -- }

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

    -- Debugger
    -- [TODO]: Test out how does this work
    use {
      "rcarriga/nvim-dap-ui",
      "nvim-dap-python",
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
          -- Autoclose tags
          "windwp/nvim-ts-autotag",
          after = "nvim-treesitter",
        },
        {
          -- Context based commenting
          "JoosepAlviste/nvim-ts-context-commentstring",
          after = "nvim-treesitter",
        },
        {
          "nvim-treesitter/playground",
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

    -- LSP manager
    use {
      "williamboman/nvim-lsp-installer",
      {
        "neovim/nvim-lspconfig",
        config = function()
          require("configs.lsp")
        end,
      }
    }

    -- Formatting and linting
    use {
      "jose-elias-alvarez/null-ls.nvim",
      event = "BufRead",
      config = function()
        require("configs.null-ls").config()
      end,
    }

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

    -- gruvbox-material
    use {
      "sainnhe/gruvbox-material",
      -- since virtual text highlighting is mannualy set I need to stop it from updating to keep the change
      lock = true,
      config = function ()
        -- not working
        -- vim.cmd([[let g:gruvbox_material_diagnostic_virtual_text='colored']])
        -- vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
        vim.cmd([[colorscheme gruvbox-material]])
      end
    }

    -- Harpoon
    use {
      "ThePrimeagen/harpoon",
      config = function()
        require("configs.harpoon").config()
      end,
    }
  end,
}

return M
