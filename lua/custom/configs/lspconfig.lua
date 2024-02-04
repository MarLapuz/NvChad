local base = require("plugins.configs.lspconfig")
local on_attach = base.on_attach
local capabilities = base.capabilities

local lspconfig = require("lspconfig")

local servers = {"tsserver", "tailwindcss", "eslint", "cssls"}

-- change the diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { error = " ", warn = " ", hint = "󰠠 ", info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
  on_attach= on_attach,
  capabilities = capabilities,
  }
end

