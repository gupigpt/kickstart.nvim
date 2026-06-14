--[[
  TODO: Read the Lua guide (10-15 minutes): https://learnxinyminutes.com/docs/lua/
  Use `:help lua-guide` as a reference for how Neovim integrates Lua:
  See `:help vim.o`
  :help lua-guide or HTML version: https://neovim.io/doc/user/lua-guide.html
  The very first thing you should do is to run the command `:Tutor` in Neovim.
  Read `:help 'list'` and `:help 'listchars'`
  Read `:help lua-options` and `:help lua-guide-options`
--]]

-- ============================================================
--- SECTION 1: GLOBAL SETTINGS & LEADERS
-- ============================================================

-- Enable fast startup by caching compiled Lua modules
vim.loader.enable()

-- Append custom runtime path for Treesitter parsers
vim.opt.runtimepath:append '~/.local/share/nvim/site'

-- Set leader keys (MUST be defined before any plugins are loaded)
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Flag to signal that a Nerd Font is available in the terminal emulator
vim.g.have_nerd_font = true

-- =============================================================================
-- SECTION 2: EDITOR OPTIONS
-- =============================================================================

vim.o.number = true -- Show absolute line number of the current line
vim.o.relativenumber = true -- Show relative line numbers for easier jumping
vim.o.mouse = 'a' -- Enable mouse support in all modes (Normal, Insert, etc.)
vim.o.showmode = false -- Hide mode display (e.g. -- INSERT --) since statusline shows it

-- Sync clipboard between OS and Neovim asynchronously after UI loads to prevent sluggish startup
-- See `:help 'clipboard'`
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

vim.o.breakindent = true -- Wrapped lines keep the same indent level as the original line
vim.o.undofile = true -- Persistent undo: saves undo history to a file across sessions
vim.o.ignorecase = true -- Case-insensitive searching...
vim.o.smartcase = true -- ...UNLESS the search query contains an uppercase letter
vim.o.signcolumn = 'yes' -- Always show the sign column (left gutter) to prevent UI jitter
vim.o.updatetime = 250 -- Time (ms) of cursor inactivity before triggers like CursorHold
vim.o.timeoutlen = 300 -- Time (ms) to wait for a mapped sequence (like leader combos) to complete
vim.o.splitright = true -- Open new vertical splits to the right of the current window
vim.o.splitbelow = true -- Open new horizontal splits below the current window

-- Whitespace visualization
vim.o.list = true -- Enable rendering of invisible whitespace characters
-- 'vim.opt' is used here because it handles table configurations better than 'vim.o'
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' } -- Define characters for tabs and trailing spaces

vim.o.inccommand = 'split' -- Show live preview of substitution (:s/old/new) in a split window
vim.o.cursorline = true -- Highlight the screen line containing the cursor
vim.o.scrolloff = 5 -- Minimum number of screen lines to keep above/below the cursor
vim.o.confirm = true -- Raise a confirmation dialog instead of failing on unsaved changes

vim.opt.history = 10000 -- Max number of colon commands and search patterns to remember
vim.opt.wrap = true -- Wrap long lines visually instead of letting them run off-screen

-- Allow navigation keys to cross line boundaries to the previous/next line
vim.opt.whichwrap = 'b,s,h,l,<,>,[,]'

-- Command-line completion behavior: list matches, match longest common prefix
vim.opt.wildmode = 'list:longest'

-- Ignore specific binary, compressed, or bloated files in command-line completion
vim.opt.wildignore = '*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx'

-- Window & Global Statusline Layout
vim.o.winbar = ' %F %m' -- Show absolute path and modified status at the top of each window
vim.o.laststatus = 3 -- Use a single global statusline at the very bottom of the editor

-- =============================================================================
-- SECTION 3: GLOBAL KEYMAPS
-- =============================================================================

-- Clear search highlights by pressing <Esc> in Normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })

-- Remap space to open the command line (since comma ',' is the leader key)
vim.keymap.set({ 'n', 'v' }, '<space>', ':', { desc = 'Open command line' })

-- German layout search improvements (ß -> backward search, ü -> forward search)
vim.keymap.set('n', 'ß', '?', { desc = 'Search backward' })
vim.keymap.set('n', 'ü', '/', { desc = 'Search forward' })

-- Easier access to end-of-line by pressing '9' instead of '$'
vim.keymap.set({ 'n', 'v' }, '9', '$', { desc = 'Move to end of line' })

-- Reload the current file instantly discarding unsaved changes
vim.keymap.set('n', '<leader>r', '<cmd>e!<CR>', { desc = 'Reload file (discard unsaved changes!)' })

-- Exit Terminal mode using a double Escape sequence
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window Navigation: Move between splits using Ctrl + h/j/k/l
-- NOTE See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Window Resizing: Adjust split sizes using Ctrl + Arrow keys
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<CR>', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<CR>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Increase window width' })

-- Move windows around
vim.keymap.set('n', '<C-S-h>', '<C-w>H', { desc = 'Window: Move window to the far left' })
vim.keymap.set('n', '<C-S-j>', '<C-w>J', { desc = 'Window: Move window to the very bottom' })
vim.keymap.set('n', '<C-S-k>', '<C-w>K', { desc = 'Window: Move window to the very top' })
vim.keymap.set('n', '<C-S-l>', '<C-w>L', { desc = 'Window: Move window to the far right' })

-- Insert new lines without entering Insert mode
vim.keymap.set('n', 'o', 'o<esc>', { desc = 'Insert newline below' })
vim.keymap.set('n', 'O', 'O<esc>', { desc = 'Insert newline above' })

-- Invert the paste behavior
--vim.keymap.set('n', 'p', 'P')
--vim.keymap.set('n', 'P', 'p')

-- Clipboard mappings
vim.keymap.set('v', '<c-c>', '"+y', { desc = 'Copy selection to system clipboard' })
vim.keymap.set('', '<c-p>', '"+P', { desc = 'Paste from system clipboard' })

-- Command and search history
vim.keymap.set('n', '<leader>j', ':<C-up>', { desc = 'Show last command' })
vim.keymap.set('n', 'q<space>', 'q:', { desc = 'Open command history window' })
vim.keymap.set('n', 'q7', 'q/', { desc = 'Open search history window' })

-- Yank from cursor to end of line with Y
vim.keymap.set('n', 'Y', 'y$', { desc = 'Yank to end of line' })

-- Dynamic text object maps for German layout (maps numbers 8, 7, 9, 2 to brackets/quotes)
--   'di8' becomes 'di('  -> Delete Inside Parentheses
--   'ca7' becomes 'ca{'  -> Change Around Curly Braces
--   'yi9' becomes 'yi['  -> Yank Inside Square Brackets
--   'di2' becomes 'di"'  -> Delete Inside Double Quotes
for _, obj in ipairs { { '8', '(' }, { '7', '{' }, { '9', '[' }, { '2', '"' } } do
  vim.keymap.set('o', 'i' .. obj[1], 'i' .. obj[2], { desc = 'Inner ' .. obj[2] })
  vim.keymap.set('o', 'a' .. obj[1], 'a' .. obj[2], { desc = 'Around ' .. obj[2] })
end

-- =============================================================================
-- SECTION 4: DIAGNOSTICS & BASIC AUTOCOMMANDS
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 4.1 Mode Switching (Fast Escape)
-- -----------------------------------------------------------------------------

-- Fast Escape loop for Insert and Command modes
for _, key in ipairs { 'jj', 'jk', 'kj', 'kk' } do
  -- Exit Insert mode and move cursor right to keep position intact
  vim.keymap.set('i', key, '<esc>l', { desc = 'Fast Escape to Normal mode' })

  -- Cancel active Command-line entry safely
  vim.keymap.set('c', key, '<c-c>', { desc = 'Cancel command' })
end

-- -----------------------------------------------------------------------------
-- 4.2 Diagnostic Configuration
-- -----------------------------------------------------------------------------

