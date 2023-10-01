return {
    'sindrets/diffview.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    config = function()
        require('diffview')

        vim.keymap.set('n', '<leader>do', '<cmd>DiffviewOpen<CR>')
        vim.keymap.set('n', '<leader>dc', '<cmd>DiffviewClose<CR>')
    end
}
