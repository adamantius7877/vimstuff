set nocompatible
execute pathogen#infect()
execute pathogen#helptags()
filetype plugin on
filetype plugin indent on
set encoding=utf-8
if has("gui_running")
    hi Comment cterm=italic
    set guifont=Noto_Mono_for_Powerline:h10:cANSI:qDRAFT
else
    let g:onedark_termcolors=16
    set term=win32
endif
set omnifunc=syntaxcomplete#Complete
set backspace=2
set tabstop=4
set shiftwidth=4
set expandtab
set number rnu
set hidden
set switchbuf=useopen
syntax on
set foldmethod=syntax
set background=dark
set splitbelow
set splitright
set dir=~/tmp
colorscheme carbonized-dark
nnoremap <SPACE> <NOP>
let mapleader = "\<SPACE>"

" Ale Configuration
let g:ale_html_htmlhint_options = '--config %USERPROFILE%\vimfiles\.htmlhintrc'
let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_save = 1
let g:ale_set_loclist=0
let g:ale_set_quickfix=1

let g:ale_linters = {
            \ 'typescript':['tsuquyomi']
            \}

" Required for airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

" ctrlp
set runtimepath^=~/vimfiles/bundle/ctrlp.vim
let g:ctrlp_custom_ignore = '\v[\/](bin\\|node_modules\\|obj\\)'

" Javascript Options
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

let g:ctrlp_map = "<c-space>"
let g:ctrlp_cmd = "CtrlP"

" set foldlevelstart=1

let javascript_fold=1           " JavaScript
let perl_fold=1                 " Perl
let php_folding=1               " PHP
let r_syntax_folding=1          " R
let ruby_fold=1                 " Ruby
let sh_fold_enabled=1           " Shell Scripts
let vimsyn_folding=1            " Vim Script
let xml_syntax_folding=1        " XML

" NERDTree Mappings and Options
map <C-n> :NERDTreeToggle<CR>
map <leader>r :NERDTreeFind<CR>

" Reload .vimrc
map <leader>rs :source $MYVIMRC<CR>
" Edit .vimrc
map <leader>es :e $MYVIMRC<CR>
" Edit cmd batch
map <leader>cmd :e C:\Users\c.henderson1\Documents\BatchFiles\env.cmd<CR>
" Edit ctags file
map <leader>ctag :e C:\Users\c.henderson1\ctags.cnf<CR>
nnoremap <F6> :AsyncRun -program=make<CR>
nnoremap <leader>cal :Calendar<CR>


" Set Fold Methods
map <leader>zi :set foldmethod=indent<CR>
map <leader>zs :set foldmethod=syntax<CR>
map <leader>zm :set foldmethod=manual<CR>

" Tmux Navigator Mappings and Options
let g:tmux_navigator_no_mappings = 1
"nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
"nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
"nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
"nnoremap <silent> <C-l> :TmuxNavigateRight<CR>

nnoremap <silent> <C-h> <C-w><C-h>
nnoremap <silent> <C-j> <C-w><C-j>
nnoremap <silent> <C-k> <C-w><C-k>
nnoremap <silent> <C-l> <C-w><C-l>

