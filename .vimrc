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
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'davidhalter/jedi-vim'
"Plugin 'Rip-Rip/clang_complete'
Plugin 'ycm-core/YouCompleteMe'
"Plugin 'Shougo/neocomplete.vim'
"Plugin 'ervandew/supertab'
"Plugin 'Chiel92/vim-autoformat'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'tell-k/vim-autopep8'
Plugin 'lervag/vimtex'

Plugin 'flazz/vim-colorschemes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'joshdick/onedark.vim'

Plugin 'wesQ3/vim-windowswap'

Plugin 'jiangmiao/auto-pairs'

Plugin 'rickhowe/diffchar.vim'

"doc/NERD_commenter.txt
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

"Plugin 'nathanaelkane/vim-indent-guides'

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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"windows下的设置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backspace=indent,eol,start


if has("gui_running")
	"设置字体
	"set guifont=楷体:h10:cGB2312
	"set guifont=KaiTi:h10:cGB2312
	"set guifont=DejaVu\ Sans\ Mono:h11:cGREEK
	set encoding=utf-8
	set fileencodings=utf-8,chinese,latin-1

	if has("win32")
		set fileencoding=chinese
	else
		set fileencoding=utf-8
	endif

	let &termencoding=&encoding

	"解决菜单乱码
	source $VIMRUNTIME/delmenu.vim
	source $VIMRUNTIME/menu.vim

	"解决consle输出乱码
	language messages zh_CN.utf-8

else
	set t_Co=256
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"color scheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
"set background=light
"colorscheme default
"colorscheme solarized
colorscheme molokai
"colorscheme onedark
"colorscheme github

if &diff
	colorscheme github
endif
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
""If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more
"information.)
"if (empty($TMUX))
"if (has("nvim"))
""For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
"let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"endif
""For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
""Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
"" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
"if (has("termguicolors"))
"set termguicolors
"endif
"endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"常规设置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable

set encoding=utf-8
set nu
set cul
set ruler
set scrolloff=3 "光标移动到buffer的底部和顶部时保持3行距离
set langmenu=zh_CN.UTF-8
"set mouse=a
set mouse=n
set showmatch
set hlsearch
"让vim记忆上次编辑的位置
autocmd BufReadPost *
			\ if line("'\"")>0&&line("'\"")<=line("$") |
			\	exe "normal g'\"" |
			\endif

"开启光亮光标行
set cursorline
hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white

"开启高亮光标列
set cursorcolumn
hi Cursorcolumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white

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
set foldmethod=syntax
set foldnestmax=20
set nofoldenable
set foldlevel=1
" press space to fold/unfold code
nnoremap <space> za
vnoremap <space> zf
"nnoremap <F5> zM
nnoremap <F5> :call FoldFile()<CR>
nnoremap <F6> zR


"define FoldFile()
func FoldFile()
	if &filetype == 'py'||&filetype == 'python'
		set foldmethod=indent
	elseif &filetype == 'c'||&filetype == 'cpp'||&filetype == 'h'||&filetype == 'hpp'
		set foldmethod=syntax
	else
		set foldmethod=syntax
	endif
	exec "normal zM"
endfunc
"end FoldFile


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Plugin 'nathanaelkane/vim-indent-guides'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:indent_guides_enable_on_vim_startup=1
"let g:indent_guides_start_level=2
"hi IndentGuidesOdd  ctermbg=black
"hi IndentGuidesEven ctermbg=darkgrey
"let g:indent_guides_auto_colors = 1
"let g:indent_guides_guide_size = 1
"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Plugin 'davidhalter/jedi-vim'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:jedi#popup_on_dot = 0
"let g:jedi#show_call_signatures = "2"
"let g:jedi#use_splits_not_buffers = "right"
"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Plugin 'majutsushi/tagbar'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tagbar_left = 1



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"快捷键
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F3> :NERDTreeToggle<CR>
nmap <F4> :TagbarToggle<CR>
"noremap <F9> :Autoformat<CR>
noremap <F9> :call FormartSrc()<CR>
"map <F9> :Autopep8<CR>
map <F7> :tabnew<CR>

" CUDA filetype
"au BufNewFile,BufRead *.cu set ft=cu
" Map cuda files to c++
autocmd BufNewFile,BufRead *.cu set filetype=cpp

"define FormartSrc()
func FormartSrc()
	exec "w"
	if &filetype == 'py'||&filetype == 'python'
		"exec "r !autopep8 -i --aggressive %"
		"exec "!autopep8 -i --aggressive %"
		exec "r !yapf -i --style pep8 %"
	elseif &filetype == 'c'||&filetype == 'cpp'||&filetype == 'h'||&filetype == 'hpp'
		exec "r !clang-format -i -style Google %"
	else
		exec "normal gg=G"
		exec "w"
		return
	endif
	exec "e! %"
endfunc
"end FormartSrc

" show Todo list
"command TODO noautocmd vimgrep /TODO\|FIXME/j ** | cw

" recursively in all subdirectories of the current directory
command TODO noautocmd vimgrep /TODO/j ** | cw
" only in the current file
command Todo noautocmd vimgrep /TODO/j % | cw


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"函数注释文档生成
"vim-scripts/DoxygenToolkit.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:DoxygenToolkit_briefTag_pre="@Synopsis  "
let g:DoxygenToolkit_paramTag_pre="@Param "
let g:DoxygenToolkit_returnTag="@Returns   "
let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
let g:DoxygenToolkit_blockFooter="--------------------------------------------------------------------------"
let g:DoxygenToolkit_authorName="Shen Yunhang"
let g:DoxygenToolkit_licenseTag="YH license"
map dox : Dox<cr>


python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
