function! s:is_clojure_test_file(file)
    return match(a:file, '_test.clj$') != -1
endfunction
function! s:get_clojure_test_peer(file)
    let result = a:file
    if s:is_clojure_test_file(a:file)
        let result = substitute(result, '_test.clj$', '.clj', '')
        let result = substitute(result, '\v([\/])test([\/])', '\1src\2', '')
    else
        let result = substitute(result, '.clj$', '_test.clj', '')
        let result = substitute(result, '\v([\/])src([\/])', '\1test\2', '')
    endif
    return result
endfunction

function! s:fireplace_evaluate_buffer()
    execute('%Eval')
endfunction
function! s:fireplace_evaluate_cursor()
    execute('Eval')
endfunction
function! s:fireplace_run_tests()
    execute('RunTests')
endfunction

let b:peer_func = function('s:get_clojure_test_peer')
let b:run_tests = function('s:fireplace_run_tests')
let b:evaluate_buffer = function('s:fireplace_evaluate_buffer')
let b:evaluate_cursor = function('s:fireplace_evaluate_cursor')

