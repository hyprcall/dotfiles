-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Set mapleader to space
vim.g.mapleader = " "

-- Setup lazy.nvim
require("lazy").setup({
  {
    "rebelot/kanagawa.nvim",
    priority = 1000, -- Ensure it loads first
    config = function()
      vim.cmd("colorscheme kanagawa")
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({})
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      code = { enabled = true, style = "full", width = "full" },
      heading = { enabled = true, style = "full", width = "full" },
    },
  },

  -- Mason: Portable package manager for Neovim that easily installs LSP servers
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  
  -- Mason-LSPConfig: Bridges mason.nvim with the lspconfig plugin
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "clangd",          -- C/C++
        "omnisharp",       -- C#
        "pyright",         -- Python
        "bashls",          -- Bash
        "rust_analyzer",   -- Rust
        "intelephense",    -- PHP
        "ts_ls",           -- JavaScript/TypeScript
        "powershell_es",   -- PowerShell
      },
    },
  },
  
  -- Nvim-LSPConfig: Quickstart configs for Nvim LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp", -- Allows LSP to provide autocomplete results to cmp
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Neovim 0.11+ natively handles LSP configuration and mason-lspconfig automatically enables installed servers.
      -- We just need to globally set the autocomplete capabilities for all servers.
      vim.lsp.config('*', { capabilities = capabilities })

      -- Global mappings.
      vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          
          -- This is the Smart Rename you asked for!
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = ev.buf, desc = "Smart Rename" })
          
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })
    end,
  },

  -- Nvim-Cmp: The Autocomplete Engine
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",             -- Snippet Engine
      "saadparwaiz1/cmp_luasnip",     -- Snippet Autocompletion Source
      "hrsh7th/cmp-nvim-lsp",         -- LSP Autocompletion Source
      "hrsh7th/cmp-buffer",           -- Buffer Autocompletion Source (words in current file)
      "hrsh7th/cmp-path",             -- Filepath Autocompletion Source
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) -- Tell cmp to use LuaSnip for snippet expansion
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item
          -- Super-Tab mapping for autocomplete
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
})

-- Toggle file explorer with <Space> + e
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Sync clipboard between OS and Neovim.
-- Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)