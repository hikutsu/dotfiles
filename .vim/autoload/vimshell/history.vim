"=============================================================================
" FILE: history.vim
" AUTHOR: Shougo Matsushita <Shougo.Matsu@gmail.com>
" Last Modified: 25 Mar 2011.
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"=============================================================================

function! vimshell#history#append(command)"{{{
  " Reduce blanks.
  let l:command = substitute(a:command, '\s\+', ' ', 'g')

  " Reload history.
  if &filetype ==# 'vimshell'
    let l:program = matchstr(l:command, vimshell#get_program_pattern())
    if l:program != '' && has_key(g:vimshell_no_save_history_commands, l:program)
      " No history command.
      return
    endif
  else
    if has_key(g:vimshell_interactive_no_save_history_commands, &filetype[4:])
          \ && g:vimshell_interactive_no_save_history_commands[&filetype[4:]]
      " No history command.
      return
    endif
  endif

  " Reload history.
  let l:histories = vimshell#history#read()

  " Filtering.
  call insert(filter(l:histories, 'v:val !=# '.string(substitute(l:command, "'", "''", 'g'))), l:command)

  " Truncate.
  let l:histories = l:histories[: g:vimshell_max_command_history-1]

  call vimshell#history#write(l:histories)
endfunction"}}}
function! vimshell#history#read()"{{{
  let l:history_path = s:get_history_path()
  return filereadable(l:history_path) ?
        \ readfile(l:history_path) : []
endfunction"}}}
function! vimshell#history#write(list)"{{{
  " Save history file.
  let l:history_path = s:get_history_path()
  let l:temp_name = tempname()
  call writefile(a:list, l:temp_name)
  call rename(l:temp_name, l:history_path)
endfunction"}}}

function! s:get_history_path()"{{{
  if &filetype ==# 'vimshell'
    let l:history_path = g:vimshell_temporary_directory . '/command-history'
    if !filereadable(l:history_path)
      " Create file.
      call writefile([], l:history_path)
    endif
  else
    let l:history_dir = g:vimshell_temporary_directory . '/int-history'
    if !isdirectory(fnamemodify(l:history_dir, ':p'))
      call mkdir(fnamemodify(l:history_dir, ':p'), 'p')
    endif

    let l:history_path = l:history_dir . '/'.&filetype
  endif

  return l:history_path
endfunction"}}}

" vim: foldmethod=marker
