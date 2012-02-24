"=============================================================================
" FILE: mappings.vim
" AUTHOR: Shougo Matsushita <Shougo.Matsu@gmail.com>
" Last Modified: 10 Aug 2011.
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

" Define default mappings.
function! vimshell#mappings#define_default_mappings()"{{{
  " Plugin keymappings"{{{
  nnoremap <buffer><silent> <Plug>(vimshell_enter)  i<C-g>u<ESC>:<C-u>call vimshell#execute_current_line(0)<CR><ESC>
  nnoremap <buffer><silent> <Plug>(vimshell_previous_prompt)  :<C-u>call <SID>previous_prompt()<CR>
  nnoremap <buffer><silent> <Plug>(vimshell_next_prompt)  :<C-u>call <SID>next_prompt()<CR>
  nnoremap <buffer><silent> <Plug>(vimshell_delete_previous_output)  :<C-u>call <SID>delete_previous_output()<CR>
  nnoremap <buffer><silent> <Plug>(vimshell_paste_prompt)  :<C-u>call <SID>paste_prompt()<CR>
  nnoremap <buffer><silent> <Plug>(vimshell_move_end_argument) :<C-u>call <SID>move_end_argument()<CR>
  nnoremap <buffer><silent> <Plug>(vimshell_hide) :<C-u>call <SID>hide()<CR>
  nnoremap <buffer><silent> <Plug>(vimshell_exit) :<C-u>call <SID>exit()<CR>
  nnoremap <buffer><expr> <Plug>(vimshell_change_line) vimshell#check_prompt() ? printf('0%dlc$', vimshell#util#strchars(vimshell#get_prompt())) : 'ddO'
  nmap  <buffer> <Plug>(vimshell_delete_line) <Plug>(vimshell_change_line)<ESC>
  nnoremap <buffer><silent> <Plug>(vimshell_insert_head)  :<C-u>call <SID>move_head()<CR>
  nnoremap <buffer><silent> <Plug>(vimshell_hangup)       :<C-u>call <SID>hangup(0)<CR>
  nnoremap <buffer><silent> <Plug>(vimshell_insert_enter)  :<C-u>call <SID>insert_enter()<CR>
  nnoremap <buffer><silent> <Plug>(vimshell_insert_head)  :<C-u>call <SID>insert_head()<CR>
  nnoremap <buffer><silent> <Plug>(vimshell_append_enter)  :<C-u>call <SID>append_enter()<CR>
  nnoremap <buffer><silent> <Plug>(vimshell_append_end)  :<C-u>call <SID>append_end()<CR>
  nnoremap <buffer><silent> <Plug>(vimshell_clear)  :<C-u>call <SID>clear(0)<CR>
  nnoremap <buffer><silent> <Plug>(vimshell_move_head)  :<C-u>call <SID>move_head()<CR><ESC>l

  vnoremap <buffer><silent><expr> <Plug>(vimshell_select_previous_prompt)  <SID>select_previous_prompt()
  vnoremap <buffer><silent><expr> <Plug>(vimshell_select_next_prompt)  <SID>select_next_prompt()

  inoremap <buffer><silent><expr> <Plug>(vimshell_history_complete_whole)  vimshell#complete#history_complete#whole()
  inoremap <buffer><silent><expr> <Plug>(vimshell_history_complete_insert)  vimshell#complete#history_complete#insert()
  inoremap <buffer><silent><expr> <Plug>(vimshell_command_complete) pumvisible() ? "\<C-n>" : vimshell#parser#check_wildcard() ?
        \ <SID>expand_wildcard() : vimshell#complete#command_complete#complete()
  inoremap <buffer><silent> <Plug>(vimshell_push_current_line)  <ESC>:call <SID>push_current_line()<CR>
  inoremap <buffer><silent> <Plug>(vimshell_insert_last_word)  <ESC>:call <SID>insert_last_word()<CR>
  inoremap <buffer><silent> <Plug>(vimshell_run_help)  <ESC>:call <SID>run_help()<CR>
  inoremap <buffer><silent> <Plug>(vimshell_move_head)  <ESC>:call <SID>move_head()<CR>
  inoremap <buffer><silent><expr> <Plug>(vimshell_delete_backward_line)  <SID>delete_backward_line()
  inoremap <buffer><silent><expr> <Plug>(vimshell_delete_backward_word)  vimshell#get_cur_text()  == '' ? '' : "\<C-w>"
  inoremap <buffer><silent> <Plug>(vimshell_enter)  <C-g>u<ESC>:<C-u>call vimshell#execute_current_line(1)<CR>
  " inoremap <buffer><silent> <Plug>(vimshell_interrupt)       <C-o>:call vimshell#interactive#send_char(3)<CR>
  inoremap <buffer><silent> <Plug>(vimshell_interrupt)       <C-o>:call <SID>hangup(1)<CR>
  inoremap <buffer><silent> <Plug>(vimshell_move_previous_window)       <ESC><C-w>p

  inoremap <buffer><silent><expr> <Plug>(vimshell_delete_backward_char)  <SID>delete_backward_char()
  inoremap <buffer><silent><expr> <Plug>(vimshell_another_delete_backward_char)  <SID>delete_another_backward_char()
  inoremap <buffer><silent><expr> <Plug>(vimshell_delete_forward_line)  col('.') == col('$') ? "" : "\<ESC>lDa"
  inoremap <buffer><silent> <Plug>(vimshell_clear)  <ESC>:call <SID>clear(1)<CR>
  "}}}

  if exists('g:vimshell_no_default_keymappings') && g:vimshell_no_default_keymappings
    return
  endif

  " Normal mode key-mappings.
  " Execute command.
  nmap <buffer> <CR> <Plug>(vimshell_enter)
  " Hide vimshell.
  nmap <buffer> q <Plug>(vimshell_hide)
  " Exit vimshell.
  nmap <buffer> Q <Plug>(vimshell_exit)
  " Move to previous prompt.
  nmap <buffer> <C-p> <Plug>(vimshell_previous_prompt)
  " Move to next prompt.
  nmap <buffer> <C-n> <Plug>(vimshell_next_prompt)
  " Remove this output.
  nmap <buffer> <C-k> <Plug>(vimshell_delete_previous_output)
  " Paste this prompt.
  nmap <buffer> <C-y> <Plug>(vimshell_paste_prompt)
  " Search end argument.
  nmap <buffer> E <Plug>(vimshell_move_end_argument)
  " Change line.
  nmap <buffer> cc <Plug>(vimshell_change_line)
  " Delete line.
  nmap <buffer> dd <Plug>(vimshell_delete_line)
  " Start insert.
  nmap <buffer> I         <Plug>(vimshell_insert_head)
  nmap <buffer> A         <Plug>(vimshell_append_end)
  nmap <buffer> i         <Plug>(vimshell_insert_enter)
  nmap <buffer> a         <Plug>(vimshell_append_enter)
  nmap <buffer> ^         <Plug>(vimshell_move_head)
  " Interrupt.
  nmap <buffer> <C-c> <Plug>(vimshell_hangup)
  " Clear.
  nmap <buffer> <C-l> <Plug>(vimshell_clear)

  " Visual mode key-mappings.
  " Move to previous prompt.
  vmap <buffer> <C-p> <Plug>(vimshell_select_previous_prompt)
  " Move to next prompt.
  vmap <buffer> <C-n> <Plug>(vimshell_select_next_prompt)

  " Insert mode key-mappings.
  " Execute command.
  inoremap <expr> <SID>(bs-ctrl-])    getline('.')[col('.') - 2] ==# "\<C-]>" ? "\<BS>" : ''
  imap <buffer> <C-]>               <C-]><SID>(bs-ctrl-])
  imap <buffer> <CR>                <C-]><Plug>(vimshell_enter)
  " History completion.
  inoremap <buffer> <expr><silent> <C-l>  unite#sources#vimshell_history#start_complete()
  " Command completion.
  imap <buffer> <TAB>  <Plug>(vimshell_command_complete)
  " Move to Beginning of command.
  imap <buffer> <C-a> <Plug>(vimshell_move_head)
  " Delete all entered characters in the current line.
  imap <buffer> <C-u> <Plug>(vimshell_delete_backward_line)
  " Delete previous word characters in the current line.
  imap <buffer> <C-w> <Plug>(vimshell_delete_backward_word)
  " Push current line to stack.
  imap <buffer> <C-z> <Plug>(vimshell_push_current_line)
  " Insert last word.
  imap <buffer> <C-t> <Plug>(vimshell_insert_last_word)
  " Run help.
  imap <buffer> <C-x><C-h> <Plug>(vimshell_run_help)
  " Interrupt.
  imap <buffer> <C-c> <Plug>(vimshell_interrupt)
  " Delete char.
  imap <buffer> <C-h>    <Plug>(vimshell_delete_backward_char)
  imap <buffer> <BS>     <Plug>(vimshell_delete_backward_char)
  " Delete line.
  imap <buffer> <C-k>     <Plug>(vimshell_delete_forward_line)
  " Move to previous window.
  imap <buffer> <C-x>     <Plug>(vimshell_move_previous_window)
