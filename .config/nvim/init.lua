---- GLOBALS ----

local g = vim.g

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

g.mapleader = " "
g.localleader = "\\"

g.t_co = 256
g.background = "dark"
g.autoindent = "smartindent"

---- CLIPBOARD ----
--g.paste = true
--g.clipboard = "unnamed"
g.clipboard = {
  name = "myClipboard",
  copy = {
    ["+"] = "wl-copy -n",
    ["*"] = "wl-copy -np",
    ["0"] = "wl-copy -np"
  },
  paste = {
    ["+"] = "wl-paste -n",
    ["*"] = "wl-paste -np",
    ["0"] = "wl-paste -np"
  },
  cache_enabled = true
}

---- IMPORTS ----
require('opt')
require('key')
require('plug')
require('lsp')
require('telescope')

--g.tagbar_ctags_bin = "C:\\Program Files\\universal-ctags\\ctags.exe"
