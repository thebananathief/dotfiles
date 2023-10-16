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

---- OPTIONS ----
local opt = vim.opt

-- [[ Context ]]
opt.colorcolumn = '90'           -- str:  Show col for max line length
opt.number = true                -- bool: Show line numbers
opt.relativenumber = true
opt.scrolloff = 4                -- int:  Min num lines of context
opt.signcolumn = "yes"           -- str:  Show the sign column

-- [[ Folds ]]
--opt.foldmethod = "syntax"

-- [[ Filetypes ]]
opt.encoding = 'utf8'            -- str:  String encoding to use
opt.fileencoding = 'utf8'        -- str:  File encoding to use

-- [[ Theme ]]
opt.syntax = "ON"                -- str:  Allow syntax highlighting
opt.termguicolors = true         -- bool: If term supports ui color then enable

-- [[ Search ]]
opt.ignorecase = true            -- bool: Ignore case in search patterns
opt.smartcase = true             -- bool: Override ignorecase if search contains capitals
opt.incsearch = true             -- bool: Use incremental search
opt.hlsearch = false             -- bool: Highlight search matches

-- [[ Whitespace ]]
opt.expandtab = true             -- bool: Use spaces instead of tabs
opt.shiftwidth = 2               -- num:  Size of an indent
opt.softtabstop = 2              -- num:  Number of spaces tabs count for in insert mode
opt.tabstop = 2                  -- num:  Number of spaces tabs count for

-- [[ Splits ]]
opt.splitright = true            -- bool: Place new window to right of current one
opt.splitbelow = true            -- bool: Place new window below the current one
