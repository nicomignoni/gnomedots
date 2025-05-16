-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

return {
	-- Nord colorscheme
	{ "shaunsingh/nord.nvim" },

	-- Rose Pinè colorscheme
	{ "rose-pine/neovim" },

	-- Adawaita colorscheme
	{
		"Mofiqul/adwaita.nvim",
		lazy = false,
		priority = 1000,

		-- configure and set on startup
		config = function()
			vim.g.adwaita_darker = false -- for darker version
			vim.g.adwaita_disable_cursorline = true -- to disable cursorline
			vim.g.adwaita_transparent = false -- makes the background transparent
		end,
	},

	-- Kanagawa colorscheme
	{ "rebelot/kanagawa.nvim" },

	-- Catppuccin colorscheme
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },

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

	-- Support for LaTeX editing
	{
		"lervag/vimtex",
		lazy = false, -- lazy-loading will disable inverse search
		config = function()
			vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable K as it conflicts with LSP hover
			vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
			vim.g.vimtex_view_method = "zathura"
		end,
		keys = {
			{ "<localLeader>l", "", desc = "+vimtex" },
		},
	},

	-- Adds support for LaTeX symbols for Julia
	{ "JuliaEditorSupport/julia-vim" },

	-- Navigate to tmux panels from nvim
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
}
