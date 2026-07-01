-- Completion engine configuration.
-- blink can only ask to the engines for completion
return {
  'saghen/blink.cmp',
  event   = 'InsertEnter',
  version = '1.*',

  dependencies = {

    -- ── Snippet engine ───────────────────────────────────────────────
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

    -- ── Neovim API completion ────────────────────────────────────────
    -- lazydev teaches the Lua LSP about Neovim's runtime types so you get
    -- accurate completion for vim.*, require('...'), and plugin APIs while
    -- editing your own config.
    'folke/lazydev.nvim',
  },

  opts = {

    -- ── Keymaps ────────────────────────────────────────────────────
    -- The 'default' preset gives you:
    --   <C-n> / <C-p>   : select next / previous item
    --   <C-space>       : open menu or open docs if already open
    --   <C-e>           : hide the menu
    --   <C-b> / <C-f>   : scroll the documentation float
    --   <C-k>           : toggle signature help
    --   <Tab> / <S-Tab> : move forward / backward in snippet placeholders
    keymap = {
      preset = 'default',

      -- <Enter> confirms the highlighted item (falls back to a normal newline
      -- when the menu is closed, so it won't swallow blank lines).
      ['<Enter>'] = { 'accept', 'fallback' },

      -- <Tab> accepts the current ghost-text / selected item, then advances
      -- the snippet cursor if we are inside a snippet, otherwise inserts a
      -- regular tab.  This matches the VSCode IntelliSense / Copilot feel.
      ['<Tab>']   = { 'accept', 'snippet_forward', 'fallback' },
    },

    appearance = {
      -- Use the monospaced variant of Nerd Font icons for kind labels
      -- (functions, variables, classes, etc.).
      nerd_font_variant = 'mono',
    },

    completion = {
      -- Ghost text: renders the top completion candidate as faded inline text
      -- to the right of the cursor, similar to GitHub Copilot or VS Code.
      -- Press <Tab> or <Enter> to accept it.
      ghost_text = { enabled = true },

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

    -- ── Sources ────────────────────────────────────────────────────
    -- Completion candidates come from these sources in priority order.
    -- 'lazydev' replaces the standard 'lsp' source when editing Neovim Lua
    -- files so you get typed vim.* API completions.
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
      providers = {
        lazydev = {
          name   = 'LazyDev',
          module = 'lazydev.integrations.blink',
          -- Push Neovim API items above generic LSP results.
          score_offset = 100,
        },
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