endfunction"}}}

" VimShell key-mappings functions.
function! s:push_current_line()"{{{
  " Check current line.
  if !vimshell#check_prompt()
    return
  endif

  call add(b:vimshell.commandline_stack, getline('.'))

  " Todo:
  " Print command line stack.
  " let l:stack = map(deepcopy(b:vimshell.commandline_stack),
  "       \ 'vimshell#get_prompt_command(v:val)')
  " call append('.', l:stack)

  " Set prompt line.
  call setline('.', vimshell#get_prompt())

  startinsert!
endfunction"}}}
function! s:push_and_execute(command)"{{{
  " Check current line.
  if !vimshell#check_prompt()
    return
  endif

  call add(b:vimshell.commandline_stack, getline('.'))

  " Set prompt line.
  call setline('.', vimshell#get_prompt() . a:command)

  call s:execute_line(1)
endfunction"}}}

function! vimshell#mappings#execute_line(is_insert)"{{{
  if !vimshell#check_prompt() && !vimshell#check_secondary_prompt()
    " Prompt not found

    if a:is_insert
      return
    endif

    if !vimshell#check_prompt('$')
      " Create prompt line.
      call append('$', vimshell#get_prompt())
    endif

    if getline('.') =~ '^\s*\d\+:\s[^[:space:]]'
      " History output execution.
      call setline('$', vimshell#get_prompt() . matchstr(getline('.'), '^\s*\d\+:\s\zs.*'))
    else
      " Search cursor file.
      let l:filename = substitute(substitute(vimshell#get_cursor_filename(),
            \ '\\', '/', 'g'), ' ', '\\ ', 'g')
      call s:open_file(l:filename)
    endif

    $
  elseif line('.') != line('$')
    " History execution.

    " Search next prompt.
    let l:prompt = vimshell#escape_match(vimshell#get_prompt())
    if vimshell#get_user_prompt() != ''
      let l:nprompt = '^\[%\] '
    else
      let l:nprompt = '^' . l:prompt
    endif

    let [l:next_line, l:next_col] = searchpos(l:nprompt, 'Wn')

    if l:next_line > 0 && l:next_line - line('.') > 1
      execute printf('%s,%sdelete _', line('.')+1, l:next_line-1)

      call vimshell#terminal#clear_highlight()
      normal! k
    endif
  endif

  let l:oldpos = getpos('.')
  let b:interactive.output_pos = getpos('.')

  if !empty(b:vimshell.continuation)
    try
      let l:ret = vimshell#parser#execute_continuation(a:is_insert)
    catch
      " Error.
      call vimshell#error_line({}, v:exception . ' ' . v:throwpoint)
      let l:context = b:vimshell.continuation.context
      let b:vimshell.continuation = {}
      call vimshell#print_prompt(l:context)
      call vimshell#start_insert(a:is_insert)
    endtry

    return
  endif

  call s:execute_command_line(a:is_insert, l:oldpos)
endfunction"}}}
function! s:execute_command_line(is_insert, oldpos)"{{{
  " Get command line.
  let l:line = vimshell#get_prompt_command()
  let l:context = {
        \ 'has_head_spaces' : l:line =~ '^\s\+',
        \ 'is_interactive' : 1,
        \ 'is_insert' : a:is_insert,
        \ 'fd' : { 'stdin' : '', 'stdout': '', 'stderr': ''},
        \}

  if l:line =~ '^\s*-\s*$'
    " Popd.
    call vimshell#execute_internal_command('cd', ['-'], {}, {})
  elseif l:line =~ '^\s*$'
    " Call emptycmd filter.
    let l:line = vimshell#hook#call_filter('emptycmd', l:context, l:line)
  endif

  if l:line =~ '^\s*$\|^\s*-\s*$'
    call vimshell#print_prompt(l:context)

    call vimshell#start_insert(a:is_insert)
    return
  endif

  try
    call vimshell#parser#check_script(l:line)
  catch /^Exception: Quote/
    call vimshell#print_secondary_prompt()

    call vimshell#start_insert(a:is_insert)
    return
  endtry

  " Call preparse filter.
  let l:line = vimshell#hook#call_filter('preparse', l:context, l:line)

  " Save cmdline.
  let b:vimshell.cmdline = l:line

  " Not append history if starts spaces or dups.
  if l:line !~ '^\s'
    call vimshell#history#append(l:line)
  endif

  try
    let l:ret = vimshell#parser#eval_script(l:line, l:context)
  catch /File ".*" is not found./
    " Command not found.
    let l:oldline = l:line
    let l:line = vimshell#hook#call_filter('notfound', l:context, l:line)
    if l:line !=# l:oldline
      " Retry.
      call setpos('.', a:oldpos)
      call setline('.', l:line)
      call s:execute_line(a:is_insert)
    endif

    " Error.
    call vimshell#error_line({}, v:exception . ' ' . v:throwpoint)
    call vimshell#print_prompt(l:context)
    call vimshell#start_insert(a:is_insert)
    return
  catch
    " Error.
    call vimshell#error_line({}, v:exception . ' ' . v:throwpoint)
    call vimshell#print_prompt(l:context)
    call vimshell#start_insert(a:is_insert)
    return
  endtry

  if l:ret == 0
    call vimshell#print_prompt(l:context)
  endif

  call vimshell#start_insert(a:is_insert)
endfunction"}}}
function! s:previous_prompt()"{{{
  call search('^' . vimshell#escape_match(vimshell#get_prompt()) . '.\?', 'bWe')
endfunction"}}}
function! s:next_prompt()"{{{
  call search('^' . vimshell#escape_match(vimshell#get_prompt()) . '.\?', 'We')
endfunction"}}}
function! s:select_previous_prompt()"{{{
  let l:prompt_pattern = '^' . vimshell#escape_match(vimshell#get_prompt())
  let [l:linenr, l:col] = searchpos(l:prompt_pattern, 'bWen')
  if l:linenr == 0
    return ''
  endif
  
  return (line('.') - l:linenr - 1) . 'k'
endfunction"}}}
function! s:select_next_prompt()"{{{
  let l:prompt_pattern = vimshell#get_user_prompt() != '' ?
        \ '^' . vimshell#escape_match(vimshell#get_prompt()) : '^\[%\] '
  let [l:linenr, l:col] = searchpos(l:prompt_pattern, 'Wen')
  if l:linenr == 0
    return ''
  endif
  
  return (l:linenr - line('.') - 2) . 'j'
endfunction"}}}
function! s:delete_previous_output()"{{{
  let l:prompt = vimshell#escape_match(vimshell#get_prompt())
  if vimshell#get_user_prompt() != ''
    let l:nprompt = '^\[%\] '
  else
    let l:nprompt = '^' . l:prompt
  endif
  let l:pprompt = '^' . l:prompt

  " Search next prompt.
  if getline('.') =~ l:nprompt
    let l:next_line = line('.')
  elseif vimshell#get_user_prompt() != '' && getline('.') =~ '^' . l:prompt
    let [l:next_line, l:next_col] = searchpos(l:nprompt, 'bWn')
  else
    let [l:next_line, l:next_col] = searchpos(l:nprompt, 'Wn')
  endif
  while getline(l:next_line-1) =~ l:nprompt
    let l:next_line -= 1
  endwhile

  normal! 0
  let [l:prev_line, l:prev_col] = searchpos(l:pprompt, 'bWn')
  if l:prev_line > 0 && l:next_line - l:prev_line > 1
    execute printf('%s,%sdelete', l:prev_line+1, l:next_line-1)
    call append(line('.')-1, "* Output was deleted *")
  endif
  call s:next_prompt()

  call vimshell#terminal#clear_highlight()
endfunction"}}}
function! s:insert_last_word()"{{{
  let l:word = ''
  let l:histories = vimshell#history#read()
  if !empty(l:histories)
    for w in reverse(split(l:histories[0], '[^\\]\zs\s'))
      if w =~ '[[:alpha:]_/\\]\{2,}'
        let l:word = w
        break
      endif
    endfor
  endif
  call setline(line('.'), getline('.') . l:word)
  startinsert!
endfunction"}}}
function! s:run_help()"{{{
  if match(getline('.'), vimshell#escape_match(vimshell#get_prompt())) < 0
    startinsert!
    return
  endif

  " Delete prompt string.
  let l:line = substitute(getline('.'), '^' . vimshell#escape_match(vimshell#get_prompt()), '', '')
  if l:line =~ '^\s*$'
    startinsert!
    return
  endif

  let l:program = split(l:line)[0]
  if l:program !~ '\h\w*'
    startinsert!
    return
  elseif has_key(b:vimshell.alias_table, l:program)
    let l:program = b:vimshell.alias_table[l:program]
  elseif has_key(b:vimshell.galias_table, l:program)
    let l:program = b:vimshell.galias_table[l:program]
  endif
  
  if exists(':Ref')
    execute 'Ref man' l:program
  elseif exists(':Man')
    execute 'Man' l:program
  else
    call vimshell#error_line({}, 'Please install ref.vim or manpageview.vim.')
  endif
endfunction"}}}
function! s:paste_prompt()"{{{
  let l:prompt = getline('.')
  if l:prompt !~# vimshell#escape_match(vimshell#get_prompt())
    return
  endif

  if getline('$') !~# vimshell#escape_match(vimshell#get_prompt())
        \ || vimshell#get_prompt_command(getline('$')) != ''
    " Insert prompt line.
    call append(line('$'), l:prompt)
  else
    " Set prompt line.
    call setline(line('$'), l:prompt)
  endif
  $
endfunction"}}}
function! s:move_head()"{{{
  call s:insert_head()
endfunction"}}}
function! s:move_end_argument()"{{{
  normal! 0
  call search('\\\@<!\s\zs[^[:space:]]*$', '', line('.'))
endfunction"}}}
function! s:delete_line()"{{{
  let l:col = col('.')
  let l:mcol = col('$')
  call setline(line('.'), vimshell#get_prompt() . getline('.')[l:col :])
  call s:move_head()
  if l:col == l:mcol-1
    startinsert!
  endif
endfunction"}}}
function! s:clear(is_insert)"{{{
  " Clean up the screen.
  let l:lines = split(vimshell#get_prompt_command(), "\<NL>", 1)
  % delete _

  call vimshell#terminal#clear_highlight()
  call vimshell#terminal#init()

  call vimshell#print_prompt()
  call vimshell#set_prompt_command(l:lines[0])
  call append('$', map(l:lines[1:], string(vimshell#get_secondary_prompt()).'.v:val'))
  $

  if a:is_insert
    call vimshell#start_insert()
  endif
endfunction"}}}
function! s:expand_wildcard()"{{{
  " Wildcard.
  if empty(vimshell#get_current_args())
    return ''
  endif
  let l:wildcard = vimshell#get_current_args()[-1]
  let l:expanded = vimproc#parser#expand_wildcard(l:wildcard)

  return (pumvisible() ? "\<C-e>" : '')
        \ . repeat("\<BS>", len(l:wildcard)) . join(l:expanded)
endfunction"}}}
function! s:hide()"{{{
  let l:vimsh_buf = bufnr('%')
  " Switch buffer.
  if winnr('$') != 1
    close
  else
    call vimshell#alternate_buffer()
  endif
endfunction"}}}
function! s:exit()"{{{
  call s:hide()
  execute 'bdelete!'. l:vimsh_buf
endfunction"}}}
function! s:delete_backward_char()"{{{
  if !pumvisible()
    let l:prefix = ''
  elseif exists('g:neocomplcache_enable_auto_select') && g:neocomplcache_enable_auto_select
    let l:prefix = "\<C-e>"
  else
    let l:prefix = "\<C-y>"
  endif

  " Prevent backspace over prompt
  let l:cur_text = vimshell#get_cur_line()
  if l:cur_text !=# vimshell#get_prompt()
    return l:prefix . "\<BS>"
  else
    return l:prefix
  endif
endfunction"}}}
function! s:delete_another_backward_char()"{{{
  return vimshell#get_cur_text() != '' ?
        \ s:delete_backward_char() :
        \ winnr('$') != 1 ?
        \ "\<ESC>:close\<CR>" :
        \ "\<ESC>:buffer #\<CR>"
endfunction"}}}
function! s:delete_backward_line()"{{{
  if !pumvisible()
    let l:prefix = ''
  elseif exists('g:neocomplcache_enable_auto_select') && g:neocomplcache_enable_auto_select
    let l:prefix = "\<C-e>"
  else
    let l:prefix = "\<C-y>"
  endif

  let l:len = len(substitute(vimshell#get_cur_text(), '.', 'x', 'g'))

  return l:prefix . repeat("\<BS>", l:len)
endfunction"}}}
function! s:open_file(filename)"{{{
  " Execute cursor file.
  if a:filename == ''
    return
  endif

  if a:filename !~ '^\a\+:\|^[/~]'
    let l:prompt_nr = vimshell#get_prompt_linenr()
    let l:filename = (has_key(b:vimshell.prompt_current_dir, l:prompt_nr)?
          \ b:vimshell.prompt_current_dir[l:prompt_nr] : getcwd()) . '/' . a:filename
    let l:filename = substitute(l:filename, '//', '/', 'g')
    let l:filename = substitute(l:filename, ' ', '\\ ', 'g')
  else
    let l:filename = a:filename
  endif

  if l:filename =~ '^\%(https\?\|ftp\)://'
    " Open URI.
    call setline('$', vimshell#get_prompt() . 'open ' . l:filename)
  elseif isdirectory(substitute(l:filename, '\\ ', ' ', 'g'))
    " Change directory.
    call setline('$', vimshell#get_prompt() . 'cd ' . l:filename)
  else
    " Edit file.
    call setline('$', vimshell#get_prompt() . 'vim ' . l:filename)
  endif
endfunction"}}}
function! s:hangup(is_insert)"{{{
  if empty(b:vimshell.continuation)
    return
  endif

  " Kill process.
  call vimshell#interactive#hang_up(bufname('%'))

  " Clear continuation.
  let b:vimshell.continuation = {}

  let l:context = {
        \ 'has_head_spaces' : 0,
        \ 'is_interactive' : 1, 
        \ 'is_insert' : a:is_insert, 
        \ 'fd' : { 'stdin' : '', 'stdout': '', 'stderr': ''}, 
        \}

  call vimshell#print_prompt(l:context)
  call vimshell#start_insert(a:is_insert)
endfunction"}}}
function! s:insert_enter()"{{{
  if !vimshell#head_match(getline('.'), vimshell#get_prompt())
    $
    startinsert!
    return
  endif

  if col('.') <= len(vimshell#get_prompt())
    if len(vimshell#get_prompt()) + 1 >= col('$')
      startinsert!
      return
    else
      let l:pos = getpos('.')
      let l:pos[2] = len(vimshell#get_prompt()) + 1
      call setpos('.', l:pos)
    endif
  endif

  startinsert
endfunction"}}}
function! s:insert_head()"{{{
  normal! 0
  call s:insert_enter()
endfunction"}}}
function! s:append_enter()"{{{
  if vimshell#check_cursor_is_end()
    call s:append_end()
  else
    normal! l
    call s:insert_enter()
  endif
endfunction"}}}
function! s:append_end()"{{{
  call s:insert_enter()
  startinsert!
endfunction"}}}

" vim: foldmethod=marker
