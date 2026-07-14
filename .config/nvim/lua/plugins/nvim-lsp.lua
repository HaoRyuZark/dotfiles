-- LSP configuration for Neovim 0.11+ (stable).
-- Uses the native vim.lsp.config / vim.lsp.enable API introduced in 0.11.

-- Mason handles server installation; mason-lspconfig bridges the two.
-- The neovim api handles the connection and calls to the lsp. 

-- Completion capabilities are sourced from blink.cmp (see blink-cmp.lua).


return {

  -- ── 1. Mason ────────────────────────────────────────────────────────────
  -- Mason is the package manager that downloads and installs LSP servers,
  -- formatters and linters into a single isolated directory (~/.local/share/nvim/mason).
  {
    'mason-org/mason.nvim',
    -- build ensures binaries are relinked after mason updates itself
    build = ':MasonUpdate',
    opts = {
      ui = { border = 'rounded' },
    },
  },

  -- ── 2. mason-lspconfig ──────────────────────────────────────────────────
  -- Bridges Mason and Neovim's native LSP layer.
  -- With automatic_enable = true (Neovim 0.11+) it calls vim.lsp.enable()
  -- for every server that Mason has installed, so you never need to call
  -- vim.lsp.enable() manually in the servers loop below.
  {
    'mason-org/mason-lspconfig.nvim',
    opts = {
      automatic_enable = true,
    },
  },

  -- ── 3. mason-tool-installer ──────────────────────────────────────────────
  -- Declaratively lists the servers and extra tools that should always be
  -- present.  Run :MasonToolsInstall to trigger a manual install pass.
  -- Server names here follow the lspconfig convention; mason-lspconfig
  -- resolves them to the correct Mason registry package names automatically.
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        -- Language servers
        'lua_ls',       -- Lua
        'pyright',      -- Python (static analysis + type checking)
        'clangd',       -- C / C++
        'ts_ls',        -- JavaScript / TypeScript
        'html',         -- HTML
        'cssls',        -- CSS / SCSS / Less
        'bashls',       -- Bash / Shell scripts
        'texlab',       -- LaTeX
        'marksman',     -- Markdown
        'jdtls',        -- Java (Eclipse JDT LS)
        'hls',          -- Haskell
        'stylua',       -- Lua formatter (used by conform.nvim / manual :lua vim.lsp.buf.format)
        'rust_analyzer' -- Rust
      },
    },
  },

  -- ── 4. fidget (optional) ───────────────────────────────────────────────────────────
  -- Shows LSP initialisation progress in the bottom-right corner so you
  -- know when a server is still indexing and completions may be incomplete.
  {
    'j-hui/fidget.nvim',
    opts = {},
  },

  -- ── 5. nvim-lspconfig ───────────────────────────────────────────────────
  -- Provides well-maintained default configurations for every known server.
  -- In Neovim 0.11+, these configs are registered as vim.lsp.config entries
  -- automatically when the plugin loads, so we only need to call
  -- vim.lsp.config(name, overrides) for the settings we want to change.
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'mason-org/mason.nvim',
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- blink.cmp must load before lspconfig so that the enhanced
      -- capabilities (snippet support, completion resolve, etc.) are
      -- available when we call get_lsp_capabilities() below.
      'saghen/blink.cmp',
    },
    config = function()

      -- ── Capabilities ──────────────────────────────────────────────────
      -- blink.cmp advertises richer completion capabilities to every server
      -- (e.g. LSP snippets, label details, insertReplaceEdit support).
      -- We merge them into every server config so completions work fully.
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- ── Per-server settings ────────────────────────────────────────────
      -- Only servers that need non-default options are listed here.
      -- All of them still receive the merged capabilities.
      local servers = {

        -- Lua: point the server at Neovim's own runtime files so it can
        -- resolve vim.* APIs, and suppress the false-positive globals warning.
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file('', true),
              },
              completion  = { callSnippet = 'Replace' },
              diagnostics = { globals = { 'vim' } },
              telemetry   = { enable = false },
            },
          },
        },

        -- Python: basic type checking, auto-import completions.
        pyright = {
          settings = {
            pyright = { autoImportCompletions = true },
            python  = { analysis = { typeCheckingMode = 'basic' } },
          },
        },

        -- C / C++: background indexing, clang-tidy linting, IWYU-style headers.
        clangd = {
          cmd = {
            'clangd',
            '--background-index',
            '--clang-tidy',
            '--completion-style=detailed',
            '--header-insertion=iwyu',
          },
        },

        -- JavaScript / TypeScript: defaults are fine for most projects.
        ts_ls = {},

        -- HTML: also handle Django templates.
        html  = { filetypes = { 'html', 'htmldjango' } },

        -- CSS / SCSS / Less: defaults are sufficient.
        cssls = {},

        -- Bash: extend to .zsh files as well.
        bashls = { filetypes = { 'sh', 'bash', 'zsh' } },

        -- LaTeX: build on save, enable chktex linting on edit.
        texlab = {
          settings = {
            texlab = {
              build   = { onSave = true },
              chktex  = { onEdit = true, onOpenAndSave = true },
            },
          },
        },
  
        rust_analyzer = {
          settings = {
            ['rust-analyzer'] = {
              -- Use clippy for richer linting on every save.
              check = {
                command   = 'clippy',
                extraArgs = { '--all-targets', '--all-features' },
              },

              -- Cargo: enable all features and run build scripts so
              -- proc-macro and generated types are available.
              cargo = {
                allFeatures        = true,
                loadOutDirsFromCheck = true,
                runBuildScripts    = true,
              },

              -- Proc macros: expand them so the server can type-check
              -- macro-generated code (e.g. serde, tokio::main).
              procMacro = {
                enable = true,
              },

              -- Completion extras.
              completion = {
                autoimport           = { enable = true },
                autoself             = { enable = true },
                fullFunctionSignatures = { enable = true },
              },

              -- Diagnostics: turn on experimental and style lints.
              diagnostics = {
                enable       = true,
                experimental = { enable = true },
                styleLints   = { enable = true },
              },

              -- Inlay hints (ghost text): every hint type turned on.
              inlayHints = {
                bindingModeHints          = { enable = true },
                chainingHints             = { enable = true },
                closingBraceHints         = { enable = true, minLines = 10 },
                closureCaptureHints       = { enable = true },
                closureReturnTypeHints    = { enable = 'always' },
                discriminantHints         = { enable = 'always' },
                expressionAdjustmentHints = { enable = 'always' },
                implicitDrops             = { enable = true },
                lifetimeElisionHints      = { enable = 'always', useParameterNames = true },
                maxLength                 = nil,   -- no truncation
                parameterHints            = { enable = true },
                rangeExclusiveHints       = { enable = true },
                reborrowHints             = { enable = 'always' },
                renderColons              = true,
                typeHints                 = {
                  enable                       = true,
                  hideClosureInitialization    = false,
                  hideNamedConstructor         = false,
                },
              },
            },
          },
        },

        -- Markdown: plain defaults work well.
        marksman = {},

        -- Java: mason-lspconfig automatically sets up the per-project
        -- workspace directory that jdtls requires — no extra config needed.
        jdtls = {},

        -- Haskell: use fourmolu for formatting (change to 'ormolu' if preferred).
        hls = {
          filetypes = { 'haskell', 'lhaskell', 'cabal' },
          settings  = {
            haskell = { formattingProvider = 'fourmolu' },
          },
        },
      }

      -- Merge capabilities into each server's config and register it with
      -- Neovim's native LSP layer.  mason-lspconfig will then call
      -- vim.lsp.enable() for each server that Mason has installed.
      for name, config in pairs(servers) do
        config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
        vim.lsp.config(name, config)
      end

      -- ── Keymaps (buffer-local, set once per LspAttach) ────────────────
      -- All bindings are scoped to the buffer the server just attached to,
      -- so they won't leak into unrelated filetypes.
      vim.api.nvim_create_autocmd('LspAttach', {
        
        group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
        callback = function(event)
         
          local bufnr = event.buf

          -- Small helper so we don't repeat { buffer = bufnr, desc = … } everywhere.
          local map = function(lhs, rhs, desc, mode)
            vim.keymap.set(mode or 'n', lhs, rhs, { buffer = bufnr, desc = 'LSP: ' .. desc })
          end

          -- ── Navigation ──────────────────────────────────────────────
          -- fzf-lua provides a preview picker when there are multiple results
          -- (e.g. multiple implementations), matching VSCode's peek behaviour.
          map('<leader>gd',         function() require('fzf-lua').lsp_definitions()        end, 'Go to Definition')
          map('<leader>gD',         function() require('fzf-lua').lsp_declarations()       end, 'Go to Declaration')
          map('<leader>gr',         function() require('fzf-lua').lsp_references()         end, 'Go to References')
          map('<leader>gi',         function() require('fzf-lua').lsp_implementations()    end, 'Go to Implementation')
          map('<leader>gt',  function() require('fzf-lua').lsp_typedefs()           end, 'Go to Type Definition')
          map('<leader>gs', function() require('fzf-lua').lsp_document_symbols()  end, 'Document Symbols')
          map('<leader>gws', function() require('fzf-lua').lsp_workspace_symbols() end, 'Workspace Symbols')

          -- ── Documentation ───────────────────────────────────────────
          -- K shows the hover popup (VSCode: Ctrl+K Ctrl+I).
          -- Press K a second time to jump into the float; then use j/k to
          -- scroll.  noice.nvim also maps <C-f>/<C-b> to scroll the float
          -- from normal/insert mode (see noice.lua).
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- Signature help while typing function arguments
          -- (VSCode: Ctrl+Shift+Space).  Available in insert mode only.
          map('<C-k>', vim.lsp.buf.signature_help, 'Signature Help', 'i')

          -- ── Refactoring ──────────────────────────────────────────────
          -- Rename across all files in the project (VSCode: F2).
          map('<F2>',       vim.lsp.buf.rename,      'Rename Symbol')
          map('<leader>rn', vim.lsp.buf.rename,      'Rename Symbol')

          -- Code actions: quick-fixes, auto-imports, extract-function, etc.
          -- Works in normal mode and visual mode (range code actions).
          -- VSCode equivalent: Ctrl+.
          map('<leader>ca', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })

          -- Format the current buffer via the LSP formatter.
          -- <S-A-f> mirrors VSCode's Shift+Alt+F.  The global mapping in
          -- keymaps.lua uses the same key; this buffer-local one takes
          -- precedence when an LSP is active.
          map('<S-A-f>', function() vim.lsp.buf.format { async = true } end, 'Format Buffer')

          -- ── Diagnostics ──────────────────────────────────────────────
          -- Jump forward/backward through all diagnostics (VSCode: F8 / Shift+F8).
          map(']d', function() vim.diagnostic.jump { count =  1, float = true } end, 'Next Diagnostic')
          map('[d', function() vim.diagnostic.jump { count = -1, float = true } end, 'Prev Diagnostic')

          -- Jump only to error-level diagnostics (skip warnings/hints).
          map(']e', function() vim.diagnostic.jump { count =  1, severity = vim.diagnostic.severity.ERROR, float = true } end, 'Next Error')
          map('[e', function() vim.diagnostic.jump { count = -1, severity = vim.diagnostic.severity.ERROR, float = true } end, 'Prev Error')
         
         
          -- Float with the full diagnostic message for the current line.
          map('<leader>e', vim.diagnostic.open_float,  'Show Line Diagnostics')
         

          -- Populate the location list with all buffer diagnostics (:lopen).
          map('<leader>q', vim.diagnostic.setloclist, 'Diagnostics to Loclist')

          -- ── Optional features (guarded by server support) ────────────
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          -- Compatibility shim: supports_method() changed its call convention
          -- between Neovim 0.10 (positional args) and 0.11 (method call).
          local function supports(method)
            if not client then return false end
            if vim.fn.has('nvim-0.11') == 1 then
              return client:supports_method(method, bufnr)
            end
            return client.supports_method(method, { bufnr = bufnr })
          end

          -- Inlay hints (ghost text): auto-enable on attach; <leader>th toggles.
          -- Only activated for servers that advertise textDocument/inlayHint.
          if supports(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }, { bufnr = bufnr })
            end, 'Toggle Inlay Hints')
          end

          -- Reference highlighting: underlines every occurrence of the symbol
          -- under the cursor after 'updatetime' ms of inactivity (default 250).
          if supports(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local hl = vim.api.nvim_create_augroup('user-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = bufnr, group = hl, callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = bufnr, group = hl, callback = vim.lsp.buf.clear_references,
            })
            -- Clean up highlight autocmds when the server detaches from the buffer.
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('user-lsp-detach', { clear = true }),
              callback = function(ev)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'user-lsp-highlight', buffer = ev.buf }
              end,
            })
          end
        end,
      })

      -- ── Diagnostics appearance ─────────────────────────────────────────
      vim.diagnostic.config {
        severity_sort = true,
        -- Rounded border on the floating diagnostic window.
        float = { border = 'rounded', source = 'if_many' },
        -- Nerd Font icons in the sign column (gutter).
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN]  = '󰀪 ',
            [vim.diagnostic.severity.INFO]  = '󰋽 ',
            [vim.diagnostic.severity.HINT]  = '󰌶 ',
          },
        },
        -- Virtual text inline next to the affected line.
        -- source = 'if_many' hides the source name when only one LSP reports.
        virtual_text = {
          source  = 'if_many',
          spacing = 2,
          prefix  = '●',
        },
      }
    end,
  },
}
