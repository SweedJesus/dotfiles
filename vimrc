" Nils vimrc

" Remap leader
let mapleader=" "

" Plugins
set nocompatible
filetype off
if filereadable(expand("~/.vimrc.bundle"))
  source ~/.vimrc.bundle
endif
filetype plugin indent on

set backup
set backupdir=~/.vim/backup
set swapfile
set directory=~/.vim/swap
set undofile
set undodir=~/.vim/undo
set backspace=2
set ruler
set showcmd
set incsearch
set laststatus=2
set autowrite
set mouse=a
"set number
set foldmethod=syntax
autocmd Syntax * normal zR

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

" Softtabs, 2 spaces wide
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

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

" Syntastic
set laststatus=2
let g:syntastic_mode_map={
      \ "mode" : "passive" }
let g:syntastic_always_populate_loc_list=1
let g:syntastic_cpp_compiler="g++"
let g:syntastic_cpp_compiler_options="-std=c++11"
let g:syntastic_cpp_check_header=1
map <leader>e :SyntasticCheck<cr>

" NERDTree
nnoremap <leader>n :NERDTreeToggle<cr>

" NERDCommenter
map <C-i> <PLUG>NERDCommenterInvert k<cr>

" Tagbar
map <leader>t :TagbarToggle<cr>

" Mundo
map <leader>u :MundoToggle<cr>

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

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  if !exists("syntax_on")
    syntax on
  endif
  "set t_ut=
  set t_Co=256
  "color jellybeans
  set background=dark
  "let g:solarized_termcolors=256
  colors solarized
endif