-- Core configuration for how Neovim manages and displays LSP diagnostics
-- See `:help vim.diagnostic.Opts`
vim.diagnostic.config {
  update_in_insert = false, -- Do not update diagnostics while typing in Insert mode
  severity_sort = true, -- Sort messages by severity (Errors first, then Warnings, etc.)

  -- Floating window settings for diagnostic details
  float = {
    border = 'rounded', -- Use smooth, rounded borders for the floating window
    source = 'if_many', -- Show the source (e.g., 'lua_ls') if there are multiple diagnostics
    header = 'Diagnostics', -- Header title for the floating window
    prefix = ' ', -- Small padding/prefix before each diagnostic message
  },

  -- Set minimum severity level required for underlining code
  underline = {
    severity = { min = vim.diagnostic.severity.WARN },
  },

  -- Inline diagnostic text display toggles
  virtual_text = true, -- Show diagnostic text inline at the end of the line
  virtual_lines = false, -- Do not display diagnostics as virtual lines under the code

  -- Automatically trigger a floating window when jumping between diagnostics
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

-- -----------------------------------------------------------------------------
-- 4.3 Diagnostic Keymaps
-- -----------------------------------------------------------------------------

-- Manual triggers for diagnostic list and details
vim.keymap.set('n', '<leader>dd', vim.diagnostic.setloclist, { desc = 'Open diagnostic list' })
vim.keymap.set('n', '<leader>dc', function() vim.diagnostic.open_float { scope = 'cursor', focus = false } end, { desc = 'Show current diagnostic' })

-- Navigation: Jump to next/previous diagnostics and automatically open the details float
vim.keymap.set('n', '<leader>dn', function()
  vim.diagnostic.jump { count = 1 }
  vim.diagnostic.open_float { scope = 'cursor', focus = false }
end, { desc = 'Go to next diagnostic' })

vim.keymap.set('n', '<leader>dp', function()
  vim.diagnostic.jump { count = -1 }
  vim.diagnostic.open_float { scope = 'cursor', focus = false }
end, { desc = 'Go to previous diagnostic' })

-- -----------------------------------------------------------------------------
-- 4.4 Basic Autocommands
-- -----------------------------------------------------------------------------

-- Highlight text temporarily after it has been yanked (copied)
-- See `:help vim.hl.on_yank()`
-- Deactivate because of tiny-glimmer plugin (see bottom of file)
--vim.api.nvim_create_autocmd('TextYankPost', {
--desc = 'Highlight yanked text briefly',
--group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
--callback = function() vim.hl.on_yank() end,
--})

-- Automatically open the floating diagnostic window when holding the cursor still on an error
-- Change to open via command only?
vim.api.nvim_create_autocmd('CursorHold', {
  desc = 'Show diagnostic float on cursor hold',
  group = vim.api.nvim_create_augroup('kickstart-diagnostic-hover', { clear = true }),
  callback = function() vim.diagnostic.open_float { scope = 'cursor', focus = false } end,
})

-- =============================================================================
-- SECTION 5: PLUGIN MANAGER INTRO & BUILD HOOKS
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 5.1 Introduction to vim.pack
-- -----------------------------------------------------------------------------

-- Neovim's built-in plugin manager (`vim.pack`) handles downloading,
-- updating, and loading plugins via a pure Lua interface.
--
-- Useful Commands:
--   :lua vim.pack.update(nil, { offline = true })  -> Check plugin status/pending updates
--   :lua vim.pack.update()                         -> Fetch and install updates
--
-- Documentation:
--   - `:help vim.pack`
--   - `:help vim.pack-examples`
--   - Blog: https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack

-- -----------------------------------------------------------------------------
-- 5.2 Automated Plugin Build Hooks
-- -----------------------------------------------------------------------------

--- Helper function to execute external build compilation processes asynchronously
--- @param name string The name of the plugin being built
--- @param cmd string[] The command and arguments to execute
--- @param cwd string The working directory for the build process
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

-- Automatically trigger post-install and post-update compilation hooks
-- See `:help vim.pack-events`
vim.api.nvim_create_autocmd('PackChanged', {
  desc = 'Run compilation and build hooks after plugin installation or updates',
  group = vim.api.nvim_create_augroup('kickstart-pack-build', { clear = true }),
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind

    -- Only run hooks for fresh installations or updates
    if kind ~= 'install' and kind ~= 'update' then return end

    -- Compile fzf native library if 'make' is available
    if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
      run_build(name, { 'make' }, ev.data.path)
      return
    end

    -- Compile LuaSnip jsregexp library on non-Windows platforms
    if name == 'LuaSnip' then
      if vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1 then run_build(name, { 'make', 'install_jsregexp' }, ev.data.path) end
      return
    end

    -- Automatically update Treesitter grammar parsers
    if name == 'nvim-treesitter' then
      if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
      vim.cmd 'TSUpdate'
      return
    end
  end,
})

-- -----------------------------------------------------------------------------
-- 5.3 Repository URL Helper
-- -----------------------------------------------------------------------------

--- Shortens GitHub repository declarations to reduce repetition
--- @param repo string The "username/repository" path
--- @return string Full GitHub URL
local function gh(repo) return 'https://github.com/' .. repo end

-- =============================================================================
-- SECTION 6: UI & CORE UX PLUGINS
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 6.1 Indentation & Icons
-- -----------------------------------------------------------------------------

-- Automatically detect and adjust indentation settings based on opened files
vim.pack.add { gh 'NMAC427/guess-indent.nvim' }
require('guess-indent').setup {}

-- Load icon support only if a Nerd Font is available in the terminal
if vim.g.have_nerd_font then vim.pack.add { gh 'nvim-tree/nvim-web-devicons' } end

-- -----------------------------------------------------------------------------
-- 6.2 Git Integration (Gitsigns & Diffview)
-- gitsigns.nvim  : inline hunk signs, blame, word diff
-- diffview.nvim  : full-screen diff viewer, file history, merge conflicts
-- -----------------------------------------------------------------------------

vim.pack.add { gh 'lewis6991/gitsigns.nvim' }
vim.pack.add { gh 'dlyongemallo/diffview-plus.nvim' }

--- Helper: Detect whether the repository uses 'main' or 'master' as its default branch
local function default_branch()
  local res = vim.system({ 'git', 'rev-parse', '--verify', 'main' }, { capture_output = true }):wait()
  return res.code == 0 and 'main' or 'master'
end

--- Helper: Open DiffviewOpen with a free-text revision prompt
-- Common inputs:
--   HEAD          → diff of the latest commit vs. working tree
--   HEAD~3        → diff of the last 3 commits combined
--   main..HEAD    → all changes on your feature branch vs. main
--   <commit hash> → diff of a specific commit
--   (empty)       → working tree vs. index (same as :DiffviewOpen with no args)
local function diff_open_prompt()
  local input = vim.fn.input 'DiffviewOpen: '
  vim.cmd('DiffviewOpen ' .. input)
end

--- Helper: Open DiffviewFileHistory with a free-text path/flag prompt
-- Common inputs:
--   %             → commit history of the current file
--   .             → commit history of the entire repo (all files)
--   src/foo.lua   → commit history of a specific file by path
--   (empty)       → same as "." – full repo history
local function diff_history_prompt()
  local input = vim.fn.input 'DiffviewFileHistory: '
  vim.cmd('DiffviewFileHistory ' .. input)
end

-- Gitsigns configuration for inline hunk actions and blame indicators
require('gitsigns').setup {
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 800,
    virt_text_pos = 'right_align',
  },
  current_line_blame_formatter = '  <author>, <author_time:%d/%m/%Y> · <summary>',
  signs = {
    add = { text = '+' }, ---@diagnostic disable-line: missing-fields
    change = { text = '~' }, ---@diagnostic disable-line: missing-fields
    delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
    topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
    changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    -- Hunk navigation (matching cursor movement directions)
    vim.keymap.set('n', '<leader>gj', gs.next_hunk, { buffer = bufnr, desc = 'Go to next hunk' })
    vim.keymap.set('n', '<leader>gk', gs.prev_hunk, { buffer = bufnr, desc = 'Go to prev hunk' })

    -- Hunk staging & resetting
    vim.keymap.set('n', '<leader>gs', gs.stage_hunk, { buffer = bufnr, desc = 'Stage hunk' })
    vim.keymap.set('n', '<leader>gr', gs.reset_hunk, { buffer = bufnr, desc = 'Reset hunk (delete)' })
    vim.keymap.set('n', '<leader>gu', gs.undo_stage_hunk, { buffer = bufnr, desc = 'Unstage hunk' })
    vim.keymap.set('v', '<leader>gs', function() gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { buffer = bufnr, desc = 'Stage selected lines' })

    -- Hunk inspection & blame popups
    vim.keymap.set('n', '<leader>gp', gs.preview_hunk, { buffer = bufnr, desc = 'Preview hunk under cursor' })
    vim.keymap.set('n', '<leader>gb', gs.blame_line, { buffer = bufnr, desc = 'Show line blame (popup)' })

    -- Inline diff toggles (visualize changes without leaving the buffer)
    -- Highlight changed words within a line (more granular than line-level diff)
    vim.keymap.set('n', '<leader>gw', gs.toggle_word_diff, { buffer = bufnr, desc = 'Toggle word-level diff' })

    -- Show deleted lines as virtual text below their original position
    -- Useful to see exactly what was removed without opening a full diff view
    vim.keymap.set('n', '<leader>gx', gs.toggle_deleted, { buffer = bufnr, desc = 'Toggle deleted lines' })
  end,
}

-- Comprehensive Diffview setup for advanced revision browsing
require('diffview').setup {
  enhanced_diff_hl = true,
  view = {
    default = {
      layout = 'diff2_horizontal',
      winbar_info = true, -- show branch/commit info in the winbar
    },
    -- 3-way layout for merge conflicts: LOCAL | BASE | REMOTE
    merge_tool = {
      layout = 'diff3_mixed',
      disable_diagnostics = true, -- reduce noise during conflict resolution
    },
  },
}

-- Global Diffview Mappings
vim.keymap.set('n', '<leader>go', '<cmd>DiffviewOpen<cr>', { desc = "Open file's staged/unstaged diff" })
vim.keymap.set('n', '<leader>gq', '<cmd>DiffviewClose<cr>', { desc = 'Close diff view' })
-- Prompt-based open: lets you type any revision expression freely
-- Examples: HEAD, HEAD~3, main..HEAD, <hash>
vim.keymap.set('n', '<leader>gi', diff_open_prompt, { desc = 'Compare revision (prompt)' })
-- File history: prompt-based, type a path or "%" or "."
vim.keymap.set('n', '<leader>gh', diff_history_prompt, { desc = 'Browse history (prompt)' })
vim.keymap.set('n', '<leader>gf', '<cmd>DiffviewFileHistory --follow %<cr>', { desc = "Browse current file's diff history" })
vim.keymap.set('n', '<leader>gF', '<cmd>DiffviewFileHistory .<cr>', { desc = 'Browse repo diff history' })
vim.keymap.set('n', '<leader>gl', '<cmd>.DiffviewFileHistory --follow<cr>', { desc = "Browse current line's diff history" })
vim.keymap.set('v', '<leader>gl', "<Esc><Cmd>'<,'>DiffviewFileHistory --follow<CR>", { desc = "Browse selection's diff history" })
vim.keymap.set('n', '<leader>gm', function() vim.cmd('DiffviewOpen ' .. default_branch()) end, { desc = 'Compare this branch with local master' })
vim.keymap.set('n', '<leader>gM', function() vim.cmd('DiffviewOpen HEAD..origin/' .. default_branch()) end, { desc = 'Compare this branch with origin/master' })

-- Clipboard Diff Engine & User Commands
-- Compare the current buffer (or a visual selection) against clipboard contents.
-- Useful for: comparing AI output, a copied snippet, or any external text.
vim.api.nvim_create_user_command('Ns', function() -- :Ns creates a temporary scratch buffer (no saved file)
  vim.cmd [[
    execute 'vsplit | enew'
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
  ]]
end, { nargs = 0 })

-- :CompareClipboard opens the current file and clipboard side-by-side in diff mode
vim.api.nvim_create_user_command('CompareClipboard', function()
  local ftype = vim.api.nvim_eval '&filetype'
  vim.cmd [[
    tabnew %
    Ns
    normal! P
    windo diffthis
  ]]
  vim.cmd('set filetype=' .. ftype)
end, { nargs = 0 })

vim.keymap.set('n', '<leader>gc', '<cmd>CompareClipboard<cr>', { desc = 'Compare buffer to clipboard' })

-- Visual variant: diff only the selected lines against clipboard
vim.keymap.set(
  'v',
  '<leader>gc',
  function()
    vim.cmd [[
    normal! gv"zy
    execute 'tabnew | setlocal buftype=nofile bufhidden=hide noswapfile'
    normal! V"zp
    Ns
    normal! Vp
    windo diffthis
  ]]
  end,
  { desc = 'Compare selection to clipboard' }
)

-- -----------------------------------------------------------------------------
-- 6.3 Key Binding Guide (Which-Key)
-- -----------------------------------------------------------------------------

vim.pack.add { gh 'folke/which-key.nvim' }
require('which-key').setup {
  preset = 'modern', -- "classic", "modern", "helix"
  -- Delay between pressing a key and opening which-key (milliseconds)
  -- No delay for registers (" in N mode/ Ctrl-R in I-mode)
  delay = function(ctx)
    if ctx.plugin == 'registers' then return 0 end
    return 400
  end,
  plugins = {
    marks = true,
    registers = true,
  },
  icons = {
    mappings = vim.g.have_nerd_font,
    separator = '·', -- or use →
    group = '', -- or use +
    ellipsis = '…',
  },
  filter = function(mapping) return mapping.lhs ~= ',' end,
  layout = {
    width = { min = 18, max = 50 },
    spacing = 3,
  },
  sort = { 'order', 'alphanum' }, -- Display registers in a more natural order
  win = {
    border = 'rounded',
    padding = { 1, 2 },
    title = true,
    title_pos = 'center',
    wo = {
      winblend = 0, -- Transparent background (like telescope)
      -- Forces Which-Key to strictly respect our local transparent highlight groups
      winhighlight = 'NormalFloat:WhichKeyNormal,FloatBorder:WhichKeyBorder',
    },
  },
  spec = {
    { '<leader>s', group = 'Search', mode = { 'n', 'v' } },
    { '<leader>t', group = 'Toggle' },
    { '<leader>h', group = 'Git Hunks', mode = { 'n', 'v' } },
    { '<leader>d', group = 'Diagnostics' },
    { '<leader>g', group = 'Git' },
    { '<leader>n', group = 'Neotree' },
    { '<leader>o', group = 'Oil' },
    { '<leader>c', group = 'Code/ LSP', mode = { 'n', 'v' } },
    { '<leader>z', group = 'Games' }, -- für cellular-automaton
  },
  replace = {
    desc = {
      { 'synchronized with the system clipboard', 'system clipboard' },
      { 'last deleted, changed, or yanked', 'last delete/change/yank' },
      { 'name of the current file', 'current file' },
    },
  },
}

vim.pack.add { gh 'folke/tokyonight.nvim' }
vim.pack.add { gh 'craftzdog/solarized-osaka.nvim' }
vim.pack.add { gh 'Tsuzat/NeoSolarized.nvim' }

require('NeoSolarized').setup {
  style = 'dark',
  transparent = true,
  on_highlights = function(highlights, colors)
    -- Unified Git Diff Highlights embedded correctly inside setup
    highlights.DiffAdd = { bg = '#003820' } -- Subdued dark green
    highlights.DiffChange = { bg = '#003050' } -- Deep custom blue instead of jarring yellow
    highlights.DiffDelete = { bg = '#3a0800' } -- Dark crimson red for removals
    highlights.DiffText = { bg = '#004a70', bold = true } -- Bright blue text for granular line changes
    highlights.GitSignsAdd = { fg = colors.green }
    highlights.GitSignsChange = { fg = colors.blue }
    highlights.GitSignsDelete = { fg = colors.red }
    --[[
    -- try those git diff colours as well:
    -- Added lines: subtiles grün, passend zum dunklen Solarized-Hintergrund
    highlights.DiffAdd    = { bg = '#1a3a2a', fg = 'NONE' }
    -- Changed lines: dunkles blau-grau
    highlights.DiffChange = { bg = '#1a2a3a', fg = 'NONE' }
    -- Deleted lines: dezentes rot
    highlights.DiffDelete = { bg = '#3a1a1a', fg = colors.red }
    -- Changed words within a line (nur aktiv wenn enhanced_diff_hl = true)
    highlights.DiffText   = { bg = '#2a3a1a', fg = 'NONE', bold = true }
--]]
  end,
}
vim.cmd.colorscheme 'NeoSolarized'

-- Fine-tuning text visibility and core interface elements post-theme load
vim.api.nvim_set_hl(0, 'Normal', { ctermfg = 252, fg = '#d0d0d0' }) -- Slightly brighter white
vim.api.nvim_set_hl(0, 'Comment', { ctermfg = 252, fg = '#bfbfbf' })
vim.api.nvim_set_hl(0, 'Visual', { bg = '#b58900', fg = '#002b36' }) -- Visual selection highlighting
vim.api.nvim_set_hl(0, 'CursorLine', { bg = 'none' }) -- remove current line coloring
vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', { fg = '#3d5a5a', italic = true }) -- inline blame color

-- Transparent background groups
vim.api.nvim_set_hl(0, 'NonText', { bg = 'none' })
vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none' })
vim.api.nvim_set_hl(0, 'LineNr', { bg = 'none' })
vim.api.nvim_set_hl(0, 'FoldColumn', { bg = 'none' })

-- Custom Which-Key Colors matching Solarized dark palettes (Calmed down & Transparent)
vim.api.nvim_set_hl(0, 'WhichKeyBorder', { fg = '#93a1a1', bg = 'none' }) -- Clean light-white/grey border (alt #586e75)
vim.api.nvim_set_hl(0, 'WhichKeyNormal', { bg = 'none' }) -- Seamless transparent background
vim.api.nvim_set_hl(0, 'WhichKey', { fg = '#2aa198', bold = true }) -- Keys mapped to elegant Cyan
vim.api.nvim_set_hl(0, 'WhichKeyGroup', { fg = '#93a1a1', bold = false }) -- Folders/Groups mapped to quiet Blue
vim.api.nvim_set_hl(0, 'WhichKeyDesc', { fg = '#93a1a1' }) -- Descriptions rendered in muted grey
vim.api.nvim_set_hl(0, 'WhichKeySeparator', { fg = '#586e75' }) -- Separators tracking dark grey tones

-- More subtle colours for LSP highlighting (Prevents glowing text blocks)
vim.api.nvim_set_hl(0, 'LspReferenceText', { bg = '#073642' })
vim.api.nvim_set_hl(0, 'LspReferenceRead', { bg = '#073642' })
vim.api.nvim_set_hl(0, 'LspReferenceWrite', { bg = '#073642', bold = true })

-- Fixes the dark box background on LSP/Linter floating error popups
--vim.api.nvim_set_hl(0, 'DiagnosticFloatingNormal', { bg = 'none' })

-- Global Floating Windows Design (Errors, Prompts, Popups)
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none', fg = '#859900' })
vim.api.nvim_set_hl(0, 'FloatTitle', { bg = '#859900', fg = '#002b36', bold = true })

-- Diagnostic Severity Icon Colors

vim.api.nvim_set_hl(1, 'DiagnosticError', { fg = '#dc322f' }) -- Solarized red
vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = '#b58900' }) -- Solarized yellow
vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = '#2aa198' }) -- Solarized cyan
vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = '#268bd2' }) -- Solarized blue

