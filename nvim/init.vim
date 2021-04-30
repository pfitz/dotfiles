scriptencoding utf-8
set encoding=UTF-8
" Josh's vim configuration (http://github.com/knewter/dotfiles)

" Table of Contents
" 1) Basics #basics
"   1.1) Tabs #tabs
"   1.2) Format Options #format-options
"   1.3) Leader #leader
"   1.4) Omni #omni
"   1.5) UI Basics #ui-basics
" 2) Plugins #plugins
"   2.1) Filetypes #filetypes
"   2.2) Utilities #utilities
"   2.3) UI Plugins #ui-plugins
"   2.4) Code Navigation #code-navigation
" 3) UI Tweaks #ui-tweaks
"   3.1) Theme #theme
" 4) Navigation #navigation

"""""""""""""" Basics #basics
""" Tabs #tabs
" - Two spaces wide
set tabstop=2
set softtabstop=2
" - Expand them all
set expandtab
" - Indent by 2 spaces by default
set shiftwidth=2

""" Format Options #format-options
set formatoptions=tcrq
set textwidth=80

""" Handling backup copies
" make a copy of the file and overwrite the original one
set backupcopy=yes

set scrolloff=8
set colorcolumn=80,120
""" Leader #leader
" Use space for leader
let g:mapleader=' '
" Double backslash for local leader
let g:maplocalleader='\\'
"" Tap completion
set wildmenu
set wildmode=full
""" omni #omni
" enable omni syntax completion
set omnifunc=syntaxcomplete#Complete

""" UI Basics #ui-basics
" turn off mouse
set mouse=""

" NOTE: I stopped highlighting cursor position because it makes redrawing
" super slow.
set cursorline
set cursorcolumn

" Highlight search results
set hlsearch
" Incremental search, search as you type
set incsearch
" Ignore case when searching
set ignorecase smartcase
" Ignore case when searching lowercase
set smartcase

" Set the title of the iterm tab
set title

" Line numbering
set relativenumber
" show the current line number instead of 0 in relativenumber mode
set nu
" automatically reload file if it was changed
set autoread

" allow non saved buffers in the background
set hidden

""" Undo #undo
" undofile - This allows you to use undos after exiting and restarting
" This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
" :help undo-persistence
" This is only present in 7.3+
if isdirectory($HOME . '/.config/nvim/undo') == 0
  :silent !mkdir -p ~/.config/nvim/undo > /dev/null 2>&1
endif
set undodir=./.vim-undo//
set undodir+=~/.vim/undo//
set undofile


" makes the history a little bit greater
set history=200

nnoremap <C-k> :lnext<CR>
nnoremap <C-j> :lprev<CR>
nnoremap <C-K> :cnext<cr>
nnoremap <C-J> :cprev<cr>

" remap escape in insert mode
imap uu <Esc>
"""""""""""""" End Basics

"""""""""""""" Plugins #plugins
call plug#begin()

Plug 'takac/vim-hardtime'
  let g:hardtime_default_on = 1
  let g:list_of_normal_keys = ["h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
  let g:list_of_visual_keys = ["h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
  let g:list_of_insert_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
  let g:list_of_disabled_keys = []
  let g:hardtime_timeout = 1000
  let g:hardtime_showmsg = 0
""" Filetypes #filetypes
" Polyglot loads language support on demand!
"Plug 'sheerun/vim-polyglot'
 " let g:polyglot_disabled = ['elm']
" HTML / JS / CSS
Plug 'othree/html5.vim'
Plug 'vim-scripts/html-improved-indentation'
Plug 'pangloss/vim-javascript'
" Plug 'flowtype/vim-flow'
" Plug 'wokalski/autocomplete-flow'
Plug 'mattn/emmet-vim'
" For func argument completion
" Plug 'Shougo/neocomplete.vim'
" Plug 'Shougo/neosnippet'
" Plug 'Shougo/neosnippet-snippets'
"   imap <C-s> <Plug>(neosnippet_expand_or_jump)
"   smap <C-s> <Plug>(neosnippet_expand_or_jump)
"   xmap <C-s> <Plug>(neosnippet_expand_target)

  " SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
" imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" Go
Plug 'fatih/vim-go'
" Elixir
Plug 'elixir-lang/vim-elixir'
"Plug 'slashmili/alchemist.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

