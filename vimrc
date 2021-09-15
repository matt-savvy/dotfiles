" Comments in Vimscript start with a `"`.

" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible

" Keep a history of 200 commands and searches
set history=200

" Turn on syntax highlighting.
syntax on

" Disable the default Vim startup message.
set shortmess+=I

" Show line numbers.
set number

" Disable automatically adding comments to the next line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Disable word wrap
set nowrap

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2
" Show line, col in bottom right
set ruler
" Show commands in the bottom corner
set showcmd
" Show completion matches in status line
set wildmenu
" This makes typing Esc take effect more quickly.  Normally Vim waits a second
" to see if the Esc is the start of an escape sequence.  If you have a very slow
" remote connection, increase the number.  See 'ttimeout'.
set ttimeout
set ttimeoutlen=100
" Do not recognize numbers starting with a zero as octal.  See 'nrformats'.
set nrformats-=octal

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" Insert 4 spaces instead of a tab char when pressing the tab key in insert
" modes
set expandtab
" Stolen from garybernhardt/dotfiles/.vimrc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col
        return "\<tab>"
    endif

    let char = getline('.')[col - 1]
    if char =~ '\k'
        " There's an identifier before the cursor, so complete the identifier.
        return "\<c-p>"
    else
        return "\<tab>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>
" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" 1. Filetype detection.
" 2. Using filetype plugin files
" 3. Using indent files
filetype plugin indent on

" Allow recursive find
set path+=**

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a

" Automatically reload files
set autoread

" Adds command DiffOrig to compare changes in buffer
command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
      \ | wincmd p | diffthis
" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>
set ts=4 sw=4

call plug#begin()
Plug 'joshdick/onedark.vim'

" Deletes trailing whitespace on buffer write
Plug 'ntpeters/vim-better-whitespace'
let g:better_whitespace_enabled=0
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

" Allows changing the surrounding chars of a string with cs
Plug 'tpope/vim-surround'

" Shortcuts for navigating quickfix list
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [q :cprev<CR>

" Fuzzy file finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Remap GFiles to ctrl P
nnoremap <C-p> :<C-u>:GFiles<CR>

" Grep within working dir or repo
Plug 'mhinz/vim-grepper'
let g:grepper = {}
let g:grepper.tools = ['rg', 'git', 'grep']

if has('nvim')
    " neovim settings
    Plug 'neovim/nvim-lspconfig' "default configs for LSP
    Plug 'prabirshrestha/vim-lsp' " needed for vim-lsp-settings below
    Plug 'mattn/vim-lsp-settings' " auto installs lsp server
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " provides interface for tree-sitter
    Plug 'nvim-lua/completion-nvim' " auto completion framework using the LSP
    call plug#end()

    " setup typescript language server
    :lua require('lspconfig').tsserver.setup{}
else
    " vim settings that we don't want to use for neovim
    Plug 'pangloss/vim-javascript'
    Plug 'leafgarland/typescript-vim'
    Plug 'kchmck/vim-coffee-script'
    " Plug 'maxmellon/vim-jsx-pretty'
    " Plug 'mxw/vim-jsx'

    " Asynchronous Lint Engine - needed for linting and type checks
    Plug 'dense-analysis/ale'

    let g:ale_linters = {'javascript': ['eslint'], 'typescript': ['tsserver', 'eslint'], 'typescript.tsx': ['tsserver', 'eslint']}
    let g:ale_fixers = {'javascript': ['eslint'], 'typescript': ['prettier'], 'typescript.tsx': ['prettier']}
    let g:ale_lint_on_text_changed = 'normal'
    let g:ale_lint_on_insert_leave = 1
    let g:ale_lint_delay = 0
    let g:ale_set_quickfix = 0
    let g:ale_set_loclist = 0
    call plug#end()
endif
colorscheme onedark
