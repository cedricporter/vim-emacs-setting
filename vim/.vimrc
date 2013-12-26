"""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim setting by Hua Liang [Stupid ET [Cedric Porter]]
"    email:   et@everet.org
"    website: http://EverET.org
"
" How to upgrade:
" Git：
"    https://github.com/cedricporter/vim-emacs-setting
" How to install:
"    copy the file you pull from git to the HOME folder
"

"tags
set tags=~/.vim/tagfiles/stl_tags    
set tags+=~/.vim/tagfiles/systags    
set tags+=~/.vim/tagfiles/opengl_tags
set tags+=./tags,./../tags,./**/tags  

" build tags of your own project with CTRL+F12
map <silent> <C-F12> :w<cr>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>


" Vimgdb
" :run macros/gdb_mappings.vim 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Platform Test
function! MySys()
  if has("win32")
    return "windows"
  else
    return "linux"
  endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible "不要vim模仿vi模式，建议设置，否则会有很多不兼容的问题

" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugin
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>
" Fast make
nmap <Leader>m :w<cr>:make<cr>

"Fast reloading of the .vimrc
map <silent> <leader>ss :source $HOME/.vimrc<cr>
"Fast editing of .vimrc
map <silent> <leader>ee :e $HOME/.vimrc<cr>
"When .vimrc is edited, reload it
"autocmd! bufwritepost .vimrc source ~/.vimrc 

"Language Setting
"set langmenu=zh_CN.UTF-8               "设置菜单语言
"language messages zh_CN.utf-8          "设置提示信息语言


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 5 lines to the curors - when moving vertical..
set so=5
set wildmenu "Turn on Wild menu
set ruler "Always show current position
set cmdheight=2 "The commandbar height
set hid "Change buffer - without saving

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase "Ignore case when searching
set smartcase

set hlsearch "Highlight search things
set incsearch "Make search act like search in modern browsers
set nolazyredraw "Don't redraw while executing macros 
set magic "Set magic on, for regular expressions
set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink
set showcmd	"show (partial) command when not complete

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable "Enable syntax hl

" set position and the size of the window 
if has('gui_running')
    winpos 130 20
    set lines=37 columns=120
endif

" Set font according to system
if MySys() == "mac"
  set gfn=Menlo:h14
  set shell=/bin/bash
elseif MySys() == "windows"
  set gfn=Bitstream\ Vera\ Sans\ Mono:h10
elseif MySys() == "linux"
  "set gfn=Monospace\ 10
  set gfn=Ubuntu\ Mono\ 12
  set shell=/bin/bash
endif

if has("gui_running")
  set guioptions-=T
  set t_Co=256
  set background=dark
  colorscheme peaksea
  set nu		"开启行号显示
else
  colorscheme zellner
  set background=dark
  set nonu
endif

set encoding=utf8
try
    lang en_US
catch
endtry

let &termencoding=&encoding
" 解决打开Windows下编辑的txt乱码问题
" 通过添加gb18030编码等来解决
set fileencodings=utf-8,gbk,ucs-bom,cp936
set fenc=utf-8 " default fileencoding
set fencs=utf-8,gb18030,gbk,gb2312,cp936,ucs-bom,euc-jp
set ffs=unix,dos,mac "Default file types

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab
"set softtabstop=4

set lbr     "Line break
set tw=500  "Textwidth

set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map space to / (search) and c-space to ? (backgwards search)
"map <space> /
"map <c-space> ?
map <silent> <leader><cr> :noh<cr> "Cancel the Highlight of the matching

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,300 bd!<cr>

" Use the arrows to something usefull
map <right> :bn<cr>
map <left> :bp<cr>

" Tab configuration
map <leader>tn :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2

" Format the statusline
set statusline=\ %{HasPaste()}%t%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c\ %=[%{GitBranch()}]
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ [%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]\ %=[%{GitBranch()}]“

function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i
inoremap $t <><esc>i

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>

"-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
"common setting
autocmd BufEnter * lcd %:p:h



" 缩进
if has("autocmd")
    filetype plugin indent on "根据文件进行缩进
    augroup vimrcEx
        au!
        autocmd FileType text setlocal textwidth=78
        autocmd BufReadPost *
                    \ if line("'\"") > 1 && line("'\"") <= line("$") |
                    \ exe "normal! g`\"" |
                    \ endif
    augroup END
else
    "智能缩进，相应的有cindent，官方说autoindent可以支持各种文件的缩进，但是效果会比只支持C/C++的cindent效果会差一点，但笔者并没有看出来
    set autoindent " always set autoindenting on 
endif " has("autocmd")


" Folding {{{
"折叠相关的快捷键
"zR 打开所有的折叠
"za Open/Close (toggle) a folded group of lines.
"zA Open a Closed fold or close and open fold recursively.
"zi 全部 展开/关闭 折叠
"zo 打开 (open) 在光标下的折叠
"zc 关闭 (close) 在光标下的折叠
"zC 循环关闭 (Close) 在光标下的所有折叠
"zM 关闭所有可折叠区域
set foldenable
" 设置语法折叠
" manual  手工定义折叠
" indent  更多的缩进表示更高级别的折叠
" expr    用表达式来定义折叠
" syntax  用语法高亮来定义折叠
" diff    对没有更改的文本进行折叠
" marker  对文中的标志折叠
set foldmethod=marker
" 设置折叠层数为
set foldlevel=0
" 设置折叠区域的宽度
set foldcolumn=0
" 新建的文件，刚打开的文件不折叠
autocmd! BufNewFile,BufRead * setlocal nofoldenable
" }}}


"-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
"插件设置
"
"“”"”"”"”"”"”"”"”"”"”"”"”"”"”"”"
"” => Git Vim configuration
"“”"”"”"”"”"”"”"”"”"”"”"”"”"”"”"
"<Leader>gd :GitDiff
"<Leader>gD :GitDiff —cached
"<Leader>gs :GitStatus
"<Leader>gl :GitLog
"<Leader>ga :GitAdd
"<Leader>gA :GitAdd <cfile>
"<Leader>gc :GitCommit
"In the git-status buffer: 
"   <Enter> :GitAdd <cfile> 


"--------------------------------------------------
"neocomplcache 自动补全
" Disable AutoComplPop.
"let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" Auto select the first one.
let g:neocomplcache_enable_auto_select=1


"WinManager
"<F1>	显示帮助
"<cr>	如果光标下是目录, 则进入该目录; 如果光标下文件, 则打开该文件
"-	返回上级目录
"c	切换vim 当前工作目录正在浏览的目录
"d	创建目录
"D	删除目录或文件
"i	切换显示方式
"R	文件或目录重命名
"s	选择排序方式
"x	定制浏览方式, 使用你指定的程序打开该文件
let g:winManagerWindowLayout='FileExplorer|TagList'
nmap wm :WMToggle<cr>


"Cscope
"$ cscope -Rbq
":cs add /home/wooin/vim71/cscope.out /home/wooin/vim71
"cs find c Print
":cw 打开Quickix窗口
"--------------------------------------------------
":make
":cw
":cn        // 切换到下一个结果
":cp        // 切换到上一个结果
"如果你经常使用这两个命令, 你还可以给他们设定快捷键, 比如在~/.vimrc中增加:
"nmap <F6> :cn<cr>
"nmap <F7> :cp<cr>
"-------------------------------------------------
"cscope的主要功能是通过同的子命令"find"来实现的
"cscope find"的用法:
"cs find c|d|e|f|g|i|s|t name
"0 或 s	查找本 C 符号(可以跳过注释)
"1 或 g	查找本定义
"2 或 d	查找本函数调用的函数
"3 或 c	查找调用本函数的函数
"4 或 t	查找本字符串
"6 或 e	查找本 egrep 模式
"7 或 f	查找本文件
"8 或 i	查找包含本文件的文件
set cscopequickfix=s-,c-,d-,i-,t-,e-
map <F12> :call Do_CsTag()<CR>
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>:copen<CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:copen<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>:copen<CR>
function Do_CsTag()
    let dir = getcwd()
    if filereadable("tags")
        if(g:iswindows==1)
            let tagsdeleted=delete(dir."\\"."tags")
        else
            let tagsdeleted=delete("./"."tags")
        endif
        if(tagsdeleted!=0)
            echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None
            return
        endif
    endif
    if has("cscope")
        silent! execute "cs kill -1"
    endif
    if filereadable("cscope.files")
        if(g:iswindows==1)
            let csfilesdeleted=delete(dir."\\"."cscope.files")
        else
            let csfilesdeleted=delete("./"."cscope.files")
        endif
        if(csfilesdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.files" | echohl None
            return
        endif
    endif
    if filereadable("cscope.out")
        if(g:iswindows==1)
            let csoutdeleted=delete(dir."\\"."cscope.out")
        else
            let csoutdeleted=delete("./"."cscope.out")
        endif
        if(csoutdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.out" | echohl None
            return
        endif
    endif
    if(executable('ctags'))
        "silent! execute "!ctags -R --c-types=+p --fields=+S *"
        silent! execute "!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ."
    endif
    if(executable('cscope') && has("cscope") )
        if(g:iswindows!=1)
            silent! execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' > cscope.files"
        else
            silent! execute "!dir /s/b *.c,*.cpp,*.h,*.java,*.cs >> cscope.files"
        endif
        silent! execute "!cscope -b"
        execute "normal :"
        if filereadable("cscope.out")
            execute "cs add cscope.out"
        endif
    endif
endfunction


"Taglist
"进行Tlist的设置
"TlistUpdate可以更新tags
map <F4> :silent! Tlist<CR> "按下F4呼出了
let Tlist_Ctags_Cmd='ctags' "因为我们放在环境变量里，所以可以直接执行
let Tlist_Use_Right_Window=0 "让窗口显示在右边，0的话就是显示在左边
let Tlist_Show_One_File=0 "让taglist可以同时展示多个文件的函数列表，如果想只有1个，设置为1
let Tlist_File_Fold_Auto_Close=1 "非当前文件，函数列表折叠隐藏
let Tlist_Exit_OnlyWindow=1 "当taglist是最后一个分割窗口时，自动推出vim
let Tlist_Process_File_Always=0 "是否一直处理tags.1:处理;0:不处理。不是一直实时更新tags，因为没有必要
let Tlist_Inc_Winwidth=0


"MiniBufExplorer
"<Tab>		向前循环切换到每个buffer名上
"<S-Tab>	向后循环切换到每个buffer名上
"<Enter>	在打开光标所在的buffer
"d		删除光标所在的buffer
"--------------------------------------------------
"<C-Tab>	向前循环切换到每个buffer上,并在但前窗口打开
"<C-S-Tab>	向后循环切换到每个buffer上,并在但前窗口打开
let g:miniBufExplMapCTabSwitchBufs=1
"--------------------------------------------------
"可以用<C-h,j,k,l>切换到上下左右的窗口中去,就像:
"C-w,h j k l    向"左,下,上,右"切换窗口.
"let g:miniBufExplMapWindowNavVim = 1
"--------------------------------------------------
"用<C-箭头键>切换到上下左右窗口中去
"let g:miniBufExplMapWindowNavArrows = 1
"--------------------------------------------------
"防止打开很多个
"let g:miniBufExplorerMoreThanOne=0

"c/h文件间相互切换 -- 插件: A
":A	在新Buffer中切换到c/h文件
":AS	横向分割窗口并打开c/h文件
":AV	纵向分割窗口并打开c/h文件
":AT	新建一个标签页并打开c/h文件
"nnoremap <silent> <F12> :A<CR>


"Grep
"--------------------------------------------------
":Grep	按照指定的规则在指定的文件中查找
":Rgrep	同上, 但是是递归的grep
":GrepBuffer	在所有打开的缓冲区中查找
":Bgrep	同上
":GrepArgs	在vim的argument filenames (:args)中查找
":Fgrep	运行fgrep
":Rfgrep	运行递归的fgrep
":Egrep	运行egrep
":Regrep	运行递归的egrep
":Agrep	运行agrep
":Ragrep	运行递归的agrep
"For example, the following map invokes the :Grep command to search for the keyword under the cursor: 
nnoremap <silent> <F3> :Grep<CR>	 


"高亮的书签 -- 插件: VisualMark
"如果是gvim, 直接在代码上按下Ctrl+F2, 如果是vim, 用"mm"
"如果你设置了多个书签, 你可以用F2键正向在期间切换, 用Shift+F2反向在期间切换.


"自动补全
":help new-omni-completion
"按下"Ctrl+X Ctrl+O", 此时会弹出一个下列菜单, 显示所有匹配的标签
"--------------------------------------------------
"Ctrl+P		向前切换成员
"Ctrl+N		向后切换成员
"Ctrl+E		表示退出下拉窗口, 并退回到原来录入的文字
"Ctrl+Y		表示退出下拉窗口, 并接受当前选项
"Ctrl+X Ctrl+L	整行补全
"Ctrl+X Ctrl+N	根据当前文件里关键字补全
"Ctrl+X Ctrl+K	根据字典补全
"Ctrl+X Ctrl+T	根据同义词字典补全
"Ctrl+X Ctrl+I	根据头文件内关键字补全
"Ctrl+X Ctrl+]	根据标签补全
"Ctrl+X Ctrl+F	补全文件名
"Ctrl+X Ctrl+D	补全宏定义
"Ctrl+X Ctrl+V	补全vim命令
"Ctrl+X Ctrl+U	用户自定义补全方式
"Ctrl+X Ctrl+S	拼写建议
" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest    ",preview

"加速你的补全 -- 插件: SuperTab
":SuperTabHelp
"--------------------------------------------------
" 设置按下<Tab>后默认的补全方式, 默认是<C-P>, 
" 现在改为<C-X><C-O>. 关于<C-P>的补全方式, 
" 还有其他的补全方式, 你可以看看下面的一些帮助:
" :help ins-completion
" :help compl-omni
"let g:SuperTabDefaultCompletionType="<C-X><C-O>"
"--------------------------------------------------
" 0 - 不记录上次的补全方式
" 1 - 记住上次的补全方式,直到用其他的补全命令改变它
" 2 - 记住上次的补全方式,直到按ESC退出插入模式为止
"let g:SuperTabRetainCompletionType=2


"Doxygen注释
"To customize the output of the script, see the g:DoxygenToolkit_* 
"variables in the script's source.  These variables can be set in your 
".vimrc. 
"--------------------------------------------------
"Use: 
"- Type of comments (C/C++: /// or /** ... */, Python: ## and # ) : 
"  In vim, default C++ comments are : /** ... */. But if you prefer to use /// 
"  Doxygen comments just add 'let g:DoxygenToolkit_commentType = "C++"' 
"  (without quotes) in your .vimrc file 
"
"- License : 
"  In vim, place the cursor on the line that will follow doxygen license 
"  comment.  Then, execute the command :DoxLic.  This will generate license 
"  comment and leave the cursor on the line just after. 
"
"- Author : 
"  In vim, place the cursor on the line that will follow doxygen author 
"  comment.  Then, execute the command :DoxAuthor.  This will generate the 
"  skeleton and leave the cursor just after @author tag if no variable 
"  define it, or just after the skeleton. 
"
"- Function / class comment : 
"  In vim, place the cursor on the line of the function header (or returned 
"  value of the function) or the class.  Then execute the command :Dox.  This 
"  will generate the skeleton and leave the cursor after the @brief tag. 
"
"- Ignore code fragment (C/C++ only) : 
"  In vim, if you want to ignore all code fragment placed in a block such as : 
"    #ifdef DEBUG 
"    ... 
"    #endif 
"  You only have to execute the command :DoxUndoc(DEBUG) ! 
"   
"- Group : 
"  In vim, execute the command :DoxBlock to insert a doxygen block on the 
"  following line. 
map fg : Dox<cr>
let g:DoxygenToolkit_authorName="Cedric Porter"
let g:DoxygenToolkit_licenseTag="GPL v4 \<enter>"
let g:DoxygenToolkit_undocTag="DOXIGEN_SKIP_BLOCK"
let g:DoxygenToolkit_briefTag_pre = "@brief\t"
let g:DoxygenToolkit_paramTag_pre = "@param\t"
let g:DoxygenToolkit_returnTag = "@return\t"
let g:DoxygenToolkit_briefTag_funcName = "no"
let g:DoxygenToolkit_maxFunctionProtoLines = 30


"对NERD_commenter的设置
"在光标所在行上，按下一次ctrl+h是注释，再按下一次是取消注释。
"而其内建的指令\cm是多行注释，类似C++的/**/，\cu是取消注释。
"let NERDShutUp=1

map <F5> :call StartPython()<CR>
function StartPython()
    :w
    :!python %:t
endfunction


"NERD_tree 提供展示文件/目录列表的功能，比自带的文件浏览器要好很多
" 让Tree把自己给装饰得多姿多彩漂亮点
let NERDChristmasTree=1
" 控制当光标移动超过一定距离时，是否自动将焦点调整到屏中心
let NERDTreeAutoCenter=1
let NERDTreeShowHidden=1
map <F2> : NERDTreeToggle<cr>
map <S-F2> : NERDTreeClose<cr>
