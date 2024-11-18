return {
  -- correctly setup mason lsp / dap extensions
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "codelldb", "taplo" })
    end,
  },

  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     setup = {
  --       rust_analyzer = function()
  --         return true
  --       end,
  --     },
  --   },
  -- },
}
