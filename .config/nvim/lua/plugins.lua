local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none", "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({

    --  UI
      {
        "goolord/alpha-nvim",
      dependencies = {"nvim-tree/nvim-web-devicons"},

      config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = {
     "                                   ",
      "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
      "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
      "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
      "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
      "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
      "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
      "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
      " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
      " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
      "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
      "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
        }

       dashboard.section.buttons.val = {
       dashboard.button("f", "🗎 Find file", ":Telescope find_files <CR>"),
       dashboard.button("e", "+  New file", ":ene <BAR> startinsert <CR>"),
       dashboard.button("r", "🗁 Recently used files", ":Telescope oldfiles <CR>"),
       dashboard.button("t", "T  Find text", ":Telescope live_grep <CR>"),
       dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua<CR>"),
       dashboard.button("u", "⇧  Update", ":Lazy update <CR>"),
       dashboard.button("q", "⛌  Quit Neovim", ":qa<CR>"),
        }

        local function footer()
        return "¡Viva Cristo Rey!"
        end

        dashboard.section.footer.val = footer()

        dashboard.section.footer.opts.hl = "Type"
        dashboard.section.header.opts.hl = "Include"
        dashboard.section.buttons.opts.hl = "Keyword"

        dashboard.opts.opts.noautocmd = true

        alpha.setup(dashboard.opts)
      end,
    },
    { 

    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,

      config = function()
        require('catppuccin').setup {
          -- leave this setup function empty for default config
          -- or refer to the configuration section
          -- for configuration options
            flavour = "mocha",
        }
      end,

      -- optionally set the colorscheme within lazy config
      init = function()
        vim.cmd("colorscheme catppuccin-mocha")
      end

    },
    {

        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        
        config = function()
            require("lualine").setup({
            options = {
                theme = "catppuccin-mocha",
            },
        })
        end
    },
    --

    -- Latex 
   {
      "lervag/vimtex",
      lazy = false,     -- we don't want to lazy load VimTeX
      
      init = function()
        -- VimTeX configuration goes here, e.g.
        vim.g.vimtex_view_method = "zathura"
      end
    },
    
    -- Which Key
    {
        "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
      keys = {
        {
          "<leader>?",
          function()
            require("which-key").show({ global = false })
          end,
          desc = "Buffer Local Keymaps (which-key)",
        },
      },
    },

    -- Search
    {
        "https://github.com/ibhagwan/fzf-lua",
        dependencies = {
            "https://github.com/elanmed/fzf-lua-frecency.nvim",
        },
        event = "VeryLazy",
        config = function()
            require("fzf-lua").setup({
                "max-perf",
                winopts = {
                    height = 0.5,
                    width = 1,
                    row = 1,
                },
            })
            require("fzf-lua").register_ui_select()
            require("fzf-lua-frecency").setup({
                display_score = false,
            })
        end,
    },
    
    {
      
      {
        "nvim-telescope/telescope-ui-select.nvim",
      },
      
      {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim", },
        config = function()
          require("telescope").setup({
            extensions = {
              ["ui-select"] = {
                require("telescope.themes").get_dropdown({}),
              },
            },
          })
          local builtin = require("telescope.builtin")

        
         vim.keymap.set("n", "ff", builtin.find_files, {  desc = 'Find files'})
         vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = 'Live grep'})
         vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = 'Old files'})

          require("telescope").load_extension("ui-select")
        end,
      },
    },
    { "https://github.com/MagicDuck/grug-far.nvim", lazy = true },
    --

    -- File manager
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    config = function()
      local oil = require("oil")
      oil.setup({
          -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
            -- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
            default_file_explorer = true,
            -- Id is automatically added at the beginning, and name at the end
            -- See :help oil-columns
            columns = {
              "icon",
              -- "permissions",
              -- "size",
              -- "mtime",
            },
            -- Buffer-local options to use for oil buffers
            buf_options = {
              buflisted = false,
              bufhidden = "hide",
            },
            -- Window-local options to use for oil buffers
            win_options = {
              wrap = false,
              signcolumn = "no",
              cursorcolumn = false,
              foldcolumn = "0",
              spell = false,
              list = false,
              conceallevel = 3,
              concealcursor = "nvic",
            },
            -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
            delete_to_trash = false,
            -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
            skip_confirm_for_simple_edits = false,
            -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
            -- (:help prompt_save_on_select_new_entry)
            prompt_save_on_select_new_entry = true,
            -- Oil will automatically delete hidden buffers after this delay
            -- You can set the delay to false to disable cleanup entirely
            -- Note that the cleanup process only starts when none of the oil buffers are currently displayed
            cleanup_delay_ms = 2000,
            lsp_file_methods = {
              -- Enable or disable LSP file operations
              enabled = true,
              -- Time to wait for LSP file operations to complete before skipping
              timeout_ms = 1000,
              -- Set to true to autosave buffers that are updated with LSP willRenameFiles
              -- Set to "unmodified" to only save unmodified buffers
              autosave_changes = false,
            },
            -- Constrain the cursor to the editable parts of the oil buffer
            -- Set to `false` to disable, or "name" to keep it on the file names
            constrain_cursor = "editable",
            -- Set to true to watch the filesystem for changes and reload oil
            watch_for_changes = false,
            -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
            -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
            -- Additionally, if it is a string that matches "actions.<name>",
            -- it will use the mapping at require("oil.actions").<name>
            -- Set to `false` to remove a keymap
            -- See :help oil-actions for a list of all available actions
            keymaps = {
              ["g?"] = { "actions.show_help", mode = "n" },
              ["<CR>"] = "actions.select",
              ["<C-s>"] = { "actions.select", opts = { vertical = true } },
              ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
              ["<C-t>"] = { "actions.select", opts = { tab = true } },
              ["<C-p>"] = "actions.preview",
              ["<C-c>"] = { "actions.close", mode = "n" },
              ["<C-l>"] = "actions.refresh",
              ["-"] = { "actions.parent", mode = "n" },
              ["_"] = { "actions.open_cwd", mode = "n" },
              ["`"] = { "actions.cd", mode = "n" },
              ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
              ["gs"] = { "actions.change_sort", mode = "n" },
              ["gx"] = "actions.open_external",
              ["g."] = { "actions.toggle_hidden", mode = "n" },
              ["g\\"] = { "actions.toggle_trash", mode = "n" },
            },
            -- Set to false to disable all of the above keymaps
            use_default_keymaps = true,
            view_options = {
              -- Show files and directories that start with "."
              show_hidden = true,
              -- This function defines what is considered a "hidden" file
              is_hidden_file = function(name, bufnr)
                local m = name:match("^%.")
                return m ~= nil
              end,
              -- This function defines what will never be shown, even when `show_hidden` is set
              is_always_hidden = function(name, bufnr)
                return false
              end,
              -- Sort file names with numbers in a more intuitive order for humans.
              -- Can be "fast", true, or false. "fast" will turn it off for large directories.
              natural_order = "fast",
              -- Sort file and directory names case insensitive
              case_insensitive = false,
              sort = {
                -- sort order can be "asc" or "desc"
                -- see :help oil-columns to see which columns are sortable
                { "type", "asc" },
                { "name", "asc" },
              },
              -- Customize the highlight group for the file name
              highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
                return nil
              end,
            },
            -- Extra arguments to pass to SCP when moving/copying files over SSH
            extra_scp_args = {},
            -- EXPERIMENTAL support for performing file operations with git
            git = {
              -- Return true to automatically git add/mv/rm files
              add = function(path)
                return false
              end,
              mv = function(src_path, dest_path)
                return false
              end,
              rm = function(path)
                return false
              end,
            },
            -- Configuration for the floating window in oil.open_float
            float = {
              -- Padding around the floating window
              padding = 2,
              -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
              max_width = 0,
              max_height = 0,
              border = "rounded",
              win_options = {
                winblend = 0,
              },
              -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
              get_win_title = nil,
              -- preview_split: Split direction: "auto", "left", "right", "above", "below".
              preview_split = "auto",
              -- This is the config that will be passed to nvim_open_win.
              -- Change values here to customize the layout
              override = function(conf)
                return conf
              end,
            },
            -- Configuration for the file preview window
            preview_win = {
              -- Whether the preview window is automatically updated when the cursor is moved
              update_on_cursor_moved = true,
              -- How to open the preview window "load"|"scratch"|"fast_scratch"
              preview_method = "fast_scratch",
              -- A function that returns true to disable preview on a file e.g. to avoid lag
              disable_preview = function(filename)
                return false
              end,
              -- Window-local options to use for preview window buffers
              win_options = {},
            },
            -- Configuration for the floating action confirmation window
            confirmation = {
              -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
              -- min_width and max_width can be a single value or a list of mixed integer/float types.
              -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
              max_width = 0.9,
              -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
              min_width = { 40, 0.4 },
              -- optionally define an integer/float for the exact width of the preview window
              width = nil,
              -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
              -- min_height and max_height can be a single value or a list of mixed integer/float types.
              -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
              max_height = 0.9,
              -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
              min_height = { 5, 0.1 },
              -- optionally define an integer/float for the exact height of the preview window
              height = nil,
              border = "rounded",
              win_options = {
                winblend = 0,
              },
            },
            -- Configuration for the floating progress window
            progress = {
              max_width = 0.9,
              min_width = { 40, 0.4 },
              width = nil,
              max_height = { 10, 0.9 },
              min_height = { 5, 0.1 },
              height = nil,
              border = "rounded",
              minimized_border = "none",
              win_options = {
                winblend = 0,
              },
            },
            -- Configuration for the floating SSH window
            ssh = {
              border = "rounded",
            },
            -- Configuration for the floating keymaps help window
            keymaps_help = {
              border = "rounded",
            }
      })
      vim.keymap.set("n", "-", oil.toggle_float, {})
    end,
  },
  {
      
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
      },

      config = function()
      
      
      require("neo-tree").setup({
          filesystem = {
              filtered_items = {
                  visible = true,
                  hide_dot_files = false,
                  hide_git_ignore = false,
              },
          }
      })    
    
    end,

  },

    -- IntelliSense
    {

        "https://github.com/Saghen/blink.cmp",      
        dependencies = {
            "https://github.com/neovim/nvim-lspconfig",
        },
        version = "1.*",
        event = "VeryLazy",
        config = function()
            
    
            vim.lsp.config("lua_ls", {})
            
            vim.lsp.config("bashls", {})
      
            vim.lsp.config("pyright", {})
      
            vim.lsp.config("ts_ls", {})
      
            vim.lsp.config("asm_ls", {})
            
            vim.lsp.config("dockerls", {})
      
            vim.lsp.config("sqlls", {})
      
            vim.lsp.config("java_ls", {})
                       
            vim.lsp.config("clangd", {})
            
            vim.lsp.enable({
                  "lua_ls",
                  "clangd",
                  "bashls",
                  "pyright",
                  "asm_ls",
                  "sqlls",
                  "texlab"
              })
              
            require("blink.cmp").setup({
                keymap = {
                    preset = "enter",
                },
                cmdline = {
                    keymap = {
                        preset = "super-tab",
                    },
                },
            })
        end,
    },
  
    -- Treesitter: Syntax highlighting
    {
        "https://github.com/nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "VeryLazy",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "nix",
                    "json",
                    "c",
                    "cpp",
                    "java", 
                    "python",
                    "rust",
                    "bash",
                    "asm",
                    "typescript",
                    "vimdoc",
                },
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
            })
        end,
    },
    
  -- Noice: Command Bar
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
    
    -- stylua: ignore
    keys = {
      { "<leader>sn", "", desc = "+noice"},
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
      { "<leader>snt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
      },
      config = function(_, opts)
        -- HACK: noice shows messages from before it was enabled,
        -- but this is not ideal when Lazy is installing plugins,
        -- so clear the messages in this case.
        if vim.o.filetype == "lazy" then
          vim.cmd([[messages clear]])
        end
        require("noice").setup(opts)
      end,
      
    }, 
    
    {
        "https://github.com/windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },

    -- Git
    { "https://github.com/tpope/vim-fugitive", cmd = "Git" },

    {
        "https://github.com/nvim-mini/mini.diff",
        event = "VeryLazy",
        config = function()
            require("mini.diff").setup({})
        end,
    },

    --Miscellaneous
    { "https://github.com/farmergreg/vim-lastplace", event = "BufReadPost" },
    { "https://github.com/echasnovski/mini.bufremove", lazy = true },

    {
        "https://github.com/tpope/vim-sleuth",
        event = "VeryLazy",
        config = function()
            vim.cmd("silent Sleuth")
        end,
    },
    {
        "rcarriga/nvim-notify",
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    }, 

  -- Rust 
    {
      
      'mrcjkb/rustaceanvim',
      version = '^5', -- Use the latest stable version
      ft = { 'rust' },
      config = function()
        vim.g.rustaceanvim = {
          server = {
            on_attach = function(_, bufnr)
              -- Keybinding to toggle inlay hints
              vim.keymap.set('n', '<Leader>th', function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
              end, { buffer = bufnr })
            end,
            settings = {
              ['rust-analyzer'] = {
                cargo = { allFeatures = true },
                checkOnSave = { command = 'clippy' },
                inlayHints = {
                  enable = true,               -- Enable inlay hints
                  typeHints = true,            -- Show type hints
                  parameterHints = true,       -- Show parameter hints
                  chainingHints = true,        -- Show hints for chained method calls
                  closingBraceHints = true,    -- Show closing brace hints
                  maxLength = 30,              -- Max length of the hints
                },
              },
            },
          },
        }
      end
    }, 
  
  -- Database Stuff
  {
    'tpope/vim-dadbod'
  }, 
  {
   'kristijanhusak/vim-dadbod-ui' 
  },
  {
   'kristijanhusak/vim-dadbod-completion' 
  }
})
