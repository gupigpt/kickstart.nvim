--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- ============================================================
-- SECTION 1: FOUNDATION
-- Core Neovim settings, leaders, options, basic keymaps, basic autocmds
-- ============================================================
do
  -- Enable faster startup by caching compiled Lua modules
  vim.loader.enable()

  vim.opt.runtimepath:append '~/.local/share/nvim/site' -- Treesitter parser path

  -- Set comma as the leader key
  -- See `:help mapleader`
  --  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
  vim.g.mapleader = ','
  vim.g.maplocalleader = ','

  -- Set to true if you have a Nerd Font installed and selected in the terminal
  vim.g.have_nerd_font = true

  -- [[ Setting options ]]
  --  See `:help vim.o`
  -- NOTE: You can change these options as you wish!
  --  For more options, you can see `:help option-list`

  -- Make line numbers default
  vim.o.number = true
  -- You can also add relative line numbers, to help with jumping.
  vim.o.relativenumber = true

  -- Enable mouse mode, can be useful for resizing splits for example!
  vim.o.mouse = 'a'

  -- Don't show the mode, since it's already in the status line
  vim.o.showmode = false

  -- Sync clipboard between OS and Neovim.
  --  Schedule the setting after `UiEnter` because it can increase startup-time.
  --  Remove this option if you want your OS clipboard to remain independent.
  --  See `:help 'clipboard'`
  vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

  -- Enable break indent
  vim.o.breakindent = true

  -- Enable undo/redo changes even after closing and reopening a file
  vim.o.undofile = true

  -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
  vim.o.ignorecase = true
  vim.o.smartcase = true

  -- Keep signcolumn on by default
  vim.o.signcolumn = 'yes'

  -- Decrease update time
  vim.o.updatetime = 250

  -- Decrease mapped sequence wait time
  vim.o.timeoutlen = 300

  -- Configure how new splits should be opened
  vim.o.splitright = true
  vim.o.splitbelow = true

  -- Sets how neovim will display certain whitespace characters in the editor.
  --  See `:help 'list'`
  --  and `:help 'listchars'`
  --
  --  Notice listchars is set using `vim.opt` instead of `vim.o`.
  --  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
  --   See `:help lua-options`
  --   and `:help lua-guide-options`
  vim.o.list = true
  vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

  -- Preview substitutions live, as you type!
  vim.o.inccommand = 'split'

  -- Show which line your cursor is on
  vim.o.cursorline = true

  -- Minimal number of screen lines to keep above and below the cursor.
  vim.o.scrolloff = 5

  -- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
  -- instead raise a dialog asking if you wish to save the current file(s)
  -- See `:help 'confirm'`
  vim.o.confirm = true

  -- [[ Basic Keymaps ]]
  --  See `:help vim.keymap.set()`

  -- Clear highlights on search when pressing <Esc> in normal mode
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

  -- File operations
  vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = 'Write buffer' })
  vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', { desc = 'Quit' })
  vim.keymap.set('n', '<leader>x', '<cmd>x<CR>', { desc = 'Write and quit' })
  vim.keymap.set('n', '<leader>e', '<cmd>e!<CR>', { desc = 'Reload file' })

  -- Diagnostic keymaps
  vim.keymap.set('n', '<leader>dd', vim.diagnostic.setloclist, { desc = 'Open diagnostic list' })
  vim.keymap.set('n', '<leader>dc', function() vim.diagnostic.open_float { scope = 'cursor', focus = false } end, { desc = 'Show current diagnostic' })
  --
  -- Go to previous/next diagnostic warning/hint/error etc:
  vim.keymap.set('n', '<leader>dn', function()
    vim.diagnostic.jump { count = 1 }
    vim.diagnostic.open_float { scope = 'cursor', focus = false }
  end, { desc = 'Go to next diagnostic' })

  vim.keymap.set('n', '<leader>dp', function()
    vim.diagnostic.jump { count = -1 }
    vim.diagnostic.open_float { scope = 'cursor', focus = false }
  end, { desc = 'Go to previous diagnostic' })

  -- Diagnostic Config & Keymaps
  --  See `:help vim.diagnostic.Opts`
  vim.diagnostic.config {
    update_in_insert = false,
    severity_sort = true,
    float = {
      border = 'rounded',
      source = 'if_many',
      header = 'Diagnostics', -- kein "Diagnostics:" Header
      prefix = ' ', -- kleines Symbol vor jeder Meldung
    },
    underline = { severity = { min = vim.diagnostic.severity.WARN } },

    -- Can switch between these as you prefer
    virtual_text = true, -- Text shows up at the end of the line
    virtual_lines = false, -- Text shows up underneath the line, with virtual lines

    -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
    jump = {
      on_jump = function(_, bufnr)
        vim.diagnostic.open_float {
          bufnr = bufnr,
          scope = 'cursor',
          focus = false,
        }
      end,
    },
  }

  -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
  -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
  -- is not what someone will guess without a bit more experience.
  --
  -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
  -- or just use <C-\><C-n> to exit terminal mode
  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

  -- TIP: Disable arrow keys in normal mode
  -- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
  -- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
  -- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
  -- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

  -- Keybinds to make split navigation easier.
  --  Use CTRL+<hjkl> to switch between windows
  --
  --  See `:help wincmd` for a list of all window commands
  vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

  -- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
  -- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
  -- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
  -- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
  -- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

  -- [[ Basic Autocommands ]]
  --  See `:help lua-guide-autocommands`

  -- Highlight when yanking (copying) text
  --  Try it with `yap` in normal mode
  --  See `:help vim.hl.on_yank()`
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
  })
end

-- Diagnostic Float bei Cursor-Hover
vim.api.nvim_create_autocmd('CursorHold', {
  desc = 'Show diagnostic float on cursor hold',
  group = vim.api.nvim_create_augroup('kickstart-diagnostic-hover', { clear = true }),
  callback = function() vim.diagnostic.open_float { scope = 'cursor', focus = false } end,
})

