
local servers = {
    "tsserver",
    "html",
    "cssls",
    "tailwindcss",
    "lua_ls",
    "emmet_ls",
    "rust_analyzer",
    "clangd",
    "typos_lsp",
    "clangd",
    "clangd",
    "cmake",
    "pylyzer",
    "pylsp",
    "dockerls",
    "gopls",
    "golangci_lint_ls",
  }
  
  local settings = {
      ui = {
          border = "rounded",
          icons = {
              package_installed = "◍",
              package_pending = "◍",
              package_uninstalled = "◍",
          },
      },
      log_level = vim.log.levels.INFO,
      max_concurrent_installers = 4,
  }
  
  require("mason").setup(settings)
  require("mason-lspconfig").setup({
      ensure_installed = servers,
      automatic_installation = true,
  })
  
  local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
  if not lspconfig_status_ok then
      return
  end
  
  local opts = {}
  
  for _, server in pairs(servers) do
      opts = {
          on_attach = require("user.lsp.handlers").on_attach,
          capabilities = require("user.lsp.handlers").capabilities,
      }
  
      server = vim.split(server, "@")[1]
  
      lspconfig[server].setup(opts)
  end