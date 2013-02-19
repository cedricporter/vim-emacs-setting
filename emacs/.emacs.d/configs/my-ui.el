;;; my-ui.el ---
;;
;; Author: Hua Liang[Stupid ET] <et@everet.org>
;; Time-stamp: <2013-02-19 20:06:42 Tuesday by Hua Liang>

;;====================== time setting =====================
;;启用时间显示设置，在minibuffer上面的那个杠上（忘了叫什么来着）
(display-time-mode 1)

;;时间使用24小时制
(setq display-time-24hr-format t)
(setq display-time-format "%02H:%02M:%02S %Y-%02m-%02d %3a")

;;时间显示包括日期和具体时间
(setq display-time-day-and-date t)

;;时间栏旁边启用邮件设置
					;(setq display-time-use-mail-icon t)

;;时间的变化频率
(setq display-time-interval 1)

;;显示时间，格式如下
(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
;;----------------------    END    time setting    ---------------------


;; ==================== UI setting ====================

;; Font Setting

(setq my-font "Monaco-11")

(add-to-list 'default-frame-alist
             '(font . my-font))

;(set-frame-font "Ubuntu Mono-12")
(defun frame-setting ()
  (set-frame-font my-font)
  (set-fontset-font "fontset-default"
		    'chinese-gbk "WenQuanYi Micro Hei Mono 11"))

;; ;; 解决汉字表格对齐问题，也就是设置等宽汉字
;; (if (and (fboundp 'daemonp) (daemonp))
;;     (add-hook 'after-make-frame-functions
;;               (lambda (frame)
;;                 (with-selected-frame frame
;; 		  (frame-setting))))
;;   (frame-setting))

(add-hook 'after-make-frame-functions
          (lambda (frame)
            (with-selected-frame frame
              (frame-setting))))
(if (not (and (fboundp 'daemonp) (daemonp)))
    (frame-setting))

(setq-default fill-column 81)
(setq default-fill-column 80)


;; 启动窗口大小
(setq default-frame-alist
      '((height . 35) (width . 125) (menu-bar-lines . 20) (tool-bar-lines . 0)))

;; 去掉滚动栏
(scroll-bar-mode -1)

;;去掉菜单栏，将F10绑定为显示菜单栏，需要菜单栏了可以摁F10调出，再摁F10就去掉菜单
;; 如果总是不显示工具栏，将下面代码加到.emacs中
;; 参考： http://www.emacswiki.org/emacs/ToolBar
;; 注意：在menu-bar不显示的情况下，按ctrl+鼠标右键还是能调出菜单选项的
(tool-bar-mode -1)
;; 如果总是不显示菜单，将下面代码加到.emacs中
;;参考： http://www.emacswiki.org/emacs/MenuBar
(menu-bar-mode -1)


;; -------------------- UI setting --------------------


;; ==================== mode line ====================
(setq show-buffer-file-name nil)
(defun toggle-show-buffer-file-name ()
  "toggle show or hide buffer full file name in mode line"
  (interactive)
  (setq show-buffer-file-name
	(if show-buffer-file-name nil t)))
(global-set-key (kbd "M-<f11>") 'toggle-show-buffer-file-name)

;; use setq-default to set it for /all/ modes
;; http://emacs-fu.blogspot.com/2011/08/customizing-mode-line.html
(defun my-mode-line ()
  (setq-default
   mode-line-format
   (list
    ;; the buffer name; the file name as a tool tip
    '(:eval (propertize "%b " 'face 'font-lock-keyword-face
			'help-echo (buffer-file-name)))

    ;; line and column
    "(" ;; '%02' to set to 2 chars at least; prevents flickering
    (propertize "%01l" 'face 'font-lock-type-face) ","
    (propertize "%02c" 'face 'font-lock-type-face) 
    ") "

    ;; relative position, size of file
    "["
    (propertize "%p" 'face 'font-lock-constant-face) ;; % above top
    "/"
    (propertize "%I" 'face 'font-lock-constant-face) ;; size
    ;; (format "%d" (count-lines (point-min) (point-max)))
    "] "

    ;; the current major mode for the buffer.
    "["

    '(:eval (propertize "%m" 'face 'font-lock-string-face
			'help-echo buffer-file-coding-system))
    "] "
    

    "[" ;; insert vs overwrite mode, input-method in a tooltip
    '(:eval (propertize (if overwrite-mode "Ovr" "Ins")
			'face 'font-lock-preprocessor-face
			'help-echo (concat "Buffer is in "
					   (if overwrite-mode "overwrite" "insert") " mode")))

    ;; was this buffer modified since the last save?
    '(:eval (when (buffer-modified-p)
	      (concat ","  (propertize "Mod"
				       'face 'font-lock-warning-face
				       'help-echo "Buffer has been modified"))))

    ;; is this buffer read-only?
    '(:eval (when buffer-read-only
	      (concat ","  (propertize "RO"
				       'face 'font-lock-type-face
				       'help-echo "Buffer is read-only"))))  
    "] "

    ;; add the time, with the date and the emacs uptime in the tooltip
    '(:eval (propertize (format-time-string "%H:%M:%S")
			'face 'font-lock-type-face
			'help-echo
			(concat (format-time-string "%Y-%02m-%02d %02H:%02M:%02S %Y-%02m-%02d %3a; ")
				(emacs-uptime "Uptime:%hh"))))

    ;; show buffer file name
    '(:eval (when show-buffer-file-name
	      (format " [%s]" (buffer-file-name))))

    " "
    
    ;; date
    '(:eval (propertize (format-time-string "%Y-%02m-%02d %3a")
			'face 'font-lock-type-face))
	

    " --"
    ;; i don't want to see minor-modes; but if you want, uncomment this:
    ;; minor-mode-alist  ;; list of minor modes
    "%-" ;; fill with '-'
    ))
  ;; 这里不知道Emacs发生啥事，初始化完成后，mode-line-format就被设置回默认值。
  ;; (setq default-mode-line-format mode-line-format) ; 奇葩了，没有这行它就没法设置成功
  )
(my-mode-line)
;; -------------------- mode line --------------------


;;; my-ui.el ends here
