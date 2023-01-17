let s:timer = 0

function s:evalfngen(query)
    return {idx, val -> match(val, a:query) >= 0}
endfunction

function! ctrlp_kensaku#matcher(items, str, limit, mmode, ispath, crfile, regex) abort
  if empty(a:str)
    call clearmatches()
    return a:items[:&lines]
  endif

  if a:regex
    return filter(a:items, 'v:val =~ a:str')
  else
    let l:regex_query = "\\v" .. kensaku#query(a:str)
    "call timer_stop(s:timer)
    "let s:timer = timer_start(10, {t ->
    "\ [clearmatches(), matchadd('CtrlPMatch', l:regex_query), hlexists('CtrlPLinePre') ? matchadd('CtrlPLinePre', '^>') : '', execute('redraw')]
    "\}, {'repeat': 0})

    return filter(copy(a:items), s:evalfngen(l:regex_query))
  endif
endfunction
