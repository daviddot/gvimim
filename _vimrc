﻿set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

" 本文件须保存为utf-8(BOM)格式

" 让Vim自动检测文件类型并加载相关插件
filetype on
filetype plugin on

" pyflakes
filetype plugin indent on

" 开启语法高亮
syntax on

" 颜色主题
colorscheme zellner

" 常规设置
if has("win32")

    " vim在与屏幕/键盘交互时用的编码
    "set termencoding = 
    
    " 打开文件时用的编码
    set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
     
    " 文件存储时的编码
    " set fileencoding =

    set lines=30
    set columns=120

    " 显示行号
    set nu

	" 不换行
	"set nowrap

    " 状态栏不自动消失
    " set laststatus=2

    " 设置缩进
    set shiftwidth=4
    set tabstop=4

	" 关闭备份
	set nobackup
	set nowritebackup

	" 移除菜单栏、工具栏和滚动条
	"set guioptions-=m
	"set guioptions-=T
	"set guioptions-=r
	"set guioptions-=b
	
	" 代码折叠 
	set foldmethod=syntax

	" 使用中文帮助
	set helplang=cn
	
	" gvim设置
	if has("gui_running")

    	" vim内部编码
    	set encoding=utf-8

		" 解决起始画面及标题乱码
		language messages zh_CN.utf-8

		" 解决菜单乱码
		source $VIMRUNTIME/delmenu.vim
		source $VIMRUNTIME/menu.vim
		
		" 字体设置
        set guifont=Menlo:h10
        "set guifont=Monaco:h9
		"set guifont=Consolas:h10
		"set guifont=Courier_New:h10
        set guifontwide=微软雅黑:h10

		" 设置窗口的起始位置和大小
		winpos 250 200

	endif

endif

" 插件设置
let s:appdata = expand('$VIM\.appdata')
" jshint
let g:jshint_rcfile = s:appdata.'\jshint\.jshintrc'
" loadtemplate
let g:template_path = s:appdata.'\load_template\templates\'
" vimwiki
let g:vimwiki_use_mouse = 1
let g:vimwiki_list = [{
			\"path":s:appdata."/vimwiki",
			\"path_html":s:appdata."/vimwiki/html",
			\"html_header":s:appdata."/html_template/header.tpl",
			\"html_footer":s:appdata."/html_template/footer.tpl"
			\}]

" 常用快捷键
" F2取消高亮
nmap <F2> :nohlsearch<CR>

" F3删掉windows换行符^M
nmap <F3> :%s/\r\(\n\)/\1/g<CR>