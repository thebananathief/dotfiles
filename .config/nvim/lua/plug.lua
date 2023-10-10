---- PLUGINS ----

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  print('Installing lazy.nvim...')
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
  print('Done.')
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- "folke/which-key.nvim",
  -- { "folke/neoconf.nvim", cmd = "Neoconf" },
  -- "folke/neodev.nvim",
  -- "neoclide/coc.nvim",
  { 'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'L3MON4D3/LuaSnip'},
      {'onsails/lspkind.nvim'},
    }
  },
  { 'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup{
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.3
          end
        end,
        hidden = true,
        direction = "vertical"
      }
    end
  },
  --{ "preservim/nerdcommenter" },
  { "numToStr/Comment.nvim",
    opts = {
      toggler = {
        line = '<leader>cc',
        block = '<leader>bc',
      },
      opleader = {
        line = '<leader>cc',
        block = '<leader>bc',
      },
      extra = {
        above = '<leader>cO',
        below = '<leader>co',
        eol = '<leader>cA',
      },
    },
    lazy = false,
  },
  { "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {
        sort_by = "case_sensitive",
        view = {
            width = 30,
        },
        renderer = {
            group_empty = true,
        },
        filters = {
            dotfiles = false,
            git_ignored = true,
        }
      }
    end
  },
  { "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },
  { "majutsushi/tagbar" },
  { 'feline-nvim/feline.nvim',
    config = function() require('feline').setup() end
  },
  { "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup {
        transparent_background = true,
        integrations = {
          treesitter = true,
          --telescope = true,
          nvimtree = true,
        }
      }
    end
  }
})

vim.cmd.colorscheme "catppuccin"
vim.g.catppuccin_flavour = 'mocha'

local Terminal  = require('toggleterm.terminal').Terminal

