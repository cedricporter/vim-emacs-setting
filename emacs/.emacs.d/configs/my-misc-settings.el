;; author: Hua Liang [Stupid ET]
;; Time-stamp: <2013-04-01 15:13:04 Monday by Hua Liang>



;; ==================== time-stamp ====================
(add-hook 'write-file-hooks 'time-stamp)
(setq time-stamp-format "%:y-%02m-%02d %02H:%02M:%02S %:a by %U")
;; -------------------- time-stamp --------------------


;; ==================== fast-open-dot-emacs ====================
(defun open-setting-file()
  (interactive)
  (find-file "~/.emacs"))
(global-set-key (kbd "C-c , e") 'open-setting-file)
;; -------------------- fast-open-dot-emacs --------------------




;; 在Emacs23里，可以用命令M-x quick-calc或快捷键C-x * q来启动Quick Calculator模式。
;; 这是一个非常小巧的工具，启动后会在minibuffer里提示输入数学计算式，回车就显示结果。
;; 这个模式能非常方便地用来做一些基本的数学运算，比用系统自带的计算器来得方便、快捷一些。


;; ==================== Common Setting ====================
;;-------------------- end --------------------

;; ==================== 缩进 ====================
;; 自动indent
(electric-indent-mode 1)

;; 对某些mode关闭自动electric-indent
(defun disable-eletric-indent-mode-local ()
  "Make electric indent function local to disable it"
  (set (make-local-variable 'electric-indent-functions)
       (list (lambda (arg) 'no-indent)))
  )
(add-hook 'org-mode-hook 'disable-eletric-indent-mode-local)
(add-hook 'python-mode-hook 'disable-eletric-indent-mode-local)
(add-hook 'coffee-mode-hook 'disable-eletric-indent-mode-local)


(defadvice indent-region
  (before autoindentregion activate compile)
  "在没有region的时候，自动缩进当前行"
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
	   (line-beginning-position 2)))))
;; -------------------- 缩进 --------------------



;; ==================== 控制右括号的缩进 ====================
(defun my-electric-keys (arg)
  "indent if necessary"
  (interactive "*P")
  (let ((count (prefix-numeric-value arg))
        (indent-flag (looking-back "\\s-")) ; 如果前面是空白，那么进行缩进
        )
    (self-insert-command count)
    (when indent-flag
      (indent-region (line-beginning-position) (line-end-position)))))

(defun my-electric-keys-hook ()
  (local-set-key (kbd "}") 'my-electric-keys)
  (local-set-key (kbd "]") 'my-electric-keys)
  )

(add-hook 'python-mode-hook 'my-electric-keys-hook)
(add-hook 'js2-mode-hook 'my-electric-keys-hook)
;; -------------------- 控制右括号的缩进 --------------------



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
(global-set-key (kbd "C-x C-i") 'ibuffer)
; hide all buffers starting with an asterisk. http://www.emacswiki.org/emacs/IbufferMode
(require 'ibuf-ext)
(add-to-list 'ibuffer-never-show-predicates "^\\*")

;; Mark Set
(global-unset-key (kbd "C-SPC"))
(global-set-key (kbd "M-SPC") 'set-mark-command)


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


;; 设置句尾
(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")

;; 直接打开图片
(auto-image-file-mode)

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
(setq frame-title-format
      (list "ψωETωψ ◎ "
        '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

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



;; ==================== cua-mode ====================
;; cua-mode: I want the rectangle edit
(setq cua-enable-cua-keys nil)
(setq cua-rectangle-mark-key (kbd "C-c . r"))
(cua-mode t)
;; -------------------- cua-mode --------------------


;; (global-set-key [(f5)] 'speedbar)


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
;; based on:  Oliver Scholz
;; 当你按 C-t x (x 是任意一个字符) 时，光 标就会到下一个 x 处。再次按 x，光标就到下一个 x。
;; 比如 C-t w w w w ..., C-t b b b b b b ... 我改造了一下，按C-u C-t则是相反方向。
(defun my-go-to-char (n char)
  "Move forward to Nth occurence of CHAR.
Typing `my-go-to-char-key' again will move forwad to the next Nth
occurence of CHAR."
  (interactive "p\ncGo to char: ")
  (let ((case-fold-search nil))
    (if (eq n 1)
        (progn                            ; forward
          (search-forward (string char) nil nil n)
          (backward-char)
          (while (equal (read-key)
                        char)
            (forward-char)
            (search-forward (string char) nil nil n)
            (backward-char)))
      (progn                              ; backward
        (search-backward (string char) nil nil )
        (while (equal (read-key)
                      char)
          (search-backward (string char) nil nil )))))
  (setq unread-command-events (list last-input-event)))
(global-set-key (kbd "C-t") 'my-go-to-char)
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
(global-set-key (kbd "M-7") 'previous-buffer)
(global-set-key (kbd "M-8") 'next-buffer)
;; -------------------- jump to next/previous buffer --------------------


;; ==================== backup files ====================
(setq backup-directory-alist '(("." . "~/.emacs_backups")))
;; -------------------- backup files --------------------


;; ==================== open new line ====================
(defun open-line-below ()
  (interactive)
  (end-of-line)
  (newline)
  (indent-for-tab-command))

(defun open-line-above ()
  (interactive)
  (beginning-of-line)
  (newline)
  (forward-line -1)
  (indent-for-tab-command))

(global-set-key (kbd "<C-return>") 'open-line-below) ; conflict with semantic, set in my minor
(global-set-key (kbd "<C-S-return>") 'open-line-above)
;; -------------------- open new line --------------------


;; ==================== auto revert ====================
;; Auto refresh buffers
(global-auto-revert-mode 1)

;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)
;; -------------------- auto revert --------------------



;; ==================== highlight-parenthese ====================
;; http://www.emacswiki.org/HighlightParentheses
(add-hook 'highlight-parentheses-mode-hook
          '(lambda ()
             (setq autopair-handle-action-fns
                   (append
                    (if autopair-handle-action-fns
                        autopair-handle-action-fns
                      '(autopair-default-handle-action))
                    '((lambda (action pair pos-before)
                        (hl-paren-color-update)))))))

(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)
;; -------------------- highlight-parenthese --------------------


;; ==================== stop asking active process when exit ====================
(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  "Prevent annoying \"Active processes exist\" query when you quit Emacs."
  (flet ((process-list ())) ad-do-it))
;; -------------------- stop asking active process when exit --------------------


;; ==================== browse-url ====================
(global-set-key (kbd "C-c C-v") 'browse-url)
;; -------------------- browse-url --------------------


;; ==================== zsh ====================
(add-to-list 'auto-mode-alist '("\\.zsh$" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.zsh-theme$" . sh-mode))
;; -------------------- zsh --------------------


;; ==================== google ====================
(defun google ()
  "Google the selected region if any, display a query prompt otherwise."
  (interactive)
  (browse-url
   (concat
    "https://www.google.com.hk/search?ie=utf-8&oe=utf-8&q="
    (url-hexify-string (if mark-active
         (buffer-substring (region-beginning) (region-end))
         (read-string "Google: "))))))

(global-set-key (kbd "C-c g") 'google)
;; -------------------- google --------------------


;; ==================== woman ====================
;; woman => w/o man, WithOut man
;; (defalias 'man 'woman)
;; (eval-after-load 'woman '(defalias 'man 'woman))
(global-set-key (kbd "<M-f12>") (lambda ()
                                  (interactive)
                                  (let ((woman-use-topic-at-point t))
                                    (woman))))
;; -------------------- woman --------------------


;; ==================== frame ====================
(global-set-key (kbd "C-x 5 o") 'display-buffer-other-frame)
(global-set-key (kbd "C-x 5 f") 'ido-find-file-other-frame)
;; -------------------- frame --------------------

;; (provide 'my-misc-settings)