-- Winbar & Split Layout Styling
vim.api.nvim_set_hl(0, 'WinBar', { bg = '#073642', fg = '#859900' })
vim.api.nvim_set_hl(0, 'WinBarNC', { bg = '#073642', fg = '#93a1a1' })

-- -----------------------------------------------------------------------------
-- 6.5 Enhanced Search (hlslens)
-- -----------------------------------------------------------------------------

vim.pack.add { gh 'kevinhwang91/nvim-hlslens' }
require('hlslens').setup {
  calm_down = true,
  nearest_only = true,
  nearest_float_when = 'auto', -- if line is too long, show in a float box
}

-- Search and Match Highlight Overrides
vim.api.nvim_set_hl(0, 'HlSearchNear', { fg = '#002b36', bg = '#859900', bold = true })
vim.api.nvim_set_hl(0, 'HlSearchLens', { fg = '#2aa198' })
vim.api.nvim_set_hl(0, 'HlSearchLensNear', { fg = '#859900', bold = true })
vim.api.nvim_set_hl(0, 'Search', { fg = '#002b36', bg = '#b58900' })
vim.api.nvim_set_hl(0, 'IncSearch', { fg = '#002b36', bg = '#859900', bold = true })

-- Interactive Search Navigation Keymaps integrated with hlslens
local function hlslens_search(key)
  return function()
    local ok = pcall(vim.cmd, 'normal! ' .. vim.v.count1 .. key)
    if ok then require('hlslens').start() end
  end
