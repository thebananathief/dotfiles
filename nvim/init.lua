---- GLOBALS ----

local g = vim.g

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

g.mapleader = " "
g.localleader = "\\"

g.t_co = 256
g.background = "dark"
g.paste = true
g.autoindent = "smartindent"

--g.clipboard = "unnamed"
g.clipboard = {
  name = "clip.exe (Copy Only)",
  copy = {
    ["+"] = "win32yank.exe -i",
    ["*"] = "win32yank.exe -i"
  },
  paste = {
    ["+"] = "win32yank.exe -o",
    ["*"] = "win32yank.exe -o"
  },
  cache_enabled = true
}

---- IMPORTS ----
require('opt')
require('key')
require('plug')

g.tagbar_ctags_bin = "C:\\Program Files\\universal-ctags\\ctags.exe"