Plug 'mhinz/vim-mix-format'
  let g:mix_format_on_save = 1
Plug 'vim-test/vim-test'
  nnoremap <leader>tn :TestNearest<CR>
  nnoremap <leader>tf :TestFile<CR>
  nnoremap <leader>ts :TestSuite<CR>
  nnoremap <leader>tl :TestLast<CR>
  nnoremap <leader>tv :TestVisit<CR>
  let test#strategy = "basic"
  let test#elixir#exunit#options = '--no-start --trace'
Plug 'kassio/neoterm'
  let g:neoterm_size='70'
  let g:neoterm_default_mod = 'vertical'
  let g:neoterm_autoscroll = 1
  let g:neoterm_repl_ruby = 'pry'
  let g:neoterm_keep_term_open = 1

  nnoremap <silent> <leader>th :Tclose<CR>
  nnoremap <silent> <leader>tl :Tclear<CR>
  nnoremap <silent> <leader>tk :Tkill<CR>

"Plug 'slashmili/alchemist.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" let g:mix_format_on_save = 1
""" Add support for ANSI colors - this has variously been necessary and caused
""" problems, no clue what's up there...
"  Plug 'powerman/vim-plugin-AnsiEsc'

" Phoenix
Plug 'c-brenn/phoenix.vim'
Plug 'tpope/vim-projectionist' " required for some navigation features

" Database
Plug 'tpope/vim-dadbod'
" Elm
"Plug 'ElmCast/elm-vim'
"  let g:elm_format_autosave = 1
"  let g:elm_detailed_complete = 1
"  let g:elm_syntastic_show_warnings = 1
"  let g:elm_format_fail_silently = 1
"  let g:elm_browser_command = 'open'
"  let g:elm_make_show_warnings = 1
"  let g:elm_setup_keybindings = 1

" Fuse
"Plug 'BeeWarloc/vim-fuse'

" Markdown
function! NpmInstallAndUpdateRemotePlugins(info)
  !npm install
  UpdateRemotePlugins
endfunction
Plug 'neovim/node-host', { 'do': function('NpmInstallAndUpdateRemotePlugins') }
Plug 'vimlab/mdown.vim', { 'do': function('NpmInstallAndUpdateRemotePlugins') }

