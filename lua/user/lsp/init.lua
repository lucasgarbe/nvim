local mason_status, mason = pcall(require, "mason")
if not mason_status then
	return
end

local mason_lsp_status, mason_lsp = pcall(require, "mason-lspconfig")
if not mason_lsp_status then
	return
end

local nvim_lsp_status, lspconfig = pcall(require, "lspconfig")
if not nvim_lsp_status then
	return
end

local null_ls = require("null-ls")

local servers = {
	"clangd",
	"tsserver",
	"sumneko_lua",
	"gopls",
	"intelephense",
	"jdtls",
	"tailwindcss",
	"yamlls",
	"jsonls",
}

mason.setup()
mason_lsp.setup({
	ensure_installed = servers,
})

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true }

	vim.keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	vim.keymap.set("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.keymap.set("n", "<leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	vim.keymap.set("n", "<leader>cr", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
	vim.keymap.set("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
	vim.keymap.set("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)

	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
	end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

for _, lsp in ipairs(servers) do
	require("lspconfig")[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

-- vim.lsp.protocol.CompletionItemKind = {
--     "", -- Text
--     "", -- Method
--     "", -- Function
--     "", -- Constructor
--     "", -- Field
--     "", -- Variable
--     "", -- Class
--     "ﰮ", -- Interface
--     "", -- Module
--     "", -- Property
--     "", -- Unit
--     "", -- Value
--     "", -- Enum
--     "", -- Keyword
--     "﬌", -- Snippet
--     "", -- Color
--     "", -- File
--     "", -- Reference
--     "", -- Folder
--     "", -- EnumMember
--     "", -- Constant
--     "", -- Struct
--     "", -- Event
--     "ﬦ", -- Operator
--     "", -- TypeParameter
-- }

-- Set up completion using nvim_cmp with LSP source
-- nvim_lsp.flow.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
-- })

-- nvim_lsp.tsserver.setup({
--     on_attach = on_attach,
--     -- filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript" },
--     cmd = { "typescript-language-server", "--stdio" },
--     capabilities = capabilities,
-- })

lspconfig.sumneko_lua.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},

			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
		},
	},
})

lspconfig.intelephense.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		intelephense = {
			stubs = {
				"apache",
				"bcmath",
				"bz2",
				"calendar",
				"com_dotnet",
				"Core",
				"ctype",
				"curl",
				"date",
				"dba",
				"dom",
				"enchant",
				"exif",
				"fileinfo",
				"filter",
				"fpm",
				"ftp",
				"gd",
				"hash",
				"iconv",
				"imap",
				"interbase",
				"intl",
				"json",
				"ldap",
				"libxml",
				"mbstring",
				"mcrypt",
				"meta",
				"mssql",
				"mysqli",
				"oci8",
				"odbc",
				"openssl",
				"pcntl",
				"pcre",
				"PDO",
				"pdo_ibm",
				"pdo_mysql",
				"pdo_pgsql",
				"pdo_sqlite",
				"pgsql",
				"Phar",
				"posix",
				"pspell",
				"readline",
				"recode",
				"Reflection",
				"regex",
				"session",
				"shmop",
				"SimpleXML",
				"snmp",
				"soap",
				"sockets",
				"sodium",
				"SPL",
				"sqlite3",
				"standard",
				"superglobals",
				"sybase",
				"sysvmsg",
				"sysvsem",
				"sysvshm",
				"tidy",
				"tokenizer",
				"wddx",
				"xml",
				"xmlreader",
				"xmlrpc",
				"xmlwriter",
				"Zend OPcache",
				"zip",
				"zlib",
				"wordpress",
				"woocommerce",
				"acf-pro",
				"wordpress-globals",
				"wp-cli",
				"polylang",
			},
			environment = {
				includePaths = "/home/lucasgarbe/.composer/vendor/php-stubs/",
			},
			files = {
				maxSize = 5000000,
			},
		},
	},
})

lspconfig.gopls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "gopls" },
	-- for postfix snippets and analyzers
	settings = {
		gopls = {
			experimentalPostfixCompletions = true,
			analyses = {
				unusedparams = true,
				shadow = true,
			},
			staticcheck = true,
		},
	},
	filetypes = { "go", "gomod" },
})

lspconfig.jdtls.setup({
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		"/Users/lucasgarbe/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
		"-configuration",
		"/Users/lucasgarbe/.local/share/nvim/mason/packages/jdtls/config_mac",
		"-data",
		"/Users/lucasgarbe/.local/share/nvim/mason/packages/jdtls/workspace",
	},
	root_dir = function(fname)
		return require("lspconfig").util.root_pattern("pom.xml", "gradle.build", ".git")(fname) or vim.fn.getcwd()
	end,
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	update_in_insert = false,
	virtual_text = { spacing = 4, prefix = "●" },
	severity_sort = true,
})

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
	},
	update_in_insert = true,
	float = {
		source = "always", -- Or "if_many"
	},
})

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettierd.with({
			extra_filetypes = { "php" },
		}),
		null_ls.builtins.completion.spell,
	},
	on_attach = on_attach,
})
