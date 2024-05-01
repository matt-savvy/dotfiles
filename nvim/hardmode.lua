-- Shortcut to open this file
vim.keymap.set('n', '<Leader>v', ':e ~/dev/dotfiles/nvim/hardmode.lua<CR>', { silent = true })

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
vim.o.clipboard = "unnamedplus"

-- Autoindent (>>, <<) will use tabstop value
vim.o.shiftwidth = 0

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

        -- Tab counts for 4 spaces
        vim.bo.tabstop = 4
	end
})

-- Allow recursive find
vim.opt.path:append('**')

-- No large banner at the top of netwr
vim.g.netrw_banner = 0

-- highlight embedded lua
vim.g.vimsyn_embed = 'l'

-- Plugins

-- vim-better-whitespace'
vim.g.better_whitespace_enabled = 0
vim.g.strip_whitespace_on_save = 1
vim.g.strip_whitespace_confirm = 0

-- Open diffs in vertical splits by default
vim.opt.diffopt:append({ internal = false })
vim.opt.diffopt:remove({ 'vertical' })


-- telescope
local telescope = require('telescope')
telescope.setup({
    pickers = {
        colorscheme = {
            enable_preview = true
        }
    }
})
telescope.load_extension('fzy_native')
local telescopeBuiltins = require('telescope.builtin')

-- open telescope file finder on cmd-P
vim.keymap.set('n', '<C-p>', telescopeBuiltins.find_files, { noremap = true })
-- open live grepper
vim.keymap.set('n', '<Leader>lg', '<cmd>Telescope live_grep<cr>', { noremap = true })

-- vim-grepper
-- use rg and git grep
vim.g.grepper = {
    tools = {'rg'}
}

-- Use gs to take any motion and populate the search prompt
vim.keymap.set({'n', 'x'}, 'gs', '<plug>(GrepperOperator)')

-- Shortcut to open :Grepper
vim.keymap.set('n', '<Leader>gg', ':Grepper<CR>', { silent = true })

-- keymaps to yank file name
vim.keymap.set('n', '<Leader>ff', ':let @+ = expand("%")<cr>', { silent = true })
vim.keymap.set('n', '<Leader>f', ':let @+ = expand("%:t")<cr>', { silent = true })

-- temporary fix for https://github.com/elixir-editors/vim-elixir/issues/562
vim.cmd("au BufRead,BufNewFile *.eex,*.heex,*.leex,*.sface,*.lexs set filetype=eelixir")

vim.cmd('colorscheme terafox')
vim.cmd('syntax off')

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
vim.keymap.set('n', '<Leader>bd', ':%bd|e#<CR>', { silent = true, noremap = true })

-- Git conflict marker shortcuts
vim.keymap.set('n', '<Leader><', '/<<<<<<<<CR>', { silent = true })
vim.keymap.set('n', '<Leader>>', '/>>>>>>><CR>', { silent = true })
vim.keymap.set('n', '<Leader>=', '/=======<CR>', { silent = true })

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
