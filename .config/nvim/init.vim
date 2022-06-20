nnoremap <SPACE> <Nop>
let mapleader = " "
"" Reload vim config
nnoremap <leader><S-r> :source $MYVIMRC<CR>

syntax enable
filetype plugin indent on 
set nocompatible      	" use vim-defaults instead of vi-defaults (easier, more user friendly)
set nowrap              " dont wrap lines
set incsearch
set ignorecase
set encoding=utf-8
"set scrolloff=8
set smartcase           
set cindent
set smarttab            " smart tab handling for indenting
set history=50          " keep 50 lines of command history
set relativenumber
set nu rnu
set tabstop=4			" show existing tab with 4 spaces width
set shiftwidth=4 		" when indenting with '>', use 4 spaces width
set clipboard=unnamedplus
set wildmenu
set wildmode=longest:list,full
set wildignore+=*.o
set wildignore+=*.obj
set wildignore+=*.git
set wildignore+=*.bak
set wildignore+=*.exe
set wildignore+=*.py[co]
set wildignore+=*.swp
set wildignore+=**/.git/*
set wildignore+=**/node_modules/*
set exrc 				" Allows to have a .vimrc file specific for each project
set cmdheight=2 		" Give more space for displaying messages.
let g:autoformat_remove_trailing_spaces = 0


"" Customize colors
set t_Co=256
set termguicolors
set background=dark
autocmd vimenter * ++nested colorscheme gruvbox
let g:gruvbox_invert_selection=0

"" Status line
set laststatus=2 		" Status line
function! GitBranch()
	return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
	let l:branchname = GitBranch()
	return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%#PmenuSel#
if has('unix')
	set statusline+=%{StatuslineGit()}
endif
set statusline+=\

" Navigation

" Use backspace to swap last buffer
nnoremap <bs> <c-^>
" nnoremap <leader>1 :tab split<CR>
" nnoremap <leader>0 :q<CR>
nnoremap <leader>h :split<CR>
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>- :split<CR>
nnoremap <leader>\ :vsplit<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"" Auto close braces/parentheses
"inoremap " ""<left>
"inoremap ' ''<left>
"inoremap ( ()<left>
"inoremap [ []<left>
"inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
"inoremap [<CR> [<CR>]<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" yank 
call plug#begin(stdpath('config') . '/plugged')
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'
Plug 'https://tpope.io/vim/fugitive.git' "git
"Plug 'preservim/tagbar'
Plug 'vim-airline/vim-airline'
"Plug 'rust-lang/rust.vim'
"Plug 'rust-analyzer/rust-analyzer'
Plug 'mbbill/undotree'
"Plug 'dbeniamine/cheat.sh-vim'
"Plug 'vimwiki/vimwiki'

Plug 'Yggdroot/indentLine'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'nvim-treesitter/nvim-treesitter-context'
"Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'ThePrimeagen/harpoon'
Plug 'takac/vim-hardtime'
"Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-commentary' "use gcc to comment
Plug 'lervag/vimtex'
Plug 'fatih/vim-go'
Plug 'tomlion/vim-solidity'
Plug 'mattn/vim-goimports'
"Plug 'honza/vim-snippets'
Plug 'chrisbra/csv.vim'
Plug 'preservim/nerdtree'
" LSP
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig' 
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'onsails/lspkind-nvim'
" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'windwp/nvim-autopairs'
" Debugging
Plug 'mfussenegger/nvim-dap'
Plug 'leoluz/nvim-dap-go'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'nvim-telescope/telescope-dap.nvim'
call plug#end()

"" press <Tab> to expand or jump in a snippet. These can also be mapped separately
"" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
"imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
"" -1 for jumping backwards.
"inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
"
"snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
"snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
"
"" For changing choices in choiceNodes (not strictly necessary for a basic setup).
"imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
"smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'

nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>x :!chmod +x %<CR>
"" Telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fH <cmd>Telescope help_tags<cr>
nnoremap <leader>fo <cmd>Telescope oldfiles<cr>
nnoremap <leader>fr <cmd>Telescope lsp_references<cr>
nnoremap <leader>fs <cmd>Telescope lsp_document_symbols<cr>


nnoremap <silent><leader>a :lua require("harpoon.mark").add_file()<CR>
nnoremap <silent><C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <silent><leader>tc :lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>
nnoremap <silent><leader>1 :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <leader>m :! ./build.sh<CR>
	" nnoremap <leader>jr :! ./build.sh run<CR>
	" nnoremap <leader>jt :! ./build.sh test<CR>
elseif has('win64')
	"map <M-m> : !build.bat <CR>
endif

nmap <c-c> <esc>
vmap <c-c> <esc>
omap <c-c> <esc>


" Now apply macro with Q
nnoremap Q @q
vnoremap Q :norm @q<cr>

" Motion bindings so I can move around in insert
" inoremap <C-k> <C-o>gk
" inoremap <C-h> <Left>
" inoremap <C-l> <Right>
" inoremap <C-j> <C-o>gj

" Recenter vertically when moving around search occurrences
nnoremap n nzzzv
nnoremap n nzzzv

" When merging lines, first mark cursor position, then merge, then go back to position
nnoremap J mzJ`z

"This unsets the `last search pattern` register by hitting return
nnoremap <CR> :noh<CR>

nnoremap <leader>e :Ex<CR>
vnoremap <leader>p "_dP		" replace selection, but keep old yank
vnoremap <leader>y "+y		" yank to system clipboard
nnoremap <leader>Y gg"+yG 	" yank whole file to system clipboard

" Move selected lines up/down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"" Fugitive (git)
nmap <leader>gs :G<CR>

"" Blink when yanking
augroup highlight_yank
	autocmd!
	autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END


"" Golang
" enable auto format when write (default)
let g:go_fmt_command = 'goimports'


"" LaTeX
let g:vimtex_view_method = 'zathura'
let g:vimtex_view_general_viewer = 'evince'

"" Snippets
"ActivateAddons vim-snippets snipmate
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
"let g:UltiSnipsExpandTrigger="<c-s>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"

" Make .ejs files be considered html files
au BufNewFile,BufRead *.ejs set filetype=html

" ***************************
" 		DEBUGGING
" ***************************
fun GotoWindow(id)
	call win_gotoid(a:id)
endfun

"" Debugging
let g:vimspector_enable_mappings = 'HUMAN'
"nnoremap <leader>m :MaximizerToggle!<CR>
nnoremap <leader>dd : call vimspector#Launch()<CR>
nnoremap <leader>de : call vimspector#Reset()<CR>
nnoremap <leader>dr : call vimspector#Restart()<CR>

nnoremap <leader>dc : call GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dt : call GotoWindow(g:vimspector_session_windows.tagpage)<CR>
nnoremap <leader>dv : call GotoWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>dw : call GotoWindow(g:vimspector_session_windows.watches)<CR>
nnoremap <leader>ds : call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>do : call GotoWindow(g:vimspector_session_windows.output)<CR>

nnoremap <leader>drc : call vimspector#RunToCursor()<CR>
nnoremap <leader>db : call vimspector#ToggleBreakpoint()<CR>
nnoremap <leader>dcb <Plug>VimspectorToggleConditionalBreakPoint

nnoremap <leader>d<space> :call vimspector#Continue()<CR>
nnoremap <leader>dh <Plug>VimspectorRestart
nnoremap <leader>dj <Plug>VimspectorStepInto
nnoremap <leader>dk <Plug>VimspectorStepOver
nnoremap <leader>dl <Plug>VimspectorStepOut

" ***************************
" 		NERDTree
" ***************************
nnoremap <leader>n :NERDTreeFocus<CR>
"nnoremap <C-n> :NERDTree<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <silent> <C-f> :silent !tmux neww ~/config/tmux/tmux-sessionizer<CR>

lua require("init")
lua require("lsp-config")
lua require("treesitter")
"lua require("telescope")