end

local function hlslens_cmd(cmd)
  return function()
    local ok = pcall(vim.cmd, cmd)
    if ok then require('hlslens').start() end
  end
end

-- Type n/N to navigate through the current search results with hlslens feedback
vim.keymap.set('n', 'n', hlslens_search 'n', { desc = 'Next search match with lens' })
vim.keymap.set('n', 'N', hlslens_search 'N', { desc = 'Previous search match with lens' })
-- Type #/* to start a search for the word under the cursor with hlslens feedback
vim.keymap.set('n', '*', hlslens_cmd 'normal! *', { desc = 'Search forward for word under cursor' })
vim.keymap.set('n', '#', hlslens_cmd 'normal! #', { desc = 'Search backward for word under cursor' })

-- -----------------------------------------------------------------------------
-- 6.6 Comment Annotations (Todo-Comments)
-- -----------------------------------------------------------------------------

-- Configure todo-style comment annotations and highlighting
vim.pack.add { gh 'folke/todo-comments.nvim' }

require('todo-comments').setup {
  signs = true, -- show signs in the git column on the left

  keywords = {
    -- Highlight bug/fix annotations with high severity
    -- FIX: This is a fix
    FIX = {
      icon = ' ',
      color = 'error',
      alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' },
    },
    -- Highlight regular follow-up tasks
    -- TODO: This is a todo
    TODO = {
      icon = ' ',
      color = 'info',
    },
    -- Highlight temporary workarounds or questionable code
    -- HACK: This is a hack
    HACK = {
      icon = ' ',
      color = 'warning',
    },
    -- Highlight warnings and risky code areas
    -- WARN: This is a warn
    WARN = {
      icon = ' ',
      color = 'warning',
      alt = { 'WARNING', 'XXX' },
    },
    -- Highlight performance-related notes
    -- PERF: This is a perf
    PERF = {
      icon = ' ',
      color = 'default',
      alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' },
    },
    -- Highlight informational notes
    -- NOTE: This is a note
    NOTE = {
      icon = ' ',
      color = 'hint',
      alt = { 'INFO' },
    },
    -- Highlight testing-related annotations
    -- TEST: This is a test
    TEST = {
      icon = '⏲ ',
      color = 'test',
      alt = { 'TESTING', 'PASSED', 'FAILED' },
    },
  },

  merge_keywords = true, -- keep default keywords and extend them

  highlight = {
    multiline = true, -- highlight multi-line annotations
    multiline_pattern = '^.',
    multiline_context = 10,

    before = '',
    keyword = 'wide', -- emphasize the annotation keyword
    after = 'fg', -- highlight the annotation text

    pattern = [[.*<(KEYWORDS):]], -- match keywords ending with a colon, like TODO:
    comments_only = true, -- only highlight annotations inside comments
    max_line_len = 400, -- skip very long lines for performance

    exclude = {
      'help',
      'lazy',
      'mason',
      'TelescopePrompt',
    },
  },

  search = {
    command = 'rg',
    args = {
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
    },
    pattern = [[\b(KEYWORDS):]], -- search project-wide annotations
  },
}

-- Navigate between todo-style annotations
vim.keymap.set('n', ']t', function() require('todo-comments').jump_next() end, { desc = 'Next todo comment' })

vim.keymap.set('n', '[t', function() require('todo-comments').jump_prev() end, { desc = 'Previous todo comment' })

-- List project-wide todo-style annotations
vim.keymap.set('n', '<leader>xt', '<cmd>TodoQuickFix<cr>', {
  desc = 'Todo comments quickfix list',
})

-- List only actionable todo/fix annotations
vim.keymap.set('n', '<leader>xT', '<cmd>TodoQuickFix keywords=TODO,FIX,FIXME,BUG<cr>', {
  desc = 'Todo/Fix comments quickfix list',
})

-- -----------------------------------------------------------------------------
-- 6.7 mini.nvim Module Suite
-- -----------------------------------------------------------------------------

vim.pack.add { gh 'nvim-mini/mini.nvim' }

-- mini.ai: Smart and advanced text objects selection
-- TODO learn aa + ii selectors!
-- Examples:
--  - va)  - [V]isually select [A]round [)]paren
--  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
--  - ci'  - [C]hange [I]nside [']quote
require('mini.ai').setup {
  mappings = {
    around_next = 'aa',
    inside_next = 'ii',
  },
  n_lines = 500,
}

-- mini.surround: Add, delete, or replace surrounding delimiters (brackets, quotes, etc.)
-- TODO learn about surround commands!
-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - sd'   - [S]urround [D]elete [']quotes
-- - sr)'  - [S]urround [R]eplace [)] [']
require('mini.surround').setup()

-- mini.statusline: Highly customized status bar layout
local statusline = require 'mini.statusline'
statusline.setup { use_icons = vim.g.have_nerd_font }

statusline.active = function()
  local mode, mode_hl = statusline.section_mode { trunc_width = 120 }

  -- Git branch details retrieved dynamically via gitsigns state
  local branch = vim.b.gitsigns_head or ''
  local git = branch ~= '' and (' ' .. branch) or ''

  local gs = vim.b.gitsigns_status_dict or {}
  local changes = ''
  if gs.added and gs.added > 0 then changes = changes .. ' +' .. gs.added end
  if gs.changed and gs.changed > 0 then changes = changes .. ' ~' .. gs.changed end
  if gs.removed and gs.removed > 0 then changes = changes .. ' -' .. gs.removed end

  -- LSP connection monitoring
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

  -- Safely initialize search string to avoid configuration crashes
  local search = ''

  -- File specifications
  local enc = vim.bo.fileencoding ~= '' and vim.bo.fileencoding or vim.o.encoding
  local ft = vim.bo.filetype ~= '' and vim.bo.filetype or 'no ft'

  -- Cursor progress position data
  local location = string.format('row: %d  col: %d  %d%%%%', vim.fn.line '.', vim.fn.col '.', math.floor(vim.fn.line '.' / vim.fn.line '$' * 100))

  return statusline.combine_groups {
    { hl = mode_hl, strings = { mode } },
    { hl = 'MiniStatuslineDevinfo', strings = { git, changes } },
    { hl = 'MiniStatuslineDevinfo', strings = { lsp, diagnostics } },
    '%<',
    { hl = 'MiniStatuslineFilename', strings = { '%t' } },
    '%=',
    { hl = 'MiniStatuslineFileinfo', strings = { search } },
    '%=',
    { hl = 'MiniStatuslineFileinfo', strings = { enc .. '  ' .. ft } },
    { hl = mode_hl, strings = { location } },
  }
end

-- Custom Statusline Palette Configuration
vim.api.nvim_set_hl(0, 'MiniStatuslineModeNormal', { bg = '#268bd2', fg = '#002b36', bold = true })
vim.api.nvim_set_hl(0, 'MiniStatuslineModeInsert', { bg = '#2aa198', fg = '#002b36', bold = true })
vim.api.nvim_set_hl(0, 'MiniStatuslineModeVisual', { bg = '#d33682', fg = '#002b36', bold = true })
vim.api.nvim_set_hl(0, 'MiniStatuslineModeCommand', { bg = '#b58900', fg = '#002b36', bold = true })
vim.api.nvim_set_hl(0, 'MiniStatuslineModeOther', { bg = '#859900', fg = '#002b36', bold = true })
vim.api.nvim_set_hl(0, 'MiniStatuslineFilename', { bg = '#073642', fg = '#93a1a1' })
vim.api.nvim_set_hl(0, 'MiniStatuslineFileinfo', { bg = '#073642', fg = '#93a1a1' })
vim.api.nvim_set_hl(0, 'MiniStatuslineInactive', { bg = '#073642', fg = '#586e75' })

-- -----------------------------------------------------------------------------
-- 6.8 Window Separators (Colorful-Winsep)
-- -----------------------------------------------------------------------------

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

-- =============================================================================
-- SECTION 7: SEARCH & NAVIGATION (TELESCOPE)
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 7.1 Core Telescope Plugins
-- -----------------------------------------------------------------------------

-- Core dependencies and main fuzzy finder implementation
vim.pack.add { gh 'nvim-lua/plenary.nvim' }
vim.pack.add { gh 'nvim-telescope/telescope.nvim' }

