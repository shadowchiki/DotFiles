return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
  build = ":MasonUpdate",
  opts_extend = { "ensure_installed" },
  opts = {
    ensure_installed = {
      -- Formateadores
      "prettier",  -- Formateador universal para JS, TS, HTML, CSS, etc.
      "stylua",    -- Formateador para Lua
      "shfmt",     -- Formateador para Shell scripts
      "clang-format", -- Formateador para C, C++, etc.

      -- Linters
      "eslint_d", -- Linter para JS/TS
      "jsonlint", -- Linter para JSON
      "yamllint", -- Linter para YAML
      "stylelint", -- Linter para CSS/SCSS
      "ktlint", -- Linter para Kotlin

      -- LSPs
      "typescript-language-server",
      "html-lsp",                 -- HTML LSP
      "css-lsp",                  -- CSS/SCSS LSP
      "tailwindcss-language-server", -- Tailwind CSS LSP
      "jdtls",                    -- Java LSP
      "kotlin-language-server",   -- Kotlin LSP
      "lemminx",                  -- XML LSP
      "docker-compose-language-service",
      "dockerfile-language-server"
    },
  },
  ---@param opts MasonSettings | {ensure_installed: string[]}
  config = function(_, opts)
    require("mason").setup(opts)
    local mr = require("mason-registry")
    mr:on("package:install:success", function()
      vim.defer_fn(function()
        -- trigger FileType event to possibly load this newly installed LSP server
        require("lazy.core.handler.event").trigger({
          event = "FileType",
          buf = vim.api.nvim_get_current_buf(),
        })
      end, 100)
    end)

    mr.refresh(function()
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end)
  end,
}
