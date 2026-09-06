" ============================================================
"                    Misha's Neovim Config
" ============================================================

" -------------------- General Settings ---------------------

set mouse=a
set number
set relativenumber
set cursorline

set autoindent
set smartindent
set smarttab

set tabstop=4
set shiftwidth=4
set expandtab

set splitbelow
set splitright

set completeopt-=preview
set shortmess+=c

set termguicolors
set background=dark
set nowrap

set ignorecase
set smartcase
set incsearch
set hlsearch

set signcolumn=yes
set updatetime=300

set guifont=FiraCode\ Nerd\ Font:h12

" Arch WSL = Bash
set shell=bash

" Leader = Space
let mapleader = "\<Space>"


" ============================================================
"                         PLUGINS
" ============================================================

call plug#begin("~/.config/nvim/plugged")

" -------------------- Themes & UI ----------------------------

Plug 'Mofiqul/dracula.nvim'
Plug 'morhetz/gruvbox'
Plug 'maxmx03/fluoromachine.nvim'
Plug 'vim-airline/vim-airline'
Plug 'ap/vim-css-color'
Plug 'ryanoasis/vim-devicons'
Plug 'navarasu/onedark.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'jaredgorski/spacecamp'
Plug 'lunarvim/synthwave84.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'

" -------------------- Tools ---------------------------------

Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'tc50cal/vim-terminal'
Plug 'jiangmiao/auto-pairs'

" -------------------- IntelliSense ---------------------------

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()


" ============================================================
"                    GENERAL KEYBINDINGS
" ============================================================

" Tagbar
nnoremap <C-u> :TagbarToggle<CR>

" NERDTree
nnoremap <C-t> :NERDTreeToggle<CR>

" Horizontal terminal/split
nnoremap <C-y> :botright split<CR>

" Save
nnoremap <C-s> :w<CR>

" Quit
nnoremap <C-q> :q<CR>

" Save + Quit
nnoremap <C-f> :wq<CR>

" Delete line
nnoremap <C-d> dd

" Undo
nnoremap <C-z> u


" ============================================================
"                    COC INTELLISENSE
" ============================================================

" ------------------------------------------------------------
" TAB = ACCEPT COMPLETION
" ------------------------------------------------------------

inoremap <silent><expr> <Tab>
      \ coc#pum#visible()
      \ ? coc#pum#confirm()
      \ : "\<Tab>"


" ------------------------------------------------------------
" SHIFT + TAB = PREVIOUS COMPLETION
" ------------------------------------------------------------

inoremap <silent><expr> <S-Tab>
      \ coc#pum#visible()
      \ ? coc#pum#prev(1)
      \ : "\<C-h>"


" ------------------------------------------------------------
" ENTER = NORMAL ENTER
" ------------------------------------------------------------

inoremap <silent><expr> <CR> "\<CR>"


" ------------------------------------------------------------
" CTRL + SPACE = MANUALLY TRIGGER COMPLETION
" ------------------------------------------------------------

inoremap <silent><expr> <C-Space> coc#refresh()


" ------------------------------------------------------------
" BACKSPACE CHECK
" ------------------------------------------------------------

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction


" ============================================================
"                    COC KEYBINDINGS
" ============================================================

" Code Action
nmap <leader>ca <Plug>(coc-codeaction-cursor)

" Go to Definition
nmap <silent> gd <Plug>(coc-definition)

" Rename Symbol
nmap <leader>rn <Plug>(coc-rename)

" Documentation
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction


" ============================================================
"                         THEME
" ============================================================

colorscheme synthwave84

highlight Normal guibg=black


" ============================================================
"                       TERMINAL
" ============================================================

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


" Toggle terminal
nnoremap <C-r> :call ToggleTerminal()<CR>

" Toggle terminal from terminal mode
tnoremap <C-r> <C-\><C-n>:call ToggleTerminal()<CR>

" Automatically enter insert mode in terminal
autocmd BufEnter term://* startinsert


" ============================================================
"                         PYTHON
" ============================================================

augroup exe_code

    autocmd!

    autocmd FileType python nnoremap <buffer> <localleader>r
          \ :sp<CR>
          \ :term python3 %<CR>
          \ :startinsert<CR>

augroup END


" ============================================================
"                      PERSISTENT UNDO
" ============================================================

set undofile


" ============================================================
"                   REMEMBER CURSOR POSITION
" ============================================================

autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   execute "normal! g`\"" |
      \ endif


" ============================================================
"                         END CONFIG
" ============================================================
