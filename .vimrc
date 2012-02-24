syntax on
filetype on
filetype indent on
filetype plugin on

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
" neocomplcache
let g:neocomplcache_enable_at_startup = 1 " 起動時に有効化
" スニペットファイルの置き場所
let g:NeoComplCache_SnippetsDir = '~/.vim/snippets'
" TABでスニペットを展開
imap <expr> <TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" :\<Tab>"
" スニペット編集 引数にfiletype
command! -nargs=* Snip NeoComplCacheEditSnippets

" 無名レジスタに入るデータを、*レジスタにも入れる。
set clipboard+=unnamed

" Vundle
set rtp+=~/.vim/vundle.git/
call vundle#rc()

" Syntax
Bundle 'hail2u/vim-css3-syntax'
Bundle "jQuery"
Bundle "Markdown"
Bundle "https://github.com/timcharper/textile.vim.git"
Bundle "http://github.com/othree/html5-syntax.vim"

" Plugins
Bundle 'VimExplorer'
Bundle 'shemerey/vim-project'
Bundle "YankRing.vim"
Bundle "http://github.com/thinca/vim-poslist.git"
Bundle "http://github.com/thinca/vim-quickrun.git"
Bundle 'Shougo/neocomplcache'
Bundle 'matchit.zip'
Bundle 'http://github.com/scrooloose/nerdcommenter.git'
Bundle 'surround.vim'
Bundle 'unite.vim'

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