""" Utilities #utilities
Plug 'bogado/file-line'
Plug 'mileszs/ack.vim'

" Plug 'preservim/nerdtree'
"    nnoremap <leader>s :NERDTreeFocus<Cr>
" Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'lambdalisue/nerdfont.vim'
" Plug 'ryanoasis/vim-devicons'

" Easily toggle quickfix and locations lists with <leader>l and <leader>q
Plug 'milkypostman/vim-togglelist'

"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
 " let g:deoplete#enable_at_startup = 1
  " use tab for completion
  "inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
  "let g:deoplete#sources = {}
  "let g:deoplete#sources._ = ['file', 'neosnippet']
  "let g:deoplete#omni#functions = {}
  "let g:deoplete#omni#input_patterns = {}

  " Elm support
  " h/t https://github.com/ElmCast/elm-vim/issues/52#issuecomment-264161975
  " let g:deoplete#sources.elm = ['omni'] + g:deoplete#sources._
  " let g:deoplete#omni#functions.elm = ['elm#Complete']
  " let g:deoplete#omni#input_patterns.elm = '[^ \t]+'
  " let g:deoplete#disable_auto_complete = 1

  "Plug 'ervandew/supertab'

" Add comment textobjects (I really want to reformat comments without affecting
" the next line of code)
Plug 'kana/vim-textobj-user' | Plug 'glts/vim-textobj-comment'
  " Example: Reformat a comment with `gqac` (ac is "a comment")

Plug 'kana/vim-textobj-entire'
  " vim-textobj-entire provides two text objects:
" * `ae` targets the entire content of the current buffer.
" * `ie` is similar to `ae`, but `ie` does not include leading and trailing empty
"   lines.  `ie` is handy for some situations.  For example,
"     1. Paste some text into a new buffer (`<C-w>n"*P`)
"        -- note that the initial empty line is left as the last line.
"     2. Edit the text (`:%s/foo/bar/g` etc)
"     3. Then copy the resulting text to another application (`"*yie`)

Plug 'michaeljsmith/vim-indent-object'
" This plugin defines two new text objects. These are very similar - they differ
" only in whether they include the line below the block or not.
"
" | Key bindings | Description                                                 |
" | ------------ | ----------------------------------------------------------- |
" | `<count>ai`  | **A**n **I**ndentation level and line above.                |
" | `<count>ii`  | **I**nner **I**ndentation level (**no line above**).        |
" | `<count>aI`  | **A**n **I**ndentation level and lines above/below.         |
" | `<count>iI`  | **I**nner **I**ndentation level (**no lines above/below**). |
"
" **Note:** the `iI` mapping is mostly included simply for completeness, it is
" effectively a synonym for `ii`.

Plug 'andyl/vim-textobj-elixir'
" ## Simple one operator-pending mapping `e`
"
" Elixir text objects include: 'setup_all', 'setup', 'describe', 'test',
" 'unless', 'quote', 'case', 'cond', 'when', 'with', 'for', 'if',
" 'defprotocol', 'defmodule', 'defmacro', 'defmacrop', 'defimpl', 'defp',
" 'def'.
"
" Example:
"
" `#\%` is the place of your cursor.
"
" ```elixir
" def hoge(yo) do
"   if yo do
"     IO.puts "yo!"
"     #\%
"   end
"   IO.puts "everyone!"
" end
" ```
"
" Typing `dae` removes whole `if` block
Plug 'kana/vim-textobj-line'

Plug 'vim-scripts/argtextobj.vim'
" Examples:
"   case1) delete An argument
"       function(int arg1,    ch<press 'daa' here>ar* arg2="a,b,c(d,e)")
"       function(int arg1<cursor here; and if you press 'daa' again..>)
"       function(<cursor>)
"
"   case2) change Inner argument
"       function(int arg1,    ch<press 'cia' here>ar* arg2="a,b,c(d,e)")
"       function(int arg1,    <cursor here>)
"
"   case 3) smart argument recognition (g:argumentobject_force_toplevel = 0)
"        function(1, (20<press 'cia' here>*30)+40, somefunc2(3, 4))
"        function(1, <cursor here>, somefunc2(3, 4))
"
"        function(1, (20*30)+40, somefunc2(<press 'cia' here>3, 4))
"        function(1, (20*30)+40, somefunc2(<cursor here>4))
"
"   case 4) smart argument recognition (g:argumentobject_force_toplevel = 1)
"        function(1, (20<press 'cia' here>*30)+40, somefunc2(3, 4))
"        function(1, <cursor here>, somefunc2(3, 4)) " note that this result is the same of above.
"
"        function(1, (20*30)+40, somefunc2(<press 'cia' here>3, 4))
"        function(1, (20*30)+40, <cursor here>) " sub-level function is deleted because it is a argument in terms of the outer function.


Plug 'christoomey/vim-system-copy'
" Usage
" -----
"
" System copy provides a mapping to copy to the system clipboard using a motion
" or visual selection. It also provides a mapping for pasting from the system
" clipboard.
"
" The default mapping is `cp` for copying and `cv` for pasting, and can be followed by any motion or text
" object. For instance:
"
" - `cpiw` => copy word into system clipboard
" - `cpi'` => copy inside single quotes to system clipboard
" - `cvi'` => paste inside single quotes from system clipboard
"
" In addition, `cP` is mapped to copy the current line directly.
"
" The sequence `cV` is mapped to paste the content of system clipboard to the
" next line.

Plug 'christoomey/vim-titlecase'
" Usage
" -----
"
" The main interface to the plugin is via the `<Plug>Titlecase` operator, by
" default mapped to `gt`.
"
" The `gt` mapping will wait for a text object or motion before completing the
" titlecase operation. This means `gti'` will titlecase inside of single quotes,
" `gtap` will titlecase a paragraph, etc. `gt` will also work on a visual
" selection.
"
" In addition, `gT` will titlecase the current line.

Plug 'christoomey/vim-sort-motion'
" Usage
" -----
" Linewise
"
" The primary interface to this plugin is via the gs mapping, for sorting based on a text object or motion. To use the mapping, type gs followed by a motion, ie 2j to sort down two lines.
"
" Examples:
"
" gs2j => Sort down two lines (current + 2 below)
" gsip => Sort the current paragraph
" gsii => Sort the current indentation level (requires text-obj-indent plugin)
" Character
"
" In addition, if the text object is within a line then sort-motion will attempt to sort the text as a comma separated list.
"
" Examples:
"
" gsi( => Sort within parenthesis. (b, c, a) would become (a, b, c)

" Plug 'vim-scripts/ReplaceWithRegister'
" USAGE
" [count]["x]gr{motion}   Replace {motion} text with the contents of register x.
"                         Especially when using the unnamed register, this is
"                         quicker than "_d{motion}P or "_c{motion}<C-R>"
" [count]["x]grr          Replace [count] lines with the contents of register x.
"                         To replace from the cursor position to the end of the
"                         line use ["x]gr$
" {Visual}["x]gr          Replace the selection with the contents of register x.


" EditorConfig support
"Plug 'editorconfig/editorconfig-vim'

" Jump between quicklist, location (syntastic, etc) items with ease, among other things
Plug 'tpope/vim-unimpaired'
Plug 'stefandtw/quickfix-reflector.vim'
" Usage
" =====
"
" In the quickfix window, simply edit any entry you like. Once you save the quickfix buffer, your changes will be made in the actual file an entry points to.
"
" You can also delete lines in the quickfix window. This way, you can first review the quickfix list, remove all entries you don't care to change, and then use `%s/foo/bar` (or anything else) on the rest.

Plug 'wellle/targets.vim'
" Usage
" =====
"
" Check https://github.com/wellle/targets.vim

" Line commenting
Plug 'tomtom/tcomment_vim'
  " By default, `gc` will toggle comments
Plug 'unblevable/quick-scope'
  let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

"Plug 'janko-m/vim-test'                " Run tests with varying granularity
"  nmap <silent> <leader>t :TestNearest<CR>
"  nmap <silent> <leader>T :TestFile<CR>
"  nmap <silent> <leader>a :TestSuite<CR>
"  nmap <silent> <leader>l :TestLast<CR>
"  nmap <silent> <leader>g :TestVisit<CR>
  " run tests in neoterm
"  let g:test#strategy = 'neoterm'
  " I use spinach, not cucumber!
"  let g:test#ruby#cucumber#executable = 'spinach'

" Asynchronous file linter
" Plug 'w0rp/ale'
"   " wait a bit before checking syntax in a file, if typing
"   let g:ale_lint_delay = 5000
"   " Use global eslint
"   let g:ale_javascript_eslint_use_global = 1
"   " Only use es6 for js
"   let g:ale_linters = {'javascript': ['eslint']}

" git support from dat tpope
Plug 'tpope/vim-fugitive'

Plug 'airblade/vim-gitgutter'

" github support from dat tpope
Plug 'tpope/vim-rhubarb'

" vim interface to web apis.  Required for gist-vim
"Plug 'mattn/webapi-vim'

" create gists trivially from buffer, selection, etc.
Plug 'mattn/gist-vim'
  let g:gist_open_browser_after_post = 1
  let g:gist_detect_filetype = 2
  let g:gist_post_private = 1
  if has('macunix')
    let g:gist_clip_command = 'pbcopy'
  endif

" visualize your undo tree
Plug 'mbbill/undotree'
  nnoremap <F5> :UndotreeToggle<CR>

" org-mode
"Plug 'jceb/vim-orgmode'
"  let g:org_agenda_files = ['~/org/index.org']
"  let g:org_export_emacs = '/usr/local/bin/emacs'
"  let g:org_export_verbose = 1

" universal text linking
"Plug 'vim-scripts/utl.vim'

" allow portions of a file to use different syntax
"Plug 'vim-scripts/SyntaxRange'

" increment dates like other items
"Plug 'tpope/vim-speeddating'

" calendar application
"Plug 'itchyny/calendar.vim'
"  let g:calendar_google_calendar = 1
"  let g:calendar_google_task = 1

" nicer api for neovim terminal
Plug 'kassio/neoterm'


""" UI Plugins #ui-plugins
" Molokai theme makes me cozy
"Plug 'tomasr/molokai'
"Plug 'fmoralesc/molokayo'
" Try out the ayu theme - https://github.com/ayu-theme/ayu-vim
"Plug 'ayu-theme/ayu-vim'
" Solarized - variant with specific terminal support
"Plug 'lifepillar/vim-solarized8'
"Plug 'Rigellute/shades-of-purple.vim'
"  let g:shades_of_purple_airline = 1

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'tomasiser/vim-code-dark'
Plug 'rakr/vim-one'
  let g:airline_theme = 'one'
  "let g:airline_theme = 'lucius'
  "let g:airline_theme = 'one'
  let g:bufferline_echo = 0
  let g:airline_powerline_fonts=0
  let g:airline_enable_branch=1
  let g:airline_enable_syntastic=1
  let g:airline_branch_prefix = '⎇ '
  let g:airline_paste_symbol = '∥'
  let g:airline#extensions#tabline#enabled = 0

