-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Make line numbers default
vim.o.number = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Save undo history
vim.o.undofile = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Sets how neovim will display certain whitespace characters in the editor.
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
vim.o.confirm = true

-- Reduce tabs to 4 space
vim.opt.shiftwidth = 4

-- Cycle through buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>", { noremap = true, silent = true })

-- Edit the current directory 
vim.keymap.set("n", "<leader>sf", ":e .<CR>", { noremap = true, silent = true })

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

    	-- -- Telescope
    	-- {
    	--     'nvim-telescope/telescope.nvim', tag = '0.1.8',
    	--     dependencies = { 
    	--     'nvim-lua/plenary.nvim', 
    	--         { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    	--     },
    	--     config = function()
    	--         -- Search for files in the cwd
    	--         vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files)
    	--
    	--         -- Search for files in the neovim config directory
    	--         vim.keymap.set("n", "<leader>sn", function() 
    	--     	require("telescope.builtin").find_files { cwd = vim.fn.stdpath("config") }
    	--         end)
    	--     end
    	-- },

    	-- Markdown preview
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
	  ---@module 'oil'
	  ---@type oil.SetupOpts
	  opts = {},
	  -- Optional dependencies
	  dependencies = { { "echasnovski/mini.icons", opts = {} } },
	  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	  lazy = false,
	},

	-- Adds support for LaTeX symbols for Julia
	{ "JuliaEditorSupport/julia-vim" },
    }
})
