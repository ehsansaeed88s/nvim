set mouse=a
set number
set completeopt-=preview
set autoindent
set smarttab
set splitbelow splitright
set tabstop=4
set shiftwidth=4
set expandtab
set shortmess+=c
set shell=powershell
set guifont=FiraCode\ Nerd\ Font:h12

" Set leader key to Space
let mapleader = "\<Space>"

call plug#begin("~/.config/nvim/plugged")

" --- Themes & UI ---
Plug 'https://github.com/Mofiqul/dracula.nvim'
Plug 'https://github.com/morhetz/gruvbox'
Plug 'https://github.com/maxmx03/fluoromachine.nvim'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/ap/vim-css-color'
Plug 'https://github.com/ryanoasis/vim-devicons'
Plug 'https://github.com/navarasu/onedark.nvim'
Plug 'https://github.com/folke/tokyonight.nvim'
Plug 'jaredgorski/spacecamp'
Plug 'lunarvim/synthwave84.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'https://github.com/romgrk/barbar.nvim'

" --- Tools ---
Plug 'https://github.com/preservim/nerdtree'
Plug 'https://github.com/preservim/tagbar'
Plug 'https://github.com/tc50cal/vim-terminal'
Plug 'https://github.com/jiangmiao/auto-pairs'
Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" --- General Key Bindings ---
nnoremap <C-u> :TagbarToggle<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-y> :botright split<CR>
nnoremap <C-s> :w<CR>
nnoremap <C-q> :q<CR>
nnoremap <C-f> :wq<CR>
nnoremap <C-d> dd<CR>
nnoremap <C-z> u<CR>

" --- Coc.nvim Autocompletion ---
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" --- UI Settings ---
set termguicolors
colorscheme synthwave84
highlight Normal guibg=black

" --- Terminal Toggle Function ---
let g:toggle_term_buf = -1

function! ToggleTerminal()
  if bufexists(g:toggle_term_buf)
    let l:term_win = bufwinnr(g:toggle_term_buf)
    if l:term_win != -1
      execute l:term_win . 'wincmd q'
    else
      execute 'rightbelow 15split'
      execute 'buffer ' . g:toggle_term_buf
      startinsert
    endif
  else
    execute 'rightbelow 15split'
    term
    let g:toggle_term_buf = bufnr('%')
    startinsert
  endif
endfunction

nnoremap <C-r> :call ToggleTerminal()<CR>
tnoremap <C-r> <C-\><C-n>:call ToggleTerminal()<CR>
autocmd BufEnter term://* startinsert

set background=dark

" --- Python Settings ---
augroup exe_code
    autocmd!
    autocmd FileType python nnoremap  <buffer> <localleader> r
                           \ :sp<CR> :term python3 %<CR> :startinsert<CR>
augroup END

" --- Coc.nvim Intellisense Keymaps (General) ---

" 'Code Action' (Wrap, Extract, etc.)
nmap <leader>ca  <Plug>(coc-codeaction-cursor)

" Show Documentation on Hover (Shift+K)
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Jump to Definition
nmap <silent> gd <Plug>(coc-definition)

" Rename Symbol
nmap <leader>rn <Plug>(coc-rename)
