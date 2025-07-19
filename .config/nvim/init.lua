-- General Settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.clipboard = 'unnamedplus'
vim.g.mapleader = ' '

-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin Specifications
require('lazy').setup({
  -- Colorscheme
  {'folke/tokyonight.nvim', priority = 1000},
  
  -- File Explorer
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup({
        view = { width = 30 },
        renderer = { group_empty = true },
        filters = { dotfiles = false }
      })
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { silent = true })
    end
  },

  -- Mason: LSP/DAP/Linter/Formatter Manager
  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup({
        automatic_installation = true,
      })
      
      -- Automatically install these tools
      require('mason-tool-installer').setup({
        ensure_installed = {
          -- LSP Servers
          'clangd',           -- C/C++
          'pyright',         -- Python
          'ts_ls',         -- JavaScript/TypeScript
          'html-lsp',         -- HTML
          'css-lsp',          -- CSS
          'emmet-ls',         -- HTML/CSS expansion
          'lua-language-server',-- Lua
          
          -- Formatters
          'clang-format',     -- C/C++
          'black',            -- Python
          'prettier',         -- JS/TS/HTML/CSS
          'stylua',           -- Lua
          
          -- Linters
          'cpplint',          -- C/C++
          'pylint',           -- Python
          'eslint_d',         -- JS/TS
        },
      })
    end
  },

  -- LSP Configuration
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
    config = function()
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      
      -- Language servers with custom configurations
      local servers = {
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm"
          },
        },
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "strict",
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true
              }
            }
          }
        },
        ts_ls = {
          settings = {
            completions = {
              completeFunctionCalls = true
            }
          }
        },
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' }
              }
            }
          }
        }
      }
      
      -- Setup all servers
      for server, config in pairs(servers) do
        config.capabilities = capabilities
        lspconfig[server].setup(config)
      end

      -- Keybindings for LSP
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          local buf = args.buf
          local opts = { buffer = buf }

          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end
      })
    end
  },

  -- Enhanced Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
      'onsails/lspkind.nvim'
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      require('luasnip.loaders.from_vscode').lazy_load()
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' }
        }),
        formatting = {
          format = require('lspkind').cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
            ellipsis_char = '...',
          })
        }
      })
    end
  },

  -- Advanced Syntax Highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'c', 'cpp', 'python', 'javascript', 'typescript', 
          'html', 'css', 'lua', 'bash', 'json', 'yaml', 'tsx'
        },
        highlight = { 
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<C-space>',
            node_incremental = '<C-space>',
            scope_incremental = '<C-s>',
            node_decremental = '<C-backspace>',
          },
        },
        autotag = {
          enable = true,
          filetypes = { 'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'jsx', 'tsx' }
        }
      })
    end
  },

  -- Auto Pairs and Tags
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({})
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end
  },
  {
    'windwp/nvim-ts-autotag',
    config = true
  },

  -- Comments
  { 'numToStr/Comment.nvim', config = true },

  -- Surround
  { 'kylechui/nvim-surround', config = true },

  -- Status Line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = { theme = 'tokyonight' },
        sections = {
          lualine_c = {
            { 'filename', path = 1 }  -- Show relative path
          }
        }
      })
    end
  },

  -- Git Integration
  { 
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        current_line_blame = true,
        sign_priority = 9,
      })
    end
  },
})

-- Apply Colorscheme
vim.cmd.colorscheme('tokyonight')

-- Keybindings
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>', { desc = 'Clear search highlight' })
vim.keymap.set('n', '<leader>tt', ':NvimTreeFindFileToggle<CR>', { desc = 'Toggle tree at current file' })
