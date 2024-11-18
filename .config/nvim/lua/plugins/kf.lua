-- Plugins specific to work at kf

return {
  {
    "google/vim-jsonnet",
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "jsonnetfmt", "jsonnet_ls" })
    end,
  },
}