Plug 'luochen1990/rainbow'
  let g:rainbow_active = 1
Plug 'nathanaelkane/vim-indent-guides'
  let g:indent_guides_enable_on_vim_startup = 1
""" Code Navigation #code-navigation
" fzf fuzzy finder
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf.vim'
"   let g:fzf_layout = { 'window': 'enew' }
"   nnoremap <silent> <C-P> :GFiles<cr>
"   nnoremap <silent> <leader>a :Ag<cr>
"   augroup localfzf
"     autocmd!
"     autocmd FileType fzf :tnoremap <buffer> <C-J> <C-J>
"     autocmd FileType fzf :tnoremap <buffer> <C-K> <C-K>
"     autocmd VimEnter * command! -bang -nargs=* Ag
"       \ call fzf#vim#ag(<q-args>,
"       \                 <bang>0 ? fzf#vim#with_preview('up:60%')
"       \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
"       \                 <bang>0)
"   augroup END

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'



" Open files where you last left them
Plug 'dietsche/vim-lastplace'

" motions with jumpmarks
Plug 'easymotion/vim-easymotion'
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
" Execute code checks, find mistakes, in the background
" Plug 'neomake/neomake'
"   " Run Neomake when I save any buffer
  " augroup localneomake
  "   autocmd! BufWritePost * Neomake
  " augroup END
"   " Don't tell me to use smartquotes in markdown ok?
  " let g:neomake_markdown_enabled_makers = []
"
"   " Configure a nice credo setup, courtesy https://github.com/neomake/neomake/pull/300
  " let g:neomake_elixir_enabled_makers = ['mix', 'mycredo']
  " function! NeomakeCredoErrorType(entry)
  "   if a:entry.type ==# 'F'      " Refactoring opportunities
  "     let l:type = 'W'
  "   elseif a:entry.type ==# 'D'  " Software design suggestions
  "     let l:type = 'I'
  "   elseif a:entry.type ==# 'W'  " Warnings
  "     let l:type = 'W'
  "   elseif a:entry.type ==# 'R'  " Readability suggestions
  "     let l:type = 'I'
  "   elseif a:entry.type ==# 'C'  " Convention violation
  "     let l:type = 'W'
  "   else
  "     let l:type = 'M'           " Everything else is a message
  "   endif
  "   let a:entry.type = l:type
  " endfunction
  "
  " let g:neomake_elixir_mycredo_maker = {
  "       \ 'exe': 'mix',
  "       \ 'args': ['credo', 'list', '%:p', '--format=oneline'],
  "       \ 'errorformat': '[%t] %. %f:%l:%c %m,[%t] %. %f:%l %m',
  "       \ 'postprocess': function('NeomakeCredoErrorType')
  "       \ }

" Easily manage tags files
" Plug 'ludovicchabant/vim-gutentags'
"   let g:gutentags_cache_dir = '~/.tags_cache'

" navigate up a directory with '-' in netrw, among other things
Plug 'tpope/vim-vinegar'

" vifm file manager as the default vim file management tool
" Plug 'vifm/neovim-vifm'
" NOTE: I don't get highlighting with this and it's hard to see where the
" selection is

" Dash
Plug 'rizzatti/dash.vim'
" Tim Popes vim-surround
Plug 'tpope/vim-surround'
:nmap <silent> <leader>d <Plug>DashSearch

Plug 'junegunn/vim-peekaboo'
" Usage
" -----
"
" Peekaboo will show you the contents of the registers on the sidebar when you
" hit `"` or `@` in normal mode or `<CTRL-R>` in insert mode. The sidebar is
" automatically closed on subsequent key strokes.
"
" You can toggle fullscreen mode by pressing spacebar.

Plug 'jiangmiao/auto-pairs'
" Insert or delete brackets, parens, quotes in pair.

Plug 'godlygeek/tabular'
" Sometimes, it's useful to line up text.  Naturally, it's nicer to have the
" computer do this for you, since aligning things by hand quickly becomes
" unpleasant.  While there are other plugins for aligning text, the ones I've
" tried are either impossibly difficult to understand and use, or too simplistic
" to handle complicated tasks.  This plugin aims to make the easy things easy
" and the hard things possible, without providing an unnecessarily obtuse
" interface.  It's still a work in progress, and criticisms are welcome

Plug 'mg979/vim-visual-multi', {'branch': 'master'}
" It's called ___vim-visual-multi___ in analogy with _visual-block_, but the plugin works mostly from normal mode.
"
" Basic usage:
"
" - select words with <kbd>Ctrl-N</kbd> (like `Ctrl-d` in Sublime Text/VS Code)
" - create cursors vertically with <kbd>Ctrl-Down</kbd>/<kbd>Ctrl-Up</kbd>
" - select one character at a time with <kbd>Shift-Arrows</kbd>
" - press <kbd>n</kbd>/<kbd>N</kbd> to get next/previous occurrence
" - press <kbd>[</kbd>/<kbd>]</kbd> to select next/previous cursor
" - press <kbd>q</kbd> to skip current and get next occurrence
" - press <kbd>Q</kbd> to remove current cursor/selection
" - start insert mode with <kbd>i</kbd>,<kbd>a</kbd>,<kbd>I</kbd>,<kbd>A</kbd>
"
" Two main modes:
"
" - in _cursor mode_ commands work as they would in normal mode
" - in _extend mode_ commands work as they would in visual mode
" - press <kbd>Tab</kbd> to switch between «cursor» and «extend» mode
"
" Most vim commands work as expected (motions, <kbd>r</kbd> to replace characters, <kbd>~</kbd> to change case, etc). Additionally you can:
"
" - run macros/ex/normal commands at cursors
" - align cursors
" - transpose selections
" - add patterns with regex, or from visual mode
"
" And more... of course, you can enter insert mode and autocomplete will work.

Plug 'wincent/ferret'

Plug 'dbeniamine/cheat.sh-vim'
" This is a highly configurable vim plugin to browse cheat sheet from
" [cheat.sh](https://github.com/chubin/cheat.sh) directly from vim.
" ### How to use it
"
" The easiest way to use this plugin is to use one of the following mappings :
"
" + `K` get answer on the word under the cursor or the selection on a pager (this
" feature requires vim >= 7.4.1833, you can check if have the right version with :
" `:echo has("patch-7.4.1833")`)
" + `<leader>KK` same as `K` but works on lines or visual selection (not working
" on neovim, because they killed interactive commands with `:!`)
" + `<leader>KB` get the answer on a special buffer
" + `<leader>KR` Replace your question by the answer
" + `<leader>KP` Past the answer below your question
" + `<leader>KC` Replay last query, toggling comments
" + `<leader>KE` Send first error to cht.sh
" + `<leader>C` Toggle showing comments by default see [configuration](#configuration)
" + `<leader>KL` Replay last query
call plug#end()

"" Plugin configuration that has to run after plug#end

"""""""""""""" End Plugins


"""""""""""""" UI Tweaks #ui-tweaks
""" Theme #theme
if (empty($TMUX))
  if (has('termguicolors'))
    set termguicolors
  endif
