-- Shortcut to open this file
vim.keymap.set('n', '<Leader>v', ':e ~/.config/nvim/init.lua<CR>', { silent = false })

-- Don't give the intro message when starting
vim.opt.shortmess:append({ I = true })

-- use line numbers
vim.o.number = true

-- Disable word wrap
vim.wo.wrap = false

-- This makes typing Esc take effect more quickly.  Normally Vim waits a second
-- to see if the Esc is the start of an escape sequence.  If you have a very slow
-- remote connection, increase the number.  See 'ttimeout'.
vim.o.ttimeoutlen = 100

-- Do not highlight all search hits
vim.o.hlsearch = false

-- Enable mouse support in normal and visual modes.
vim.o.mouse = "nv"

-- Use system clipboard by default
vim.o.clipboard = "unnamed"

-- TODO: what do these do?
vim.o.ts = 4
vim.o.sw = 4

-- Disable automatically adding comments to the next line
vim.api.nvim_create_autocmd('FileType', {
	pattern = '*',
	callback = function()
		vim.opt.formatoptions:remove({'c', 'r', 'o'})

		-- Disable swapfiles
		vim.bo.swapfile = false

		-- Insert 4 spaces instead of a tab char when pressing the tab key in insert
		-- modes
		vim.bo.expandtab = true
	end
})

-- Allow recursive find
vim.opt.path:append('**')

-- No large banner at the top of netwr
vim.g.netrw_banner = 0

-- highlight embedded lua
vim.g.vimsyn_embed = 'l'

-- Plugins
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

-- gruvbox theme
Plug('morhetz/gruvbox')

-- Deletes trailing whitespace on buffer write
Plug('ntpeters/vim-better-whitespace')

vim.g.better_whitespace_enabled = 0
vim.g.strip_whitespace_on_save = 1
vim.g.strip_whitespace_confirm = 0

-- Allows changing the surrounding chars of a string with cs
Plug('tpope/vim-surround')

-- Allows for easy commenting out of lines and motions
Plug('tpope/vim-commentary')

-- Allows . command to repeat plugin actions
Plug('tpope/vim-repeat')

-- Git integration
Plug('tpope/vim-fugitive')

-- Open diffs in vertical splits by default
vim.opt.diffopt:append({ internal = false })
vim.opt.diffopt:remove({ 'vertical' })

-- treesitter configs and abstraction layer
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

-- Needed for telescope
Plug('nvim-lua/plenary.nvim')

-- Fuzzy finder
Plug('nvim-telescope/telescope.nvim')

-- open telescope file finder on cmd-P
vim.keymap.set('n', '<C-p>', '<cmd>Telescope git_files<cr>', { noremap = true })

-- Grep within working dir or repo
Plug('mhinz/vim-grepper')

-- use rg and git grep
vim.g.grepper = {
    tools = {'rg', 'git'}
}
-- Use gs to take any motion and populate the search prompt
vim.keymap.set({'n', 'x'}, 'gs', '<plug>(GrepperOperator)')
-- Shortcut to open :Grepper
vim.keymap.set('n', '<Leader>gg', ':Grepper<CR>', { silent = true })

-- JS Doc
Plug('heavenshell/vim-jsdoc', {
  ['for'] = {'javascript', 'javascriptreact', 'typescript', 'typescriptreact'},
  ['do'] = 'make install'
})

-- Quickstart configs for Nvim LSP
Plug('williamboman/nvim-lsp-installer')
Plug('neovim/nvim-lspconfig')

-- Allow neovim to act as a language server for non-LSP based utils
Plug('jose-elias-alvarez/null-ls.nvim')

-- for autoformat
Plug('sbdchd/neoformat')
vim.g.neoformat_try_node_exe = 1

-- register prettier shortcut and autosave for js/ts files
vim.api.nvim_create_autocmd('FileType', {
    pattern = { "ts", "javascript", "javascriptreact", "typescript", "typescriptreact" },
    callback = function()
        -- keymap for prettier
        vim.keymap.set('n', '<Leader>f', function()
            vim.cmd("Neoformat prettierd")
        end
        , { silent = true })
        -- register autocommand to format on save
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("Autoformat", { clear = true }),
            callback = function()
                vim.cmd("Neoformat prettierd")
            end
        })
    end
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = "elm",
    callback = function()
        -- keymap for prettier
        vim.keymap.set('n', '<Leader>f', vim.cmd("Neoformat elmformat"), { silent = true })
        -- register autocommand to format on save
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("Autoformat", { clear = true }),
            callback = function()
                vim.cmd("Neoformat elmformat")
            end
        })
    end
})
-- coffeescript support
Plug('kchmck/vim-coffee-script')