" Status Line Options
set statusline+=%#warningmsg#
set statusline+=%*
set statusline+=%{gutentags#statusline()}
set statusline+=%{ObsessionStatus()}

" Syntastic Mappings and Options
map <leader>c :lclose<CR>
map <leader>o :lopen<CR>
map <leader>ne :lnext<CR>
map <leader>pe :lprev<CR>
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:used_javascript_libs='jquery, angularjs, angular4'

map <leader>ts :let NERDTreeIgnore = ['\.js']<CR>r
map <leader>nf :let NERDTreeIgnore = ['']<CR>r

map <leader>> 10<C-w><S->>
map <leader>< 10<C-w><S-<>
map <leader>bs :b#<CR>



let g:ycm_semantic_triggers = {
            \ 'css': [ 're!^\s{4}', 're!:\s+' ],
            \ 'scss': [ 're!^\s{4}', 're!:\s+' ],
            \}

noremap <F4> :call asyncrun#quickfix_toggle(8)<CR>
noremap <leader>test :AsyncRun npm test<CR>
noremap <leader>stop :AsyncStop<CR>
map <leader>lp `.

if has("autocmd")
    autocmd FileType TypeScript nnoremap gd :TsuDefinition<CR>
    autocmd FileType TypeScript nnoremap gb :TsuGoBack<CR>
    autocmd FileType TypeScript nnoremap <leader>import :TsuImport<CR>
    autocmd QuickFixCmdPost * call asyncrun#quickfix_toggle(8,1)

    augroup omnisharp_commands
        autocmd!

        autocmd FileType cs vnoremap <C-k><C-c> :s/^/\/\//<CR>
        autocmd FileType cs vnoremap <C-k><C-u> :s/^\/\///<CR>
        "Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
        autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

        " Synchronous build (blocks Vim)
        autocmd FileType cs nnoremap <F6> :OmniSharpBuild<CR>
        " Builds can also run asynchronously with vim-dispatch installed
        autocmd FileType cs nnoremap <leader>b :wa!<CR>:OmniSharpBuildAsync<CR>
        " automatic syntax check on events (TextChanged requires Vim 7.4)
        autocmd BufEnter,TextChanged,InsertLeave *.cs ALELint

        "show type information automatically when the cursor stops moving
        autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

        "The following commands are contextual, based on the current cursor position.

        autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<CR>
        autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<CR>
        autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<CR>
        autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<CR>
        autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<CR>
        "finds members in the current buffer
        autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<CR>
        " cursor can be anywhere on the line containing an issue
        autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<CR>
        autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<CR>
        autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<CR>
        autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<CR>
        "navigate up by method/property/field
        autocmd FileType cs nnoremap <leader>nu :OmniSharpNavigateUp<CR>
        "navigate down by method/property/field
        autocmd FileType cs nnoremap <leader>nd :OmniSharpNavigateDown<CR>

    augroup END

    augroup abbreviations
        autocmd!
        autocmd FileType TypeScript vnoremap <C-k><C-c> :s/^/\/\//<CR>
        autocmd FileType TypeScript vnoremap <C-k><C-u> :s/^\/\///<CR>
        autocmd FileType TypeScript iabbrev describe( describe(!cursor!', () => {<CR>});<Esc>gg=G:call search('!cursor!','b')<CR>cf!
        autocmd FileType TypeScript iabbrev it( it(!cursor!', () => {<CR>});<Esc>gg=G:call search('!cursor!','b')<CR>cf!
    augroup END

    augroup vimwiki
        autocmd!
        autocmd FileType vimwiki nnoremap <leader>h1 yypVr=
        autocmd FileType vimwiki nnoremap <leader>h2 yypVr-
    augroup END

    augroup templates
        autocmd!
        autocmd BufNewFile *.component.ts 0r C:\Users\c.henderson1\vimfiles\templates\skeleton.component.ts
        autocmd BufNewFile *.component.spec.ts 0r C:\Users\c.henderson1\vimfiles\templates\skeleton.component.spec.ts
        autocmd BufNewFile *.service.ts 0r C:\Users\c.henderson1\vimfiles\templates\skeleton.service.ts
        autocmd BufNewFile *.service.spec.ts 0r C:\Users\c.henderson1\vimfiles\templates\skeleton.service.spec.ts
    augroup END

    augroup vimstuff
        autocmd FileType vim vnoremap <C-k><C-c> :s/^/\"\"/<CR>
        autocmd FileType vim vnoremap <C-k><C-u> :s/^\"\"//<CR>
    augroup END
endif

packadd! matchit
nnoremap <leader>bn :bn<cr>
nnoremap <leader>bp :bp<cr>

fun! ScratchBuffer()
    new
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
    setlocal nobuflisted
endfun!

fun! GoToCode()
    let s:filePath = expand("%:p:h")
    let s:fileParts = split(expand("%:t"), '\.')
    let s:extension = expand("%:e")
    let s:extensionIndex = index(s:fileParts, s:extension)
    let s:found = 0
    if s:extension ==? "html"
        let s:found = 1
        let s:fileParts[s:extensionIndex] = "ts"
    elseif s:extension ==? "scss"
        let s:found = 1
        let s:fileParts[s:extensionIndex] = "ts"
    elseif s:extension ==? "ts"
        let s:found = 1
        let s:specIndex = index(s:fileParts, "spec")
        if s:specIndex >= 0
            let s:bis = s:specIndex - 1
            let s:newFileParts = s:fileParts[0 : s:bis]
            call add(s:newFileParts, s:fileParts[ s:extensionIndex ])
            let s:fileParts = s:newFileParts
        else
            let s:fileParts[s:extensionIndex] = "html"
        endif

    endif
    if s:found == 1
        let s:codeFile = join(s:fileParts, ".")
        let s:filePath = s:filePath . "\\" . s:codeFile
        execute "e ".fnameescape(s:filePath)
    endif
endfun!


fun! GoToSpec()
    let s:filePath = expand("%:p:h")
    let s:fileParts = split(expand("%:t"), '\.')
    let s:extension = expand("%:e")
    let s:extensionIndex = index(s:fileParts, s:extension)
    let s:found = 0
    if s:extension ==? "html"
        let s:found = 1
    elseif s:extension ==? "ts"
        let s:specIndex = index(s:fileParts, "spec")
        let s:found = s:specIndex == -1
    elseif s:extension ==? "scss"
        let s:found = 1
    endif
    if s:found == 1
        let s:fileParts[s:extensionIndex] = "spec.ts"
        let s:codeFile = join(s:fileParts, ".")
        let s:filePath = s:filePath . "\\" . s:codeFile
        execute "e ".fnameescape(s:filePath)
    endif
endfun!

fun! GoToStyleSheet()
    let s:filePath = expand("%:p:h")
    let s:fileParts = split(expand("%:t"), '\.')
    let s:extension = expand("%:e")
    let s:extensionIndex = index(s:fileParts, s:extension)
    let s:found = 0
    if s:extension ==? "html"
        let s:found = 1
    elseif s:extension ==? "ts"
        let s:found = 1
        let s:specIndex = index(s:fileParts, "spec")
        if s:specIndex >= 0
            let s:bis = s:specIndex - 1
            let s:newFileParts = s:fileParts[0 : s:bis]
            call add(s:newFileParts, s:fileParts[ s:extensionIndex ])
            let s:fileParts = s:newFileParts
            let s:extensionIndex = index(s:fileParts, s:extension)
        endif
    endif
    if s:found == 1
        let s:fileParts[s:extensionIndex] = "scss"
        let s:codeFile = join(s:fileParts, ".")
        let s:filePath = s:filePath . "\\" . s:codeFile
        execute "e ".fnameescape(s:filePath)
    endif
endfun!

nnoremap <F7> :call GoToCode()<CR>
nnoremap <s-F7> :call GoToSpec()<CR>
nnoremap <c-F7> :call GoToStyleSheet()<CR>
nnoremap <leader>sb :call ScratchBuffer()<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>wa :wa<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>waq :waq<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>qa :qa<CR>
nnoremap <leader>= :wincmd =<CR>
nnoremap <leader>default :source ~/sessions/default<CR>
nnoremap <F8> :vertical wincmd f<CR>
nnoremap <F3> :TagbarToggle<CR>
nnoremap <leader>nav :set makeprg=~/Documents/BatchFiles/Commands/buildnav.cmd<CR>
nnoremap <leader>coms :set makeprg=~/Documents/BatchFiles/Commands/buildcoms.cmd<CR>
nnoremap <leader>build :set makeprg=~/Documents/BatchFiles/Commands/buildnpm.cmd<CR>
nnoremap <leader>watch :set makeprg=~/Documents/BatchFiles/Commands/buildnpmwatch.cmd<CR>


" TypeScript CTags
let g:tagbar_type_typescript = {                                                  
            \ 'ctagsbin' : 'tstags',                                                        
            \ 'ctagsargs' : '-f-',                                                           
            \ 'kinds': [                                                                     
            \ 'e:enums:0:1',                                                               
            \ 'f:function:0:1',                                                            
            \ 't:typealias:0:1',                                                           
            \ 'M:Module:0:1',                                                              
            \ 'I:import:0:1',                                                              
            \ 'i:interface:0:1',                                                           
            \ 'C:class:0:1',                                                               
            \ 'm:method:0:1',                                                              
            \ 'p:property:0:1',                                                            
            \ 'v:variable:0:1',                                                            
            \ 'c:const:0:1',                                                              
            \ ],                                                                            
            \ 'sort' : 0                                                                    
            \ } 

" PowerShell CTags
let g:tagbar_type_ps1 = {
            \ 'ctagstype' : 'powershell',
            \ 'kinds'     : [
            \ 'f:function',
            \ 'i:filter',
            \ 'a:alias'
            \ ]
            \ }

" CSS CTags
let g:tagbar_type_css = {
            \ 'ctagstype' : 'Css',
            \ 'kinds'     : [
            \ 'c:classes',
            \ 's:selectors',
            \ 'i:identities'
            \ ]
            \ }

" SCSS CTags
let g:tagbar_type_scss = {
            \ 'ctagstype' : 'Scss',
            \ 'kinds'     : [
            \ 'c:classes',
            \ 's:selectors',
            \ 'i:identities'
            \ ]
            \ }

let g:DirDiffForceLang = "C"

let g:OmniSharp_start_server = 0
let g:OmniSharp_server_type  = 'roslyn'
let g:OmniSharp_prefer_global_sln = 1
let g:OmniSharp_timeout = 10

let g:calendar_google_calendar = 1
let g:calendar_google_task = 1
