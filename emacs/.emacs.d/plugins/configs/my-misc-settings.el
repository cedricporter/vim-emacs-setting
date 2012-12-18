(defun open-setting-file()
  (interactive)
  (find-file "~/.emacs"))


;;======================    time setting        =====================
;;启用时间显示设置，在minibuffer上面的那个杠上（忘了叫什么来着）
(display-time-mode 1)

;;时间使用24小时制
(setq display-time-24hr-format t)

;;时间显示包括日期和具体时间
(setq display-time-day-and-date t)

;;时间栏旁边启用邮件设置
					;(setq display-time-use-mail-icon t)

;;时间的变化频率
(setq display-time-interval 10)

;;显示时间，格式如下
(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t) 
;;----------------------    END    time setting    ---------------------


;; ==================== UI setting ====================

;; Font Setting
;(set-frame-font "Ubuntu Mono-12")
(defun frame-setting ()
  (set-frame-font "Monaco-11")
  (set-fontset-font "fontset-default"
		    'chinese-gbk "WenQuanYi Micro Hei Mono 11"))

;; 解决汉字表格对齐问题，也就是设置等宽汉字
(if (and (fboundp 'daemonp) (daemonp))
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (with-selected-frame frame
		  (frame-setting))))
  (frame-setting))


;; 实现全屏效果，快捷键为f11
(global-set-key [(control f11)] 'my-fullscreen) 
(defun my-fullscreen ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_FULLSCREEN" 0))
  )
;; 最大化
(defun my-maximized ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  )
;; 启动emacs时窗口最大化
(when window-system
  (my-maximized)) 


(setq-default fill-column 81)
(setq default-fill-column 80)


;; 启动窗口大小
(setq default-frame-alist
      '((height . 35) (width . 125) (menu-bar-lines . 20) (tool-bar-lines . 0)))
;; -------------------- UI setting --------------------


;; 在Emacs23里，可以用命令M-x quick-calc或快捷键C-x * q来启动Quick Calculator模式。
;; 这是一个非常小巧的工具，启动后会在minibuffer里提示输入数学计算式，回车就显示结果。
;; 这个模式能非常方便地用来做一些基本的数学运算，比用系统自带的计算器来得方便、快捷一些。


;; ==================== Common Setting ====================

;; 尽快显示按键序列
(setq echo-keystrokes 0.1)

(defadvice desktop-restore-file-buffer
  (around my-desktop-restore-file-buffer-advice)
  "Be non-interactive while starting a daemon."
  (if (and (daemonp)
	   (not server-process))
      (let ((noninteractive t))
	ad-do-it)
    ad-do-it))
(ad-activate 'desktop-restore-file-buffer)


;;;_ xterm & console
(when (eq system-type 'gnu/linux)
  ;; (if (not window-system)
  ;;     (xterm-mouse-mode t))
  ;;(gpm-mouse-mode t) ;;for Linux console

  (load-library "help-mode")  ;; to avoid the error message "Symbol's value as variable is void: help-xref-following"
  )

;(setq tramp-default-method "ssh")

;;; shift the meaning of C-s and C-M-s
(global-set-key [(control s)] 'isearch-forward-regexp)
(global-set-key [(control meta s)] 'isearch-forward)
(global-set-key [(control r)] 'isearch-backward-regexp)
(global-set-key [(control meta r)] 'isearch-backward)

;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Mark Set
(global-unset-key (kbd "C-SPC"))  
(global-set-key (kbd "M-SPC") 'set-mark-command)


;;去掉菜单栏，将F10绑定为显示菜单栏，需要菜单栏了可以摁F10调出，再摁F10就去掉菜单
;; 如果总是不显示工具栏，将下面代码加到.emacs中
;; 参考： http://www.emacswiki.org/emacs/ToolBar
;; 注意：在menu-bar不显示的情况下，按ctrl+鼠标右键还是能调出菜单选项的 
(tool-bar-mode -1)
;; 如果总是不显示菜单，将下面代码加到.emacs中
;;参考： http://www.emacswiki.org/emacs/MenuBar
(menu-bar-mode -1)

;; eliminate long "yes" or "no" prompts
(fset 'yes-or-no-p 'y-or-n-p)

;; ;; 防止页面滚动时跳动，可以很好的看到上下文。
;; (setq scroll-margin 3
;;       scroll-conservatively 10000)

;; 改造你的C-w和M-w键
(defadvice kill-ring-save (before slickcopy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
	   (line-beginning-position 2)))))
(defadvice kill-region (before slickcut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
	   (line-beginning-position 2)))))

;; 4.1 在单元格之间移动
;; table-forward-cell<==>tab
;; table-backward-cell<==>shift+tab
;; 
;; 4.2 合并单元格
;; table-span-cell
;; 
;; 4.3 拆分单元格
;; +---------------------------------------+---------------+
;; |table-split-cell-horizontally          |C-c C-c -      |
;; +---------------------------------------+---------------+
;; |table-split-cell-vertically            |C-c C-c |      |
;; +---------------------------------------+---------------+
;; 
;; 4.4 扩大或缩小单元格的宽度、高度
;; +--------------------------------------+----------+
;; |垂直扩大：table-highten-cell          |C-c C-c } |
;; |                                      |          |
;; +--------------------------------------+----------+
;; |垂直缩小：table-shorten-cell          |C-c C-c { |
;; |                                      |          |
;; +--------------------------------------+----------+
;; |水平扩大: table-widen-cell            |C-c C-c > |
;; |                                      |          |
;; +--------------------------------------+----------+
;; |水平缩小：table-narrow-cell           |C-c C-c < |
;; |                                      |          |
;; +--------------------------------------+----------+
;; 
;; 5、单元格对齐方式
;; +---------------------------------------+-----------+
;; |命令：table-justify                    |C-c C-c :  |
;; +---------------------------------------+-----------+

;; 可以“所见即所得”的编辑一个文本模式的 表格。
(autoload 'table-insert "table" "WYGIWYS table editor")


;;设置句尾
(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")

;;直接打开图片
(auto-image-file-mode)

;; 去掉滚动栏
(scroll-bar-mode -1)

;; 一打开就起用 text 模式。  
(setq default-major-mode 'text-mode)

;; 语法高亮
(global-font-lock-mode t)

;;use meta and direction key to go to the window
(windmove-default-keybindings 'meta)


;;禁用启动信息
;(setq inhibit-startup-message t) 

;; 回车缩进
;; (global-set-key "\C-m" 'newline-and-indent)
(global-set-key (kbd "C-<return>") 'newline)

;; 显示括号匹配 
(show-paren-mode t)
(setq show-paren-style 'parentheses)
(require 'highlight-parentheses)
(highlight-parentheses-mode 1)

;; 显示ascii表
;(require 'ascii)


;; ;; Make it behave like vim
;; (global-set-key "\M-f" 'forward-same-syntax) 
;; (global-set-key "\M-b" (lambda () (interactive) (forward-same-syntax -1)))
;;  
;; (defun kill-syntax (&optional arg)
;;   "Kill ARG sets of syntax characters after point."
;;   (interactive "p")
;;   (let ((opoint (point)))
;;  	(forward-same-syntax arg)
;;  	(kill-region opoint (point))) )
;; (global-set-key "\M-d" 'kill-syntax)
;; (global-set-key [(meta backspace)] (lambda() (interactive) (kill-syntax -1) ) )


;;用一个很大的 kill ring. 这样防止我不小心删掉重要的东西。
(setq kill-ring-max 200)

;;高亮显示选中的区域
(transient-mark-mode t) 

;;支持emacs和外部程序的拷贝粘贴
(setq x-select-enable-clipboard t) 

;;在标题栏提示当前位置
(setq frame-title-format "ET@%b")

;;使用C-k删掉指针到改行末的所有东西
(setq-default kill-whole-line t)


;;==================== 注释 ====================
(global-set-key (kbd "C-c c") 'comment-or-uncomment-region)
(global-set-key (kbd "C-c b") 'comment-box)
(global-set-key (kbd "C-c k") 'comment-kill)
;;-------------------- end --------------------



;;==================== color theme ====================
(add-to-list 'load-path "~/.emacs.d/plugins/color-theme-6.6.0/") 
(require 'color-theme) 
(load-file "~/.emacs.d/plugins/color-theme-6.6.0/themes/color-theme-library.el")
;;(require 'color-theme-library)
;;(color-theme-charcoal-black)
;;(color-theme-taylor)
(color-theme-taylor-et)
;;(color-theme-infodoc)
;;-------------------- color theme --------------------


;; cua-mode: I want the rectangle C-return
(setq cua-enable-cua-keys nil)
(cua-mode t) 


(global-set-key [(f5)] 'speedbar)




(provide 'my-misc-settings)
