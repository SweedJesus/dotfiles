" Nils vimrc

set nocompatible
"filetype off
" Remap leader
let mapleader=" "

" Plugins
source ~/.vimrc.bundle
"source ~/.vimrc.private

" Syntax
if &t_Co >= 2 || has('gui_running')
  syntax on
endif

" Theme
"if has('gui_running') || has('gui_vimr') || $ITERM_PROFILE == "Asciinema"
"colorscheme solarized
"set background=dark
"else
"colorscheme wal
colorscheme nord
"colorscheme one
"set background=light
"set background=dark
hi Normal ctermbg=NONE

" Fix conceal style
"hi Conceal ctermbg=None
"hi Conceal guibg=None
"endif
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[3 q"
let &t_EI = "\<Esc>[2 q"

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

function! Lua()
    set foldmethod=indent
endfunction
autocmd BufRead,BufNewFile,BufEnter *.lua call Lua()

function! LaTeX()
    set textwidth=80
    " Compile/display shortcut
    "map <leader>\ :! lualatex -shell-escape %<cr>
    map <leader>\ :! arara % -v<cr>
    map <leader><c-\> :! open $(echo % \| cut -d "." -f 1).pdf<cr>
    " Custom concealments
    source ~/.vimrc.custom
    map <leader>c :call ToggleConcealLevel()<cr>
    function! ToggleConcealLevel()
        if &conceallevel
            set conceallevel=0
        else
            set conceallevel=2
        endif
    endfunction
endfunction
autocmd BufRead,BufNewFile,BufEnter *.tex call LaTeX()

function! Lilypond()
    map <leader>\ :! lilypond %<cr>
    map <leader><c-\> :! open $(echo % \| cut -d "." -f 1).pdf<cr>
endfunction
autocmd BufRead,BufNewFile,BufEnter *.ly call Lilypond()

function! MathAndLiquid()
    "" Define certain regions
    " Block math. Look for "$$[anything]$$"
    syn region math start=/\$\$/ end=/\$\$/
    " inline math. Look for "$[not $][anything]$"
    syn match math_block '\$[^$].\{-}\$'

    " Liquid single line. Look for "{%[anything]%}"
    syn match liquid '{%.*%}'
    " Liquid multiline. Look for "{%[anything]%}[anything]{%[anything]%}"
    syn region highlight_block start='{% highlight .*%}' end='{%.*%}'
    " Fenced code blocks, used in GitHub Flavored Markdown (GFM)
    syn region highlight_block start='```' end='```'

    "" Actually highlight those regions.
    hi link math Statement
    hi link liquid Statement
    hi link highlight_block Function
    hi link math_block Function

    map <leader>\ :! pandoc --pdf-engine=lualatex % -o $(echo % \| cut -d "." -f 1).pdf<cr>
    map <leader><c-\> :! open $(echo % \| cut -d "." -f 1).pdf<cr>
    "map <leader>\ :! pandoc --pdf-engine=lualatex % -o $(echo % \| cut -d "." -f 1).html<cr>
    "map <leader><c-\> :! open $(echo % \| cut -d "." -f 1).html<cr>
endfunction
autocmd BufRead,BufNewFile,BufEnter *.md,*.markdown call MathAndLiquid()

function! CAndCPP()
    " C/C++ indent options
    set cindent
    set cinoptions=g-1
endfunction
autocmd BufRead,BufNewFile,BufEnter *.c,*.cpp,*.h,*.hpp call CAndCPP()

function! MIPS()
    set ft=mips
    " Label reference
    syntax match mipsLabel /\w\+/ contained
    syntax match mipsLabelDef /\w\+:/ contains=mipsLabel nextgroup=mipsLabel
    hi def link mipsLabel MipsLabel
    hi MipsLabel ctermfg=127 cterm=bold
    " Stationeers misc instructions
    syntax keyword mipsInstruction alias define
    syntax keyword mipsInstruction sleep yield
    syntax keyword mipsInstruction hcf
    " Stationeers device instructions
    syntax keyword mipsInstruction bdns bdse
    syntax keyword mipsInstruction bdnsal bdseal
    syntax keyword mipsInstruction brdns brdse
    syntax keyword mipsInstruction breq breqz brgt brgtz brle brlt brne brnez
    syntax keyword mipsInstruction bnezal
    syntax keyword mipsInstruction l lr ls s
    " Stationeers constant-manipulating instructions
    syntax keyword mipsInstruction sdns sdse
    syntax keyword mipsInstruction seqz sgtz slez slez sltz snez
    syntax keyword mipsInstruction sap sapz sna snaz
    syntax keyword mipsInstruction select
    " Stationeers math instructions
    syntax keyword mipsInstruction cos acos sin asin tan atan
    syntax keyword mipsInstruction ceil floor
    syntax keyword mipsInstruction exp log sqrt
    syntax keyword mipsInstruction max min
    syntax keyword mipsInstruction mod trunc
    syntax keyword mipsInstruction rand
    " Stationeers stack instructions
    syntax keyword mipsInstruction peek pop push
    " Stationeers registers
    syntax match mipsRegister '\<[dr][dr]*\d\{1,\}\>'
    syntax keyword mipsRegister sp
    syntax keyword mipsRegister ra
    syntax keyword mipsRegister db
    " Stationeers device parameters
    syntax keyword mipsParameter Activate
    syntax keyword mipsParameter ClearMemory
    syntax keyword mipsParameter CompletionRatio
    syntax keyword mipsParameter Error
    syntax keyword mipsParameter ExportCount
    syntax keyword mipsParameter ImportCount
    syntax keyword mipsParameter Lock
    syntax keyword mipsParameter Mode
    syntax keyword mipsParameter OccupantHash
    syntax keyword mipsParameter On
    syntax keyword mipsParameter Open
    syntax keyword mipsParameter Power
    syntax keyword mipsParameter PrefabHash
    syntax keyword mipsParameter Pressure
    syntax keyword mipsParameter Quantity
    syntax keyword mipsParameter Reagents
    syntax keyword mipsParameter RecipeHash
    syntax keyword mipsParameter RequiredPower
    syntax keyword mipsParameter Setting
    syntax keyword mipsParameter Temperature
    hi def link mipsParameter Identifier
endfunction
autocmd BufRead,BufNewFile,BufEnter *.mips call MIPS()

set number
set backup
set backupdir=~/.vim/backup
set swapfile
set directory=~/.vim/swap
set undofile
set undodir=~/.vim/undo
set acd
set showcmd
set incsearch
set laststatus=2
set autowrite
set mouse=a
if !has("nvim")
    if has("mouse_sgr")
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif
set foldmethod=syntax
set foldlevelstart=20
set conceallevel=2

" Un-fuck the cursor
set guicursor=

"augroup vimrcEx
"au!
"au BufReadPost *
            "\ if &ft != 'gitcommit' && line("'\"") > 0 && line ("'\"") <= line("$") |
            "\ exe "normal g`\"" |
            "\ endif
"au BufRead,BufNewFile Appraisals set filetype=ruby
"au BufRead,BufNewFile *.md set filetype=markdown
"au BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
"augroup END

" Encoding
set encoding=utf8
set fileencoding=utf8

" Font
"set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete:h12

" Two column wide softtabs
" No copyindent, let syntax file handle that
set tabstop=4 shiftwidth=4 expandtab shiftround

" Linebreaking
set wrap linebreak nolist
"set showbreak=↪\

" Display extra whitespace
"set list listchars=tab:»·,trail:·,nbsp:·
"set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨

" Make it obvious where n characters is
set textwidth=100
set colorcolumn=+1

" Use one space, not two, after punctuation.
set nojoinspaces

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Source spellfile
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete using spellfile when spell is on
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
"set wildmode=list:longest,list:full
"function! InsertTabWrapper()
"let col = col('.') - 1
"if !col || getline('.')[col - 1] !~ '\k'
"return "\<tab>"
"else
"return "\<c-p>"
"endif
"endfunction
"inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
"inoremap <S-Tab> <c-n>

" Use The Silver Searcher
" https://github.com/ggreer/the_silver_searcher
"if executable('ag')
"" Use Ag over Grep
"set grepprg=ag\ --nogroup\ --nocolor

"" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
"let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'

"" ag is fast enough that CtrlP doesn't need to cache
"let g:ctrlp_use_caching = 0

"if !exists(":Ag")
"command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
"nnoremap \ :Ag<SPACE>
"endif
"endif

" Ascii art (using https://github.com/sepandhaghighi/art)
" (Unfinished attempt)
"function Test() range
"let cmd = 'python -m art text ' . getline('.')
"let result = substitute(system(cmd), '[\]\|[[:cntrl:]]', '', 'g')
"call setline(line('.'), getline('.') . ' ' . result)
"endfunction

" Get off my lawn
nnoremap <Left> :echoe "Use h noob"<cr>
nnoremap <Right> :echoe "Use l noob"<cr>
nnoremap <Up> :echoe "Use k noob"<cr>
nnoremap <Down> :echoe "Use j noob"<cr>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Normie copy
"vnoremap <C-c> "*y
"noremap <C-v> "*p

" Quicker saving and quitting
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>W :w!<cr>
nnoremap <leader>Q :q!<cr>

"Turn off highlighting
nnoremap <leader>l :nohlsearch<cr>:SyntasticReset<cr>

" Run commands that require an interactive shell
nnoremap <leader>r :RunInInteractiveShell<space>
