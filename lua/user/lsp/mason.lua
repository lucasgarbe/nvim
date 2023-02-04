local status, mason = pcall(require, "mason")
if not status then
	return
end

local status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status then
	return
end

local status, lspconfig = pcall(require, "lspconfig")
if not status then
	return
end

mason.setup()
mason_lspconfig.setup()

lspconfig.sumneko_lua.setup(require("user.lsp.settings.sumneko_lua"))

lspconfig.intelephense.setup(require("user.lsp.settings.intelephense"))

-- lspconfig.phpactor.setup({})

lspconfig.jsonls.setup({})

lspconfig.gopls.setup({})

lspconfig.tsserver.setup({
  -- on_attach = on_attach,
  -- filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript" },
  cmd = { "typescript-language-server", "--stdio" },
  -- capabilities = capabilities,
})

