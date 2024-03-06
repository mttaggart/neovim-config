return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    opts = {
      servers = {
        -- Ensure mason installs the server
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
        ruff_lsp = {},
        dockerls = {},
        hls = {},
        -- rust_analyzer = {
        --   keys = {
        --     { "K", "<cmd>RustHoverActions<cr>", desc = "Hover Actions (Rust)" },
        --     { "<leader>cR", "<cmd>RustCodeAction<cr>", desc = "Code Action (Rust)" },
        --     { "<leader>dr", "<cmd>RustDebuggables<cr>", desc = "Run Debuggables (Rust)" },
        --   },
        --   settings = {
        --     ["rust-analyzer"] = {
        --       cargo = {
        --         allFeatures = true,
        --         loadOutDirsFromCheck = true,
        --         runBuildScripts = true,
        --       },
        --       -- Add clippy lints for Rust.
        --       checkOnSave = {
        --         allFeatures = true,
        --         command = "clippy",
        --         extraArgs = { "--no-deps" },
        --       },
        --       procMacro = {
        --         enable = true,
        --         ignored = {
        --           ["async-trait"] = { "async_trait" },
        --           ["napi-derive"] = { "napi" },
        --           ["async-recursion"] = { "async_recursion" },
        --         },
        --       },
        --     },
        --   },
        -- },
        taplo = {
          keys = {
            {
              "K",
              function()
                if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
                  require("crates").show_popup()
                else
                  vim.lsp.buf.hover()
                end
              end,
              desc = "Show Crate Documentation",
            },
          },
        },
      },
      setup = {
        -- rust_analyzer = function(_, opts)
        --   local rust_tools_opts = require("lazyvim.util").opts("rust-tools.nvim")
        --   require("rust-tools").setup(vim.tbl_deep_extend("force", rust_tools_opts or {}, { server = opts }))
        --   return true
        -- end,
        ruff_lsp = function()
          require("lazyvim.util").lsp.on_attach(function(client, _)
            if client.name == "ruff_lsp" then
              -- Disable hover in favor of Pyright
              client.server_capabilities.hoverProvider = false
            end
          end)
        end,
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
      },
    },
  },
}
