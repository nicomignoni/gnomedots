-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Make line numbers default
vim.o.number = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Save undo history
vim.o.undofile = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Sets how neovim will display certain whitespace characters in the editor.
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Show which line your cursor is on
vim.o.cursorline = true

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
vim.o.confirm = true

-- Reduce tabs to 4 space
vim.opt.shiftwidth = 4

-- Yank to clipboard
vim.keymap.set({ "n", "v" }, "y", '"+y')
vim.keymap.set("n", "yy", '"+yy')

-- Cycle through buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>", { noremap = true, silent = true })

-- Edit the current directory 
vim.keymap.set("n", "<leader>sf", ":e .<CR>", { noremap = true, silent = true })

-- Edit the nvim config directory
vim.keymap.set("n", "<leader>sn", ":e $HOME/.config/nvim<CR>", { noremap = true, silent = true })

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
	-- Adwaita theme for GNOME
    	{
    	    "Mofiqul/adwaita.nvim",
    	    lazy = false,
    	    priority = 1000,
    	    config = function()
    	        vim.cmd.colorscheme("adwaita")
    	    end
    	},

	-- Treesitter
	{
	    "nvim-treesitter/nvim-treesitter",
	    build = function()
		require("nvim-treesitter.install").update({ with_sync = true })()
	    end
	},

	-- Some of the mini.nvim plugins
	{ 
	    'echasnovski/mini.nvim', version = '*',
	    config = function()
		require("mini.starter").setup()
		require("mini.icons").setup()
		require("mini.tabline").setup()
		require("mini.statusline").setup { use_icons = vim.g.have_nerd_font }

		local gen_loader = require("mini.snippets").gen_loader
		require("mini.snippets").setup({
		    snippets = {
			gen_loader.from_lang() 
		    }
		})
	    end
	},
	
	-- Main LSP Configuration
	{
	    'neovim/nvim-lspconfig',
	    dependencies = {
		{ 'mason-org/mason.nvim', opts = {} },
		'mason-org/mason-lspconfig.nvim',
		'WhoIsSethDaniel/mason-tool-installer.nvim',
		'saghen/blink.cmp',
	    },
	    config = function()
		require('mason-lspconfig').setup({
		    ensure_installed = { 'pyright', 'lua_ls', 'julia-lsp' },
		})
	    end
    	},

	-- Autocompletion
	{
	    'saghen/blink.cmp',
	    version = '1.*',
	    opts = {
		-- Press enter to confirm
	      	keymap = { preset = 'enter' },
	      	appearance = {
	      	  nerd_font_variant = 'normal'
	      	},
	      	-- (Default) Only show the documentation popup when manually triggered
	      	completion = { documentation = { auto_show = false } },
	      	sources = {
	      	  default = { 'lsp', 'path', 'snippets', 'buffer' },
	      	},
	      	-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
		fuzzy = { implementation = "prefer_rust_with_warning" },
		signature = { enabled = true },
	    },
	    opts_extend = { "sources.default" }
	},	

	-- LaTeX support
	{
	    "lervag/vimtex",
	    lazy = false,     -- we don't want to lazy load VimTeX
	    -- tag = "v2.15", -- uncomment to pin to a specific release
	    init = function()
	      vim.g.vimtex_view_method = "zathura"
	    end
	},

	-- Markdown preview
	-- (npm install -g yarn)
	{
	    "iamcco/markdown-preview.nvim",
	    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	    build = "cd app && yarn install",
	    init = function()
	      vim.g.mkdp_filetypes = { "markdown" }
	    end,
	    ft = { "markdown" },
	},
	
	-- Edit files and directories like a buffer
	{
	    'stevearc/oil.nvim',
	    lazy = false,
	    opts = {
		view_options = { show_hidden = true }
	    },
	},

	-- Adds support for LaTeX symbols for Julia
	{ "JuliaEditorSupport/julia-vim" },
    }
})