endif
set background=dark
"set background=light
syntax enable
colorscheme one

" Ayu theme config
"let ayucolor="light"  " for light version of theme
"let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
" colorscheme ayu
"colorscheme solarized8_light_flat
"colorscheme solarized8_dark_flat

""" Keyboard
" Remove highlights
" Clear the search buffer when hitting return
nnoremap <silent> <cr> :nohlsearch<cr>

" NO ARROW KEYS COME ON
"map <Left>  :echo "no!"<cr>
"map <Right> :echo "no!"<cr>
"map <Up>    :echo "no!"<cr>
"map <Down>  :echo "no!"<cr>

" Custom split opening / closing behaviour
map <C-N> :vsp<CR><C-P>
map <C-C> :q<CR>
" Remap window switching
" nmap <C-w><Left> <C-w>h
" nmap <C-w><Right> <C-w>l
" nmap <C-w><Up> <C-w>j
" nmap <C-w><Down> <C-w>k
" Custom tab opening behaviour
map <leader>n :tabnew .<CR><C-P>

" reselect pasted content:
noremap gV `[v`]

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Split line (sister to [J]oin lines above)
" The normal use of S is covered by cc, so don't worry about shadowing it.
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" Open the alternate file
map ,, <C-^>

" Makes foo-bar considered one word
set iskeyword+=-

""" Auto Commands ====================== #auto-cmd

