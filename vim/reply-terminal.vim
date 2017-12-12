" nREPL, REPL-y with vim :terminal
if !has('terminal')
    finish
endif

if !exists("g:Reply_cmd")
    if has('win32')
        let g:Reply_cmd = 'lein.bat repl'
    else
        let g:Reply_cmd = 'lein repl'
    endif
endif

let s:reply_term_prefix = 'reply'

function! s:get_reply_term_name(name)
    let name = a:name != '' ? a:name : 'unnamed'
    return join([s:reply_term_prefix, name], '_')
endfunction

if !exists("g:Reply_callback_triggers")
    let g:Reply_callback_triggers = {}
endif
let s:reply_callback_prefix = 'reply-vim-callback'
function! s:reply_callback(ch, message)
    let i = 1
    let m = matchlist(a:message, s:reply_callback_prefix . ':\(\p*\)', 0, i)
    while m != [] && m[1] != ''
        let subcmd = m[1]
        for s in keys(g:Reply_callback_triggers)
            let sm = matchlist(subcmd, '^' . s . ':\(\p*\)')
            let param = get(sm, 1, v:null)
            if param != v:null
                call g:Reply_callback_triggers[s](param)
            endif
        endfor
        let i += 1
        let m = matchlist(a:message, s:reply_callback_prefix . ':\(\p*\)', 0, i)
    endwhile
endfunction

function! g:Reply_launch(opts)
    let name = get(a:opts, 'name', '')
    let term_name = s:get_reply_term_name(name)
    let term_opts = {
                \ "term_name": term_name,
                \ "out_cb": function("s:reply_callback"),
                \ }
    call extend(term_opts, get(a:opts, 'term_opts', {}))
    let term = term_start(g:Reply_cmd, term_opts)
    return term
endfunction

function! g:Reply_get_term_by_name(name)
    let term_name = s:get_reply_term_name(a:name)
    for buf in getbufinfo()
        if buf.name =~ '^' . term_name . '.*' && term_getstatus(buf.bufnr) == 'running'
            return buf.bufnr
        endif
    endfor
    return -1
endfunction

function! g:Reply_get_or_create_term(opts)
    let name = get(a:opts, 'name', '')
    let term = g:Reply_get_term_by_name(name)
    if term > 0
        return term
    endif

    return g:Reply_launch(a:opts)
endfunction

function! g:Reply_shutdown(term)
    if term_getstatus(a:term) == 'running'
        echom "send \<c-d> to term " . a:term
        call term_sendkeys(a:term, "\<c-d>\n")
    endif
endfunction

function! g:Reply_shutdown_all()
    for buf in getbufinfo()
        if buf.name =~? '^' . s:reply_term_prefix . '.*'
            call g:Reply_shutdown(buf.bufnr)
        endif
    endfor
endfunction

command! ReplyShutdownAll call g:Reply_shutdown_all()

function! g:Reply_eval(term, expr)
    call term_sendkeys(a:term, a:expr . '')
endfunction

function! g:Reply_fire_callback(term, trigger, param)
    let body = join([s:reply_callback_prefix, a:trigger, a:param], ':')
    call g:Reply_eval(a:term, ';' . body)
endfunction

function! g:Reply_fire_callback_by_eval(term, trigger, expr)
    let body = '(println (str "$prefix$" ":" "$trigger$" ":" $expr$))'
    let body = substitute(body, '\V$prefix$', s:reply_callback_prefix, '')
    let body = substitute(body, '\V$trigger$', a:trigger, '')
    let body = substitute(body, '\V$expr$', a:expr, '')
    call Reply_eval(a:term, body)
endfunction

function! g:Reply_fire_callback_by_eval_list(term, trigger, expr)
    let body = '(map (comp println (partial str "$prefix$" ":" "$trigger$" ":")) $expr$)'
    let body = substitute(body, '\V$prefix$', s:reply_callback_prefix, '')
    let body = substitute(body, '\V$trigger$', a:trigger, '')
    let body = substitute(body, '\V$expr$', a:expr, '')
    call Reply_eval(a:term, body)
