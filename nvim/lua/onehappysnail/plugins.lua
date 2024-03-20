local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and repoen Neovim ..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever plugins.lua is saved
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we do not get an error on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Plugins
return packer.startup(function(use)
    -- Packer
    use "wbthomason/packer.nvim" -- Let packer manage itself

    -- Style
    use "nvim-lua/plenary.nvim"      -- Common LUA functions used in a lot of plugins
    use "folke/tokyonight.nvim"      -- tokyonight color scheme
    use "nvim-lualine/lualine.nvim"  -- Status bar
    use "kyazdani42/nvim-web-devicons" -- Icons used by several plugins

    -- Completion plugins
    use "hrsh7th/nvim-cmp"       -- Completion plugin
    use "hrsh7th/cmp-buffer"     -- Buffer completion
    use "hrsh7th/cmp-path"       -- Path completion
    use "saadparwaiz1/cmp_luasnip" -- Snippet completion
    use "hrsh7th/cmp-nvim-lsp"   -- LSP completion

    -- Auto close brakets
    use "windwp/nvim-autopairs"

    -- Snippets
    use "L3MON4D3/LuaSnip"           -- Snippter engine
    use "rafamadriz/friendly-snippets" -- Snipped library

    -- LSP
    use "neovim/nvim-lspconfig"           -- Enable LSP
    use "williamboman/mason.nvim"         -- LSP installer
    use "williamboman/mason-lspconfig.nvim" -- Use nvim-lspconfig and mason together

    -- Formatting
    use "mhartington/formatter.nvim" -- Formatter plugin

    -- Telescope
    use "nvim-telescope/telescope.nvim" -- Telescope

    -- Git integration
    use "tpope/vim-fugitive"    -- Git integration
    use "lewis6991/gitsigns.nvim" -- Git signs and line blame

    -- Automatically set up config after cloning packer.nvim
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
