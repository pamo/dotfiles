" Let-er ripgrep!
if executable('rg')
  set grepprg=rg\ --vimgrep\ --color=always
  let g:ctrlp_user_command = 'rg %s --column --no-heading  --files --hidden --glob ""'
  let g:ctrlp_use_caching = 0
endif

let g:ctrlp_extensions = ['tag', 'dir']
let g:ctrlp_max_files = 0
let g:ctrlp_max_height=20
let g:ctrlp_root_markers = ['.projections.json', '.git']
let g:ctrlp_working_path_mode = 'ra'