-- Native performance optimization for sorting (compiled via Section 5's build hooks)
vim.pack.add { gh 'nvim-telescope/telescope-fzf-native.nvim' }

-- Overrides Neovim's built-in selection overlays (e.g., code actions) with Telescope
vim.pack.add { gh 'nvim-telescope/telescope-ui-select.nvim' }

-- -----------------------------------------------------------------------------
-- 7.2 Telescope Engine Configuration
-- -----------------------------------------------------------------------------

local actions = require 'telescope.actions'

require('telescope').setup {
  defaults = {
    -- Clean layout matching the custom rounded border style
    sorting_strategy = 'ascending',
    layout_config = {
      horizontal = {
        prompt_position = 'top',
        preview_width = 0.55,
      },
      width = 0.85,
      height = 0.80,
    },
    borderchars = {
      prompt = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      results = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    },

    -- Default interactive keyboard shortcuts inside the picker list
    mappings = {
      i = {
        -- Selection list navigation
        ['<C-k>'] = { actions.move_selection_previous, type = 'action', opts = { desc = 'Move to previous item in list' } },
        ['<C-j>'] = { actions.move_selection_next, type = 'action', opts = { desc = 'Move to next item in list' } },

        -- Global Neovim quickfix engine integration
        ['<C-q>'] = { actions.send_to_qflist + actions.open_qflist, type = 'action', opts = { desc = 'Send items to quickfix list' } },

        -- Help popup inside Telescope, for German layout
        ['?'] = { actions.which_key, type = 'action', opts = { desc = 'Show available telescope shortcuts' } },
        ['ß'] = { actions.which_key, type = 'action', opts = { desc = 'Show available telescope shortcuts' } },
      },
    },
  },
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown {},
    },
  },
}

-- Safely activate the compiled extensions post-setup
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

-- -----------------------------------------------------------------------------
-- 7.3 Navigation & Fuzzy Search Keymaps
-- -----------------------------------------------------------------------------

local builtin = require 'telescope.builtin'

-- Core discovery pickers mapped to the <leader>s (Search) prefix
-- Project-wide file and text discovery
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Search Files (By name in project root)' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search Grep (By text content across project)' })

-- Neovim core structures and documentation lookup
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Search Help (Official documentation)' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Search Keymaps (Active editor bindings)' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Search Diagnostics (LSP errors/warnings)' })
vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = 'Search Commands (Available vim commands)' })

-- Meta-utilities and history navigation
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = 'Search Select (List all available pickers)' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Search Resume (Reopen last search state)' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = 'Search Recent Files (History)' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find existing buffers (Active tabs)' })

-- Context-aware text search (Normal mode grabs word, Visual mode grabs selection)
vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = 'Search current Word/Selection project-wide' })

-- Smooth interactive fuzzy search in active document
local current_buffer_search = function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 0,
    previewer = false,
  })
end
vim.keymap.set('n', '<leader>/', current_buffer_search, { desc = 'Fuzzily search current buffer lines' })
vim.keymap.set('n', '<leader>7', current_buffer_search, { desc = 'Fuzzily search current buffer lines' })

-- Quick access shortcut for Neovim configurations
vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end, { desc = 'Search Neovim config files' })

-- -----------------------------------------------------------------------------
-- 7.4 Telescope UI Solarized Color Overrides (Fully Transparent)
-- -----------------------------------------------------------------------------

-- Core window Base
vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = 'none', fg = '#93a1a1' })

-- Search input field (prompt window - Solarized Green/Yellow)
vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { bg = 'none', fg = '#93a1a1' })
vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { bg = 'none', fg = '#859900' })
vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { bg = '#859900', fg = '#002b36', bold = true })

-- Results window (Solarized Cyan)
vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = 'none', fg = '#586e75' })
vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', { bg = 'none', fg = '#2aa198' })
vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { bg = '#2aa198', fg = '#002b36', bold = true })

-- Preview window (content view - Solarized Blue)
vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', { bg = 'none', fg = '#268bd2' })
vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { bg = '#268bd2', fg = '#002b36', bold = true })

-- Visual selection bar and character match highlights
vim.api.nvim_set_hl(0, 'TelescopeSelection', { bg = '#073642', fg = '#859900', bold = true })
vim.api.nvim_set_hl(0, 'TelescopeMatching', { fg = '#cb4b16', bold = true })

-- =============================================================================
-- SECTION 8: LSP & COMPLETION SETUP
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 8.1 LSP CORE CONFIGURATION
-- -----------------------------------------------------------------------------
do
  -- 1. Install core LSP management and configuration plugins via vim.pack
  vim.pack.add { gh 'williamboman/mason.nvim' } -- External package manager for tools
  vim.pack.add { gh 'williamboman/mason-lspconfig.nvim' } -- Bridge between mason.nvim and lspconfig
  vim.pack.add { gh 'neovim/nvim-lspconfig' } -- Quickstart configurations for Neovim's built-in LSP
  vim.pack.add { gh 'whoissethdaniel/mason-tool-installer.nvim' } -- Automates installation of non-LSP tools

  -- 2. Initialize Mason (The graphical UI manager for language servers, linters, and formatters)
  require('mason').setup {
    ui = {
      border = 'rounded', -- Clean rounded borders for the Mason dashboard window (:Mason)
      icons = {
        package_installed = '✓',
        package_pending = '➜',
        package_uninstalled = '✗',
      },
    },
  }

  -- 3. Define the language servers you want Mason to install and configure.
  -- You can easily expand this table later as you start developing in other languages.
  local servers = {
    -- Lua Language Server configuration (optimized for Neovim development)
    lua_ls = {
      settings = {
        Lua = {
          completion = { callSnippet = 'Replace' },
          -- Inform the server that 'vim' is a valid global variable to eliminate annoying warning highlights
          diagnostics = { globals = { 'vim' } }, -- Eliminate annoying warning highlights on 'vim' global
        },
      },
    },
    -- Python Development
    pyright = {},
    -- JavaScript & TypeScript (ts_ls is the modern, official successor to tsserver)
    ts_ls = {},
    -- Web Development (HTML & CSS syntax intelligence)
    html = {},
    cssls = {},
    -- Shell Scripting (Bash / Sh architecture diagnostics)
    bashls = {},
    -- JSON, YAML
    jsonls = {}, -- Structural verification for JSON (e.g., package.json)
    yamlls = {}, -- Structural verification for YAML (e.g., GitHub Actions, Docker Compose)
  }

  -- 4. Gather tools that are not language servers but should still be managed by Mason (e.g., code formatters)
  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {
    'stylua', -- Elegant formatter for Lua files
    'black', -- Industry-standard deterministic formatter for Python
    'prettier', -- Universal high-fidelity formatter for HTML, CSS, JavaScript, and JSON
  })

  -- Automatically trigger background installation for all requested servers and tools
  require('mason-tool-installer').setup { ensure_installed = ensure_installed }

  -- 5. Broadcast Neovim's autocompletion capabilities to the active LSP servers
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local has_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
  if has_cmp then
    -- Extend native capabilities with advanced completion triggers provided by nvim-cmp
    capabilities = vim.tbl_deep_extend('force', capabilities, cmp_nvim_lsp.default_capabilities())
  end

  -- 6. Dynamic server registration hook provided by mason-lspconfig
  require('mason-lspconfig').setup {
    handlers = {
      function(server_name)
        local server_opts = servers[server_name] or {}
        -- Deep merge capabilities to ensure every server knows how to feed the completion menu
        server_opts.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server_opts.capabilities or {})
        -- Safely initialize and boot the specific server via standard lspconfig
        require('lspconfig')[server_name].setup(server_opts)
      end,
    },
  }

  -- 7. Global LSP Keymaps Autocommand
  -- These keymaps are context-aware and will ONLY be mapped when an LSP server actively attaches to a file buffer.
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
      -- Helper function to quickly generate local normal-mode keybindings with clean descriptions
      local map = function(keys, func, desc) vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc }) end

      -- Code intelligence and navigation powered by Telescope search engine overlays
      map('gd', require('telescope.builtin').lsp_definitions, 'Go to Definition (Jump to where variable/function is declared)')
      map('gr', require('telescope.builtin').lsp_references, 'Go to References (Search all usages across project)')
      map('gI', require('telescope.builtin').lsp_implementations, 'Go to Implementation')
      map('<leader>cD', require('telescope.builtin').lsp_type_definitions, 'Type Definition info')
      map('<leader>cs', require('telescope.builtin').lsp_document_symbols, 'Document Symbols (List functions/variables in current file)')

      -- Code refactoring and documentation utilities
      map('<leader>cr', vim.lsp.buf.rename, 'Rename Symbol (Safely changes all instances in project)')
      map('<leader>ca', vim.lsp.buf.code_action, 'Code Action (Context-aware quick fixes, e.g., auto-imports)')
      map('K', vim.lsp.buf.hover, 'Hover Documentation (Shows function signatures and docstrings)')
      map('gD', vim.lsp.buf.declaration, 'Go to Declaration')

      -- 8. Visual Word Highlighting under Cursor Position
      -- If the active LSP client supports document highlighting, illuminate all matching words in the current file.
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client:supports_method 'textDocument/documentHighlight' then
        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })

        -- Trigger highlight whenever the cursor rests on a word
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        -- Instantly clear the highlights as soon as the cursor moves away
        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        -- Safely clean up all active autocommands if the LSP detaches from this specific buffer
        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
          callback = function(event2)
            if event2.buf == event.buf then
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event.buf }
            end
          end,
        })
      end
    end,
  })
end

