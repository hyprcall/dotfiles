-- =========================
-- Core options
-- =========================
vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 200
vim.opt.signcolumn = "yes"

-- =========================
-- Providers (silence ones you don't use)
-- =========================
vim.g.loaded_perl_provider  = 0
vim.g.loaded_ruby_provider  = 0
-- If you truly don't want Node provider, uncomment:
-- vim.g.loaded_node_provider  = 0

-- Prefer a local Python venv for provider if present
do
  local venv_py = vim.fn.expand("~/.venvs/nvim/bin/python")
  if vim.fn.executable(venv_py) == 1 then vim.g.python3_host_prog = venv_py end
end

-- =========================
-- Bootstrap lazy.nvim
-- =========================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git","clone","--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- =========================
-- Plugins (no nvim-lspconfig anywhere)
-- =========================
local plugins = {
  -- Theme
  { "catppuccin/nvim", name = "catppuccin", priority = 1000,
    config = function() vim.cmd.colorscheme("catppuccin") end
  },

  -- Telescope
  { "nvim-telescope/telescope.nvim", version = false, dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local b = require("telescope.builtin")
      vim.keymap.set("n","<leader>ff", b.find_files, { desc = "Find files" })
      vim.keymap.set("n","<leader>fg", b.live_grep,  { desc = "Live grep"  })
      vim.keymap.set("n","<leader>fb", b.buffers,    { desc = "Buffers"    })
    end
  },

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "lua","python","bash","javascript","typescript",
        "json","yaml","html","css","markdown","markdown_inline","vim","vimdoc","query","c"
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end
  },

  -- Statusline
  { "nvim-lualine/lualine.nvim",
    config = function() require("lualine").setup({ options = { theme = "auto" } }) end
  },

  -- Git signs
  { "lewis6991/gitsigns.nvim", config = function() require("gitsigns").setup() end },

  -- Mason core + tool installer (servers, formatters, linters)
  { "williamboman/mason.nvim", build = ":MasonUpdate", config = true },
  { "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "lua-language-server",
          "pyright",
          "bash-language-server",
          "typescript-language-server",
          -- Add formatters/linters if desired:
          -- "stylua","black","ruff","prettierd","eslint_d"
        },
        auto_update = false,
        run_on_start = true,
      })
    end
  },

  -- Completion
  { "hrsh7th/nvim-cmp",
    event = "InsertEnter",  -- lazy-load so first boot can finish
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local ok, cmp = pcall(require, "nvim-cmp")
      if not ok then return end
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<CR>"]     = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"]= cmp.mapping.complete(),
        }),
        sources = { { name = "nvim_lsp" } },
      })
    end
  },
}

require("lazy").setup(plugins, {
  rocks = { enabled = false },   -- kill luarocks/hererocks ❌
  checker = { enabled = false },
})

-- =========================
-- Native LSP (vim.lsp.config/start)
-- =========================
local capabilities = vim.lsp.protocol.make_client_capabilities()
do
  local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
  if ok then capabilities = cmp_lsp.default_capabilities(capabilities) end
end

local function on_attach(_, bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end
  map("n","gd",         vim.lsp.buf.definition,     "Go to definition")
  map("n","gD",         vim.lsp.buf.declaration,    "Go to declaration")
  map("n","gr",         vim.lsp.buf.references,     "References")
  map("n","gi",         vim.lsp.buf.implementation, "Implementation")
  map("n","K",          vim.lsp.buf.hover,          "Hover")
  map("n","<leader>rn", vim.lsp.buf.rename,         "Rename")
  map("n","<leader>ca", vim.lsp.buf.code_action,    "Code action")
  map("n","<leader>fd", vim.diagnostic.open_float,  "Line diagnostics")
  map("n","[d",         vim.diagnostic.goto_prev,   "Prev diagnostic")
  map("n","]d",         vim.diagnostic.goto_next,   "Next diagnostic")
end

local function start_lsp(opts)
  local cfg = vim.lsp.config(opts)
  vim.lsp.start(cfg)
end

local function find_root(bufnr, markers)
  return vim.fs.root(bufnr or 0, markers) or vim.fn.getcwd()
end

-- lua_ls
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function(args)
    start_lsp({
      name = "lua_ls",
      cmd = { "lua-language-server" },
      root_dir = find_root(args.buf, { ".luarc.json", ".luarc.jsonc", ".stylua.toml", ".git" }),
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace   = { checkThirdParty = false },
          telemetry   = { enable = false },
        }
      }
    })
  end,
})

-- pyright
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function(args)
    start_lsp({
      name = "pyright",
      cmd = { "pyright-langserver", "--stdio" },
      root_dir = find_root(args.buf, { "pyproject.toml", "setup.cfg", "requirements.txt", "pyrightconfig.json", ".git" }),
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = "openFilesOnly",
            useLibraryCodeForTypes = true,
          }
        }
      }
    })
  end,
})

-- bashls
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sh", "bash" },
  callback = function(args)
    start_lsp({
      name = "bashls",
      cmd = { "bash-language-server", "start" },
      root_dir = find_root(args.buf, { ".git" }),
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        bashIde = { globPattern = "*@(.sh|.inc|.bash|.command)" }
      }
    })
  end,
})

-- ts / js (ts_ls naming in lspconfig; binary is typescript-language-server)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript","javascriptreact","javascript.jsx","typescript","typescriptreact","typescript.tsx" },
  callback = function(args)
    start_lsp({
      name = "ts_ls",
      cmd = { "typescript-language-server", "--stdio" },
      init_options = { hostInfo = "neovim" },
      root_dir = find_root(args.buf, { "package.json", "tsconfig.json", "jsconfig.json", ".git" }),
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,
})

-- Diagnostics UI
for name, icon in pairs({ Error="", Warn="", Hint="", Info="" }) do
  local hl = "DiagnosticSign"..name
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
vim.diagnostic.config({
  virtual_text = { spacing = 2, prefix = "●" },
  severity_sort = true,
  float = { border = "rounded" },
})
