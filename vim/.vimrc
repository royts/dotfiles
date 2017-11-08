set number
" Vundle start
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"Plugin 'pangloss/vim-javascript'
"Plugin 'crusoexia/vim-javascript-lib'
"Plugin 'Raimondi/delimitMate'
Plugin 'Valloric/YouCompleteMe'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
"Plugin 'editorconfig/editorconfig-vim'
Plugin 'vim-airline/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'crusoexia/vim-monokai'
"Plugin 'ruanyl/vim-fixmyjs'
Plugin 'w0rp/ale'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

" to install plugins -  Launch vim and run :PluginInstall
" Vundle end
let g:ale_fixers = {'javascript': ['eslint']}

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
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
"let g:ctrlp_custom_ignore = {
    "\ 'dir':  '\.git$\|\.hg$\|\.svn$\|bower_components$\|dist$\|node_modules$\|project_files$\',
    "\ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard', 'git --git-dir=~/.git ls-files -oc --exclude-standard']

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
"noremap <F3> :Autoformat<CR>
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
