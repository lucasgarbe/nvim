local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- navigate panes
keymap("n", "<C-h>", "<C-W><C-h>", opts)
keymap("n", "<C-j>", "<C-W><C-j>", opts)
keymap("n", "<C-k>", "<C-W><C-k>", opts)
keymap("n", "<C-l>", "<C-W><C-l>", opts)

-- navigate buffers
keymap("n", "<S-l>", ":bnext<cr>", opts)
keymap("n", "<S-h>", ":bprevious<cr>", opts)

-- telescope / fzf
keymap("n", "<C-p>", ":Files <cr>", opts)
keymap("n", "<C-b>", ":Buffers <cr>", opts)
keymap("n", "<C-f>", ":Rg <cr>", opts)

-- search highlight
keymap("n", "<esc>", ":noh <cr>", opts)

-- nerdtree
keymap("n", "<C-n>", ":NERDTreeToggle<cr>", opts)
