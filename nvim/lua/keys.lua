--[[ keys.lua ]]
local map = vim.api.nvim_set_keymap

-- remap the key used to leave insert mode
map('i', 'jj', '<Esc>', {})

-- toggle filetree
map('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', {})

vim.g.clipboard = {
  name = "clip.exe (Copy Only)",
  copy = {
    ["+"] = "clip.exe",
    ["*"] = "clip.exe"
  },
  paste = {
    ["+"] = "clip.exe",
    ["*"] = "clip.exe"
  },
  cache_enabled = true
}


-- remap yank and paste to system clipboard
map('n', 'yy', '"*y<cr>', {})
map('n', 'pp', '"*p<cr>', {})
