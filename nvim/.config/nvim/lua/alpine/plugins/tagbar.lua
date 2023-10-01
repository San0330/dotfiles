return {
    "preservim/tagbar",
    config = function()
        vim.api.nvim_set_keymap('n', '<F8>', '<cmd>TagbarToggle<CR>', { noremap = true, silent = true })

        vim.cmd([[
        let g:tagbar_type_typescript = {
          \ 'ctagstype': 'typescript',
          \ 'kinds': [
            \ 'c:classes',
            \ 'n:modules',
            \ 'f:functions',
            \ 'v:variables',
            \ 'v:varlambdas',
            \ 'm:members',
            \ 'i:interfaces',
            \ 'e:enums',
          \ ]
        \ }
        ]])
    end
}
