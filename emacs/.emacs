;; Setting By 华亮 [ Cedric Porter ]
;; Mail: cedricporter@gmail.com

;;Personal information
(setq user-full-name "Cedric Porter")
(setq user-mail-address "cedricporter@gmail.com") 

(set-default-font "Ubuntu Mono-12")


;; Add plugins to load-path.
;; We will put some tiny plugins in it
(add-to-list 'load-path "~/.emacs.d/plugins/") 
(add-to-list 'load-path "~/.emacs.d/plugins/configs") 

;; ====================      line number      ====================
;; 调用linum.el(line number)来显示行号：
(require 'linum)
(global-linum-mode t)
;; --------------------      End         --------------------

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

;; ==================== recent-jump ====================
;; set recent-jump
(setq recent-jump-threshold 4)
(setq recent-jump-ring-length 10)
(global-set-key (kbd "C-o") 'recent-jump-jump-backward)
(global-set-key (kbd "M-o") 'recent-jump-jump-forward)
(require 'recent-jump)
;; -------------------- end of recent-jump --------------------

;; ==================== UI setting ====================
;; 实现全屏效果，快捷键为f11
(global-set-key [f11] 'my-fullscreen) 
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
(my-maximized)

;; 启动窗口大小
(setq default-frame-alist
      '((height . 35) (width . 125) (menu-bar-lines . 20) (tool-bar-lines . 0)))
;; -------------------- UI setting --------------------


;; 在Emacs23里，可以用命令M-x quick-calc或快捷键C-x * q来启动Quick Calculator模式。
;; 这是一个非常小巧的工具，启动后会在minibuffer里提示输入数学计算式，回车就显示结果。
;; 这个模式能非常方便地用来做一些基本的数学运算，比用系统自带的计算器来得方便、快捷一些。


;; ==================== Common Setting ====================

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

;; 方便的在 kill-ring 里寻找需要的东西。
(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings)
(global-set-key "\C-c\C-k" 'browse-kill-ring)


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

;; 解决汉字表格对齐问题，也就是设置等宽汉字
(if (and (fboundp 'daemonp) (daemonp))
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (with-selected-frame frame
                  (set-fontset-font "fontset-default"
                                    'chinese-gbk "WenQuanYi Micro Hei Mono 12"))))
  (set-fontset-font "fontset-default" 'chinese-gbk "WenQuanYi Micro Hei Mono 12"))

;;设置句尾
(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")

;;直接打开图片
(auto-image-file-mode)

;; take the place of C-x C-f
;; 当你输入了一些字符后，系统会自动帮你补全；
;; C-s(next)或是C-r(previous)用来在列表中循环；
;; 按[Tab]键会自动列出可能的补全方法；
;; 用C-x C-d直接打开当前目录的Dired浏览模式；
(require 'ido)
(ido-mode t)

;; 去掉滚动栏
(scroll-bar-mode nil)

;; 一打开就起用 text 模式。  
(setq default-major-mode 'text-mode)

;; 语法高亮
(global-font-lock-mode t)
	 
;;use meta and direction key to go to the window
(windmove-default-keybindings 'meta)

;; session
(require 'session) 
(add-hook 'after-init-hook 'session-initialize) 
(load "desktop") 
(desktop-save-mode) 

;; back to last position when we close the file
(require 'saveplace)
(setq-default save-place t)

;;tabbar
(require 'tabbar)  
(tabbar-mode 1)  
(global-set-key [(meta j)] 'tabbar-backward)  
(global-set-key [(meta k)] 'tabbar-forward)
(global-set-key [(control meta j)] 'tabbar-backward-group)
(global-set-key [(control meta k)] 'tabbar-forward-group)
;;set group strategy
(defun tabbar-buffer-groups ()  
  "tabbar group"  
  (list  
   (cond  
    ((memq major-mode '(shell-mode dired-mode))  
     "shell"  
     )  
    ((memq major-mode '(c-mode c++-mode))  
     "cc"  
     )  
    ((eq major-mode 'python-mode)  
     "python"  
     )  
    ((memq major-mode
	   '(php-mode nxml-mode nxhtml-mode))
     "WebDev"
     )
    ((eq major-mode 'emacs-lisp-mode)
      "Emacs-lisp"
      )
    ((memq major-mode
	   '(tex-mode latex-mode text-mode snippet-mode))
     "Text"
     )
    ((string-equal "*" (substring (buffer-name) 0 1))  
     "emacs"  
     )  
    (t  
     "other"  
     )  
    )))  
(setq tabbar-buffer-groups-function 'tabbar-buffer-groups) 

;;;; 设置tabbar外观
;; 设置默认主题: 字体, 背景和前景颜色，大小
(set-face-attribute 'tabbar-default nil
                    :family "Vera Sans YuanTi Mono"
                    :background "gray80"
                    :foreground "gray10"
                    :height 1.0
                    )
;; 设置左边按钮外观：外框框边大小和颜色
(set-face-attribute 'tabbar-button nil
                    :inherit 'tabbar-default
                    :box '(:line-width 1 :color "gray30")
                    )
;; 设置当前tab外观：颜色，字体，外框大小和颜色
(set-face-attribute 'tabbar-selected nil
                    :inherit 'tabbar-default
                    :foreground "DarkGreen"
                    :background "LightGoldenrod"
                    :box '(:line-width 2 :color "DarkGoldenrod")
                    ;; :overline "black"
                    ;; :underline "black"
                    :weight 'bold
                    )
;; 设置非当前tab外观：外框大小和颜色
(set-face-attribute 'tabbar-unselected nil
                    :inherit 'tabbar-default
                    :box '(:line-width 2 :color "gray70")
                    )
;; cancel grouping
;;(setq tabbar-buffer-groups-function
;;    (lambda (b) (list “All Buffers”)))
;;(setq tabbar-buffer-list-function
;;    (lambda ()
;;        (remove-if
;;          (lambda(buffer)
;;             (find (aref (buffer-name buffer) 0) ” *”))
;;          (buffer-list))))

;;禁用启动信息
;(setq inhibit-startup-message t) 

;; 回车缩进
(global-set-key "\C-m" 'newline-and-indent)
(global-set-key (kbd "C-<return>") 'newline)

;; 显示括号匹配 
(show-paren-mode t)
(setq show-paren-style 'parentheses)
(require 'highlight-parentheses)
(highlight-parentheses-mode 1)

;; 显示ascii表
(require 'ascii)

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

;(require 'doxygen-config.el)

;;==================== color theme ====================
(add-to-list 'load-path "~/.emacs.d/plugins/color-theme-6.6.0/") 
(require 'color-theme) 
(load-file "~/.emacs.d/plugins/color-theme-6.6.0/themes/color-theme-library.el")
;;(require 'color-theme-library)
;;(color-theme-charcoal-black)
;;(color-theme-taylor)
(color-theme-taylor-et)
;;-------------------- color theme --------------------

;;==================== evil ====================
;;vi emulator
(setq evil-want-C-i-jump t)
(setq evil-want-C-u-scroll t)

(add-to-list 'load-path "~/.emacs.d/plugins/evil")
(require 'evil)  
(evil-mode 1)
(require 'surround)
(global-surround-mode 1)

;;(global-set-key [(kdb "C-u")] 'evil-scroll-up)

(define-key evil-normal-state-map ",i" 'ibuffer)
(define-key evil-normal-state-map ",b" 'ido-switch-buffer)
(define-key evil-normal-state-map ",m" 'magit-status)
(define-key evil-normal-state-map ",w" 'save-buffer)
(define-key evil-normal-state-map "ZZ" (kbd "C-c C-c"))

;; org-mode relaterat
(define-key evil-normal-state-map ",a" 'org-agenda)

;; lisp-relaterat som annars inte verkar fungera
(define-key evil-normal-state-map ",hv" 'describe-variable)
(define-key evil-normal-state-map ",hk" 'describe-key)
(define-key evil-normal-state-map ",hf" 'describe-function)
(define-key evil-normal-state-map ",hm" 'describe-mode)

;; window
(define-key evil-normal-state-map ",0" 'delete-window)         ;delete this window, same as C-x 0 
(define-key evil-normal-state-map ",1" 'delete-other-windows)  ;delete other windows
(define-key evil-normal-state-map ",3" 'split-window-3)        ;split the window to 3 window, left big
(define-key evil-normal-state-map ",4" 'split-window-4)        ;split the window into 4 equal size window
(define-key evil-normal-state-map ",q" 'winner-undo)	       ;undo, in other word, restore to previous window style
(define-key evil-normal-state-map ",Q" 'winner-redo)	       ;redo window style change

;; End of evil config copied from monotux@reddit
;;-------------------- evil --------------------

;;==================== undo tree ====================
(require 'undo-tree)
;;-------------------- undo tree --------------------

(require 'window-setting)

;;==================== yasnippt ====================
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")
;;-------------------- yasnippt --------------------


;;==================== auto complete ====================
;; auto complete with clang
(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/auto-complete/ac-dict/")  
(require 'auto-complete-clang)

(setq ac-auto-start 1)
(setq ac-quick-help-delay 0.5)
;; (ac-set-trigger-key "TAB")
(define-key ac-mode-map [(control tab)] 'auto-complete)

(defun my-ac-config ()
  (setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
  (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
  ;; (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)
  (add-hook 'css-mode-hook 'ac-css-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))
(defun my-ac-cc-mode-setup ()
  (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))
(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
;; ac-source-gtags
(my-ac-config)
;; -------------------- end of auto complete --------------------

;;==================== python ====================
(require 'python)

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(add-to-list 'load-path "~/.emacs.d/plugins/Pymacs")

(require 'pymacs)
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(autoload 'pymacs-autoload "pymacs")
;;(eval-after-load "pymacs"
;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))

;;; Initialize Rope
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)

(ac-ropemacs-initialize)
(add-hook 'python-mode-hook
	  (lambda ()
	    (add-to-list 'ac-sources 'ac-source-ropemacs)))
;;-------------------- python --------------------


;;==================== cedet ====================
(add-to-list 'load-path "~/.emacs.d/plugins/cedet/common")
;;(add-to-list 'load-path "~/.emacs.d/plugins/cedet/semantic")
(require 'cedet)
(require 'semantic-ia)

(global-ede-mode 1)

;;(semantic-load-enable-minimum-features)
(semantic-load-enable-code-helpers)
;;(semantic-load-enable-guady-code-helpers)
;;(semantic-load-enable-excessive-code-helpers)
(semantic-load-enable-semantic-debugging-helpers)

;;(semantic-load-enable-excessive-code-helpers)
;;(semantic-load-enable-sematic-debugging-helpers)

(global-srecode-minor-mode 1)
;;-------------------- cedet --------------------

;; ==================== gud ====================

(gud-tooltip-mode 1)
(add-hook 'gdb-mode-hook '(lambda ()
                            (define-key c-mode-base-map [(f5)] 'gud-go)
                            (define-key c-mode-base-map [(f11)] 'gud-step)
                            (define-key c-mode-base-map [(f10)] 'gud-next)))

;; -------------------- gud --------------------


;; compile
(setq compilation-read-command nil)	;don't prompt to press ENTER
(global-set-key [(f7)] (lambda()
			 (interactive)
			 (save-some-buffers t)	   ;save all buffers
			 (compile compile-command) ;compile
			 ))

(global-set-key [f4] 'eshell)

;定制C/C++缩进风格
(add-hook 'c-mode-hook
          '(lambda ()
             (c-set-style "k&r")))
(add-hook 'c++-mode-hook
          '(lambda ()
             (c-set-style "stroustrup")))


;; 设置缩进字符数
(setq c-basic-offset 4)

(global-set-key [(f5)] 'speedbar)
