if exists('g:loaded_editor_util')
    finish
endif
let s:save_cpo = &cpo

nnoremap <Plug>(EditorActionEditPeerFile)   :<C-u>call <SID>edit_peer_file()<CR>
nnoremap <Plug>(EditorActionGotoPeerFile)   :<C-u>call <SID>goto_peer_file()<CR>
nnoremap <Plug>(EditorActionGotoTerminal)   :<C-u>call <SID>goto_terminal()<CR>
nnoremap <Plug>(EditorActionRunFile)        :<C-u>call <SID>buffer_func('run')<CR>
nnoremap <Plug>(EditorActionRunTests)       :<C-u>call <SID>buffer_func('run_tests')<CR>
nnoremap <Plug>(EditorActionEvaluateCursor) :<C-u>call <SID>buffer_func('evaluate_cursor')<CR>
nnoremap <Plug>(EditorActionEvaluateBuffer) :<C-u>call <SID>buffer_func('evaluate_buffer')<CR>

function! s:buffer_func(name)
    let l:Func = get(b:, a:name, 0)
    if l:Func != 0
        return l:Func()
    else
        echom 'b:' . a:name . ' not defined'
        return v:null
    endif
endfunction

function! s:get_peer_file()
    let peer = get(b:, 'peer_file', "")
    if peer != ""
        return peer
    endif
    let b:peer_file = get(b:, 'peer_func', {-> ""})(expand('%:p'))
    return b:peer_file
endfunction

function! s:goto_peer_file()
    let peer = s:get_peer_file()
    if peer != ""
        let winnr = bufwinnr(peer)
        if winnr > 0
            execute(winnr . "wincmd w")
        endif
    endif
endfunction

function! s:edit_peer_file()
    let peer = s:get_peer_file()
    if peer != ""
        execute("edit " . peer)
    endif
endfunction


function! s:goto_terminal()
    let Get_winnr = get(b:, 'get_terminal_winnr')
    if Get_winnr
        let winnr = Get_winnr()
        if winnr > 0
            execute(winnr . "wincmd w")
        endif
        return
    endif
    call s:goto_first_terminal()
endfunction

function! s:goto_first_terminal()
    for bufnr in term_list()
        let winnr = bufwinnr(bufnr)
        if winnr > 0
            execute(winnr . "wincmd w")
            return
        endif
    endfor
endfunction


let g:loaded_editor_util = 1
let &cpo = s:save_cpo
unlet s:save_cpo
