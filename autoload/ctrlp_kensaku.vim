let s:timer = 0

function s:evalfngen(query)
    return {idx, val -> match(val, a:query) >= 0}
endfunction

function! ctrlp_kensaku#matcher(items, str, limit, mmode, ispath, crfile, regex) abort
  if empty(a:str)
    call clearmatches()
    return a:items[:&lines]
  endif

  if a:regex || len(a:str) == 1
    return filter(copy(a:items), 'v:val =~ a:str')
  else
    "let l:regex_query = "\\v" .. join(map(filter(
        "\ split(a:str, ' '), 'v:val != " "'), 'kensaku#query(v:val)'), '.*')
    let l:regex_queries = []
    for q in filter(split(a:str, ' '), 'v:val != " "')
      let l:regex_q = kensaku#query(q)
      if len(l:regex_queries) == 0
        call extend(l:regex_queries, [l:regex_q])
      else
        call extend(l:regex_queries, [l:regex_queries[-1] .. '.*' .. l:regex_q])
      endif
    endfor
    let l:regex_queries = reverse(map(l:regex_queries, '"\\v" .. v:val'))
    call timer_stop(s:timer)
    for q in l:regex_queries
      try
        let l:filtereditems = filter(copy(a:items), s:evalfngen(q))
        let s:timer = timer_start(10, {t ->
              \ [clearmatches(), matchadd('CtrlPMatch', q), hlexists('CtrlPLinePre') ? matchadd('CtrlPLinePre', '^>') : '', execute('redraw')]
              \}, {'repeat': 0})
        return l:filtereditems
      catch /:E\%(871\|872\):/
        continue
      endtry
    endfor
    return copy(a:items)
  endif
endfunction
