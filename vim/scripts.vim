if did_filetype() " 既にファイル形式が決定している
    finish        " ..その時はこのチェックは行わない
endif

" glsl version detection for glsl.vim
if expand('%') =~ '^.*\.\(.*\)$'
    let s:extension = substitute(expand('%'), '^.*\.\(.*\)$', '\1', '')
    if s:extension =~ '^\(vert\|frag\|glsl\|vs\|fs\)$'
        let s:line1 = getline(1)
        if s:line1 =~ '^#version *\(\d+\).*$'
            let s:glsl_version = substitute(s:line1, '^#version *\(\d+\).*$', '\1', '')
            execute 'set filetype=glsl'.s:glsl_version
        else
            set filetype=glsl
        endif
    endif
endif

