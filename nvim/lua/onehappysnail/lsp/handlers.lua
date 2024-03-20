-- nvim/lua/onehappysnail/lsp/handlers.lua

local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return
end

M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
  -- Diagnostics setup
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "⚠" },
    { name = "DiagnosticSignHint", text = "🞻" },
    { name = "DiagnosticSignInfo", text = "i" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = true,
    signs = {
      active = signs,
    },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
  }

  vim.diagnostic.config(config)
end

-- Set up keymaps for buffer
local function lsp_keymaps(bufnr)
  local keymap = vim.api.nvim_buf_set_keymap
  local opts = { noremap = true, silent = true }
  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  keymap(bufnr, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  keymap(bufnr, "n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  keymap(bufnr, "n", "<leader>df", "<cmd>Telescope diagnostics<CR>", opts)
  keymap(bufnr, "n", "<leader>dj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  keymap(bufnr, "n", "<leader>dk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  keymap(bufnr, "n", "<leader>fd", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)

  -- Disable formatting for tsserver and eslint
  if client.name == "tsserver" or client.name == "eslint" then
    client.sever_capabilities.documentFormattingProvider = false
  end
end

return M
