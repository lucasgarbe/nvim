local status, saga = pcall(require, "lspsaga")
if not status then
	return
end

saga.init_lsp_saga()

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "gh", "<Cmd>Lspsaga lsp_finder<CR>", opts)
vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
vim.keymap.set("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", opts)
vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
vim.keymap.set("n", "[d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
vim.keymap.set("n", "]d", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
-- vim.keymap.set("i", "<C-k>", "<Cmd>Lspsaga signature_help<CR>", opts)
-- vim.keymap.set("n", "gd", "<Cmd>Lspsaga peek_definition<CR>", opts)
vim.keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
vim.keymap.set("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)

