local plugins = {
    {
      "neovim/nvim-lspconfig",
        config = function()
          require "plugins.configs.lspconfig"
          require "custom.configs.lspconfig"
        end,
    },

    {
      "lervag/vimtex",
      lazy = false,
      ft = { "tex" },
      init = function()
        vim.g.tex_flavor = "latex"
        vim.g.vimtex_quickfix_mode = 0
        vim.g.vimtex_mappings_enabled = 0
        vim.g.vimtex_indent_enabled = 0

        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_context_pdf_viewer = "zathura"
      end,
   },

   {
     "iamcco/markdown-preview.nvim",
     cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
     ft = { "markdown" },
     build = function()
       vim.fn["mkdp#util#install"]()
     end,
   }
}

return plugins
