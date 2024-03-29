local map = vim.keymap.set
require("telescope").load_extension("refactoring")
local builtin = require('telescope.builtin')

map('n', '<leader>ff', builtin.find_files, {})
map('n', '<leader>fg', builtin.live_grep, {})
map('n', '<leader>fb', builtin.buffers, {})
map('n', '<leader>fh', builtin.help_tags, {})
map('n', '<leader>fr', builtin.lsp_references, {})
map('n', '<leader>ft', builtin.treesitter, {})

map({'n', 'x'}, "<leader>rr", function() require('telescope').extensions.refactoring.refactors() end)