-- -----------------------------------------------------------------------------
-- SECTION 8.2: AUTOCOMPLETION ENGINE & VISUAL COMPLETION MENU
-- -----------------------------------------------------------------------------
do
  -- 1. Install the visual completion engine popup suite and its data engines
  vim.pack.add { gh 'hrsh7th/nvim-cmp' } -- Core frontend completion framework
  vim.pack.add { gh 'hrsh7th/cmp-nvim-lsp' } -- Bridge: Feeds active LSP suggestions into the popup
  vim.pack.add { gh 'hrsh7th/cmp-path' } -- Bridge: Feeds local filesystem paths into the popup
  vim.pack.add { gh 'hrsh7th/cmp-buffer' } -- Bridge: Feeds words found inside the active file buffer

  -- 2. Install snippet engine infrastructure (nvim-cmp strictly requires a snippet expander to function)
  vim.pack.add { gh 'L3MON4D3/LuaSnip' } -- Core code boilerplate/snippet expansion engine
  vim.pack.add { gh 'saadparwaiz1/cmp_luasnip' } -- Bridge: Feeds LuaSnip boilerplates into nvim-cmp

  local cmp = require 'cmp'
  local luasnip = require 'luasnip'
  luasnip.config.setup {} -- Initialize snippet engine with defaults

  cmp.setup {
    -- Tie the snippet engine directly to the completion routine
    snippet = {
      expand = function(args) luasnip.lsp_expand(args.body) end,
    },

    -- Configure menu triggers: 'menuone' forces popup to open even if there's only 1 item;
    -- 'noinsert' stops the editor from aggressively auto-injecting text before you confirm it.
    completion = { completeopt = 'menu,menuone,noinsert' },

    -- 3. Ergonomic Menu Keymaps (Tailored for speed, keeping your hands centered on the home row)
    mapping = cmp.mapping.preset.insert {
      -- Selection list navigation
      ['<C-n>'] = cmp.mapping.select_next_item(), -- Move down to the next completion item (Ctrl+n)
      ['<C-p>'] = cmp.mapping.select_prev_item(), -- Move up to the previous completion item (Ctrl+p)

      -- Scrolling documentation windows (useful if an item has extensive help notes)
      ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- Scroll documentation popup window Up (Ctrl+b)
      ['<C-f>'] = cmp.mapping.scroll_docs(4), -- Scroll documentation popup window Down (Ctrl+f)

      -- Elite Confirmation Mapping: Confirms selection via Ctrl+y
      -- Setting 'select = true' automatically selects the top item if you haven't explicitly scrolled to one.
      -- Extremely ergonomic as it bypasses the distant Enter key.
      ['<C-y>'] = cmp.mapping.confirm { select = true },

      -- Manually force-trigger the completion popup menu if previously closed (Ctrl+g)
      ['<C-g>'] = cmp.mapping.complete {},

      -- Smart Snippet Traversal: Jump back and forth through active snippet variables/placeholders (Ctrl+l)
      ['<M-l>'] = cmp.mapping(function()
        if luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump() -- Jump forward to the next snippet field via Alt+l
        end
      end, { 'i', 's' }),
      ['<M-h>'] = cmp.mapping(function()
        if luasnip.locally_jumpable(-1) then
          luasnip.jump(-1) -- Jump backward to the previous snippet field via Alt+h
        end
      end, { 'i', 's' }),
    },

    -- 4. Define data streams feeding into the popup (Order determines priority from top to bottom)
    sources = cmp.config.sources {
      { name = 'nvim_lsp', priority = 1000 }, -- Priority 1: High-intelligence context suggestions from LSP
      { name = 'luasnip', priority = 750 }, -- Priority 2: Custom code boilerplates and snippets
      { name = 'path', priority = 500 }, -- Priority 3: Contextual filesystem paths
      { name = 'buffer', priority = 250 }, -- Priority 4: Plain text words harvested from open tabs
    },

    -- 5. Elegant UI Borders matching the Solarized architectural design choices
    window = {
      completion = cmp.config.window.bordered { border = 'rounded' },
      documentation = cmp.config.window.bordered { border = 'rounded' },
    },
  }
end

-- =============================================================================
-- SECTION 9.1: CORE UTILITIES & BACKGROUND PROCESSING
-- =============================================================================
do
  -- Fidget.nvim: Displays elegant LSP loading indicators in the bottom-right corner
  vim.pack.add { gh 'j-hui/fidget.nvim' }
  require('fidget').setup {}

  -- Smear-Cursor: Smooth, organic animations for cursor transitions
  vim.pack.add { gh 'sphamba/smear-cursor.nvim' }
  require('smear_cursor').setup {
    -- Smoothly yields to neoscroll to prevent visual stutter during fast scrolling
    legacy_computing_symbols_support = false,
  }
end

-- =============================================================================
-- SECTION 9.2: AUTOMATED CODE FORMATTING (conform.nvim)
-- =============================================================================
do
  vim.pack.add { gh 'stevearc/conform.nvim' }
  require('conform').setup {
    notify_on_error = false,

    -- Format-on-Save Hook tailored precisely for my development ecosystem
    format_on_save = function(bufnr)
      local enabled_filetypes = {
        lua = true,
        python = true,
        javascript = true,
        html = true,
        css = true,
      }
      if enabled_filetypes[vim.bo[bufnr].filetype] then return { timeout_ms = 500, lsp_format = 'fallback' } end
      return nil
    end,

    -- Map the required languages to the industry-standard engines managed by Mason
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'black' },
      javascript = { 'prettier' },
      html = { 'prettier' },
      css = { 'prettier' },
    },
  }

  -- Global manual formatting shortcut (Works in both Normal and Visual mode)
  vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = 'Format: Beautifully align current buffer' })
end

-- =============================================================================
-- SECTION 9.3: ADVANCED SYNTAX HIGHLIGHTING (nvim-treesitter)
-- =============================================================================
do
  vim.pack.add { { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' } }

  -- Pre-install core parsers including all my preferred tracking languages
  local parsers = {
    'bash',
    'c',
    'diff',
    'html',
    'css',
    'javascript',
    'python',
    'lua',
    'luadoc',
    'markdown',
    'markdown_inline',
    'query',
    'vim',
    'vimdoc',
    'json',
    'yaml',
  }
  require('nvim-treesitter').install(parsers)

  -- Highly performant contextual attachment routine for lightning-fast buffer loads
  local function treesitter_try_attach(buf, language)
    if not vim.treesitter.language.add(language) then return end
    vim.treesitter.start(buf, language)
    if vim.treesitter.query.get(language, 'indents') ~= nil then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
  end

  local available_parsers = require('nvim-treesitter').get_available()
  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('kickstart-treesitter', { clear = true }),
    callback = function(args)
      local buf, filetype = args.buf, args.match
      local language = vim.treesitter.language.get_lang(filetype)
      if not language then return end

      local installed_parsers = require('nvim-treesitter').get_installed 'parsers'
      if vim.tbl_contains(installed_parsers, language) then
        treesitter_try_attach(buf, language)
      elseif vim.tbl_contains(available_parsers, language) then
        require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
      else
        treesitter_try_attach(buf, language)
      end
    end,
  })
end

