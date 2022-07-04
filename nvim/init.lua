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

-- Disable swapfiles
vim.bo.swapfile = false

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

-- Remove neovim mapping of Y to y$
vim.keymap.del('n', 'Y')
