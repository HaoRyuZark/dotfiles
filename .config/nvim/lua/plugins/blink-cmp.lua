return {

  'saghen/blink.cmp',
  event   = 'InsertEnter',
  version = '1.*',

  dependencies = {

    -- Snippet engine 
    -- LuaSnip expands LSP snippets (e.g. auto-filled function parameters)
    -- and loads the friendly-snippets collection.
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (function()
        -- The jsregexp build step enables regex-based transformations inside
        -- snippets.  Skipped on Windows or when make is unavailable.
        if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then return end
        return 'make install_jsregexp'
      end)(),

      dependencies = {
        -- A curated collection of snippets for many languages (Python, JS,
        -- Lua, HTML, CSS, Rust, Haskell, LaTeX, Bash …).
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
    },

    -- Neovim API completion 
    -- lazydev teaches the Lua LSP about Neovim's runtime types so you get
    -- accurate completion for vim.*, require('...'), and plugin APIs while
    -- editing your own config.
    {
      'folke/lazydev.nvim',
      ft = 'lua',
      opts = {
        library = {
          { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        },
      },
    },
  },

  opts = {

    -- Keymaps     
    -- The 'default' preset gives you:
    --   <C-n> / <C-p>   : select next / previous item
    --   <C-space>       : open menu or open docs if already open
    --   <C-e>           : hide the menu
    --   <C-b> / <C-f>   : scroll the documentation float
    --   <C-k>           : toggle signature help
    --   <Tab> / <S-Tab> : move forward / backward in snippet placeholders
    keymap = {
      preset = 'default',

      -- <CR> confirms the highlighted item (falls back to a normal newline
      -- when the menu is closed, so it won't swallow blank lines).
      ['<CR>'] = { 'accept', 'fallback' },

      -- <Tab>: Copilot suggestion if visible, else accept the selected item,
      -- else jump to the next snippet placeholder, else insert a tab.
      ['<Tab>']   = {
        function()
          local ok, s = pcall(require, 'copilot.suggestion')
          if ok and s.is_visible() then
            s.accept()
            return true
          end
        end,
        'accept',
        'snippet_forward',
        'fallback',
      },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
    },

    appearance = {
      -- Use the monospaced variant of Nerd Font icons for kind labels
      -- (functions, variables, classes, etc.).
      nerd_font_variant = 'mono',
    },

    completion = {
      -- Ghost text disabled: Copilot owns inline ghost text.
      ghost_text = { enabled = false },

      -- Documentation popup: shows automatically after a short delay.
      -- Press <C-space> to open it manually, or <C-b>/<C-f> to scroll it
      -- (noice.nvim maps the same keys to scroll LSP hover floats).
      documentation = {
        auto_show          = true,
        auto_show_delay_ms = 400,
        window = { border = 'rounded' },
      },

      -- Completion menu appearance.
      menu = {
        border = 'rounded',
        draw = {
          -- Show the completion label + description on the left, and the
          -- kind icon + kind name on the right (e.g. "[Function]").
          columns = {
            { 'label', 'label_description', gap = 1 },
            { 'kind_icon', 'kind' },
          },
        },
      },
    },

    -- Sources 
    -- Completion candidates come from these sources in priority order.
    -- 'lazydev' is added for Lua buffers only; dadbod for SQL buffers.
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      per_filetype = {
        lua   = { inherit_defaults = true, 'lazydev' },
        sql   = { 'dadbod', 'snippets', 'buffer' },
        mysql = { 'dadbod', 'snippets', 'buffer' },
        plsql = { 'dadbod', 'snippets', 'buffer' },
      },
      providers = {
        lazydev = {
          name   = 'LazyDev',
          module = 'lazydev.integrations.blink',
          -- Push Neovim API items above generic LSP results.
          score_offset = 100,
        },
        dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
      },
    },

    -- Use LuaSnip for all snippet operations (expand, jump forward/backward).
    snippets = { preset = 'luasnip' },

    -- Prefer the compiled Rust fuzzy-matcher for speed on large completion
    -- lists; falls back transparently to the Lua implementation if the
    -- prebuilt binary is unavailable on this platform.
    fuzzy = { implementation = 'prefer_rust_with_warning' },

    -- Show a signature help popup while typing inside a function call's
    -- argument list.  Toggle it manually with <C-k> in insert mode.
    signature = { enabled = true },
  },
}
