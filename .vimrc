" Set the numerous vim settings
call pathogen#infect()
syntax on
filetype plugin indent on
set nocompatible
set termguicolors
set expandtab
set number
set relativenumber
set hidden
set autoindent
set smartindent
set cindent
set splitbelow
set splitright
set background=dark
set shiftwidth=4
set tabstop=4
set foldmethod=syntax
set laststatus=2
let mapleader=" "
color onedark

" Keybindings
nnoremap <Space> <Nop>
nnoremap <leader>w :w<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>rs :so $MYVIMRC<CR>
nnoremap <leader>es :e $MYVIMRC<CR>
nnoremap <C-CR> <leader>se<CR>
nnoremap <C-K><C-D> gg=G
nnoremap <F3> :TagbarToggle<CR>
nnoremap <F4> :call asyncrun#quickfix_toggle(8)<CR>
map <F8> :vert wincmd f<CR>
nnoremap <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=_iaS --extra=+q .<CR>
nnoremap th :tabfirst<cr>
nnoremap tj :tabnext<cr>
nnoremap tk :tabprev<cr>
nnoremap tl :tablast<cr>
nnoremap tt :tabedit<Space>
nnoremap tn :tabnew<Space>
nnoremap tm :tabm<Space>
nnoremap td :tabclose<cr>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <c-h> <c-w>h
nnoremap <leader>ts :TJSNerd<cr>
nnoremap <leader>nf :NoFilter<cr>
noremap <leader>test :AsyncRun CHROME_BIN=/bin/chromium npm test<cr>
noremap <leader>stop :AsyncStop<cr>
map <leader>bs :b#<cr>
map <C-n> :NERDTreeToggle<CR>
" The following mapping of <c-[> causes issues when entering vim 'nnoremap <c-[> :pop<cr>'

" Set the tags locations
set tags+=tags
set tags+=~/.vim/tags/gl
set tags+=~/.vim/tags/qt
set tags+=~/.vim/tags/qt4
set tags+=~/.vim/tags/sdl

" OmniCPPComplete
let OmniCpp_NamespaceSearch=1
let OmniCpp_GlobalScopeSearch=1
let OmniCpp_ShowAccess=1
let OmniCpp_ShowPrototypeInAbbr=1
let OmniCpp_MayCompleteDot=1
let OmniCpp_MayCompleteArrow=1
let OmniCpp_MayCompleteScope=1
let OmniCpp_DefaultNamespaces=["std", "_GLIBCXX_STD"]
 
" This sets the diff mode to show the changed characters in white
if &diff
    " diff mode
    set diffopt+=iwhite
endif

" Automatically resize the splits to equal window size when the
" window is resized and you are in diff mode
if exists("##VimResized")
    if &diff
        au VimResized * wincmd =
    endif
endif

" Airline Settings
let g:airline#extensions#tabline#enabled = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1
let g:airline_symbols.space = "\ua0"

" CTRLP Settings
let g:ctrlp_by_filename=1
let g:ctrlp_custom_ignore = {'file': '\v\.(o)$' }

" Tsuquyomi Settings (Typescript)
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi']

" NERDTree Settings
command! TJSNerd call ToggleJSNerdTreeFilter()
function! ToggleJSNerdTreeFilter()
    let g:NERDTreeIgnore = ['\.js$','\.js.map$']
endfunction

command! NoFilter call NoFilter()
function! NoFilter()
    let g:NERDTreeIgnore = ['']
endfunction

" Simple re-format for minified Javascript
command! UnMinify call UnMinify()
function! UnMinify()
    %s/{\ze[^\r\n]/{\r/g
    %s/){/) {/g
    %s/};\?\ze[^\r\n]/\0\r/g
    %s/;\ze[^\r\n]/;\r/g
    %s/[^\s]\zs[=&|]\+\ze[^\s]/ \0 /g
    normal ggVG=
endfunction

" Always open the quickfix window when something is added
augroup vimrc
    autocmd QuickFixCmdPost * botright copen 8
augroup END