-- ============================================================
-- SECTION 2: PLUGIN MANAGER INTRO
-- vim.pack intro, build hooks
-- ============================================================
do
  -- [[ Intro to `vim.pack` ]]
  -- `vim.pack` is a new plugin manager built into Neovim,
  --  which provides a Lua interface for installing and managing plugins.
  --
  --  See `:help vim.pack`, `:help vim.pack-examples` or the
  --  excellent blog post from the creator of vim.pack and mini.nvim:
  --  https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack
  --
  --  To inspect plugin state and pending updates, run
  --    :lua vim.pack.update(nil, { offline = true })
  --
  --  To update plugins, run
  --    :lua vim.pack.update()
  --
  --
  --  Throughout the rest of the config there will be examples
  --  of how to install and configure plugins using `vim.pack`.
  --
  --  In this section we set up some autocommands to run build
  --  steps for certain plugins after they are installed or updated.

  local function run_build(name, cmd, cwd)
    local result = vim.system(cmd, { cwd = cwd }):wait()
    if result.code ~= 0 then
      local stderr = result.stderr or ''
      local stdout = result.stdout or ''
      local output = stderr ~= '' and stderr or stdout
      if output == '' then output = 'No output from build command.' end
      vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
    end
  end

  -- This autocommand runs after a plugin is installed or updated and
  --  runs the appropriate build command for that plugin if necessary.
  --
  -- See `:help vim.pack-events`
  vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
      local name = ev.data.spec.name
      local kind = ev.data.kind
      if kind ~= 'install' and kind ~= 'update' then return end

      if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
        run_build(name, { 'make' }, ev.data.path)
        return
      end

      if name == 'LuaSnip' then
        if vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1 then run_build(name, { 'make', 'install_jsregexp' }, ev.data.path) end
        return
      end

      if name == 'nvim-treesitter' then
        if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
        vim.cmd 'TSUpdate'
        return
      end
    end,
  })
end

---Because most plugins are hosted on GitHub, you can use the helper
---function to have less repetition in the following sections.
---@param repo string
---@return string
local function gh(repo) return 'https://github.com/' .. repo end

-- ============================================================
-- SECTION 3: UI / CORE UX PLUGINS
-- guess-indent, gitsigns, which-key, colorscheme, todo-comments, mini modules
-- ============================================================
do
  -- [[ Installing and Configuring Plugins ]]
  --
  -- To install a plugin simply call `vim.pack.add` with its git url.
  -- This will download the default branch of the plugin, which will usually be `main` or `master`
  -- You can also have more advanced specs, which we will talk about later.
  --
  -- For most plugins its not enough to install them, you also need to call their `.setup()` to start them.
  --
  -- For example, lets say we want to install `guess-indent.nvim` - a plugin for
  -- automatically detecting and setting the indentation.
  --
  -- We first install it from https://github.com/NMAC427/guess-indent.nvim
  -- and then call its `setup()` function to start it with default settings.
  vim.pack.add { gh 'NMAC427/guess-indent.nvim' }
  require('guess-indent').setup {}

  -- Because lua is a real programming language, you can also have some logic to your installation -
  -- like only installing a plugin if a condition is met.
  --
  -- Here we only install `nvim-web-devicons` (which adds pretty icons) if we have a Nerd Font,
  -- since otherwise the icons won't display properly.
  if vim.g.have_nerd_font then vim.pack.add { gh 'nvim-tree/nvim-web-devicons' } end

  -- Here is a more advanced configuration example that passes options to `gitsigns.nvim`
  --
  -- See `:help gitsigns` to understand what each configuration key does.
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  vim.pack.add { gh 'lewis6991/gitsigns.nvim' }
  require('gitsigns').setup {
    current_line_blame = true, -- Show inline git blame
    current_line_blame_opts = {
      delay = 800, -- ms bis es erscheint
      virt_text_pos = 'right_align', -- Show the blame on the right - other option "eol" to show directly after the code
    },
    current_line_blame_formatter = '  <author>, <author_time:%d.%m.%Y> · <summary>',
    signs = {
      add = { text = '+' }, ---@diagnostic disable-line: missing-fields
      change = { text = '~' }, ---@diagnostic disable-line: missing-fields
      delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
      topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
      changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      vim.keymap.set('n', '<leader>hs', gs.stage_hunk, { buffer = bufnr, desc = 'Stage hunk' })
      vim.keymap.set('n', '<leader>hr', gs.reset_hunk, { buffer = bufnr, desc = 'Reset hunk' })
      vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { buffer = bufnr, desc = 'Preview hunk' })
      vim.keymap.set('n', '<leader>hb', gs.blame_line, { buffer = bufnr, desc = 'Blame line' })
      vim.keymap.set('n', '<leader>hd', gs.diffthis, { buffer = bufnr, desc = 'Diff this' })
      vim.keymap.set('n', '<leader>hn', gs.next_hunk, { buffer = bufnr, desc = 'Go to next hunk' })
      vim.keymap.set('n', '<leader>hN', gs.prev_hunk, { buffer = bufnr, desc = 'Go to previous hunk' })
    end,
  }

  -- Very weak grey color for inline blames:
  vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', { fg = '#253535', italic = true }) --try also #1d3030 or #3d5a5a

  -- Useful plugin to show you pending keybinds.
  vim.pack.add { gh 'folke/which-key.nvim' }
  require('which-key').setup {
    -- Delay between pressing a key and opening which-key (milliseconds)
    delay = 600, --in millisec - set to sth higher so fast commands don't show a pop up
    icons = { mappings = vim.g.have_nerd_font },
    filter = function(mapping) return mapping.lhs ~= ',' end,
    layout = {
      width = { min = 20, max = 50 },
      spacing = 3,
    },
    win = {
      border = 'rounded',
      padding = { 1, 2 },
      -- Transparent background (like telescope):
      -- wo = {
      -- winblend = 15,
      -- },
    },
    spec = {
      { '<leader>s', group = 'Search', mode = { 'n', 'v' } },
      { '<leader>t', group = 'Toggle' },
      { '<leader>h', group = 'Git Hunks', mode = { 'n', 'v' } },
      { '<leader>d', group = 'Diagnostics' },
      { '<leader>g', group = 'Git' },
      { 'gr', group = 'LSP' },
      { '<leader>z', group = 'Games' }, -- für cellular-automaton
    },
  }
  -- Which-key popup menu design:
  vim.api.nvim_set_hl(0, 'WhichKey', { fg = '#859900' }) -- Taste
  vim.api.nvim_set_hl(0, 'WhichKeyDesc', { fg = '#93a1a1' }) -- Beschreibung
  vim.api.nvim_set_hl(0, 'WhichKeyGroup', { fg = '#268bd2', bold = true }) -- Gruppe
  vim.api.nvim_set_hl(0, 'WhichKeySeparator', { fg = '#586e75' }) -- Pfeil
  vim.api.nvim_set_hl(0, 'WhichKeyFloat', { bg = '#073642' }) -- Hintergrund
  vim.api.nvim_set_hl(0, 'WhichKeyBorder', { bg = '#073642', fg = '#859900' })