endfunction

""" unnamed """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !exists('g:Reply_unnamed_term_opts')
    let g:Reply_unnamed_term_opts = {}
endif
function! s:unnamed_reply(expr)
    let term = g:Reply_get_or_create_term(extend({'term_opts': {'term_rows': 10}}, g:Reply_unnamed_term_opts))
    call g:Reply_eval(term, a:expr)
endfunction

function! s:exec_reply_command(args, range) range
    if a:range == 0
        call s:unnamed_reply(a:args)
    else
        call s:unnamed_reply(join(getline(a:firstline, a:lastline), ''))
    endif
endfunction
command! -range -nargs=* Reply <line1>,<line2>call s:exec_reply_command(<q-args>, <range>)
command! -nargs=1 ReplyDoc call s:unnamed_reply("(doc " . <q-args> . ")")
command! -nargs=1 ReplySource call s:unnamed_reply("(source " . <q-args> . ")")


""" slamhound """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:slamhound_finished_trigger = 'slamhound-finished'
function! s:slamhound()
    let filepath = substitute(expand("%:p"), '\', '\\\\', 'g')
    let bufnr = bufnr('%')
    let term = g:Reply_get_or_create_term({'name': 'slamhound', 'term_opts': {"hidden": 1} })
    call g:Reply_eval(term, "(require 'slam.hound)")
    call g:Reply_eval(term, "(slam.hound/swap-in-reconstructed-ns-form \"" . filepath . "\")")
    call g:Reply_fire_callback(term, s:slamhound_finished_trigger, bufnr)
endfunction

function! s:slamhound_finished(param)
    let cur_win_id = win_getid()
    for w in getbufinfo(str2nr(a:param))[0]['windows']
        let window = win_id2win(w)
        execute window . 'windo :e'
    endfor
    call win_gotoid(cur_win_id)
endfunction
let g:Reply_callback_triggers[s:slamhound_finished_trigger] = function('s:slamhound_finished')

command! SlamHound call s:slamhound()

""" eastwood """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:eastwood_lint_trigger = 'eastwood-lint'
function! s:eastwood_lint()
    let term = g:Reply_get_or_create_term({'name': 'eastwood-lint', 'term_opts': {"hidden": 1}})
    let cwd = substitute(getcwd(), '\', '/', 'g')
    call g:Reply_eval(term,
                \ "(require 'eastwood.lint)" .
                \ '(defn get-relative-path [uri]' .
                \ '  (let [cwd (.toPath (clojure.java.io/as-file "'. cwd .'"))' .
                \ '        uri-path (java.nio.file.Paths/get uri)]' .
                \ '    (.relativize cwd uri-path)))' .
                \ '(defn fmt [m] ' .
                \ '  (clojure.string/join ":" (map m [:relative-path :line :column :msg])))' .
                \ '(defn fmt-waring [w]' .
                \ '  (fmt (assoc w :relative-path (get-relative-path (:uri w)))))' .
                \ '(def get-exception (comp :exception :err-data))' .
                \ '(defn fmt-error [r]' .
                \ '  (when-let [ex (some-> r get-exception Throwable->map)]'. 
                \ '    (let [data     (:data ex)' .
                \ '          file-uri (.toURI (clojure.java.io/resource (:file data)))]' .
                \ '      (fmt (assoc data :relative-path (get-relative-path file-uri) ' .
                \ '                       :msg           (:cause ex))))))' .
                \ '')
    cgetexpr ''
    call g:Reply_fire_callback_by_eval_list(term, s:eastwood_lint_trigger,
                \ '(let [r (eastwood.lint/lint {:source-paths ["src"]})]' .
                \ '  (conj (map fmt-waring (:warnings r)) (fmt-error r)))' .
                \ '')
endfunction

function! s:eastwood_lint_emitted(param)
    if a:param != ''
        echom a:param
        caddexpr a:param
    endif
endfunction
let g:Reply_callback_triggers[s:eastwood_lint_trigger] = function('s:eastwood_lint_emitted')

command! Eastwood call s:eastwood_lint()
