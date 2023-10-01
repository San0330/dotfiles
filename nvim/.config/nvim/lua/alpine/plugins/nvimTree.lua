return {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    config = function()
        local nvimTree = require('nvim-tree')

        vim.g.loaded = 1
        vim.g.loaded_netrwPlugin = 1

        local function on_attach(bufnr)
            local api = require('nvim-tree.api')

            local function opts(desc)
                return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end
            -- default mappings
            api.config.mappings.default_on_attach(bufnr)

            vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))
            vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
        end

        nvimTree.setup({
            on_attach = on_attach,
            sort_by = "case_sensitive",
            view = {
                adaptive_size = true,
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = true,
            },
            hijack_directories = {
                auto_open = true
            },
            actions = {
                open_file = {
                    quit_on_open = true,
                }
            }
        })

        local opts = { noremap = true, silent = true }

        vim.keymap.set("n", "<leader>et", ":NvimTreeToggle<CR>", opts)
        vim.keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>", opts)
        vim.keymap.set("n", "<leader>er", ":NvimTreeRefresh<CR>", opts)
        vim.keymap.set("n", "<leader>ec", ":NvimTreeCollapse<CR>", opts)
    end
}
