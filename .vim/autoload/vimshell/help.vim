"=============================================================================
" FILE: help.vim
" AUTHOR: Shougo Matsushita <Shougo.Matsu@gmail.com>
" Last Modified: 15 May 2011.
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

" For echodoc."{{{
let s:doc_dict = {
      \ 'name' : 'vimshell',
      \ 'rank' : 10,
      \ 'filetypes' : { 'vimshell' : 1 },
      \ }
function! s:doc_dict.search(cur_text)"{{{
  " Get command name.
  try
    let l:args = vimshell#get_current_args(a:cur_text)
  catch /^Exception: Quote/
    return []
  endtry
  if empty(l:args)
    return []
  endif

  let l:command = fnamemodify(l:args[0], ':t:r')

  let l:commands = vimshell#available_commands()
  if l:command == ''
    return []
  elseif !has_key(l:commands, l:command)
    if !has_key(s:cached_doc, l:command)
      return []
    endif

    let l:description = s:cached_doc[l:command]
  else
    let l:description = l:commands[l:command].description
  endif

  let l:usage = [{ 'text' : 'Usage: ', 'highlight' : 'Identifier' }]
  if l:description =~? '^usage:\s*'
    call add(l:usage, { 'text' : l:command, 'highlight' : 'Statement' })
    call add(l:usage, { 'text' : ' ' . join(split(l:description)[2:]) })
  elseif l:description =~# l:command.'\s*'
    call add(l:usage, { 'text' : l:command, 'highlight' : 'Statement' })
    call add(l:usage, { 'text' : l:description[len(l:command) :] })
  else
    call add(l:usage, { 'text' : l:description })
  endif

  return l:usage
endfunction"}}}
"}}}

function! vimshell#help#init()"{{{
  if exists('g:loaded_echodoc') && g:loaded_echodoc
    call echodoc#register('vimshell', s:doc_dict)
  endif

  call s:load_cached_doc()
endfunction"}}}
function! vimshell#help#get_cached_doc()"{{{
  return s:cached_doc
endfunction"}}}
function! vimshell#help#set_cached_doc(cache)"{{{
  let s:cached_doc = a:cache
  let l:doc_path = g:vimshell_temporary_directory.'/cached-doc'
  call writefile(values(map(deepcopy(s:cached_doc), 'v:key."!!!".v:val')), l:doc_path)
endfunction"}}}

function! s:load_cached_doc()"{{{
  let s:cached_doc = {}
  let l:doc_path = g:vimshell_temporary_directory.'/cached-doc'
  if !filereadable(l:doc_path)
    call writefile([], l:doc_path)
  endif
  for args in map(readfile(l:doc_path), 'split(v:val, "!!!")')
    let s:cached_doc[args[0]] = join(args[1:], '!!!')
  endfor
endfunction"}}}

" vim: foldmethod=marker
