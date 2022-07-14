-- 自动安装 Packer.nvim
-- 插件安装目录
-- ~/.local/share/nvim/site/pack/packer/
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local paccker_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
    vim.notify('正在安装Pakcer.nvim，请稍后...')
    paccker_bootstrap = fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        -- "https://gitcode.net/mirrors/wbthomason/packer.nvim",
        install_path,
    })

    -- https://github.com/wbthomason/packer.nvim/issues/750
    local rtp_addition = vim.fn.stdpath('data') .. '/site/pack/*/start/*'
    if not string.find(vim.o.runtimepath, rtp_addition) then
        vim.o.runtimepath = rtp_addition .. ',' .. vim.o.runtimepath
    end
    vim.notify('Pakcer.nvim 安装完毕')
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    vim.notify('没有安装 packer.nvim')
    return
end

packer.startup({
    function(use)
        -- Packer 可以管理自己本身
        use('wbthomason/packer.nvim')
        -------------------------- plugins -------------------------------------------
        -- nvim-tree
        use({ 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' })
        -- bufferline
        use({ 'akinsho/bufferline.nvim', requires = { 'kyazdani42/nvim-web-devicons', 'moll/vim-bbye' } })
        -- lualine
        use({ 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons' } })
        use('arkav/lualine-lsp-progress')
        -- telescope
        use({ 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } })
        -- telescope extensions
        use('LinArcX/telescope-env.nvim')
        -- dashboard-nvim
        use('glepnir/dashboard-nvim')
        -- project
        use('ahmedkhalf/project.nvim')
        -- treesitter
        use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
        -- 补全引擎
        use('hrsh7th/nvim-cmp')
        -- snippet 引擎
        use('hrsh7th/vim-vsnip')
        -- 补全源
        use('hrsh7th/cmp-vsnip')
        use('hrsh7th/cmp-nvim-lsp') -- { name = nvim_lsp }
        use('hrsh7th/cmp-buffer') -- { name = 'buffer' },
        use('hrsh7th/cmp-path') -- { name = 'path' }
        use('hrsh7th/cmp-cmdline') -- { name = 'cmdline' }
        -- 常见编程语言代码段
        use('rafamadriz/friendly-snippets')
        -- 代码格式化
        --use("mhartington/formatter.nvim")
        use({ 'jose-elias-alvarez/null-ls.nvim', requires = 'nvim-lua/plenary.nvim' })
        -- JSON 增强
        use('b0o/schemastore.nvim')
        -- TypeScript增强
        use({ 'jose-elias-alvarez/nvim-lsp-ts-utils', requires = 'nvim-lua/plenary.nvim' })
        -- ui
        use('onsails/lspkind-nvim')
        use('tami5/lspsaga.nvim')
        -- indent-blankline
        use('lukas-reineke/indent-blankline.nvim')
        --------------------- LSP --------------------
        use({ 'williamboman/nvim-lsp-installer', commit = '36b44679f7cc73968dbb3b09246798a19f7c14e0' })
        -- Lspconfig
        use({ 'neovim/nvim-lspconfig' })
        --------------------- colorschemes --------------------
        -- tokyonight
        -- use("folke/tokyonight.nvim")
        -- nord
        use('shaunsingh/nord.nvim')
        -------------------------------------------------------
    end,
    config = {
        -- 并发数限制
        max_jobs = 16,
        -- 自定义源
        git = {
            -- default_url_format = "https://hub.fastgit.xyz/%s",
            -- default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
            -- default_url_format = "https://gitcode.net/mirrors/%s",
            -- default_url_format = "https://gitclone.com/github.com/%s",
        },
    },
})

-- 每次保存 plugins.lua 自动安装插件
-- move to autocmds.lua
-- pcall(
--   vim.cmd,
--   [[
-- augroup packer_user_config
-- autocmd!
-- autocmd BufWritePost plugins.lua source <afile> | PackerSync
-- augroup end
-- ]]
-- )