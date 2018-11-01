" Nils vimrc

" Remap leader
let mapleader=" "

" Plugins
source ~/.vimrc.bundle

" Theme
if has('gui_running') || has('gui_vimr')
  colorscheme NeoSolarized
  set background=dark
else
  colorscheme wal
endif

" Syntax
if &t_Co >= 2 || has('gui_running')
  syntax on
endif

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
    "syn region highlight_block start='```' end='```'

    "" Actually highlight those regions.
    hi link math Statement
    hi link liquid Statement
    hi link highlight_block Function
    hi link math_block Function

    map <leader>\ :! pandoc % -o $(echo % \| cut -d "." -f 1).pdf<cr>
endfunction

" Call everytime we open a Markdown file
autocmd BufRead,BufNewFile,BufEnter *.md,*.markdown call MathAndLiquid()

set number
set backup
set backupdir=~/.vim/backup
set swapfile
set directory=~/.vim/swap
set undofile
set undodir=~/.vim/undo
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

augroup vimrcEx
  au!
  au BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line ("'\"") <= line("$") |
        \ exe "normal g`\"" |
        \ endif
  au BufRead,BufNewFile Appraisals set filetype=ruby
  au BufRead,BufNewFile *.md set filetype=markdown
  au BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
augroup END

" Encoding
set encoding=utf8
set fileencoding=utf8

" Font
"set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete:h12

" Two column wide softtabs
" No copyindent, let syntax file handle that
set tabstop=2 shiftwidth=2 expandtab shiftround

" Linebreaking
set wrap linebreak nolist
set showbreak=↪\ 

" Display extra whitespace
"set list listchars=tab:»·,trail:·,nbsp:·
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨

" Make it obvious where 80 characters is
set textwidth=80
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
set wildmode=list:longest,list:full
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Use The Silver Searcher
" https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif

" C/C++ indent options
set cindent
set cinoptions=g-1

" Get off my lawn
nnoremap <Left> :echoe "Use h"<cr>
nnoremap <Right> :echoe "Use l"<cr>
nnoremap <Up> :echoe "Use k"<cr>
nnoremap <Down> :echoe "Use j"<cr>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Quicker saving and quitting
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>

" Turn off highlighting
nnoremap <leader>l :nohlsearch<cr>

" Run commands that require an interactive shell
nnoremap <leader>r :RunInInteractiveShell<space>