-- Show number of occurrences when searching for sth
vim.pack.add { gh 'kevinhwang91/nvim-hlslens' }
require('hlslens').setup {
  calm_down = true, -- highlight verschwindet wenn Cursor sich bewegt
  nearest_only = true, -- nur aktuellen Treffer hervorheben
  nearest_float_when = 'never',
}

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    vim.api.nvim_set_hl(0, 'HlSearchNear',     { fg = '#002b36', bg = '#859900', bold = true })
    vim.api.nvim_set_hl(0, 'HlSearchLens',     { fg = '#859900', bg = 'none' })
    vim.api.nvim_set_hl(0, 'HlSearchLensNear', { fg = '#93a1a1', bg = 'none', bold = true })
    vim.api.nvim_set_hl(0, 'HlSearchFloat',    { fg = '#002b36', bg = '#859900' })
    vim.api.nvim_set_hl(0, 'Search',           { fg = '#002b36', bg = '#b58900' })
    vim.api.nvim_set_hl(0, 'IncSearch',        { fg = '#002b36', bg = '#859900', bold = true })
  end,
})

-- n/N Mappings ersetzen:
vim.keymap.set('n', 'n', function()
  vim.cmd 'normal! n'
  require('hlslens').start()
  local count = vim.fn.searchcount { maxcount = 0 }
  if count.total > 0 then vim.notify(string.format('%d/%d', count.current, count.total), vim.log.levels.INFO) end
end)
vim.keymap.set('n', 'N', function()
  vim.cmd 'normal! N'
  require('hlslens').start()
  local count = vim.fn.searchcount { maxcount = 0 }
  if count.total > 0 then vim.notify(string.format('%d/%d', count.current, count.total), vim.log.levels.INFO) end
end)


  -- [[ Colorscheme ]]
  -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command under that to load whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  -- deaktiviert um NeoSolarized von github/tsuzat zu installieren
  --[[
  vim.pack.add { gh 'folke/tokyonight.nvim' }
  ---@diagnostic disable-next-line: missing-fields
  require('tokyonight').setup {
    styles = {
      comments = { italic = false }, -- Disable italics in comments
    },
  }
--]]
  -- neues Theme NeoSolarized:
  vim.pack.add { gh 'Tsuzat/NeoSolarized.nvim' }
  require('NeoSolarized').setup {
    style = 'dark',
    transparent = true,
  }
  vim.cmd.colorscheme 'NeoSolarized'

  -- remove current line coloring
  vim.api.nvim_set_hl(0, 'CursorLine', { bg = 'none' })

  --[[
-- Load the colorscheme here.
-- Like many other themes, this one has different styles, and you could load
-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
vim.cmd.colorscheme 'tokyonight-night'
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--]]

  -- Telescope popup – abgestimmt auf NeoSolarized dark
  vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = '#073642' }) -- Solarized base03, etwas heller als Hintergrund
  --vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = '#0a3040' })
  vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = '#073642', fg = '#859900' }) -- grüner Rand
  --vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { bg = '#0a4050' }) -- minimal heller
  vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { bg = '#0d3d50' })
  vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { bg = '#0a4050', fg = '#859900' }) -- auch grün
  vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { bg = '#859900', fg = '#002b36' }) -- grüner Titel
  vim.api.nvim_set_hl(0, 'TelescopeResultsNormal', { bg = '#073642' })
  vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', { bg = '#073642', fg = '#859900' })
  vim.api.nvim_set_hl(0, 'TelescopePreviewNormal', { bg = '#073642' })
  vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', { bg = '#073642', fg = '#859900' })
  vim.api.nvim_set_hl(0, 'TelescopeSelection', { bg = '#0d4a5a', bold = true }) -- Auswahl-Zeile
  vim.api.nvim_set_hl(0, 'TelescopeSelectionCaret', { fg = '#859900' })

  --
  -- Design of the float box (for errors, hints etc)
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#073642' })
  vim.api.nvim_set_hl(0, 'FloatBorder', { bg = '#073642', fg = '#859900' })
  vim.api.nvim_set_hl(0, 'FloatTitle', { bg = '#859900', fg = '#002b36', bold = true })

  vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = '#dc322f' }) -- Solarized red
  vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = '#b58900' }) -- Solarized yellow
  vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = '#2aa198' }) -- Solarized cyan
  vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = '#268bd2' }) -- Solarized blue

  --
  -- Highlight todo, notes, etc in comments
  vim.pack.add { gh 'folke/todo-comments.nvim' }
  require('todo-comments').setup { signs = false }

  -- [[ mini.nvim ]]
  --  A collection of various small independent plugins/modules
  vim.pack.add { gh 'nvim-mini/mini.nvim' }

  -- Better Around/Inside textobjects
  --
  -- Examples:
  --  - va)  - [V]isually select [A]round [)]paren
  --  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
  --  - ci'  - [C]hange [I]nside [']quote
  require('mini.ai').setup {
    -- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
    mappings = {
      around_next = 'aa',
      inside_next = 'ii',
    },
    n_lines = 500,
  }

  -- Add/delete/replace surroundings (brackets, quotes, etc.)
  --
  -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
  -- - sd'   - [S]urround [D]elete [']quotes
  -- - sr)'  - [S]urround [R]eplace [)] [']
  require('mini.surround').setup()

  -- Simple and easy statusline.
  --  You could remove this setup call if you don't like it,
  --  and try some other statusline plugin
  local statusline = require 'mini.statusline'
  -- Set `use_icons` to true if you have a Nerd Font
  statusline.setup { use_icons = vim.g.have_nerd_font }

  -- You can configure sections in the statusline by overriding their
  -- default behavior. For example, here we set the section for
  -- cursor location to LINE:COLUMN
  ---@diagnostic disable-next-line: duplicate-set-field

  -- rechte Seite der status bar wie in vim gestalten:
  --statusline.section_location = function() return '%2l:%-2v' end
  --statusline.section_location = function() return 'row: %l  col: %c  progress: %p%%' end

  -- Winbar: absoluter Pfad + modified flag
  vim.o.winbar = ' %F %m'

  -- eine einzige Statusline ganz unten
  vim.o.laststatus = 3
  --
  -- Statusline content
  statusline.active = function()
    local mode, mode_hl = statusline.section_mode { trunc_width = 120 }

    -- Git branch + changes (via gitsigns plugin)
    local branch = vim.b.gitsigns_head or ''
    local git = branch ~= '' and (' ' .. branch) or ''

    local gs = vim.b.gitsigns_status_dict or {}
    local changes = ''
    if gs.added and gs.added > 0 then changes = changes .. ' +' .. gs.added end
    if gs.changed and gs.changed > 0 then changes = changes .. ' ~' .. gs.changed end
    if gs.removed and gs.removed > 0 then changes = changes .. ' -' .. gs.removed end

    -- LSP + Diagnostics
    local clients = vim.lsp.get_clients { bufnr = 0 }
    local lsp = ''
    if #clients > 0 then
      local names = {}
      for _, c in ipairs(clients) do
        table.insert(names, c.name)
      end
      lsp = '󰒋 ' .. table.concat(names, ', ')
    end
    local diagnostics = statusline.section_diagnostics { trunc_width = 75 }

    -- Encoding + Filetype
    local enc = vim.bo.fileencoding ~= '' and vim.bo.fileencoding or vim.o.encoding
    local ft = vim.bo.filetype ~= '' and vim.bo.filetype or 'no ft'
    local fileinfo = string.format('%s  %s', enc, ft)

    -- Location
    local location = string.format('row: %d  col: %d  %d%%%%', vim.fn.line '.', vim.fn.col '.', math.floor(vim.fn.line '.' / vim.fn.line '$' * 100))

    return statusline.combine_groups {
      { hl = mode_hl, strings = { mode } },
      { hl = 'MiniStatuslineDevinfo', strings = { git, changes } },
      { hl = 'MiniStatuslineDevinfo', strings = { lsp, diagnostics } },
      '%<',
      { hl = 'MiniStatuslineFilename', strings = { '%t' } },
      '%=',
      { hl = 'MiniStatuslineFileinfo', strings = { enc .. '  ' .. ft } },
      { hl = mode_hl, strings = { location } },
    }
  end

  -- ... and there is more!
  --  Check out: https://github.com/nvim-mini/mini.nvim