-- =============================================================================
-- SECTION 10.1: FILE MANAGEMENT — OIL.NVIM (Floating File Editor)
-- =============================================================================
do
  vim.pack.add { gh 'stevearc/oil.nvim' }
  vim.pack.add { gh 'refractalize/oil-git-status.nvim' }

  -- Isolated highlight groups to safeguard Telescope from global style pollution
  vim.api.nvim_set_hl(0, 'OilNormal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'OilBorder', { fg = '#2aa198', bg = 'none' })

  require('oil').setup {
    -- Show same columns as in "ll" command
    columns = { 'icon', 'permissions', 'size', 'mtime' },
    -- Show hidden files by default
    view_options = { show_hidden = true },
    -- UI Tuning: Forces the buffer to behave like a clean file explorer, not source code
    win_options = {
      wrap = false,
      cursorcolumn = false, -- Don't draw a vertical line under the cursor
      foldcolumn = '0', -- Hide the code-folding gutter on the left
      spell = false, -- Disable spell-checking highlights on filenames
      list = false, -- Hide whitespace/tab tracking characters
      conceallevel = 3, -- Completely hide technical path prefixes or markers
      concealcursor = 'nvic', -- Keep markers hidden even when cursor sits on them
      signcolumn = 'yes:2', -- Essential for seamless Git status indicator layouts
    },
    -- Floating layout configuration
    float = {
      padding = 2,
      max_width = 90,
      max_height = 35,
      border = 'rounded',
      win_options = {
        winblend = 0,
        -- Local window override: Applies Cyan border ONLY to the main Oil window
        winhighlight = 'NormalFloat:OilNormal,FloatBorder:OilBorder',
      },
      -- Layer control: Forces Oil to render on top of other overlapping floating windows
      override = function(conf)
        conf.zindex = 50
        return conf
      end,
    },
    use_default_keymaps = false,
    keymaps = {
      -- Explorer-like navigation
      ['h'] = { 'actions.parent', desc = 'Go to parent directory' },
      ['l'] = { 'actions.select', desc = 'Enter directory/Open file in current buffer' },

      -- Keep explicit alternatives (default mappings)
      ['<CR>'] = { 'actions.select', desc = 'Enter directory/Open file in current buffer (Enter)' },
      ['<BS>'] = { 'actions.parent', desc = 'Go to parent directory (Backspace)' },
      ['-'] = { 'actions.parent', desc = 'Go to parent directory (-)' },

      -- Open files/folders in split windows
      ['L'] = { 'actions.select', opts = { vertical = true }, desc = 'Open in vertical split (to the right)' },
      ['J'] = { 'actions.select', opts = { horizontal = true }, desc = 'Open in horizontal split (below)' },
      ['T'] = { 'actions.select', opts = { tab = true }, desc = 'Open in new tab' },

      ['q'] = { 'actions.close', desc = 'Close Oil' },
      ['<Esc>'] = { 'actions.close', desc = 'Close Oil' },
      ['.'] = { 'actions.toggle_hidden', desc = 'Toggle hidden files' },
      ['s'] = { 'actions.change_sort', desc = 'Change sort order' },
      ['?'] = { 'actions.show_help', desc = 'Show help' },
      ['ß'] = { 'actions.show_help', desc = 'Show help' },
      ['_'] = { 'actions.open_cwd', desc = 'Open current working directory (Underscore)' },
      ['`'] = { 'actions.cd', desc = 'Change window directory (Backtick)' },
    },
  }

  -- Activated tracking of gitignored files with clean formatting
  require('oil-git-status').setup { show_ignored = true }
  -- To ensure ":e ." opens in Oil, not in Neo-Tree:
  default_file_explorer =
    true,
    -- Global Toggle: Opens Oil as a centered float window
    vim.keymap.set('n', '<leader>o', function() require('oil').open_float() end, { desc = 'Oil: Open floating file manager' })

  -- Oil Specific Autocommands (Fixes navigation conflicts & enables ESC to close)
  local oil_group = vim.api.nvim_create_augroup('oil-custom-behavior', { clear = true })

  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'oil',
    group = oil_group,
    callback = function()
      -- Defend hlslens search navigation from being overridden by Oil internal maps
      vim.keymap.set('n', 'n', 'n', { buffer = true, nowait = true })
      vim.keymap.set('n', 'N', 'N', { buffer = true, nowait = true })
    end,
  })

  -- Architectural patch: Intercepts the hardcoded Oil help popup on launch
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'oil_help',
    group = oil_group,
    callback = function()
      -- Enable instantaneous Escape & Q exit paths
      vim.keymap.set('n', '<Esc>', '<cmd>close<CR>', { buffer = true, nowait = true, silent = true })
      vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = true, nowait = true, silent = true })

      -- Force injection of a rounded window border and apply the local Cyan styling
      local win = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_config(win, { border = 'rounded' })
      vim.wo[win].winhighlight = 'NormalFloat:OilNormal,FloatBorder:OilBorder'
    end,
  })

  -- Design Tuning: Solarized Architectural Color Palette for Oil
  vim.api.nvim_set_hl(0, 'OilDir', { fg = '#268bd2', bold = true })
  vim.api.nvim_set_hl(0, 'OilFile', { fg = '#93a1a1' })
  vim.api.nvim_set_hl(0, 'OilLink', { fg = '#2aa198', italic = true })
  vim.api.nvim_set_hl(0, 'OilPermRead', { fg = '#859900' })
  vim.api.nvim_set_hl(0, 'OilPermWrite', { fg = '#cb4b16' })
  vim.api.nvim_set_hl(0, 'OilPermExec', { fg = '#b58900' })
  vim.api.nvim_set_hl(0, 'OilSize', { fg = '#586e75' })
  vim.api.nvim_set_hl(0, 'OilMtime', { fg = '#586e75' })

  -- Git Status specific diagnostics matching Solarized base tones
  vim.api.nvim_set_hl(0, 'OilGitStatusIndexModified', { fg = '#b58900' })
  vim.api.nvim_set_hl(0, 'OilGitStatusWorkingTreeModified', { fg = '#b58900' })
  vim.api.nvim_set_hl(0, 'OilGitStatusIndexAdded', { fg = '#859900' })
  vim.api.nvim_set_hl(0, 'OilGitStatusWorkingTreeAdded', { fg = '#859900' })
  vim.api.nvim_set_hl(0, 'OilGitStatusIndexDeleted', { fg = '#dc322f' })
  vim.api.nvim_set_hl(0, 'OilGitStatusWorkingTreeDeleted', { fg = '#dc322f' })
  vim.api.nvim_set_hl(0, 'OilGitStatusIndexUntracked', { fg = '#2aa198' })
  vim.api.nvim_set_hl(0, 'OilGitStatusWorkingTreeUntracked', { fg = '#2aa198' })
  vim.api.nvim_set_hl(0, 'OilGitStatusIndexRenamed', { fg = '#268bd2' })
  vim.api.nvim_set_hl(0, 'OilGitStatusWorkingTreeRenamed', { fg = '#268bd2' })

  -- Visually muted design for gitignored files (Subtle Solarized grey base)
  vim.api.nvim_set_hl(0, 'OilGitStatusIndexIgnored', { fg = '#586e75' })
  vim.api.nvim_set_hl(0, 'OilGitStatusWorkingTreeIgnored', { fg = '#586e75' })
end

-- =============================================================================
-- SECTION 10.2: FILE MANAGEMENT — NEO-TREE (Sidebar Project Tree)
-- =============================================================================
do
  vim.pack.add { gh 'nvim-neo-tree/neo-tree.nvim', gh 'MunifTanjim/nui.nvim' }

  require('neo-tree').setup {
    close_if_last_window = true,
    popup_border_style = 'rounded',
    enable_git_status = true,
    enable_diagnostics = true,
    default_component_configs = {
      indent = {
        indent_size = 1,
        padding = 1,
        with_markers = true,
        indent_marker = '│',
        last_indent_marker = '└',
        highlight = 'NeoTreeIndentMarker',
      },
      icon = {
        folder_closed = '󰉋',
        folder_open = '󰝰',
        folder_empty = '󰉖',
        folder_empty_open = '󰷏',
        default = '󰈙',
        selected = '󰄯',
        use_filtered_colors = true,
      },
      -- Git status signaling glyphs appearing right to files
      git_status = {
        symbols = {
          added = '+',
          modified = '~',
          deleted = '✖',
          renamed = '➜',
          untracked = '?',
          ignored = '',
          unstaged = '!',
          staged = '',
          conflict = '',
        },
      },
    },
    window = {
      position = 'left',
      width = 30,

      mappings = {
        -- Core navigation, aligned with Oil
        ['<CR>'] = 'open',
        ['h'] = 'close_node',

        -- Split navigation, aligned with Oil mappings
        ['l'] = 'open_vsplit',
        ['L'] = 'open_vsplit',
        ['J'] = 'open_split',
        ['T'] = 'open_tabnew',

        -- Tree structure
        ['C'] = 'close_node',
        ['z'] = 'close_all_nodes',

        -- File operations
        ['a'] = 'add',
        ['d'] = 'delete',
        ['r'] = 'rename',
        ['y'] = 'copy_to_clipboard',
        ['x'] = 'cut_to_clipboard',
        ['p'] = 'paste_from_clipboard',

        -- UI / utility
        ['q'] = 'close_window',
        ['?'] = 'show_help',
        ['ß'] = 'show_help',
        ['<'] = 'prev_source', -- Cycle sources (Filesystem -> Buffers -> Git)
        ['>'] = 'next_source', -- same as leader-nb / ng
        ['R'] = 'refresh',
        ['i'] = 'show_file_details',
        ['<Esc>'] = 'cancel',
        ['P'] = { 'toggle_preview', config = { use_float = true } },
      },
    },
    filesystem = {
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = false,
      },
      follow_current_file = { enabled = false }, -- Mark current file in the tree: NO
      use_libuv_file_watcher = true,

      window = {
        mappings = {
          ['.'] = 'toggle_hidden',
        },
      },
    },
  }

  -- Neo-tree relative line numbers
  local neotree_group = vim.api.nvim_create_augroup('neo-tree-custom-behavior', { clear = true })

  local function set_neotree_line_numbers(args)
    vim.schedule(function()
      local bufnr = args and args.buf or vim.api.nvim_get_current_buf()

      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win) == bufnr then
          vim.wo[win].number = true
          vim.wo[win].relativenumber = true
          vim.wo[win].numberwidth = 3
          vim.wo[win].signcolumn = 'yes'
        end
      end
    end)
  end

  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'neo-tree',
    group = neotree_group,
    callback = set_neotree_line_numbers,
  })

  vim.api.nvim_create_autocmd({ 'BufWinEnter', 'WinEnter' }, {
    pattern = '*',
    group = neotree_group,
    callback = function(args)
      if vim.bo[args.buf].filetype == 'neo-tree' then set_neotree_line_numbers(args) end
    end,
  })

  -- Core Project Sidebar Keymaps
  vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle source=filesystem position=left reveal=true<CR>', { desc = 'Toggle Neotree file explorer on the left' })
  vim.keymap.set('n', '<leader>ng', '<cmd>Neotree toggle source=git_status position=left<CR>', { desc = 'Explorer: Neotree Git status' })
  vim.keymap.set('n', '<leader>nb', '<cmd>Neotree toggle source=buffers position=left<CR>', { desc = 'Explorer: Neotree active buffers list' })

  -- Design Tuning: Clean, transparent Solarized aesthetics for Neo-Tree
  vim.api.nvim_set_hl(0, 'NeoTreeNormal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NeoTreeNormalNC', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NeoTreeWinSeparator', { fg = '#073642', bg = 'none' })
  vim.api.nvim_set_hl(0, 'NeoTreeBorder', { fg = '#2aa198', bg = 'none' })
  vim.api.nvim_set_hl(0, 'NeoTreeDirectoryName', { fg = '#268bd2', bold = true })
  vim.api.nvim_set_hl(0, 'NeoTreeDirectoryIcon', { fg = '#268bd2' })
  vim.api.nvim_set_hl(0, 'NeoTreeRootName', { fg = '#859900', bold = true })

  -- Restored specific layout highlight lines
  vim.api.nvim_set_hl(0, 'NeoTreeFileName', { fg = '#93a1a1' })
  vim.api.nvim_set_hl(0, 'NeoTreeFileIcon', { fg = '#586e75' })
  vim.api.nvim_set_hl(0, 'NeoTreeIndentMarker', { fg = '#073642' })
  vim.api.nvim_set_hl(0, 'NeoTreeExpander', { fg = '#586e75' })

  -- Git Status specific diagnostics matching Solarized base tones
  vim.api.nvim_set_hl(0, 'NeoTreeGitModified', { fg = '#b58900' })
  vim.api.nvim_set_hl(0, 'NeoTreeGitAdded', { fg = '#859900' })
  vim.api.nvim_set_hl(0, 'NeoTreeGitDeleted', { fg = '#dc322f' })
  vim.api.nvim_set_hl(0, 'NeoTreeGitUntracked', { fg = '#2aa198' })
end

-- =============================================================================
-- SECTION 11: ERGONOMIC IN-BUFFER MOTION (clever-f & neoscroll)
-- =============================================================================
vim.pack.add {
  'https://github.com/rhysd/clever-f.vim',
}

-- Suche über Zeilenenden hinaus (zeilenübergreifend)
vim.g.clever_f_across_no_line = 0
-- Smart case: Großbuchstabe → case-sensitiv, sonst nicht
vim.g.clever_f_smart_case = 1
-- ; matcht beliebige Sonderzeichen
vim.g.clever_f_chars_match_any_signs = ',' -- Komma anstatt Semikolon
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
-- Nach 4 Sek. Inaktivität Zustand zurücksetzen
vim.g.clever_f_timeout_ms = 4000
-- Highlight bleibt 2 Sek. nach dem Sprung sichtbar
vim.g.clever_f_highlight_timeout_ms = 4000

-- =============================================================================
-- SECTION 10.5: KINETIC UI SCROLLING — NEOSCROLL (Smooth Navigation)
-- =============================================================================
do
  vim.pack.add { gh 'karb94/neoscroll.nvim' }

  local neoscroll = require 'neoscroll'

  neoscroll.setup {
    mappings = {}, -- Eigene Mappings unten, keine Defaults verwenden
    hide_cursor = true, -- Cursor während des Scrollens verstecken
    stop_eof = true, -- Nicht über das Dateiende hinausscrollen
    respect_scrolloff = true, -- Dein Scrolloff-Margin strikt respektieren
    duration_multiplier = 1.0,
    --cursor_scrolls_alone = true, -- Cursor moves dynamically during viewport shift
    easing = 'sine', -- Sanfte Sinus-Kurve für deine Bewegung (or try "quadratic")
    -- Deaktiviert Smear-Cursor beim Scrollen, um Grafik-Schlieren zu verhindern:
    pre_hook = function()
      pcall(function() require('smear_cursor').enabled = false end)
    end,
    post_hook = function()
      pcall(function() require('smear_cursor').enabled = true end)
    end,
  }

  local modes = { 'n', 'v', 'x' }
  local keymap = {
    -- halbes Fenster: schnell, sine-Easing (maybe try "quadratic" as well)
    ['<C-u>'] = function() neoscroll.ctrl_u { duration = 200, easing = 'sine' } end,
    ['<C-d>'] = function() neoscroll.ctrl_d { duration = 200, easing = 'sine' } end,
    -- ganzes Fenster: etwas langsamer, circular für weiches Abbremsen
    ['<C-b>'] = function() neoscroll.ctrl_b { duration = 350, easing = 'circular' } end,
    ['<C-f>'] = function() neoscroll.ctrl_f { duration = 350, easing = 'circular' } end,
    -- zeilenweises Scrollen ohne Cursor (jeweils 2 Zeilen)
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
end

-- =============================================================================
-- SECTION 11.5: HIGH-PERFORMANCE CSV VIEWER — CSVVIEW
-- =============================================================================
do
  -- Load plugin via custom github helper
  vim.pack.add { gh 'hat0uma/csvview.nvim' }

  require('csvview').setup {
    parser = {
      comments = { '#', '//' }, -- Recognize common comment headers
      delimiter = {
        ft = {
          csv = ';',
          tsv = '\t',
        },
      },
    },
    view = {
      display_mode = 'border', -- Render clean grid borders for column separation
      spacing = { left = 1, right = 1 },
      header_lnum = true,
      sticky_header = {
        enabled = true,
        separator = '─',
      },
    },
  }

  -- Toggle CSV table rendering via leader-tc
  vim.keymap.set('n', '<leader>tc', function()
    vim.cmd 'CsvViewToggle'
    vim.notify('CSV table view toggled', vim.log.levels.INFO)
  end, {
    desc = 'Toggle CSV Table View',
  })

  -- Switch between comma/semicolon as CSV delimiter via leader-td
  vim.keymap.set('n', '<leader>td', function()
    vim.cmd 'CsvViewToggle delimiter=,'
    vim.notify('CSV comma delimiter toggled', vim.log.levels.INFO)
  end, {
    desc = 'Switch between Comma/Semicolon as CSV Delimiter',
  })

  -- Enable table view automatically for CSV/TSV files
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'csv', 'tsv' },
    callback = function()
      vim.opt_local.wrap = false
      vim.opt_local.list = false
      require('csvview').enable()
    end,
  })
