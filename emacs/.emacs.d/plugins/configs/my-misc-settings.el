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


;; Re-open read-only files as root automte



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

;; ==================== 改造你的C-w和M-w键 ====================
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
;; -------------------- 改造你的C-w和M-w键 --------------------


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


;;禁用启动信息
;(setq inhibit-startup-message t) 

;; 回车缩进
;; (global-set-key "\C-m" 'newline-and-indent)
;(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "M-<return>") 'newline)

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

(defadvice comment-or-uncomment-region
  (before autocommentuncomment activate compile)
  "在没有region的时候，自动注释反注释当前行"
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
	   (line-beginning-position 2)))))
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


;; ==================== cua-mode ====================
;; cua-mode: I want the rectangle edit
(setq cua-enable-cua-keys nil)
(setq cua-rectangle-mark-key (kbd "C-c . r"))
(cua-mode t)
;; -------------------- cua-mode --------------------


(global-set-key [(f5)] 'speedbar)


;; ==================== sudo reopen ====================
(defun sudo-reopen-file ()
  (interactive)
  (message (concat "/sudo::" buffer-file-name))
  (let* ((file-name (expand-file-name buffer-file-name))
	 (sudo-file-name (concat "/sudo::" file-name)))
    (progn
      (setq buffer-file-name sudo-file-name)
      (rename-buffer sudo-file-name)
      (setq buffer-read-only nil)
      (message (concat "File name set to " sudo-file-name)))))
(global-set-key (kbd "C-c o s") 'sudo-reopen-file)
;; -------------------- sudo reopen --------------------


;; ==================== goto char ====================
;; go-to-char 非常感谢 Oliver Scholz 提供这个函数有了这段代码之后，当你按 C-t x
;; (x 是任意一个字符) 时，光 标就会到下一个 x 处。再次按 x，光标就到下一个 x。
;; 比如 C-t w w w w ..., C-t b b b b b b ... 我改造了一下，按C-u C-t则是相反方
;; 向。
(defun wy-go-to-char (n char)
  "Move forward to Nth occurence of CHAR.
Typing `wy-go-to-char-key' again will move forwad to the next Nth
occurence of CHAR."
  (interactive "p\ncGo to char: ")
  (if (eq n 1)
      (progn                            ; forward
        (search-forward (string char) nil nil n)
        (backward-char)
        (while (char-equal (read-char)
                           char)
          (forward-char)
          (search-forward (string char) nil nil n)
          (backward-char)))
    (progn                              ; backward
      (search-backward (string char) nil nil )
      (while (char-equal (read-char)
                         char)
        (search-backward (string char) nil nil ))))
  (setq unread-command-events (list last-input-event)))
(global-set-key (kbd "C-t") 'wy-go-to-char)
;; -------------------- goto char --------------------


;; ==================== 在最近两个buffer间切换 ====================
(defun switch-to-previous-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))
(global-set-key (kbd "C-`") 'switch-to-previous-buffer)
;; -------------------- 在最近两个buffer间切换 --------------------


;; ==================== zap up to char ====================
(autoload 'zap-up-to-char "misc"
  "Kill up to, but not including ARGth occurrence of CHAR.")
(global-set-key (kbd "M-Z") 'zap-up-to-char)
;; -------------------- zap up to char --------------------

;; ==================== kill-emacs ====================
(global-set-key (kbd "C-x C-S-c") 'kill-emacs)
;; -------------------- kill-emacs --------------------

;; ==================== bookmark ====================
(setq bookmark-save-flag 1)
;; -------------------- bookmark --------------------

;; ==================== jump to next/previous buffer ====================
(global-set-key (kbd "C-S-j") 'previous-buffer)
(global-set-key (kbd "C-S-k") 'next-buffer)
;; -------------------- jump to next/previous buffer --------------------


;; ==================== yaml ====================
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
;; -------------------- yaml --------------------


;; ==================== markdown-mode ====================
(require 'markdown-mode)
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.text" . markdown-mode) auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
;; -------------------- markdown-mode --------------------


;; ==================== scss-mode ====================
(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
;; -------------------- scss-mode --------------------


;; ==================== backup files ====================
(setq backup-directory-alist '(("." . "~/.emacs.backups")))
;; -------------------- backup files --------------------



(provide 'my-misc-settings)
