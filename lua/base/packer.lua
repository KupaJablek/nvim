-- This file can be loaded by calling `lua require('plugins')` from your init.vim
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- fuzzy finder
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.x',
        -- or                            , branch = '1.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- colours
    use { "ellisonleao/gruvbox.nvim", as = 'gruvbox' }
    use { "catppuccin/nvim", as = "catppuccin" }
    use { 'projekt0n/caret.nvim', as = "caret"}

    -- syntax highlighting
    use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use ('nvim-treesitter/playground')

    -- fast file management
    use ('theprimeagen/harpoon')

    -- view/manage file changes
    use ('mbbill/undotree')

    -- lsp
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {                                      -- Optional
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'},     -- Required
        }
    }

    -- file explorer
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }

    -- better nvim terminal
    use { 'NvChad/nvterm' }

    -- DAP -> debugger
    use {
        "mfussenegger/nvim-dap",
        "jay-babu/mason-nvim-dap.nvim"
    }
    -- DAP UI -> ui for DAP
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }

    -- gitsign icons
    use 'lewis6991/gitsigns.nvim'

    if packer_bootstrap then
        require('packer').sync()
    end
end)
