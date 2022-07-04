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

-- Insert 4 spaces instead of a tab char when pressing the tab key in insert
-- modes
vim.bo.expandtab = true

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
	end
})

-- Allow recursive find
vim.opt.path:append('**')

-- Disable swapfiles
vim.bo.swapfile = false

-- No large banner at the top of netwr
vim.g.netrw_banner = 0

-- highlight embedded lua
vim.g.vimsyn_embed = 'l'


-- Plugins
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')
-- plug#begin has the effect of
-- filetype plugin indent on

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
Plug('nvim-treesitter/nvim-treesitter')
-- Needed for telescope
Plug('nvim-lua/plenary.nvim')
-- Fuzzy finder
Plug('nvim-telescope/telescope.nvim')
-- open telescope file finder on cmd-P
vim.keymap.set('n', '<C-p>', '<cmd>Telescope git_files<cr>', { noremap = true })

-- Grep within working dir or repo
Plug('mhinz/vim-grepper')
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

vim.call('plug#end')

vim.cmd('colorscheme gruvbox')

-- Shortcut to open this file
vim.keymap.set('n', '<Leader>v', ':e ~/.config/nvim/init.lua<CR>', { silent = false })

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

-- Git conflict marker shortcuts
vim.keymap.set('n', '<Leader><', '/<<<<<<<<CR>', { silent = true })
vim.keymap.set('n', '<Leader>>', '/>>>>>>><CR>', { silent = true })
vim.keymap.set('n', '<Leader>=', '/=======<CR>', { silent = true })

-- 'Q' in normal mode enters Ex mode. You almost never want this.
vim.keymap.set('n', 'Q', '<Nop>')

-- Multipurpose tab key
function InsertTabWrapper()
    vim.cmd [[
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
    ]]
end

-- vim.keymap.set('i', '<tab>', sanity, { expr = true })
-- inoremap <expr> <tab> InsertTabWrapper()

-- Remove neovim mapping of Y to y$
-- vim.keymap.del('n', 'Y')

