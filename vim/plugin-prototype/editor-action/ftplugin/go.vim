nmap <buffer> <LocalLeader>r <Plug>(go-run)
nmap <buffer> <LocalLeader>c <Plug>(go-coverage-toggle)
nmap <buffer> <LocalLeader>a <Plug>(go-alternate-edit)
nmap <buffer> <LocalLeader>l <Plug>(go-metalinter)
nmap <buffer> <LocalLeader>s <Plug>(go-info)
nmap <buffer> <LocalLeader>i <Plug>(go-install)
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
nmap <buffer> <LocalLeader>b :<C-u>call <SID>build_go_files()<CR>
