call plug#begin()
Plug 'tpope/vim-commentary'      " easier comments with gcc
Plug 'vim-airline/vim-airline'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-surround'
Plug 'junegunn/seoul256.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'skbolton/embark'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'tomasiser/vim-code-dark'
" Plug 'sheerun/vim-polyglot'
" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
call plug#end()

" colorscheme embark
" colo seoul256         " Unified color scheme (default: dark)
" set background=dark
" let g:seoul256_background = 234
syntax on
set t_Co=256
" colorscheme onehalfdark
colorscheme gruvbox
let g:airline_theme='onehalfdark'
" lightline
" let g:lightline.colorscheme='onehalfdark'
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
highlight LineNr guifg=#050505

" Exiting normal mode with jj
inoremap jj <Esc>
" Unhighlighting searched text
nnoremap <silent> <C-n> :nohl<CR><C-n>
" Moving accross windows with ctrl-j ctrl-k
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" auto closing of brackets, tildes..
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" adds new line from normal mode
nnoremap ss i<space><esc>

" Ctrl p and Ctrl-n beahave as up and down in ex mode
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
"""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""  REGULAR CONFIGS 
"""""""""""""""""""""""""""""""""""""""""""""""""
set clipboard=unnamed " Systems clipboard to work with vim buffer
set tabstop=4         " show existing tab with 4 spaces width
set shiftwidth=4      " when indenting with '>', use 4 spaces width
set expandtab         " On pressing tab, insert 4 spaces
set hlsearch          " highlight searches
set number            " enable line numbering
let mapleader=" "     " Mapping space to be leader key
set backspace=indent,eol,start " patch to make the backpasce work again
" set listchars=tab:\|\ ,trail:·,nbsp:_ "Display dots for normal spaces
" set list
set cursorline        " cursor line and colum
" set colorcolumn=90

" FZF.VIM CUSTOMIZATION
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" Mappings  ----------------------------------{{{
" fuzzy find files in the working directory (where you launched Vim from)
nmap <leader>f :Files<cr>
" fuzzy find lines in the current file
nmap <leader>/ :BLines<cr>
" fuzzy find an open buffer
nmap <leader>b :Buffers<cr>
nmap <leader>r :Rg 
" fuzzy find Vim commands (like Ctrl-Shift-P in Sublime/Atom/VSC)
nmap <leader>c :Commands<cr>
" Removew preview window
set completeopt=menu


" COC onfiguration
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
" vim.cmd('packadd nvim-lsp')
" require 'nvim_lsp'.pyls_ms.setup{}
" lua << EOF
"     local nvim_lsp = require 'nvim_lsp'
"     nvim_lsp.pyls_ms.setup{}
" EOF
