
let s:save_cpo = &cpo
set cpo&vim

function! unite#filters#converter_bookmark#define()
  return s:converter
endfunction

let s:converter = {
      \ 'name' : 'converter_bookmark',
      \ 'description' : '',
      \}

function! s:converter.filter(candidates, context)
  let candidates = copy(a:candidates)
  for candidate in candidates
    let width = get(g:, 'unite_converter_bookmark_width', 35)
    let pare  = split(candidate.word)
    let name  = matchstr(pare[0], '\[\zs.\+\ze\]')
    let candidate.abbr = s:padding(name, width) . ' ' . pare[1]
  endfor

  return candidates
endfunction

function! s:padding(msg, len)
  let msg = a:msg
  while strwidth(msg) < a:len
    let msg .= ' '
  endwhile
  return msg
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

