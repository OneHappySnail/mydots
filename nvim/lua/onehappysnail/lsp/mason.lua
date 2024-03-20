local status_ok_lspconf, lspconf = pcall(require, "lspconfig")
if not status_ok_lspconf then
 return
end

local status_ok_mason, mason = pcall(require, "mason")
if not status_ok_mason then
  return
end

local status_ok_masonconf, mason_conf = pcall(require, "mason-lspconfig")
if not status_ok_masonconf then
  return
end

local servers = {
  "tsserver",
  "lua_ls",
  "eslint",
  "jsonls",
  "lemminx"
}

local settings = {
  ui = {
    border = "rounded",
    icons = {
      package_installed = "✔",
      package_pending = "𝍄",
      package_uninstalled = "✖",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

mason.setup(settings)
mason_conf.setup {
  ensure_installed = servers,
  automatic_installation = true,
}

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("onehappysnail.lsp.handlers").on_attach,
    capabilities = require("onehappysnail.lsp.handlers").capabilities,
  }
  server = vim.split(server, "@")[1]
  lspconf[server].setup(opts)
end

