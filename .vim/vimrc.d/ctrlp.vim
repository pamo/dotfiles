" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
  let g:ag_working_path_mode="ra"

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --hidden -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

let g:ctrlp_extensions = ['tag', 'dir']
let g:ctrlp_max_files = 0
let g:ctrlp_max_height=20
let g:ctrlp_root_markers = ['.projections.json', '.git']
let g:ctrlp_working_path_mode = 'ra'
