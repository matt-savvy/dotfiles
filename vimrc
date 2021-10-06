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


" Disable automatically adding comments to the next line
autocmd FileType * set formatoptions-=c formatoptions-=r formatoptions-=o
" Allow recursive find
set path+=**

" Allows %% in command mode to fill in the directory of the buffer
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Enable searching as you type, rather than waiting till you press enter.
set incsearch
" Do not highlight all search hits
set nohlsearch
"This unsets the "last search pattern" register by hitting return
nnoremap <silent><CR> :noh<CR><CR>

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a

" Automatically reload files
set autoread

" No large banner at the top of netwr
let g:netrw_banner=0
" Adds command DiffOrig to compare changes in buffer
" command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
      "\ | wincmd p | diffthis
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
Plug 'morhetz/gruvbox'

" Deletes trailing whitespace on buffer write
Plug 'ntpeters/vim-better-whitespace'
let g:better_whitespace_enabled=0
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

" Allows changing the surrounding chars of a string with cs
Plug 'tpope/vim-surround'

" Allows for easy commenting out of lines and motions
Plug 'tpope/vim-commentary'

" Shortcuts for navigating quickfix list
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [q :cprev<CR>

" Shortcuts to navigate the buffer list
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [b :bprev<CR>
" Fuzzy file finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git integration
Plug 'tpope/vim-fugitive'
" Open diffs in vertical splits by default
set diffopt+=vertical
" Remap GFiles to ctrl P
nnoremap <C-p> :<C-u>:GFiles<CR>

" Grep within working dir or repo
Plug 'mhinz/vim-grepper'
let g:grepper = {}
let g:grepper.tools = ['rg', 'git', 'grep']
" Use gs to take any motion and populate the search prompt
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)

if has('nvim')
    " neovim settings
    Plug 'neovim/nvim-lspconfig' "default configs for LSP
    Plug 'prabirshrestha/vim-lsp' " needed for vim-lsp-settings below
    Plug 'mattn/vim-lsp-settings' " auto installs lsp servers as needed
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " provides interface for tree-sitter
    Plug 'nvim-lua/completion-nvim' " auto completion framework using the LSP
    Plug 'nvim-lua/plenary.nvim' " required for telescope
    Plug 'nvim-telescope/telescope.nvim' " fuzzy finder and more
    call plug#end()
lua << EOF
    -- set up telescope
    require("telescope").setup()

    local nvim_lsp = require('lspconfig')
    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        -- Enable completion triggered by <c-x><c-o>
        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        local opts = { noremap=true, silent=true }

        -- See `:help vim.lsp.*` for documentation on any of the below functions
        buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
        buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
        buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
        buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end
    -- Use a loop to conveniently call 'setup' on multiple servers and
    -- map buffer local keybindings when the language server attaches
    local servers = { 'tsserver' }
    for _, lsp in ipairs(servers) do
      nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        },
        handlers = {
            ["textDocument/publishDiagnostics"] = vim.lsp.with(
                vim.lsp.diagnostic.on_publish_diagnostics, {
                    -- Disable virtual_text
                    virtual_text = false
                    }
                ),
            }
        }
    end
EOF
else
    " vim settings that we don't want to use for neovim
    Plug 'pangloss/vim-javascript'
    Plug 'leafgarland/typescript-vim'
    Plug 'kchmck/vim-coffee-script'
    Plug 'maxmellon/vim-jsx-pretty'
    " Plug 'mxw/vim-jsx'

    " Asynchronous Lint Engine - linting and type checks
    Plug 'dense-analysis/ale'
    " ALE options
    let g:ale_linters = {'javascript': ['eslint'], 'typescript': ['tsserver', 'eslint'], 'typescript.tsx': ['tsserver', 'eslint']}
    let g:ale_fixers = {'javascript': ['eslint'], 'typescript': ['prettier'], 'typescript.tsx': ['prettier']}
    let g:ale_open_list = 0
    let g:ale_lint_on_text_changed = 'normal'
    let g:ale_lint_on_insert_leave = 1
    let g:ale_lint_delay = 0
    let g:ale_set_quickfix = 0
    let g:ale_set_loclist = 1
    let g:ale_hover_cursor = 1
    let g:ale_floating_preview = 1
    let g:ale_set_balloons = 1
    let g:ale_floating_window_border = []
    let g:ale_sign_column_always = 1
    let g:ale_cursor_detail = 0
    let g:ale_hover_to_floating_preview = 1
    let g:ale_detail_to_floating_preview = 1
    " Mappings from Modern Vim to move through warnings/errors
    nmap <silent> [W <Plug>(ale_first)
    nmap <silent> [w <Plug>(ale_previous)
    nmap <silent> ]w <Plug>(ale_next)
    nmap <silent> ]W <Plug>(ale_last)
    " Mappings for other ALE commands
    nmap gd <Plug>(ale_go_to_definition)
    nmap gr <Plug>(ale_find_references)

    call plug#end()
endif
colorscheme onedark
colorscheme gruvbox
set background=dark
