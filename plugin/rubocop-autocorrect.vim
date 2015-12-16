if exists('g:loaded_rubocop_autocorrect') || &cp
  finish
endif

let g:loaded_rubocop_autocorrect = 1

function! s:get_visual_selection()
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return lines
endfunction

function! s:autocorrect(content)
  let l:tmp_file = tempname()
  call writefile(a:content, l:tmp_file)
  let l:rubocop_cmd = "rubocop --auto-correct " . l:tmp_file
  call system(l:rubocop_cmd)
  let l:output = join(readfile(l:tmp_file), "\n") . "\n"

  return l:output
endfunction

function! s:main()
  let @x = s:autocorrect(s:get_visual_selection())
  " delete current selection
  normal gvd
  " paste code from tmp file
  normal "xP
  " format pasted text
  silent normal `[=`]
endfunction

xnoremap <silent> <Plug>RubocopAutocorrect :<C-U>call <SID>main()<CR>'"))

xmap = <Plug>RubocopAutocorrect
