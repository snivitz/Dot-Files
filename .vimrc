scriptencoding utf-8

"-----------------------------------------------------------------------
" Vim settings file for Ciaran McCreesh <ciaranm at gentoo.org>
"
" I finally added some comments, so you can have some vague idea of
" what all this does.
"
" Most recent update: Tue Nov  1 15:44:16 2016
"
" Get the latest version from:
"     http://dev.gentoo.org/~ciaranm/configs/vimrc
"
" Don't just blindly copy this vimrc. There's some rather idiosyncratic
" stuff in here...
"
"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

" TERMINAL SETUP
"-----------------------------------------------------------------------

" Extra terminal things
" if ($TERM == "rxvt-unicode") && (&termencoding == "")
"     set termencoding=utf-8
" endif

" Set terminal encoding to utf-8
set tenc=utf-8
 
" Set read encoding to UTF-8:
set encoding=utf-8

" Enable 256 colors on XTerm
if ($TERM == "xterm")
    set term=xterm-256color
else
" xfce4/Terminal has issues with the previous setting
" xfce4/Terminal $TERM is now set to "xterm-color"
" This helps vim use default xterm settings
    if($TERM =="xterm-color")
        set term=xterm
    endif
endif

" BASE SETTING
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

" Search options: incremental search, do clever case things, highlight
" search
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

" Try to show at least three lines and two columns of context when
" scrolling
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

" Set fonts
if has("gui_gtk")
    set guifont=Terminus\ 12
elseif has("gui_running")
    set gfn=-xos4-terminus-medium-r-normal-*-*-160-*-*-c-*-iso8859-1
endif

" Changing colorschemes to match time of day

let s:hour=strftime("%H")
let s:sunrise=6
let s:sunset =18

"if has('gui')
"    colorscheme inkpot
"        else
"    colorscheme desert
"endif

colorscheme desert

" Try to load a nice colourscheme
" fun! LoadColourScheme(schemes)
"     let l:schemes = a:schemes . ":"
"     while l:schemes != ""
"         let l:scheme = strpart(l:schemes, 0, stridx(l:schemes, ":"))
"         let l:schemes = strpart(l:schemes, stridx(l:schemes, ":") + 1)
"         try
"             exec "colorscheme" l:scheme
"             break
"         catch
"         endtry
"     endwhile
" endfun

" if has('gui')
"     call LoadColourScheme("inkpot:desert")
" else    
"     if &t_Co == 88 || &t_Co == 256
"         call LoadColourScheme("desert")
"     else
"         call LoadColourScheme("desert")
"     endif
" endif

"    if &t_Co == 88 || &t_Co == 256
"        call LoadColourScheme("inkpot:desert:elflord")
"    else
"        call LoadColourScheme("desert:elflord")
"    endif
" endif

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

" Enable modelines only on secure vim versions
if (v:version == 603 && has("patch045")) || (v:version > 603)
    set modeline
else
    set nomodeline
endif

" Nice statusbar
set laststatus=2
set statusline=
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%m%r%w                     " flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{&encoding},                " encoding
set statusline+=%{&fileformat}]              " file format
if filereadable(expand("$VIM/vimfiles/plugin/vimbuddy.vim"))
    set statusline+=\ %{VimBuddy()}          " vim buddy
endif
set statusline+=%=                           " right align
set statusline+=0x%-8B\                      " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset

" If possible, try to use a narrow number column.
" if v:version >= 700
"     try
"         setlocal numberwidth=3
"     catch
"     endtry
" endif

" Include $HOME in cdpath
let &cdpath=','.expand("$HOME")

