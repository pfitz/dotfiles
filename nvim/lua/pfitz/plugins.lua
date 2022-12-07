-- auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
	print("shit")
	return
end

-- add list of plugins to install
return packer.startup(function(use)
	use("wbthomason/packer.nvim")

	use("nvim-lua/plenary.nvim") -- lua functions that many plugins use

	-- use("bluz71/vim-nightfly-guicolors") -- preferred colorscheme
	use("joshdick/onedark.vim")

	use("christoomey/vim-tmux-navigator") -- tmux & split window navigation

	use("szw/vim-maximizer") -- maximizes and restores current window

	-- essential plugins
	use("tpope/vim-surround") -- add, delete, change surroundings (it's awesome)
	use("inkarkat/vim-ReplaceWithRegister") -- replace with register contents using motion (gr + motion)

	-- commenting with gc
	use("numToStr/Comment.nvim")

	-- file explorer
	use("nvim-tree/nvim-tree.lua")

	-- vs-code like icons
	use("nvim-tree/nvim-web-devicons")

	-- statusline
	use("nvim-lualine/lualine.nvim")

	-- fuzzy finding w/ telescope
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder

	-- autocompletion
	use("hrsh7th/nvim-cmp") -- completion plugin
	use("hrsh7th/cmp-buffer") -- source for text in buffer
	use("hrsh7th/cmp-path") -- source for file system paths

	-- snippets
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets

	-- managing & installing lsp servers, linters & formatters
	use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
	use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

	-- configuring lsp servers
	use("neovim/nvim-lspconfig") -- easily configure language servers
	use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
	use({ "glepnir/lspsaga.nvim", branch = "main" }) -- enhanced lsp uis
	use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
	use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

	-- formatting & linting
	use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
	use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

	-- treesitter configuration
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- auto closing
	use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

	-- git integration
	use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

	-- easy motion
	use("easymotion/vim-easymotion")

	-- -------------------------------------------------------------------------
	-- Text objects
	-- -------------------------------------------------------------------------
	-- text object comment
	use("kana/vim-textobj-user") -- required for comment
	use("glts/vim-textobj-comment")
	-- " Example: Reformat a comment with `gqac` (ac is "a comment")

	-- text object entire document
	use("kana/vim-textobj-entire")
	-- vim-textobj-entire provides two text objects:
	-- ae targets the entire content of the current buffer.
	-- ie is similar to ae, but ie does not include leading and trailing empty lines. ie is handy for some situations. For example,
	-- Paste some text into a new buffer (<C-w>n"*P) -- note that the initial empty line is left as the last line.
	-- Edit the text (:%s/foo/bar/g etc)
	-- Then copy the resulting text to another application ("*yie)

	-- indent text object
	use("michaeljsmith/vim-indent-object")
	-- only in whether they include the line below the block or not.
	--
	-- | Key bindings | Description                                                 |
	-- | ------------ | ----------------------------------------------------------- |
	-- | `<count>ai`  | **A**n **I**ndentation level and line above.                |
	-- | `<count>ii`  | **I**nner **I**ndentation level (**no line above**).        |
	-- | `<count>aI`  | **A**n **I**ndentation level and lines above/below.         |
	-- | `<count>iI`  | **I**nner **I**ndentation level (**no lines above/below**). |
	--
	-- **Note:** the `iI` mapping is mostly included simply for completeness, it is
	-- effectively a synonym for `ii`.

	-- text object line
	use("kana/vim-textobj-line")

	-- argument text objects
	use("vim-scripts/argtextobj.vim")
	-- This plugin provides a text-object 'a' (argument). You can
	-- d(elete), c(hange), v(select)... an argument or inner argument in familiar ways.
	-- That is, such as 'daa'(delete-an-argument) 'cia'(change-inner-argument) 'via'(select-inner-argument).
	-- What this script does is more than just typing
	--   F,dt,
	-- because it recognizes inclusion relationship of parentheses.
	--
	-- There is an option to descide whether the motion should go out to toplevel function or not in nested function application.
	--
	-- Examples:
	--   case1) delete An argument
	--       function(int arg1,    ch<press 'daa' here>ar* arg2="a,b,c(d,e)")
	--       function(int arg1<cursor here; and if you press 'daa' again..>)
	--       function(<cursor>)
	--
	--   case2) change Inner argument
	--       function(int arg1,    ch<press 'cia' here>ar* arg2="a,b,c(d,e)")
	--       function(int arg1,    <cursor here>)
	--
	--   case 3) smart argument recognition (g:argumentobject_force_toplevel = 0)
	--        function(1, (20<press 'cia' here>*30)+40, somefunc2(3, 4))
	--        function(1, <cursor here>, somefunc2(3, 4))
	--
	--        function(1, (20*30)+40, somefunc2(<press 'cia' here>3, 4))
	--        function(1, (20*30)+40, somefunc2(<cursor here>4))
	--
	--   case 4) smart argument recognition (g:argumentobject_force_toplevel = 1)
	--        function(1, (20<press 'cia' here>*30)+40, somefunc2(3, 4))
	--        function(1, <cursor here>, somefunc2(3, 4)) " note that this result is the same of above.
	--
	--        function(1, (20*30)+40, somefunc2(<press 'cia' here>3, 4))
	--        function(1, (20*30)+40, <cursor here>) " sub-level function is deleted because it is a argument in terms of the outer function.

	if packer_bootstrap then
		require("packer").sync()
	end
end)
