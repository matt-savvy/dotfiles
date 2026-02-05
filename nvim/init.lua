-- Shortcut to open this file
vim.keymap.set('n', '<Leader>v', ':e ~/dev/dotfiles/nvim/init.lua<CR>', { silent = false })

-- Keymap to sort inside paragraph
vim.keymap.set('n', '<Leader>ss', '!ip sort<CR>', { silent = false })

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

-- Tab counts for 4 spaces
vim.o.tabstop = 4
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
    },
    extensions = {
        fzf = {}
    }
})

telescope.load_extension('fzy_native')
local telescopeBuiltins = require('telescope.builtin')

-- open telescope file finder on ctrl-P
vim.keymap.set('n', '<C-p>', telescopeBuiltins.find_files, { noremap = true })

-- vim-grepper
-- use rg and git grep
vim.g.grepper = {
    tools = {'rg', 'git'}
}
-- Use gs to take any motion and populate the search prompt
vim.keymap.set({'n', 'x'}, 'gs', '<plug>(GrepperOperator)')
-- Shortcut to open :Grepper
vim.keymap.set('n', '<Leader>gg', function() vim.cmd("Grepper") end, { silent = true })

-- keymaps to yank file name

function filename_with_line()
    local line, _ = unpack(vim.api.nvim_win_get_cursor(0))

    local filename = vim.fn.expand("%")
    return filename .. ":" .. line
end

local function remote_filename_with_line(mode)
	local repo_url = vim.fn.system("git remote get-url origin"):gsub("^git@(.*):(.*)%.git.*", "https://%1/%2"):gsub("%s+", "")
	local rev = vim.fn.system("git rev-parse --abbrev-ref HEAD"):gsub("%s+", "")
    if rev == "HEAD" then
        rev = vim.fn.system("git rev-parse --short HEAD`"):gsub("%s+", "")
    end
    local filename = vim.fn.expand("%")
	local remote_filename = repo_url .. "/blob/" .. rev .. "/" .. filename

    if mode == "n" then
        local line, _ = unpack(vim.api.nvim_win_get_cursor(0))
        return remote_filename .. "#L" .. line
    elseif mode == "v" then
        local start_line = math.min(vim.fn.line("v"), vim.fn.line("."))
        local end_line = math.max(vim.fn.line("v"), vim.fn.line("."))
        return remote_filename .. "#L" .. start_line .. "-L" .. end_line
    end
end

-- yank filename with line number of cursor
vim.keymap.set('n', '<Leader>fl', function() vim.fn.setreg("+", filename_with_line()) end , { silent = false })
-- yank filename (with path)
vim.keymap.set('n', '<Leader>ff', ':let @+ = expand("%")<cr>', { silent = true })
-- yank filename (without path)
vim.keymap.set('n', '<Leader>f', ':let @+ = expand("%:t")<cr>', { silent = true })
-- yank remote filename with line number of cursor
vim.keymap.set('n', '<Leader>fr', function() vim.fn.setreg("+", remote_filename_with_line('n')) end , { silent = false })
-- yank remote filename with line number of cursor
vim.keymap.set('v', '<Leader>fr', function() vim.fn.setreg("+", remote_filename_with_line('v')) end , { silent = false })

-- temporary fix for https://github.com/elixir-editors/vim-elixir/issues/562
vim.filetype.add({
    extension = {
        heex = "eelixir",
        eex = "eelixir",
        leex = "eelixir",
        sface = "eelixir",
        lexs = "eelixir",
    }
})

vim.cmd('colorscheme terafox')

-- Shortcut to open workingMemory.txt
vim.keymap.set('n', '<Leader>wm', ':e ~/workingMemory.txt<CR>', { silent = false })
-- Shortcut to open longTermMemory.txt
vim.keymap.set('n', '<Leader>ltm', ':e ~/longTermMemory.txt<CR>', { silent = false })

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
vim.keymap.set('n', ']b', vim.cmd.bnext, { noremap = true, silent = true })
vim.keymap.set('n', '[b', vim.cmd.bprev, { noremap = true, silent = true })
vim.keymap.set('n', '[a', ':e #<CR>', { noremap = true, silent = true })

-- Shortcuts for navigating quickfix list
vim.keymap.set('n', ']q', ":cnext<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '[q', ":cprev<CR>", { noremap = true, silent = true })

-- Close hidden buffers
local function clear_hidden_buffers()
    for _, buffer in pairs(vim.fn.getbufinfo()) do
        if buffer.hidden == 1 then
            vim.cmd.bd(buffer.bufnr)
        end
    end
end

vim.keymap.set('n', '<Leader>bd', clear_hidden_buffers, { silent = false, noremap = true })

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
		return "<c-n>"
    end

    return "<tab>"
end

vim.keymap.set('i', '<tab>', InsertTab, { expr = true })
vim.keymap.set('i', '<s-tab>', '<c-n>', { noremap = true })

-- Allows %% in command mode to fill in the directory of the buffer
vim.keymap.set('c', '%%', "getcmdtype() == ':' ? expand('%:h').'/' : '%%'", { expr = true, noremap = true })

-- Remove neovim mapping of Y to y$
vim.keymap.del('n', 'Y')

vim.lsp.config('elixir-ls', {
    cmd = { '/home/matt/.local/bin/elixir-ls-v0.29.3/language_server.sh' },
    settings = { autoBuild = false },
    filetypes = { 'elixir', 'eelixir', 'heex' },
    root_markers = { 'mix.exs', '.git' },
})

vim.lsp.enable('elixir-ls')

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        -- always show a sign column of width 1
        vim.wo.signcolumn = "yes:1"

        local opts = { noremap=true, silent=true }
        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions

        -- "gO" is mapped in Normal mode to vim.lsp.buf.document_symbol()
        vim.keymap.set('n', '<Leader>d', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '[w', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']w', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '<Leader>q', vim.diagnostic.setqflist, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        -- "gri" is mapped in Normal mode to vim.lsp.buf.implementation()
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        -- CTRL-S is mapped in Insert mode to vim.lsp.buf.signature_help()
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        -- "grt" is mapped in Normal mode to vim.lsp.buf.type_definition()
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        -- "grn" is mapped in Normal mode to vim.lsp.buf.rename()
        vim.keymap.set('n', '<Leader>r', vim.lsp.buf.rename, opts)
        -- "gra" is mapped in Normal and Visual mode to vim.lsp.buf.code_action()
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
        -- "grr" is mapped in Normal mode to vim.lsp.buf.references()
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('my.lsp', { clear = true }),
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id, async = false, timeout_ms = 1000 })
                end
            })
        end
    end
})

-- configure diagnostics
vim.diagnostic.config({
  virtual_text = false,
  underline = { severity = vim.diagnostic.severity.ERROR },
  update_in_insert = false,
  signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = '>',
        [vim.diagnostic.severity.WARN]  = 'W',
        [vim.diagnostic.severity.INFO]  = 'I',
        [vim.diagnostic.severity.HINT]  = 'H',
      },
  }
})
