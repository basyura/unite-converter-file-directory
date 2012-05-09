
let s:save_cpo = &cpo
set cpo&vim

function! unite#filters#converter_file_directory#define()
  return s:converter
endfunction

let s:converter = {
      \ 'name' : 'converter_file_directory',
      \ 'description' : '',
      \}

function! s:converter.filter(candidates, context)
  let candidates = copy(a:candidates)
  for candidate in candidates
    let width = get(g:, 'unite_converter_file_directory_width', 35)
    let abbr  = s:padding(fnamemodify(candidate.word, ':t'), width) . ' '
    let path  = fnamemodify(candidate.word, ':~:h')
    if path == '.'
      let path = ''
    endif
    let candidate.abbr = abbr . path
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

