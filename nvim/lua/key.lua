---- KEY MAPPINGS ----

local map = vim.api.nvim_set_keymap

-- remap the key used to leave insert mode
map('i', 'jj', '<Esc>', {})

-- toggle filetree
map('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', {})

-- disable arrow keys
map('n', '<up>', '', {})
map('n', '<down>', '', {})
map('n', '<right>', '', {})
map('n', '<left>', '', {})

map('i', '<up>', '', {})
map('i', '<down>', '', {})
map('i', '<right>', '', {})
map('i', '<left>', '', {})

map('v', '<up>', '', {})
map('v', '<down>', '', {})
map('v', '<right>', '', {})
map('v', '<left>', '', {})

-- change splits using Ctrl+nav
map('n', '<C-k>', '<C-W>k', {})
map('n', '<C-j>', '<C-W>j', {})
map('n', '<C-l>', '<C-W>l', {})
map('n', '<C-h>', '<C-W>h', {})

-- remap yank and paste to system clipboard
map('v', '<C-c>', '"*y', {})

map('n', '<leader>t', '<cmd>ToggleTerm<cr>', {})
