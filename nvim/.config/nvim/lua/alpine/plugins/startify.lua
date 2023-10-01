return {
    'mhinz/vim-startify',
    config = function()
        vim.cmd([[

            let g:startify_lists = [
                  \ { 'type': 'sessions',  'header': ['   Sessions']       },
                  \ { 'type': 'files',     'header': ['   MRU']            },
                  \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
                  \ ]

            let g:startify_session_persistence = 1
            let g:startify_change_to_vcs_root = 1
            let g:startify_session_sort = 1
            let g:startify_custom_header =
                    \ startify#fortune#cowsay('', '═','║','╔','╗','╝','╚')

            let g:startify_session_before_save = [ 'silent! tabdo NvimTreeClose' ]

            let g:startify_files_number = 5

            let g:startify_bookmarks = [
                    \ { 'nvim conf.': '~/.config/nvim' },
                    \ ]
        ]])
    end
}
