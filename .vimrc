" vim: set noexpandtab sw=4 ts=4:
"-----------关闭兼容----------
set nocompatible
"source $VIMRUNTIME/vimrc_example.vim

"-----------------------------
" 设置环境变量
"-----------------------------
" 统一缓存位置,避免在cygwin下出错
let $TMP=$VIM.'\temp'
let $TEMP=$TMP
let $SHELL='cmd'
" set directory=.,$TEMP

"-----------------------------
"-----------编码设定----------
"-----------------------------
"gvim内部编码
set encoding=utf-8
"当前编辑文件编码
set fileencoding=utf-8
"支持打开文件的编码
set fileencodings=ucs-bom,utf-8,gbk,cp936,gb2312,bug5,euc-jp,euc-kr,latinl
"解决console输出乱码
language messages zh_CN.utf-8
"解决菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"设置终端编码为gvim内部编码encoding
let &termencoding=&encoding

" 确保在终端模式下能正确编码
" 因为在window下只能是gbk
if !has('gui_running')
	set encoding=gbk
	set fileencoding=gbk
" 	" set fileencodings=ucs-bom,utf-8,gbk,cp936,gb2312,bug5,euc-jp,euc-kr,latinl
	language messages zh_CN.gbk
	let &termencoding=&encoding
end

" ----------------------------------------
" Plug-in configuration
" ----------------------------------------
" ==== minibuffer ====
" 用<C-T>，<C-S-T>切换窗口
let g:miniBufExplMapCTabSwitchBufs = 1

" autocmd BufReadPost *.c,*.h,*.cpp :set ts=4


" ==== taglist ====
" 持续处理tags
let Tlist_Process_File_Always = 1
" 在标题栏显示函数原型
" set title titlestring=%<%f\ %([%{Tlist_Get_Tag_Prototype_By_Line()}]%)
" 将标签窗口映射为<F8>
nnoremap <silent> <F8> :TlistToggle<CR>
nnoremap <silent> <C-F8> :TlistUpdate<CR>
" let Tlist_Ctags_Cmd = 'ctags --extra=-q --c++-kinds=-p'

"只显示一个文件
let Tlist_Show_One_File = 1
" 当只有tag窗口的时候退出vim
let Tlist_Exit_OnlyWindow = 1
let Tlist_Sort_Type = "order"
let Tlist_Display_Prototype = 0
let Tlist_Compact_Format = 1
" 当打开tag窗口的时候 跳转到窗口
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Display_Tag_Scope = 1 " Show tag scope next to the tag name.
" 当选择一个tag时 关闭tag窗口
let Tlist_Close_On_Select = 1
"不显示文件名
let Tlist_Enable_Fold_Column = 0
" let Tlist_WinWidth = 40

" --------------------
" ShowMarks
" --------------------
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
let g:showmarks_enable = 1
" For marks a-z
highlight ShowMarksHLl gui=bold guibg=LightBlue guifg=Blue
" For marks A-Z
highlight ShowMarksHLu gui=bold guibg=LightRed guifg=DarkRed
" For all other marks
highlight ShowMarksHLo gui=bold guibg=LightYellow guifg=DarkYellow
" For multiple marks on the same line.
highlight ShowMarksHLm gui=bold guibg=LightGreen guifg=DarkGreen

" ==== pathogen ====
" 调用pathogen 启用脚本
call pathogen#infect()
" ----------------------------------------
" GUI configuration
" ----------------------------------------

" a = 自动选择
" A = 自动选择无模式的选择
" c = 简单的选择使用控制台对话框而不是弹出式对话框
" e = tab页标签
" f = 前台
" i = 使用Vim图标
" m = 菜单栏
" M = 不执行系统菜单脚本 $VIMRUNTIME/menu.vim。
" g = 灰色菜单项
" t = 菜包含可撕下的菜单项
" T = 工具栏
" r = 右侧滚动条
" R = 如果有垂直分割的窗口，右边的滚动条总是存在
" l = 右边的滚动条总是存在
" L = 如果有垂直分割的窗口，左边的滚动条总是存在
" b = 底部的（水平）滚动条总是存在
" h = 限制水平滚动条的大小为光标所在行的长度
" v = 对话框使用垂直的按钮布局
set guioptions=fatg

