" Vundle
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" syntax
Bundle 'hail2u/vim-css3-syntax'
Bundle 'jQuery'
Bundle 'Markdown'
Bundle 'https://github.com/timcharper/textile.vim.git'
Bundle 'http://github.com/othree/html5-syntax.vim'

" Plugins
Bundle 'VimExplorer'
Bundle 'shemerey/vim-project'
Bundle 'YankRing.vim'
Bundle 'http://github.com/thinca/vim-poslist.git'
Bundle 'http://github.com/thinca/vim-quickrun.git'
Bundle 'http://github.com/Shougo/neocomplcache.git'
Bundle 'matchit.zip'
Bundle 'http://github.com/scrooloose/nerdcommenter.git'
Bundle 'surround.vim'
Bundle 'unite.vim'

filetype plugin indent on

" General
syntax on
filetype on
filetype indent on
filetype plugin on

" MacVim
if has('gui_macvim')
	set transparency=10
	set guifont=Osaka-Mono:h14
	set guioptions-=T
	set imdisable
	colorscheme desert
endif

"新しい行のインデントを現在行と同じにする
set autoindent
"タブの代わりに空白文字
set expandtab
"行番号を表示する
set number
"閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
"検索時に大文字をふくんでいたら大/少を区別する
set smartcase
"新しい行を作ったとき高度な自動インデントを行う
set smartindent
"シフト移動幅
set shiftwidth=2
"<tab>が対応する空白の数
set tabstop=2
"カーソル位置にラインを入れる
set cursorline

" 全角スペースをハイライト
if has("syntax")
  syntax on
  function! ActivateInvisibleIndicator()
    syntax match InvisibleJISX0208Space "　" display containedin=ALL
    highlight InvisibleJISX0208Space term=underline ctermbg=Cyan guibg=Cyan
  endf
  augroup invisible
    autocmd! invisible
    autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
  augroup END
endif

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
set laststatus=2

" 行末の空白をハイライト
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

" スワップファイルを作成しない
set noswapfile
" バックアップを作成しない
set nobackup

" neocomplcache.vim
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_auto_completion_start_length = 2
let g:neocomplcache_min_syntax_length = 2
let g:neocomplcache_min_keyword_length = 2
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1

" スニペット編集 引数にfiletype
" command! -nargs=* Snip NeoComplCacheEditSnippets

" 無名レジスタに入るデータを、*レジスタにも入れる。
set clipboard=unnamed


" キーマップリーダー
let mapleader = ","

" 自動で閉じる
inoremap {} {}<LEFT>
inoremap [] []<LEFT>
inoremap () ()<LEFT>
inoremap "" ""<LEFT>
inoremap '' ''<LEFT>
inoremap <> <><LEFT>

"usキーボードで使いやすく
nmap ; :
