local map = vim.keymap.set

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  -- Manual for the hovered function
  map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)

  map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  map('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  map('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  map({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
  map('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

  map('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
  map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
  map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)

  map('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  map("i", "<C-h>", '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)

  --map("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  --map("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  --map("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  --map("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  --map("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)

  --lsp_zero.default_keymaps(opts)

  if client.supports_method('textDocument/formatting') then
    require('lsp-format').on_attach(client)
  end
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  -- Must be a name on here: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
  ensure_installed = {'lua_ls', 'rust_analyzer', 'omnisharp'},
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'nvim_lua'},
    {name = 'buffer'},
  },
  formatting = {
    fields = {'abbr', 'kind', 'menu'},
    format = require('lspkind').cmp_format({
      mode = 'symbol',
      maxwidth = 50,
      ellipsis_char = '…',
    }),
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),   
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp_action.tab_complete(),
    ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
  }),
})

lsp_zero.setup()