" A helper function to restore cursor position, window position, and last search
" after running a command.  From:
" http://stackoverflow.com/questions/15992163/how-to-tell-vim-to-auto-indent-before-saving
function! Preserve(command)
  " Save the last search.
  let search = @/

  " Save the current cursor position.
  let cursor_position = getpos('.')

  " Save the current window position.
  normal! H
  let window_position = getpos('.')
  call setpos('.', cursor_position)

  " Execute the command.
  execute a:command

  " Restore the last search.
  let @/ = search

  " Restore the previous window position.
  call setpos('.', window_position)
  normal! zt

  " Restore the previous cursor position.
  call setpos('.', cursor_position)
endfunction

" Re-indent the whole buffer.
function! Indent()
  call Preserve('normal gg=G')
endfunction

""""" Filetypes ========================
augroup erlang
  autocmd!
  autocmd BufNewFile,BufRead *.erl setlocal tabstop=4
  autocmd BufNewFile,BufRead *.erl setlocal shiftwidth=4
  autocmd BufNewFile,BufRead *.erl setlocal softtabstop=4
  autocmd BufNewFile,BufRead relx.config setlocal filetype=erlang
augroup END

" augroup elixir
"   autocmd!
"   " autocmd BufWritePre *.ex call Indent()
"   " autocmd BufWritePre *.exs call Indent()
"   "
"   " Sadly, I can't enable auto-indent for elixir because it messes up my heredoc
"   " indentation for code sections and it has a couple of other issues :(
"   autocmd BufNewFile,BufRead *.ex setlocal formatoptions=tcrq
"   autocmd BufNewFile,BufRead *.exs setlocal formatoptions=tcrq
" augroup END

augroup elm
  autocmd!
  autocmd BufNewFile,BufRead *.elm setlocal tabstop=4
  autocmd BufNewFile,BufRead *.elm setlocal shiftwidth=4
  autocmd BufNewFile,BufRead *.elm setlocal softtabstop=4
augroup END

augroup dotenv
  autocmd!
  autocmd BufNewFile,BufRead *.envrc setlocal filetype=sh
augroup END

augroup es6
  autocmd!
  autocmd BufNewFile,BufRead *.es6 setlocal filetype=javascript
  autocmd BufNewFile,BufRead *.es6.erb setlocal filetype=javascript
augroup END

augroup markdown
  autocmd!
  autocmd FileType markdown setlocal textwidth=80
  autocmd FileType markdown setlocal formatoptions=tcrq
  autocmd FileType markdown setlocal spell spelllang=en
augroup END

augroup viml
  autocmd!
  autocmd FileType vim setlocal textwidth=80
  autocmd FileType vim setlocal formatoptions=tcrq
augroup END
""""" End Filetypes ====================

""""" Normalization ====================
" Delete trailing white space on save
func! DeleteTrailingWS()
  exe 'normal mz'
  %s/\s\+$//ge
  exe 'normal `z'
endfunc

augroup whitespace
  autocmd BufWrite * silent call DeleteTrailingWS()
augroup END
""""" End Normalization ================
""" End Auto Commands ==================

""" Navigation ====================== #navigation
" Navigate terminal with C-h,j,k,l
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" Navigate splits with C-h,j,k,l
nnoremap <C-Left> <C-w>h
nnoremap <C-Up> <C-w>j
nnoremap <C-Down> <C-w>k
nnoremap <C-Right> <C-w>l
"nnoremap <silent> <BS> <C-w>h
  " Have to add this because hyperterm sends backspace for C-h

" Go to last edited buffer with tab in normal mode
nmap <tab> :b#<cr>
""" End Navigation ==================

" Activate the matchit plugin
runtime macros/matchit

" Code Intelligence ---------------------------------------------- "

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> <leader>co :<C-u]CocList outline<CR>

" Show an outline of the current file.
nnoremap <silent> <leader>co :<C-u>CocList outline<CR>

" Show documentation of current symbol.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