" Better include path
set path+=src/
set path+=/usr/lib/gcc-lib/**/include/g++-v3/**
" Show tabs and trailing whitespace visually
" if (&termencoding == "utf-8") || has("gui_running")
"     if v:version >= 700
"         set list listchars=tab:»·,trail:·,extends:…,nbsp:‗
"     else
"         set list listchars=tab:»·,trail:·,extends:…
"     endif
" else
"     if v:version >= 700
"         set list listchars=tab:>-,trail:.,extends:>,nbsp:_
"     else
"         set list listchars=tab:>-,trail:.,extends:>
"     endif
" endif
" 
" set fillchars=fold:-


" WORD COMPLETION | SPELL CHECKING
"-----------------------------------------------------------------------
set dictionary=/usr/share/dict/words
"Vim's default completion command is <C-X><C-K><C-N> (:h ins-completion)
" The command below simplifies it to <C-N>
:set complete-=k complete+=k 
 
" Type :asp to begin spell checking
" cab asp :w<CR>:!aspell -e -c  %<CR>:e<CR><CR>
"
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

" Force active window to the top of the screen without losing its
" size.
fun! <SID>WindowToTop()
    let l:h=winheight(0)
    wincmd K
    execute "resize" l:h
endfun

" Force active window to the bottom of the screen without losing its
" size.
fun! <SID>WindowToBottom()
    let l:h=winheight(0)
    wincmd J
    execute "resize" l:h
endfun

" Update .*rc header
fun! <SID>UpdateRcHeader()
    let l:c=col(".")
    let l:l=line(".")
    1,10s-\(Most recent update:\).*-\="Most recent update: ".strftime("%c")-e
    call cursor(l:l, l:c)
endfun


" autocmds
augroup ciaranm
    autocmd!

    " Turn off search highlight when idle
    autocmd CursorHold * nohls | redraw

    " Automagic line numbers
    autocmd BufEnter * :call <SID>WindowWidth()

    " Update header in .vimrc and .bashrc before saving
    autocmd BufWritePre *vimrc  :call <SID>UpdateRcHeader()
    autocmd BufWritePre *bashrc :call <SID>UpdateRcHeader()

    " Always do a full syntax refresh
    autocmd BufEnter * syntax sync fromstart

    " For help files, move them to the top window and make <Return>
    " behave like <C-]> (jump to tag)
    autocmd FileType help :call <SID>WindowToTop()
    autocmd FileType help nmap <buffer> <Return> <C-]>

    " For the quickfix window, move it to the bottom
    autocmd FileType qf :3 wincmd _ | :call <SID>WindowToBottom()

    " For svn-commit, don't create backups
    autocmd BufRead svn-commit.tmp :setlocal nobackup

    " Detect procmailrc
    autocmd BufRead procmailrc :setfiletype procmail

    " bash-completion ftdetects
    autocmd BufNewFile,BufRead /*/*bash*completion*/*
                \ if expand("<amatch>") !~# "ChangeLog" |
                \     let b:is_bash = 1 | set filetype=sh |
                \ endif

    try
        " if we have a vim which supports QuickFixCmdPost (patch by
        " ciaranm, marked for inclusion in vim7), give us an error
        " window after running make, grep etc, but only if results are
        " available.
        autocmd QuickFixCmdPost * :cwindow 3
    catch
    endtry
augroup END


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

" Make <space> in normal mode go down a page rather than left a
" character
" noremap <space> <C-f>

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

" Pull the following line to the cursor position
noremap <Leader>J :s/\%#\(.*\)\n\(.*\)/\2\1<CR>

" In normal mode, jj escapes
inoremap jj <Esc>

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

" GNU format changelog entry
fun! MakeChangeLogEntry()
    norm gg
    /^\d
    norm 2O
    norm k
    call setline(line("."), strftime("%Y-%m-%d") .
                \ " Ciaran McCreesh <ciaranm@gentoo.org>")
    norm 2o
    call setline(line("."), "\t* ")
    norm $
endfun
noremap ,cl :call MakeChangeLogEntry()<CR>

" command aliases, can't call these until after cmdalias.vim is loaded
au VimEnter * if exists("loaded_cmdalias") |
            \       call CmdAlias("mkdir",   "!mkdir") |
            \       call CmdAlias("cvs",     "!cvs") |
            \       call CmdAlias("svn",     "!svn") |
            \       call CmdAlias("commit",  "!svn commit -m \"") |
            \       call CmdAlias("upload",  "make upload") |
            \ endif


" SPECIAL LESS.SH AND MAN MODES
"-----------------------------------------------------------------------

fun! <SID>is_pager_mode()
    let l:ppidc = ""
    try
        if filereadable("/lib/libc.so.6")
            let l:ppid = libcallnr("/lib/libc.so.6", "getppid", "")
        elseif filereadable("/lib/libc.so.0")
            let l:ppid = libcallnr("/lib/libc.so.0", "getppid", "")
        else
            let l:ppid = ""
        endif
        let l:ppidc = system("ps -p " . l:ppid . " -o comm=")
        let l:ppidc = substitute(l:ppidc, "\\n", "", "g")
    catch
    endtry
    return l:ppidc ==# "less.sh" ||
                \ l:ppidc ==# "vimpager" ||
                \ l:ppidc ==# "manpager.sh" ||
                \ l:ppidc ==# "vimmanpager"
endfun
if <SID>is_pager_mode()
    " we're in vimpager / less.sh / man mode
    set laststatus=0
    set ruler
    set foldmethod=manual
    set foldlevel=99
    set nolist
endif

" PLUGIN / SCRIPT / APP SETTINGS
"-----------------------------------------------------------------------

" Perl specific options
let perl_include_pod=1
let perl_fold=1
let perl_fold_blocks=1

" Vim specific options
let g:vimsyntax_noerror=1

" c specific options
let g:c_gnu=1
" Settings for taglist.vim
let Tlist_Use_Right_Window=1
let Tlist_Auto_Open=0
let Tlist_Enable_Fold_Column=0
let Tlist_Compact_Format=1
let Tlist_WinWidth=28
let Tlist_Exit_OnlyWindow=1
let Tlist_File_Fold_Auto_Close = 1
nnoremap <silent> <F9> :Tlist<CR>

" Settings minibufexpl.vim
let g:miniBufExplModSelTarget = 1
let g:miniBufExplWinFixHeight = 1
" let g:miniBufExplForceSyntaxEnable = 1

" Settings for showmarks.vim
if has("gui_running")
    let g:showmarks_enable=1
else
    let g:showmarks_enable=0
    let loaded_showmarks=1
endif

autocmd VimEnter *
            \ if has('gui') |
            \        highlight ShowMarksHLl gui=bold guifg=#a0a0e0 guibg=#2e2e2e |
            \        highlight ShowMarksHLu gui=none guifg=#a0a0e0 guibg=#2e2e2e |
            \        highlight ShowMarksHLo gui=none guifg=#a0a0e0 guibg=#2e2e2e |
            \        highlight ShowMarksHLm gui=none guifg=#a0a0e0 guibg=#2e2e2e |
            \        highlight SignColumn   gui=none guifg=#f0f0f8 guibg=#2e2e2e |
            \    endif

" Settings for explorer.vim
let g:explHideFiles='^\.'

" Settings for netrw
let g:netrw_list_hide='^\.,\~$'

" Settings for :TOhtml
let html_number_lines=1
let html_use_css=1
let use_xhtml=1

" cscope settings
if has('cscope') && filereadable("/usr/bin/cscope")
    set csto=0
    set cscopetag
    set nocsverb
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    set csverb

    let x = "sgctefd"
    while x != ""
        let y = strpart(x, 0, 1) | let x = strpart(x, 1)
        exec "nmap <C-j>" . y . " :cscope find " . y .
                    \ " <C-R>=expand(\"\<cword\>\")<CR><CR>"
        exec "nmap <C-j><C-j>" . y . " :scscope find " . y .
                    \ " <C-R>=expand(\"\<cword\>\")<CR><CR>"
    endwhile
    nmap <C-j>i      :cscope find i ^<C-R>=expand("<cword>")<CR><CR>
    nmap <C-j><C-j>i :scscope find i ^<C-R>=expand("<cword>")<CR><CR>
endif

" FINAL COMMANDS
"-----------------------------------------------------------------------

" turn off any existing search
au VimEnter * nohls

" setting linebreak so words aren't broken
set linebreak

" AUTOREAD FILES MODIFIED OUTSIDE THE VIM ENVIRONMENT
"-----------------------------------------------------------------------
set autoread


" START PATHOGEN
" execute pathogen#infect()


"-----------------------------------------------------------------------
"
"
" vim: set shiftwidth=4 softtabstop=4 expandtab tw=72                  :
"
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
