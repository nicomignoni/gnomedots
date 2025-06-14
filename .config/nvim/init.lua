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

-- Edit the nivm config directory
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

	-- Some of the mini.nvim plugins
	{ 
	    'echasnovski/mini.statusline', version = '*',
	    config = function()
		require("mini.statusline").setup { use_icons = vim.g.have_nerd_font }
	    end
	},
	
	-- Terminal
	{
	    'akinsho/toggleterm.nvim', version = "*", 
	    config = function()
		require("toggleterm").setup {
		    direction = "horizontal",
		    size = 15
		}	
	    end
	},

	-- Autocompletion
	{
	    'saghen/blink.cmp',
	    version = '1.*',
	    opts = {
	      -- All presets have the following mappings:
	      -- C-space: Open menu or open docs if already open
	      -- C-n/C-p or Up/Down: Select next/previous item
	      -- C-e: Hide menu
	      -- C-k: Toggle signature help (if signature.enabled = true)
	      --
	      -- See :h blink-cmp-config-keymap for defining your own keymap
	      keymap = { preset = 'enter' },
	    
	      appearance = {
	        nerd_font_variant = 'mono'
	      },
	    
	      -- (Default) Only show the documentation popup when manually triggered
	      completion = { documentation = { auto_show = false } },
	    
	      -- Default list of enabled providers defined so that you can extend it
	      -- elsewhere in your config, without redefining it, due to `opts_extend`
	      sources = {
	        default = { 'lsp', 'path', 'snippets', 'buffer' },
	      },
	    
	      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
	      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
	      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
	      --
	      -- See the fuzzy documentation for more information
	      fuzzy = { implementation = "prefer_rust_with_warning" }
	    },
	    opts_extend = { "sources.default" }
	},	

    	-- -- Markdown preview
    	-- {
    	--   "iamcco/markdown-preview.nvim",
    	--   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    	--   build = "cd app && yarn install",
    	--   init = function()
    	--     vim.g.mkdp_filetypes = { "markdown" }
    	--   end,
    	--   ft = { "markdown" },
    	-- },

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

-- Keymap for toggleterm
vim.keymap.set({'n', 't'}, '<leader>t', function()
    local term = require("toggleterm.terminal").get(1)

    if term and term:is_open() then
      -- Terminal is open, so close it and go to normal mode
      term:toggle()
      vim.cmd("stopinsert") -- just in case
    else
      -- Terminal is closed, so open it and go to insert mode
      require("toggleterm").toggle(1)
      vim.cmd("startinsert")
    end
end)
