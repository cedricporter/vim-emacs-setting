;; author: Hua Liang [Stupid ET]
;; Time-stamp: <2013-02-20 19:04:04 Wednesday by Hua Liang>

(require 'python)

;; Python Hook
(add-hook 'python-mode-hook
          '(lambda ()
             (setq indent-tabs-mode nil
		   tab-width 4
		   python-indent-offset 4
		   python-indent 4
		   ;; comment-start " # "
		   )))

;; 删除行尾的空白字符
(add-hook 'python-mode-hook '(lambda ()
			      (add-to-list
			       'write-file-functions
			       'delete-trailing-whitespace)))

(setq python-check-command "pyflakes")


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

(defun my-python-mode-hook ()
  (local-set-key (kbd "}") 'my-electric-keys)
  (local-set-key (kbd "]") 'my-electric-keys)
  )

(add-hook 'python-mode-hook 'my-python-mode-hook)
;; -------------------- 控制右括号的缩进 --------------------



;; ;;==================== python ====================

;; (autoload 'python-mode "python-mode" "Python Mode." t)
;; (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;; (add-to-list 'interpreter-mode-alist '("python" . python-mode))
;; (add-to-list 'load-path "~/.emacs.d/plugins/pymacs")

;; (require 'pymacs)
;; (autoload 'pymacs-apply "pymacs")
;; (autoload 'pymacs-call "pymacs")
;; (autoload 'pymacs-eval "pymacs" nil t)
;; (autoload 'pymacs-exec "pymacs" nil t)
;; (autoload 'pymacs-load "pymacs" nil t)
;; (autoload 'pymacs-autoload "pymacs")
;; ;;(eval-after-load "pymacs"
;; ;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))

;; ;;; Initialize Rope
;; (pymacs-load "ropemacs" "rope-")
;; (setq ropemacs-enable-autoimport t) ;; Too slow when I am saving

;; (ac-ropemacs-initialize)
;; (add-hook 'python-mode-hook
;; 	  (lambda ()
;; 	    (add-to-list 'ac-sources 'ac-source-ropemacs)))

;; ;; ;;load pydb
;; ;; (require 'pydb)
;; ;; (autoload 'pydb "pydb" "Python Debugger mode via GUD and pydb" t)
;; ;;-------------------- python --------------------


;; (provide 'my-python-settings)
