" Edited April 20, 2017

scriptencoding utf-8

" TERMINAL SETUP
"-----------------------------------------------------------------------

" Set terminal encoding to utf-8
set tenc=utf-8
 
" Set read encoding to UTF-8:
set encoding=utf-8

" Enable 256 colors on XTerm
if ($TERM == "xterm")
    set term=xterm-256color
else
    if($TERM =="xterm-color")
        set term=xterm
    endif
endif

" BASE SETTINGS
"-----------------------------------------------------------------------

" Don't be compatible with vi
set nocompatible

" Enable a nice big viminfo file
set viminfo='1000,f1,:1000,/1000
set history=500

" Make backspace delete lots of things
set backspace=indent,eol,start

" Create backups
" set backup

" Show us the command we're typing
set showcmd

" Highlight matching parens
set showmatch

" Search options: incremental search, do clever case things, highlight search
set incsearch
set ignorecase
set infercase
set hlsearch

" Show full tags when doing search completion
set showfulltag

" Speed up macros
set lazyredraw

" No annoying error noises
set noerrorbells
set visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Try to show at least three lines and two columns of context when scrolling
set scrolloff=3
set sidescrolloff=2

" Wrap on these 
set whichwrap+=<,>,[,]

" Use the cool tab complete menu
set wildmenu
set wildignore=*.o,*~

" Allow edit buffers to be hidden
set hidden

" 1 height windows
set winminheight=1

" Enable syntax highlighting
syntax on

" Set color scheme 
colorscheme desert

" No icky toolbar, menu or scrollbars in the GUI
if has('gui')
    set guioptions-=m
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
    set guioptions=i

" Use console dialogs instead of popups 
    set guioptions=c    

" Set gui headroom to 0
    set ghr=0
end

" By default, go for an indent of 4
set shiftwidth=4

" Do clever indent things. Don't make a # force column zero.
set autoindent
set smartindent
inoremap # X<BS>#

" Enable folds
set foldenable
set foldmethod=indent

" Syntax when printing
set popt+=syntax:y

" Enable filetype settings
filetype on
filetype plugin on
filetype indent on

" Nice statusbar
set laststatus=2
set statusline=
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%m%r%w                     " flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{&encoding},                " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
set statusline+=0x%-8B\                      " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset


" Include $HOME in cdpath
let &cdpath=','.expand("$HOME")


" WORD COMPLETION | SPELL CHECKING
"-----------------------------------------------------------------------
set dictionary=/usr/share/dict/words
"Vim's default completion command is <C-X><C-K><C-N> (:h ins-completion)
" The command below simplifies it to <C-N>
:set complete-=k complete+=k 
 
" Type :asp to begin spell checking
" cab asp :w<CR>:!aspell -e -c  %<CR>:e<CR><CR>
" To type the control character  use <Ctrl-v><Ctrl-t> in insert mode
map  :w!<CR>:!aspell --lang "en_GB" check %<CR>:e! %<CR>

" AUTOCMDS
"-----------------------------------------------------------------------

" If we're in a wide window, enable line numbers.
fun! <SID>WindowWidth()
    if winwidth(0) > 90
        setlocal foldcolumn=1
        setlocal number
    else
        setlocal nonumber
        setlocal foldcolumn=0
    endif
endfun

" MAPPINGS
"-----------------------------------------------------------------------

nmap   <silent> <S-Right>  :bnext<CR>

" Delete a buffer but keep layout
command! Kwbd enew|bw #
nmap     <C-w>!   :Kwbd<CR>

" Annoying default mappings
inoremap <S-Up>   <C-o>gk
inoremap <S-Down> <C-o>gj
noremap  <S-Up>   gk
noremap  <S-Down> gj

" Automatically format pasted text
:map <c-p> =`]

" Useful things from inside imode
inoremap <C-z>w <C-o>:w<CR>
inoremap <C-z>q <C-o>gq}<C-o>k<C-o>$

" Commonly used commands
nmap <silent> <F3> :silent nohlsearch<CR>
imap <silent> <F3> <C-o>:silent nohlsearch<CR>
nmap <F5> <C-w>c
nmap <F4> :Kwbd<CR>
" nmap <F7> :so %<CR>
nmap <F7> :set nu<CR>
nmap <F8> :set nonu<CR>
nmap <F12> :pop<CR>

" Insert a single char
noremap <Leader>i i<Space><Esc>r

" Split the line
nmap <Leader>n \i<CR>


" Select everything
noremap <Leader>gg ggVG

" Reformat everything
noremap <Leader>gq gggqG

" Reformat paragraph
noremap <Leader>gp gqap

" Clear lines
noremap <Leader>clr :s/^.*$//<CR>:nohls<CR>

" Delete blank lines
noremap <Leader>dbl :g/^$/d<CR>:nohls<CR>

" Enclose each selected line with markers
noremap <Leader>enc :<C-w>execute
            \ substitute(":'<,'>s/^.*/#&#/ \| :nohls", "#", input(">"), "g")<CR>

" Enable fancy % matching
runtime! macros/matchit.vim

" q: sucks
nmap q: :q

" set up some more useful digraphs
digraph ., 8230    " ellipsis (…)



" FINAL COMMANDS
"-----------------------------------------------------------------------

" turn off any existing search
au VimEnter * nohls

" setting linebreak so words aren't broken
set linebreak

" AUTOREAD FILES MODIFIED OUTSIDE THE VIM ENVIRONMENT
"-----------------------------------------------------------------------
set autoread

" Start Powerline
set rtp+=/usr/local/lib/python2.7/site-packages/powerline/bindings/vim
set t_Co=256
let g:minBufExplForceSyntaxEnable = 1
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
 
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
	autocmd!
	au InsertEnter * set timeoutlen=0
	au InsertLeave * set timeoutlen=1000
    augroup END
endif

set laststatus=2 " Always display the statusline in all windows[

" Hide Tildes in empty file
hi NonText guifg=bg