end

-- ─── colorful-winsep ─────────────────────────────────────────────────────────
vim.pack.add { gh 'nvim-zh/colorful-winsep.nvim' }
require('colorful-winsep').setup {
  border = 'rounded',
  highlight = '#2aa198', -- cyan colored
  excluded_ft = { 'TelescopePrompt', 'mason' },
  animate = {
    enabled = 'progressive',
    progressive = {
      delay = 16,
      vertical_lerp_factor = 0.15, -- zwischen 0 und 1, höher = schneller
      horizontal_lerp_factor = 0.15,
    },
  },
  indicator_for_2wins = {
    position = 'center',
  },
}

-- ============================================================
-- SECTION 4: SEARCH & NAVIGATION
-- Telescope setup, keymaps, LSP picker mappings
-- ============================================================
do
  -- [[ Fuzzy Finder (files, lsp, etc) ]]
  --
  -- Telescope is a fuzzy finder that comes with a lot of different things that
  -- it can fuzzy find! It's more than just a "file finder", it can search
  -- many different aspects of Neovim, your workspace, LSP, and more!
  --
  -- There are lots of other alternative pickers (like snacks.picker, or fzf-lua)
  -- so feel free to experiment and see what you like!
  --
  -- The easiest way to use Telescope, is to start by doing something like:
  --  :Telescope help_tags
  --
  -- After running this command, a window will open up and you're able to
  -- type in the prompt window. You'll see a list of `help_tags` options and
  -- a corresponding preview of the help.
  --
  -- Two important keymaps to use while in Telescope are:
  --  - Insert mode: <c-/>
  --  - Normal mode: ?
  --
  -- This opens a window that shows you all of the keymaps for the current
  -- Telescope picker. This is really useful to discover what Telescope can
  -- do as well as how to actually do it!

  ---@type (string|vim.pack.Spec)[]
  local telescope_plugins = {
    gh 'nvim-lua/plenary.nvim',
    gh 'nvim-telescope/telescope.nvim',
    gh 'nvim-telescope/telescope-ui-select.nvim',
  }
  if vim.fn.executable 'make' == 1 then table.insert(telescope_plugins, gh 'nvim-telescope/telescope-fzf-native.nvim') end

  -- NOTE: You can install multiple plugins at once
  vim.pack.add(telescope_plugins)

  -- See `:help telescope` and `:help telescope.setup()`
  require('telescope').setup {
    -- You can put your default mappings / updates / etc. in here
    --  All the info you're looking for is in `:help telescope.setup()`
    --
    -- defaults = {
    --   mappings = {
    --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
    --   },
    -- },
    -- pickers = {}
    defaults = {
      winblend = 15,
      borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      prompt_prefix = ' ',
      selection_caret = ' ',
      layout_config = {
        horizontal = {
          preview_width = 0.55,
        },
      },
    },
    extensions = {
      ['ui-select'] = { require('telescope.themes').get_dropdown() },
    },
  }

  -- Enable Telescope extensions if they are installed
  pcall(require('telescope').load_extension, 'fzf')
  pcall(require('telescope').load_extension, 'ui-select')

  -- See `:help telescope.builtin`
  local builtin = require 'telescope.builtin'
  vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
  vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
  vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

  -- Add Telescope-based LSP pickers when an LSP attaches to a buffer.
  -- If you later switch picker plugins, this is where to update these mappings.
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
    callback = function(event)
      local buf = event.buf

      -- Find references for the word under your cursor.
      vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })

      -- Jump to the implementation of the word under your cursor.
      -- Useful when your language has ways of declaring types without an actual implementation.
      vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })

      -- Jump to the definition of the word under your cursor.
      -- This is where a variable was first declared, or where a function is defined, etc.
      -- To jump back, press <C-t>.
      vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })

      -- Fuzzy find all the symbols in your current document.
      -- Symbols are things like variables, functions, types, etc.
      vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open Document Symbols' })

      -- Fuzzy find all the symbols in your current workspace.
      -- Similar to document symbols, except searches over your entire project.
      vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'Open Workspace Symbols' })

      -- Jump to the type of the word under your cursor.
      -- Useful when you're not sure what type a variable is and you want to see
      -- the definition of its *type*, not where it was *defined*.
      vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = buf, desc = '[G]oto [T]ype Definition' })
    end,
  })

  -- Override default behavior and theme when searching
  vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to Telescope to change the theme, layout, etc.
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[/] Fuzzily search in current buffer' })

  -- It's also possible to pass additional configuration options.
  --  See `:help telescope.builtin.live_grep()` for information about particular keys
  vim.keymap.set(
    'n',
    '<leader>s/',
    function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end,
    { desc = '[S]earch [/] in Open Files' }
  )

  -- Shortcut for searching your Neovim configuration files
  vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end, { desc = '[S]earch [N]eovim files' })