end

-- =============================================================================
-- SECTION 11.5: HIGH-PERFORMANCE CSV VIEWER — CSVVIEW
-- =============================================================================
do
  -- Render Markdown directly inside Neovim buffers.
  vim.pack.add { gh 'MeanderingProgrammer/render-markdown.nvim' }

  require('render-markdown').setup {
    -- Enable rendering by default for supported filetypes.
    enabled = true,

    -- Keep rendering focused on Markdown buffers only.
    file_types = { 'markdown' },

    -- Render in Normal, Command, and Terminal modes; keep Insert mode raw.
    render_modes = { 'n', 'c', 't' },

    -- Hide rendered decorations on the cursor line for easier editing.
    anti_conceal = {
      enabled = true,
    },

    -- Keep the sign column clean because your config already uses many signs.
    heading = {
      sign = false,
    },

    -- Make code blocks readable without adding visual noise.
    code = {
      sign = false,
      width = 'block',
      right_pad = 1,
    },

    -- Use rounded table borders for a cleaner Markdown reading view.
    pipe_table = {
      preset = 'round',
    },
  }

  -- Toggle Markdown rendering via the existing <leader>t group.
  vim.keymap.set('n', '<leader>tm', '<cmd>RenderMarkdown toggle<CR>', {
    desc = 'Toggle Markdown Rendering',
  })
end

-- ─── fun plugin cellular-automaton ───────────────────────────────────────────
vim.pack.add {
  'https://github.com/Eandrju/cellular-automaton.nvim',
}

vim.keymap.set('n', '<leader>zr', '<cmd>CellularAutomaton make_it_rain<CR>', { desc = 'Make it Rain' })
vim.keymap.set('n', '<leader>zg', '<cmd>CellularAutomaton game_of_life<CR>', { desc = 'Game of Life' })

-- ─── Yank, undo, redo animations ───────────────────────────────────────────
vim.pack.add {
  'https://github.com/rachartier/tiny-glimmer.nvim',
}

require('tiny-glimmer').setup {
  enabled = true,
  disable_warnings = true,

  transparency_color = nil, -- or try '#002b36'

  -- Keep it smooth but not too CPU-hungry
  refresh_interval_ms = 12,
  text_change_batch_timeout_ms = 50,

  overwrite = {
    auto_map = true,

    yank = {
      enabled = true,
      default_animation = 'left_to_right',
    },

    paste = {
      enabled = true,
      default_animation = 'left_to_right',
    },

    search = {
      enabled = false, --deactivate because of hlslens
      default_animation = 'pulse',
      next_mapping = 'n',
      prev_mapping = 'N',
    },

    undo = {
      enabled = true,
      default_animation = {
        name = 'fade',
        settings = {
          from_color = 'DiffDelete',
          to_color = 'Normal',
          max_duration = 450,
          min_duration = 250,
        },
      },
    },

    redo = {
      enabled = true,
      default_animation = {
        name = 'fade',
        settings = {
          from_color = 'DiffAdd',
          to_color = 'Normal',
          max_duration = 450,
          min_duration = 250,
        },
      },
    },
  },

  animations = {
    fade = {
      max_duration = 350,
      min_duration = 200,
      chars_for_max_duration = 20,
      from_color = 'Visual',
      to_color = 'Normal',
    },

    reverse_fade = {
      max_duration = 350,
      min_duration = 200,
      chars_for_max_duration = 20,
      from_color = 'Visual',
      to_color = 'Normal',
    },

    left_to_right = {
      max_duration = 350,
      min_duration = 180,
      chars_for_max_duration = 35,
      from_color = 'IncSearch',
      to_color = 'Normal',
    },

    pulse = {
      max_duration = 300,
      min_duration = 180,
      chars_for_max_duration = 20,
      from_color = 'IncSearch',
      to_color = 'Normal',
    },

    bounce = {
      max_duration = 350,
      min_duration = 180,
      chars_for_max_duration = 20,
      from_color = 'Visual',
      to_color = 'Normal',
    },
  },

  hijack_ft_disabled = {
    'alpha',
    'dashboard',
    'neo-tree',
    'NvimTree',
    'TelescopePrompt',
    'TelescopeResults',
    'TelescopePreview',
    'lazy',
    'mason',
    'notify',
    'noice',
    'help',
    'qf',
  },
}

-- ------------------------------------------------------
-- TODO: READ:
-- :help lua-guide-autocommands`
-- :help lsp-vs-treesitter
-- :help ins-completion
-- :help modeline
-- vim: ts=2 sts=2 sw=2 et
