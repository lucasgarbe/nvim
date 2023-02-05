local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")


require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            }
        }
    }
})

vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<C-f>", builtin.live_grep, {})
vim.keymap.set("n", "<C-b>", builtin.buffers, {})
vim.keymap.set("n", "<leader>th", builtin.help_tags, {})
vim.keymap.set("n", "<leader>r", builtin.lsp_references, {})

vim.keymap.set("n", "<C-n>",
    telescope.extensions.file_browser.file_browser, {})

-- This is your opts table
require("telescope").setup {
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_ivy {
                -- even more opts
            }

            -- pseudo code / specification for writing custom displays, like the one
            -- for "codeactions"
            -- specific_opts = {
            --   [kind] = {
            --     make_indexed = function(items) -> indexed_items, width,
            --     make_displayer = function(widths) -> displayer
            --     make_display = function(displayer) -> function(e)
            --     make_ordinal = function(e) -> string
            --   },
            --   -- for example to disable the custom builtin "codeactions" display
            --      do the following
            --   codeactions = false,
            -- }
        },
        file_browser = {
            theme = "ivy",
        }
    }
}
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")
require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")
