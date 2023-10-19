---- KEY MAPPINGS ----

local map = vim.api.nvim_set_keymap

-- escape insert mode
map('i', 'jj', '<Esc>', {})

-- escape terminal mode
--map('t', 'jj', '<C-\\><C-n>', {})
map('t', '<leader>j', '<C-\\><C-n>', {})

-- change splits using Ctrl+nav
map('n', '<C-k>', '<C-W>k', {})
map('n', '<C-j>', '<C-W>j', {})
map('n', '<C-l>', '<C-W>l', {})
map('n', '<C-h>', '<C-W>h', {})

-- change tabs using Shift+h/l
map('n', '<S-h>', 'gT', {})
map('n', '<S-l>', 'gt', {})

-- resize splits with - _ = +
map('n', '=', '<cmd>vertical resize +2<cr>', {})
map('n', '-', '<cmd>vertical resize -2<cr>', {})
map('n', '+', '<cmd>horizontal resize +2<cr>', {})
map('n', '_', '<cmd>horizontal resize -2<cr>', {})
--
-- remap yank and paste to system clipboard
map('v', '<leader>y', '"+y', {})
map('n', '<leader>p', '"+p', {})

-- plugin maps
map('n', '<leader>t', '<cmd>ToggleTerm<cr>', {})
--map('n', '<leader>c', '<leader>c<leader>', {})

-- toggle filetree
map('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', {})

-- change tabs with <leader>#
map('n', '<leader>1', '1gt', {})
map('n', '<leader>2', '2gt', {})
map('n', '<leader>3', '3gt', {})
map('n', '<leader>4', '4gt', {})
map('n', '<leader>5', '5gt', {})
map('n', '<leader>6', '6gt', {})
map('n', '<leader>7', '7gt', {})
map('n', '<leader>8', '8gt', {})
map('n', '<leader>9', '9gt', {})
map('n', '<leader>0', '$tabnext', {})
