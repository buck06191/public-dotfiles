return {

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      ---@diagnostic disable-next-line: missing-parameter
      vim.list_extend(opts.ensure_installed, {
        "astro",
        "css",
      })
    end,
  },
  {
    "jxnblk/vim-mdx-js",
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        astro = {},
        yamlls = {
          settings = {
            yaml = {
              format = {
                enable = true,
              },
              hover = true,
              completion = true,
              schemaStore = {
                enable = true,
                url = "https://www.schemastore.org/api/json/catalog.json",
              },
              schemas = {
                ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
                ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
                -- ["https://raw.githubusercontent.com/awslabs/goformation/master/schema/cloudformation.schema.json"] = "cloud-formation.yaml",
              },
              customTags = {
                "!Equals sequence",
                "!FindInMap sequence",
                "!GetAtt",
                "!GetAZs",
                "!ImportValue",
                "!Join sequence",
                "!Ref",
                "!Select sequence",
                "!Split sequence",
                "!Sub",
              },
            },
          },
        },
      },
    },
  },
}
