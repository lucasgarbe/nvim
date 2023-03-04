vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.splitbelow = true
vim.opt.splitright = true

-- visuals
vim.opt.expandtab = false
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.wrap = false
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.showmatch = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.colorcolumn = "80"

vim.opt.listchars = {
	eol = "↲",
	tab = "┊ ",
	trail = "·",
	extends = "<",
	precedes = ">",
	conceal = "┊",
	nbsp = "␣",
}
vim.opt.list = true

-- search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
