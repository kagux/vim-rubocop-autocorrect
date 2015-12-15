if exists('g:loaded_rubocop_autocorrect')
  finish
endif

let g:loaded_rubocop_autocorrect = 1

function! s:RubocopAutocorrect(target)
  let l:tmp_file = fnameescape(tempname());
  let l:content = "hello world"
  " writefile(l:content, l:tmp_file);
  echo l:tmp_file;
endfunction
