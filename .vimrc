""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"常规设置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nu
set cul
set ruler
set scrolloff=3 "光标移动到buffer的底部和顶部时保持3行距离
set langmenu=zh_CN.UTF-8
"set mouse=a
set mouse=n
set showmatch
set hlsearch
:syntax on
"让vim记忆上次编辑的位置
autocmd BufReadPost *
			\ if line("'\"")>0&&line("'\"")<=line("$") |
			\	exe "normal g'\"" |
			\endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"缩进设置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" size of a hard tabstop
"set tabstop=4
"
" " size of an "indent"
"set shiftwidth=4
"
" " a combination of spaces and tabs are used to simulate tab stops at a width
" " other than the (hard)tabstop
"set softtabstop=4
"
" 自动检测文件类型并加载相应的设置
filetype plugin indent on
autocmd FileType python setlocal et sta sw=4 sts=4

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"ctags
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"ctags -R -f ~/.vim/systags --c-kinds=+p --fields=+S /usr/include /usr/local/include
set tags+=~/.vim/systags
:nmap ,t :!(cd %:p:h;ctags -R)&


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Python代码折叠
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldmethod=indent
set foldlevel=99 
" press space to fold/unfold code
nnoremap <space> za
vnoremap <space> zf
nnoremap <F5> zM
nnoremap <F6> zR


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Plugin 'davidhalter/jedi-vim'设置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:jedi#popup_on_dot = 0
"let g:jedi#show_call_signatures = "2"
"let g:jedi#use_splits_not_buffers = "right"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"快捷键
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F3> :NERDTreeToggle<CR>
nmap <F4> :TagbarToggle<CR>
map <F8> :call FormartSrc()<CR>
map <F7> :tabnew<CR>


"define FormartSrc()
func FormartSrc()
	exec "w"
	if &filetype == 'py'||&filetype == 'python'
		exec "r !autopep8 -i --aggressive %"
	elseif &filetype == 'c'||&filetype == 'cpp' ||&filetype =='h'
		exec "normal gg=G"
	else
		exec "normal gg=G"
	endif
	exec "e! %"
endfunc
"end FormartSrc


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"vundel插件管理设置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'davidhalter/jedi-vim'
"Plugin 'Rip-Rip/clang_complete'
Plugin 'Valloric/YouCompleteMe'
"Plugin 'Shougo/neocomplete.vim'
"Plugin 'ervandew/supertab'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
"Plugin 'AutoComplPop'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

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
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
