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
vim.o.clipboard = "unnamedplus"

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

-- vim-better-whitespace'
vim.g.better_whitespace_enabled = 0
vim.g.strip_whitespace_on_save = 1
vim.g.strip_whitespace_confirm = 0

-- Open diffs in vertical splits by default
vim.opt.diffopt:append({ internal = false })
vim.opt.diffopt:remove({ 'vertical' })


-- telescope
local telescope = require('telescope')
telescope.load_extension('fzy_native')
-- open telescope file finder on cmd-P
vim.keymap.set('n', '<C-p>', '<cmd>Telescope git_files<cr>', { noremap = true })

-- vim-grepper
-- use rg and git grep
vim.g.grepper = {
    tools = {'rg', 'git'}
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

-- Mappings for harpoon
vim.keymap.set('n', '<Leader>a', ':lua require("harpoon.mark").add_file()<CR>', { silent = true })
vim.keymap.set('n', '<Leader>m', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', { silent = true })

vim.keymap.set('n', '\'q', ':lua require("harpoon.ui").nav_file(1)<CR>', { silent = true })
vim.keymap.set('n', '\'w', ':lua require("harpoon.ui").nav_file(2)<CR>', { silent = true })
vim.keymap.set('n', '\'e', ':lua require("harpoon.ui").nav_file(3)<CR>', { silent = true })
vim.keymap.set('n', '\'r', ':lua require("harpoon.ui").nav_file(4)<CR>', { silent = true })

vim.keymap.set('n', ']r', ':lua require("harpoon.ui").nav_next()<CR>', { silent = true })
vim.keymap.set('n', '[r', ':lua require("harpoon.ui").nav_prev()<CR>', { silent = true })

-- Close all buffers
vim.keymap.set('n', '<Leader>bd', ':%bd|e#<CR>', { silent = true, noremap = true })

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

require('mason').setup()
require("mason-lspconfig").setup({ automatic_installation = true })

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

    -- format on save if available
    if client.server_capabilities.documentFormattingProvider then
        vim.cmd [[augroup Format]]
        vim.cmd [[autocmd! * <buffer>]]
        vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
        vim.cmd [[augroup END]]
    end
    function restartLsp()
        vim.cmd('LspStop')
        vim.cmd('LspStart')
    end
    -- restart the LSP
    vim.keymap.set('n', '<Leader>ll', restartLsp, bufopts)
end

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

require'nvim-treesitter.configs'.setup {
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,
  highlight = {
    enable = true,
  },
}


local ls = require('luasnip')
local types = require('luasnip.util.types')

ls.config.set_config {
    -- Keep the last snippet around so you can jump back in
    history = true,

    -- enables dynamic snippets
    updateevents = 'TextChanged,TextChangedI'
}

vim.keymap.set({ "i", "s" }, "<c-k>", function ()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })

-- vim.keymap.set({ "i", "s" }, "<c-j>", function ()
--     if ls.expand_or_jumpable(-1) then
--         ls.expand_or_jump(-1)
--     end
-- end, { silent = true })

-- vim.keymap.set("i", "<c-l>", function ()
--     if ls.choice_active() then
--         ls.change_choice()
--     end
-- end, { silent = true })

ls.snippets = {
    all = {
        ls.parser.parse_snippet("log", "console.log($1)"),
        ls.parser.parse_snippet("expanded", "-- this was expanded"),
    }
}