end

-- Farben passend zu Solarized:
vim.api.nvim_set_hl(0, 'HlSearchNear', { fg = '#002b36', bg = '#859900', bold = true })
vim.api.nvim_set_hl(0, 'HlSearchLens', { fg = '#586e75', bg = 'none' })
vim.api.nvim_set_hl(0, 'HlSearchLensNear', { fg = '#93a1a1', bg = 'none', bold = true })

-- ============================================================
-- SECTION 5: LSP
-- LSP keymaps, server configuration, Mason tools installations
-- ============================================================
do
  -- [[ LSP Configuration ]]
  -- Brief aside: **What is LSP?**
  --
  -- LSP is an initialism you've probably heard, but might not understand what it is.
  --
  -- LSP stands for Language Server Protocol. It's a protocol that helps editors
  -- and language tooling communicate in a standardized fashion.
  --
  -- In general, you have a "server" which is some tool built to understand a particular
  -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
  -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
  -- processes that communicate with some "client" - in this case, Neovim!
  --
  -- LSP provides Neovim with features like:
  --  - Go to definition
  --  - Find references
  --  - Autocompletion
  --  - Symbol Search
  --  - and more!
  --
  -- Thus, Language Servers are external tools that must be installed separately from
  -- Neovim. This is where `mason` and related plugins come into play.
  --
  -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
  -- and elegantly composed help section, `:help lsp-vs-treesitter`

  -- Useful status updates for LSP.
  vim.pack.add { gh 'j-hui/fidget.nvim' }
  require('fidget').setup {}

  --  This function gets run when an LSP attaches to a particular buffer.
  --    That is to say, every time a new file is opened that is associated with
  --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
  --    function will be executed to configure the current buffer
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
      -- NOTE: Remember that Lua is a real programming language, and as such it is possible
      -- to define small helper and utility functions so you don't have to repeat yourself.
      --
      -- In this case, we create a function that lets us more easily define mappings specific
      -- for LSP related items. It sets the mode, buffer and description for us each time.
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      -- Rename the variable under your cursor.
      --  Most Language Servers support renaming across files, etc.
      map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

      -- Execute a code action, usually your cursor needs to be on top of an error
      -- or a suggestion from your LSP for this to activate.
      map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

      -- WARN: This is not Goto Definition, this is Goto Declaration.
      --  For example, in C this would take you to the header.
      map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

      -- The following two autocommands are used to highlight references of the
      -- word under your cursor when your cursor rests there for a little while.
      --    See `:help CursorHold` for information about when this is executed
      --
      -- When you move your cursor, the highlights will be cleared (the second autocommand).
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client:supports_method('textDocument/documentHighlight', event.buf) then
        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
          end,
        })
      end

      -- The following code creates a keymap to toggle inlay hints in your
      -- code, if the language server you are using supports them
      --
      -- This may be unwanted, since they displace some of your code
      if client and client:supports_method('textDocument/inlayHint', event.buf) then
        map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
      end
    end,
  })

  -- Enable the following language servers
  --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
  --  See `:help lsp-config` for information about keys and how to configure
  ---@type table<string, vim.lsp.Config>
  local servers = {
    -- clangd = {},
    -- gopls = {},
    -- pyright = {},
    -- rust_analyzer = {},
    --
    -- Some languages (like typescript) have entire language plugins that can be useful:
    --    https://github.com/pmizio/typescript-tools.nvim
    --
    -- But for many setups, the LSP (`ts_ls`) will work just fine
    -- ts_ls = {},

    stylua = {}, -- Used to format Lua code

    -- Special Lua Config, as recommended by neovim help docs
    lua_ls = {
      on_init = function(client)
        client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            version = 'LuaJIT',
            path = { 'lua/?.lua', 'lua/?/init.lua' },
          },
          workspace = {
            checkThirdParty = false,
            -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
            --  See https://github.com/neovim/nvim-lspconfig/issues/3189
            library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
              '${3rd}/luv/library',
              '${3rd}/busted/library',
            }),
          },
        })
      end,
      ---@type lspconfig.settings.lua_ls
      settings = {
        Lua = {
          format = { enable = false }, -- Disable formatting (formatting is done by stylua)
        },
      },
    },
  }

  vim.pack.add {
    gh 'neovim/nvim-lspconfig',
    gh 'mason-org/mason.nvim',
    gh 'mason-org/mason-lspconfig.nvim',
    gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  }

  -- Automatically install LSPs and related tools to stdpath for Neovim
  require('mason').setup {}

  -- Ensure the servers and tools above are installed
  --
  -- To check the current status of installed tools and/or manually install
  -- other tools, you can run
  --    :Mason
  --
  -- You can press `g?` for help in this menu.
  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {
    -- You can add other tools here that you want Mason to install
  })

  require('mason-tool-installer').setup { ensure_installed = ensure_installed }

  for name, server in pairs(servers) do
    vim.lsp.config(name, server)
    vim.lsp.enable(name)
  end
