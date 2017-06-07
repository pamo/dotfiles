set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers = ['eslint', 'jsxhint']
let g:syntastic_ruby_checkers = ['rubylint']
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_yaml_checkers = ['jsyaml']
let g:syntastic_sass_checkers= ['sass_lint']
let g:syntastic_scss_checkers= ['sass_lint']

highlight SyntasticErrorLine guibg=#CB0900
highlight SyntasticWarningLine guibg=#EBEF00