-- elixir support
Plug('elixir-editors/vim-elixir')

vim.call('plug#end')

vim.cmd('colorscheme gruvbox')

-- Shortcut to open workingMemory.txt
vim.keymap.set('n', '<Leader>wm', ':e ~/workingMemory.txt<CR>', { silent = false })

-- Try to prevent bad habits like using the arrow keys for movement. This is
-- not the only possible bad habit. For example, holding down the h/j/k/l keys
-- for movement, rather than using more efficient movement commands, is also a
-- bad habit. The former is enforceable through a .vimrc, while we don't know
-- how to prevent the latter.
vim.keymap.set('n', '<Left>',  ':echoe "Use h"<CR>')
vim.keymap.set('n', '<Right>', ':echoe "Use l"<CR>')
vim.keymap.set('n', '<Up>',    ':echoe "Use k"<CR>')
vim.keymap.set('n', '<Down>',  ':echoe "Use j"<CR>')

-- Shortcuts to navigate the buffer list
vim.keymap.set('n', ']b', ':bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '[b', ':bprev<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '[a', ':e #<CR>', { noremap = true, silent = true })

-- Shortcuts for navigating quickfix list
vim.keymap.set('n', ']q', ':cnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '[q', ':cprev<CR>', { noremap = true, silent = true })

-- Close all buffers
vim.keymap.set('n', '<Leader>bd', ':%bd<CR>', { silent = true, noremap = true })

-- Git conflict marker shortcuts
vim.keymap.set('n', '<Leader><', '/<<<<<<<<CR>', { silent = true })
vim.keymap.set('n', '<Leader>>', '/>>>>>>><CR>', { silent = true })
vim.keymap.set('n', '<Leader>=', '/=======<CR>', { silent = true })

-- 'Q' in normal mode enters Ex mode. You almost never want this.
vim.keymap.set('n', 'Q', '<Nop>')

-- from https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- Multipurpose tab key
function InsertTab()
	if (has_words_before()) then
		-- There's an identifier before the cursor, so complete the identifier.
		return "<c-p>"
    end

    return "<tab>"
end

vim.keymap.set('i', '<tab>', InsertTab, { expr = true })
vim.keymap.set('i', '<s-tab>', '<c-n>', { noremap = true })

-- Allows %% in command mode to fill in the directory of the buffer
vim.keymap.set('c', '%%', "getcmdtype() == ':' ? expand('%:h').'/' : '%%'", { expr = true, noremap = true })

-- Remove neovim mapping of Y to y$
vim.keymap.del('n', 'Y')

-- from nvim-lspconfig
local nvim_lsp = require('lspconfig')


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap=true, silent=true }
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set('n', '<Leader>d', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[w', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']w', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<Leader>q', vim.diagnostic.setqflist, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<Leader>r', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    -- always show a sign column of width 1
    vim.wo.signcolumn = "yes:1"

    -- -- format on save if available
    -- if client.server_capabilities.documentFormattingProvider then
    --     vim.cmd [[augroup Format]]
    --     vim.cmd [[autocmd! * <buffer>]]
    --     vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
    --     vim.cmd [[augroup END]]
    -- end
end

-- register lsp auto installer
require("nvim-lsp-installer").setup {}

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'tsserver', 'elmls', 'eslint', 'elixirls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

vim.diagnostic.config({
  virtual_text = false,
  underline = { severity = vim.diagnostic.severity.ERROR },
  update_in_insert = false,
  signs = true,
})

-- always show
local signs = { Error = ">", Warn = "W", Hint = "H", Info = "I" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- local null_ls = require('null-ls')
-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- local lsp_formatting = function(bufnr)
--     vim.lsp.buf.formatting({
--         filter = function(client)
--             -- apply whatever logic you want (in this example, we'll only use null-ls)
--             return client.name == "null-ls"
--         end,
--         bufnr = bufnr,
--     })
-- end

-- null_ls.setup({
--     on_attach = function(client, bufnr)
--         if client.server_capabilities.documentFormattingProvider then
--             vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
--             vim.api.nvim_create_autocmd("BufWritePre", {
--                 group = augroup,
--                 buffer = bufnr,
--                 callback = lsp_formatting
--             })
--         end
--     end,
--     sources = {
--         null_ls.builtins.formatting.prettierd
--     },
-- })