set showtabline=1
set cmdheight=1
" 0: 从不显示
" 1: 需要时显示
" 2: 总是显示
set laststatus=1
" 显示行号
set number
" 行间距 单位为px
set linespace=0

" 设置字体
set guifont=Consolas:h11
" set guifontwide=Consolas:h11:cANSI
set guifontwide=YouYuan:b:h11:cGB2312
" so ~/_vimrc.gbk    

" ----------------------------------------
" 文本格式和显示
" ----------------------------------------

" 高亮当前行列
set cursorline
set cursorcolumn

set ruler
set nowrap
set cindent
set scrolloff=5
set sm		" Shortly jump to matching bracket

set noexpandtab	"expandtab = <Tab> inserts space
set tabstop=4
set shiftwidth=4

set textwidth=78
set softtabstop=0

" 使用unix文件格式
set ff=unix

" 显示不可见的字符 比如<TAB>
set list lcs=tab:│┈,trail:·,extends:>,precedes:<,nbsp:&
" set list lcs=tab:>-,trail:-,eol:<,extends:>

" formatoptions:
" c - autowrap COMMENTS using textwidth
" r - insert comment leader (?) on <enter>
" o - insert comment leader on 'o' or 'O'
" q - gq formats comments (?)
" n - recon numbered lists
" v - wrap on blanks
" t - autowrap TEXT using textwidth
set fo=croqnvt

" 总在窗口右下角显示当前光标位置
set showcmd

" 搜索设置
set ignorecase
set incsearch
" 颜色设置
colo molokai
" 常常使用这个配色 但是注释颜色不明显
hi Comment guifg=#ABCDEF


" 开启语法显示和搜索高亮
syntax on
set hlsearch

" 默认SQL方言设置
let g:sql_type_default = 'mysql'

" ----------------------------------------
" 操作
" ----------------------------------------

" 指明在哪里允许<BS>删除前面字符
set backspace=indent,eol,start
set sessionoptions+=unix,slash,winpos

" 自动检测文件类型缩进和脚本
filetype plugin indent on
" 设置换行移动
set whichwrap=b,s,<,>,[,],h,l

set mousehide
" setup backup
set nobackup

set history=50

set foldmethod=indent
set foldopen=all
set foldclose=all
set foldlevel=4

" ----------------------------------------
" 编辑器特性
" ----------------------------------------
" 当当前buffer没有保存时依然可以加载其他
set hidden
set bufhidden=hide

" 以js的高亮来显示json
autocmd BufNewFile,BufRead *.json set ft=javascript

" 自动切换当前工作目录
" set autochdir " 可能导致一些插件无法工作
" 仅当切换buffer的时候更改本地
autocmd BufEnter * silent! lcd %:p:h

autocmd! BufWritePost .vimrc so %

" ----------------------------------------
" 按键映射
" ----------------------------------------

" 键的映射
nmap	<C-Tab>		gt
nmap	<C-S-Tab>	gT
imap	<C-Tab>		<ESC>gta
imap	<C-S-Tab>	<ESC>gTa

imap	<C-S>		<ESC>:update<CR>a
vmap	<C-C>		"+ygv
imap	<C-V>		<ESC>"+pa
" cmap	<C-V>		<ESC>"+p
imap	<C-Z>		<ESC>ua

" 普通模式下 加入新行 不进入插入模式
nmap <S-Enter> O<ESC>
nmap <C-Enter> o<ESC>
" 在编辑模式下也可以直接插入行
imap <S-Enter> <Esc>O
imap <C-Enter> <Esc>o

" 手动重新加载配置文件
command! Loadconfig so $MYVIMRC

" 用因为键盘上Insert需要加FN才能使用
cmap <S-F12> <C-R><C-O>*

