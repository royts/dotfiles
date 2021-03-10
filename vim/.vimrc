set relativenumber

"""""""""""""""""" Vubdle start
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'pangloss/vim-javascript'
"Plugin 'crusoexia/vim-javascript-lib'
"Plugin 'mxw/vim-jsx'
Plugin 'Raimondi/delimitMate'
Plugin 'Valloric/YouCompleteMe'
"Plugin 'kien/ctrlp.vim'
Plugin 'elzr/vim-json'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'vim-airline/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'crusoexia/vim-monokai'
"Plugin 'ruanyl/vim-fixmyjs'
Plugin 'w0rp/ale'
Plugin 'tpope/vim-surround'
set rtp+=/usr/local/opt/fzf
Plugin 'junegunn/fzf.vim'
Plugin 'moll/vim-node'
Plugin 'mxw/vim-jsx'
Plugin 'mileszs/ack.vim'
Plugin 'dhruvasagar/vim-table-mode'
"Plugin 'chrisbra/csv.vim'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
"
" see :h vundle for more details or wiki for FAQ
"""""""""""""""""""""" Vundle end

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

noremap <F3> :ALEFix<CR>
let g:ale_sign_column_always = 1
let g:ale_echo_msg_format = '[%linter%] %s'
let g:ale_sign_error = 'E>'
let g:ale_sign_warning = 'W>'
highlight ALEWarning ctermbg=DarkMagenta
highlight ALEError ctermbg=DarkMagenta
" let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_linter_aliases = {'mjs': ['javascript'],'js': ['javascript']}
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'json': ['prettier'],
\   'python': ['autopep8'],
\   'html': ['prettier']
\}
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'json': ['prettier'],
\   'python': ['flake8'],
\   'mjs': ['eslint']
\}
au BufNewFile,BufRead *.mjs             set filetype=javascript
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

map <C-p> :GFiles<CR>
map <C-s> :Ag·

" colors
set t_Co=256
syntax on
"set background=dark
"colorscheme distinguished
colorscheme monokai

" make backspace work like most other apps
set backspace=indent,eol,start

let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
set completeopt-=preview

" ctrlp
"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP'
"let g:ctrlp_custom_ignore = {
    "\ 'dir':  '\.git$\|\.hg$\|\.svn$\|bower_components$\|dist$\|node_modules$\|project_files$\',
    "\ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }
"let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard', 'git --git-dir=~/.git ls-files -oc --exclude-standard']

" syntastic
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_json_checkers = ['eslint']
"let g:syntastic_python_checkers = ['flake8']
"let g:syntastic_enable_signs=1
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

" nerdtree
 map <C-e> :NERDTreeToggle<CR>
 map <leader>r :NERDTreeFind<cr>
 autocmd BufEnter * lcd %:p:h

" autoformat
"noremap <F3> :Fixmyjs<CR>

" vim-airline
set laststatus=2

 "disable help key F1
 :nmap <F1> :echo<CR>
 :imap <F1> <C-o>:echo<CR>

 " check spelling
 "set spell spelllang=en_us
 "turned off. instead - just type: :set spell!
 
 " Split to right by default
 set splitright

" Allow background buffers without saving
 set hidden 

" mappings
:imap jj <Esc>
:imap ^^ :lclose
nnoremap te  :tabedit<Space>

" Console log from insert mode; Puts focus inside parentheses
imap clog console.log();<Esc>==f(a
" Console log from visual mode on next line, puts visual selection inside parentheses
vmap clog yocll<Esc>p
" Console log from normal mode, inserted on next line with word your on inside parentheses
nmap clog yiwocll<Esc>p

:set ignorecase
:set smartcase
" /copyright      " Case insensitive
" /Copyright      " Case sensitive
" /copyright\C    " Case sensitive
" /Copyright\c    " Case insensitive

" cursor shape change between modes
let &t_SI="\033[4 q" " start insert mode
let &t_EI="\033[1 q" " end insert mode

" highlight searches
:set hlsearch
:highlight Search ctermbg=black ctermfg=yellow term=underline

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>
set expandtab
set mouse=a
set clipboard=unnamedplus
