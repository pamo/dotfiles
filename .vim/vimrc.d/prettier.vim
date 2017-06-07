autocmd FileType javascript set formatprg=prettier-eslint\ --stdin\ --single-quote\ --trailing-comma\ es5
autocmd BufWritePre *.js :normal gggqG
" autocmd BufWritePre *.js exe "normal! gggqG\<C-o>\<C-o>"