end

-- ============================================================
-- SECTION 6: FORMATTING
-- conform.nvim setup and keymap
-- ============================================================
do
  -- [[ Formatting ]]
  vim.pack.add { gh 'stevearc/conform.nvim' }
  require('conform').setup {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- You can specify filetypes to autoformat on save here:
      local enabled_filetypes = {
        -- lua = true,
        -- python = true,
      }
      if enabled_filetypes[vim.bo[bufnr].filetype] then
        return { timeout_ms = 500 }
      else
        return nil
      end
    end,
    default_format_opts = {
      lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
    },
    -- You can also specify external formatters in here.
    formatters_by_ft = {
      -- rust = { 'rustfmt' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  }

  vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = 'Format buffer' })
end

-- ============================================================
-- SECTION 7: AUTOCOMPLETE & SNIPPETS
-- blink.cmp and luasnip setup
-- ============================================================
do
  -- [[ Snippet Engine ]]

  -- NOTE: You can also specify plugin using a version range for its git tag.
  --  See `:help vim.version.range()` for more info
  vim.pack.add { { src = gh 'L3MON4D3/LuaSnip', version = vim.version.range '2.*' } }
  require('luasnip').setup {}

  -- `friendly-snippets` contains a variety of premade snippets.
  --    See the README about individual language/framework/plugin snippets:
  --    https://github.com/rafamadriz/friendly-snippets
  --
  -- vim.pack.add { gh 'rafamadriz/friendly-snippets' }
  -- require('luasnip.loaders.from_vscode').lazy_load()

  -- [[ Autocomplete Engine ]]
  vim.pack.add { { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' } }
  require('blink.cmp').setup {
    keymap = {
      -- 'default' (recommended) for mappings similar to built-in completions
      --   <c-y> to accept ([y]es) the completion.
      --    This will auto-import if your LSP supports it.
      --    This will expand snippets if the LSP sent a snippet.
      -- 'super-tab' for tab to accept
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- For an understanding of why the 'default' preset is recommended,
      -- you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      --
      -- All presets have the following mappings:
      -- <tab>/<s-tab>: move to right/left of your snippet expansion
      -- <c-space>: Open menu or open docs if already open
      -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
      -- <c-e>: Hide menu
      -- <c-k>: Toggle signature help
      --
      -- See `:help blink-cmp-config-keymap` for defining your own keymap
      preset = 'default',

      -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
      --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    completion = {
      -- By default, you may press `<c-space>` to show the documentation.
      -- Optionally, set `auto_show = true` to show the documentation after a delay.
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets' },
    },

    snippets = { preset = 'luasnip' },

    -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
    -- which automatically downloads a prebuilt binary when enabled.
    --
    -- By default, we use the Lua implementation instead, but you may enable
    -- the rust implementation via `'prefer_rust_with_warning'`
    --
    -- See `:help blink-cmp-config-fuzzy` for more information
    fuzzy = { implementation = 'lua' },

    -- Shows a signature help window while you type arguments for a function
    signature = { enabled = true },
  }
end

-- ============================================================
-- SECTION 8: TREESITTER
-- Parser installation, syntax highlighting, folds, indentation
-- ============================================================
do
  -- [[ Configure Treesitter ]]
  --  Used to highlight, edit, and navigate code
  --
  --  See `:help nvim-treesitter-intro`

  -- NOTE: You can also specify a branch or a specific commit
  vim.pack.add { { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' } }

  -- Ensure basic parsers are installed
  local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
  require('nvim-treesitter').install(parsers)

  ---@param buf integer
  ---@param language string
  local function treesitter_try_attach(buf, language)
    -- Check if a parser exists and load it
    if not vim.treesitter.language.add(language) then return end
    -- Enable syntax highlighting and other treesitter features
    vim.treesitter.start(buf, language)

    -- Enable treesitter based folds
    -- For more info on folds see `:help folds`
    -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    -- vim.wo.foldmethod = 'expr'

    -- Check if treesitter indentation is available for this language, and if so enable it
    -- in case there is no indent query, the indentexpr will fallback to the vim's built in one
    local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

    -- Enable treesitter based indentation
    if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
  end

  local available_parsers = require('nvim-treesitter').get_available()
  vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
      local buf, filetype = args.buf, args.match

      local language = vim.treesitter.language.get_lang(filetype)
      if not language then return end

      local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

      if vim.tbl_contains(installed_parsers, language) then
        -- Enable the parser if it is already installed
        treesitter_try_attach(buf, language)
      elseif vim.tbl_contains(available_parsers, language) then
        -- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
        require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
      else
        -- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
        treesitter_try_attach(buf, language)
      end
    end,
  })
end

-- ============================================================
-- SECTION 9: OPTIONAL EXAMPLES / NEXT STEPS
-- kickstart.plugins.* examples
-- ============================================================
do
  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug'
  -- require 'kickstart.plugins.indent_line'
  -- require 'kickstart.plugins.lint'
  -- require 'kickstart.plugins.autopairs'
  -- require 'kickstart.plugins.neo-tree'

  -- NOTE: You can add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  -- require 'custom.plugins'
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

-- Brighter white text:
vim.api.nvim_set_hl(0, 'Normal', { ctermfg = 252, fg = '#d0d0d0' })
vim.api.nvim_set_hl(0, 'Comment', { ctermfg = 252, fg = '#bfbfbf' })

-- more subtle colours for LSP highlighting:
vim.api.nvim_set_hl(0, 'LspReferenceText', { bg = '#073642' })
vim.api.nvim_set_hl(0, 'LspReferenceRead', { bg = '#073642' })
vim.api.nvim_set_hl(0, 'LspReferenceWrite', { bg = '#073642', bold = true })

-- Show a cyan line for vertically splitted windows
--vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#2aa198', bg = 'none' })

-- Winbar style:
-- mit grünem Akzent passend zu deinen Telescope-Borders
vim.api.nvim_set_hl(0, 'WinBar', { bg = '#073642', fg = '#859900' })
vim.api.nvim_set_hl(0, 'WinBarNC', { bg = '#073642', fg = '#93a1a1' })

-- old vimrc file (to be optimized):
-- ============================================================================
-- KEY MAPPINGS
-- ============================================================================

-- --- Mode switching ---------------------------------------------------------
vim.keymap.set('i', 'jj', '<esc>l')
vim.keymap.set('i', 'jk', '<esc>l')
vim.keymap.set('i', 'kk', '<esc>l')
vim.keymap.set('i', 'kj', '<esc>l')
--vim.keymap.set('i', 'kj', '<esc>l') --disabled - exit via <escape> only
--vim.keymap.set('v', 'jk', '<esc>')
--vim.keymap.set('v', 'kj', '<esc>')
vim.keymap.set('c', 'jj', '<c-c>')
vim.keymap.set('c', 'jk', '<c-c>')
vim.keymap.set('c', 'kj', '<c-c>')
vim.keymap.set('c', 'kk', '<c-c>')

vim.keymap.set('n', '<space>', ':')
vim.keymap.set('v', '<space>', ':')

-- --- Navigation -------------------------------------------------------------
vim.keymap.set('n', 'ß', '?')
vim.keymap.set('n', 'ü', '/')
vim.keymap.set('n', '9', '$')
vim.keymap.set('v', '9', '$')
-- Neue Zeile ohne Insert-Mode
vim.keymap.set('n', 'o', 'o<esc>')
vim.keymap.set('n', 'O', 'O<esc>')

-- --- Paste behavior ---------------------------------------------------------
vim.keymap.set('n', 'p', 'P')
vim.keymap.set('n', 'P', 'p')
vim.keymap.set('v', '<c-c>', '"+y')
vim.keymap.set('', '<c-p>', '"+P')

-- --- Command history --------------------------------------------------------
vim.keymap.set('n', '<leader>j', 'Show last command (:<c-up>)')
vim.keymap.set('n', 'q<space>', 'q:')
vim.keymap.set('n', 'q7', 'q/')

-- --- Quit -------------------------------------------------------------------
vim.keymap.set('n', '<leader>q1', ':q!<cr>')

-- ============================================================================
-- TEXT OBJECT SHORTCUTS
-- ============================================================================
vim.keymap.set('n', 'Y', 'y$')

for _, obj in ipairs { { '8', '(' }, { '7', '{' }, { '9', '[' }, { '2', '"' } } do
  vim.keymap.set('o', 'i' .. obj[1], 'i' .. obj[2])
  vim.keymap.set('o', 'a' .. obj[1], 'a' .. obj[2])
end

-- ============================================================================
-- WINDOW MANAGEMENT
-- ============================================================================
vim.keymap.set('n', '<c-h>', '<c-w>h')
vim.keymap.set('n', '<c-j>', '<c-w>j')
vim.keymap.set('n', '<c-k>', '<c-w>k')
vim.keymap.set('n', '<c-l>', '<c-w>l')
vim.keymap.set('n', '<c-up>', '<c-w>+')
vim.keymap.set('n', '<c-down>', '<c-w>-')
vim.keymap.set('n', '<c-left>', '<c-w>>')
vim.keymap.set('n', '<c-right>', '<c-w><')

-- TODO: add shortcuts for window/buffer resizing
--
--
-- =========
-- noch nicht in init.lua vorhanden:

-- History & Encoding
vim.opt.history = 1000

-- Search
-- vim.opt.hlsearch = true
-- vim.opt.showmatch = true
-- vim.opt.incsearch = true  -- evtl. schon durch inccommand abgedeckt

-- Editing
vim.opt.wrap = false
vim.opt.whichwrap = 'b,s,h,l,<,>,[,]'

-- Wildmenu / Completion
vim.opt.wildmode = 'list:longest'
vim.opt.wildignore = '*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx'

-- Visual selection highlight
vim.api.nvim_set_hl(0, 'Visual', { bg = '#b58900', fg = '#002b36' })

-- Transparent backgrounds (zusätzliche Gruppen)
vim.api.nvim_set_hl(0, 'NonText', { bg = 'none' })
vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none' })
vim.api.nvim_set_hl(0, 'LineNr', { bg = 'none' })
vim.api.nvim_set_hl(0, 'FoldColumn', { bg = 'none' })

-- Statusline besser sichtbar machen
vim.api.nvim_set_hl(0, 'MiniStatuslineModeNormal', { bg = '#268bd2', fg = '#002b36', bold = true })
vim.api.nvim_set_hl(0, 'MiniStatuslineModeInsert', { bg = '#2aa198', fg = '#002b36', bold = true })
vim.api.nvim_set_hl(0, 'MiniStatuslineModeVisual', { bg = '#d33682', fg = '#002b36', bold = true })
vim.api.nvim_set_hl(0, 'MiniStatuslineModeCommand', { bg = '#b58900', fg = '#002b36', bold = true })
vim.api.nvim_set_hl(0, 'MiniStatuslineModeOther', { bg = '#859900', fg = '#002b36', bold = true })
vim.api.nvim_set_hl(0, 'MiniStatuslineFilename', { bg = '#073642', fg = '#93a1a1' })
vim.api.nvim_set_hl(0, 'MiniStatuslineFileinfo', { bg = '#073642', fg = '#93a1a1' })
vim.api.nvim_set_hl(0, 'MiniStatuslineInactive', { bg = '#073642', fg = '#586e75' })

-- plugin for cursor animation:
vim.pack.add { gh 'sphamba/smear-cursor.nvim' }
require('smear_cursor').setup()
-- animationen konfigurieren!

-- ─── clever-f Plugin Konfiguration ───────────────────────────────────────
vim.pack.add {
  'https://github.com/rhysd/clever-f.vim',
}
-- Suche über Zeilenenden hinaus (zeilenübergreifend)
vim.g.clever_f_across_no_line = 0
-- Smart case: Großbuchstabe → case-sensitiv, sonst nicht
vim.g.clever_f_smart_case = 1
-- ; matcht beliebige Sonderzeichen
vim.g.clever_f_chars_match_any_signs = ';'
-- Zielzeichen in der aktuellen Zeile highlighten
vim.g.clever_f_mark_char = 1
-- Highlight-Farbe: Solarized Orange (passt zu NeoSolarized)
vim.g.clever_f_mark_char_color = 'CleverFSolarized'
vim.api.nvim_set_hl(0, 'CleverFSolarized', {
  fg = '#cb4b16', -- solarized orange
  bold = true,
  underline = true,
})
-- f immer vorwärts, F immer rückwärts (richtungsunabhängig)
--vim.g.clever_f_fix_key_direction = 1
-- Nach 2 Sek. Inaktivität Zustand zurücksetzen
vim.g.clever_f_timeout_ms = 2000
-- Highlight bleibt 2 Sek. nach dem Sprung sichtbar
vim.g.clever_f_highlight_timeout_ms = 2000

-- ─── neoscroll Plugin Konfiguration ──────────────────────────────────────
vim.pack.add {
  'https://github.com/karb94/neoscroll.nvim',
}

local neoscroll = require 'neoscroll'

neoscroll.setup {
  mappings = {}, -- eigene Mappings unten, keine defaults
  hide_cursor = true, -- Cursor während Scroll verstecken
  stop_eof = true, -- nicht über Dateiende hinausscrollen
  respect_scrolloff = true, -- scrolloff-Margin respektieren
  duration_multiplier = 1.0,
  easing = 'sine',
  pre_hook = function() require('smear_cursor').enabled = false end,
  post_hook = function() require('smear_cursor').enabled = true end,
}

local modes = { 'n', 'v', 'x' }
local keymap = {
  -- halbes Fenster: schnell, sine-Easing (maybe try "quadratic" as well)
  ['<C-u>'] = function() neoscroll.ctrl_u { duration = 200, easing = 'sine' } end,
  ['<C-d>'] = function() neoscroll.ctrl_d { duration = 200, easing = 'sine' } end,
  -- ganzes Fenster: etwas langsamer, circular für weiches Abbremsen
  ['<C-b>'] = function() neoscroll.ctrl_b { duration = 350, easing = 'circular' } end,
  ['<C-f>'] = function() neoscroll.ctrl_f { duration = 350, easing = 'circular' } end,
  -- zeilenweises Scrollen ohne Cursor
  ['<C-y>'] = function() neoscroll.scroll(-2, { move_cursor = false, duration = 80 }) end,
  ['<C-e>'] = function() neoscroll.scroll(2, { move_cursor = false, duration = 80 }) end,
  -- Rezentrierung
  ['zt'] = function() neoscroll.zt { half_win_duration = 250 } end,
  ['zz'] = function() neoscroll.zz { half_win_duration = 250 } end,
  ['zb'] = function() neoscroll.zb { half_win_duration = 250 } end,
}
for key, func in pairs(keymap) do
  vim.keymap.set(modes, key, func)
end

-- ─── fun plugin cellular-automaton ───────────────────────────────────────────
vim.pack.add {
  'https://github.com/Eandrju/cellular-automaton.nvim',
}

vim.keymap.set('n', '<leader>gr', '<cmd>CellularAutomaton make_it_rain<CR>', { desc = 'Make it Rain' })
vim.keymap.set('n', '<leader>gg', '<cmd>CellularAutomaton game_of_life<CR>', { desc = 'Game of Life' })
