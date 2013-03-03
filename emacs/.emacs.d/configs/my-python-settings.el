;; author: Hua Liang [Stupid ET]
;; Time-stamp: <2013-03-03 10:54:41 Sunday by Hua Liang>

(require 'python)

(defun switch-python-web-mode ()
  "切换python-mode和web-mode"
  (interactive)
  (cond
   ((eq major-mode 'python-mode)
    (web-mode)
    )
   ((eq major-mode 'web-mode)
    (python-mode)
    )
   ))
(global-set-key (kbd "<S-f8>") 'switch-python-web-mode)


;; Python Hook
(add-hook 'python-mode-hook
          '(lambda ()
             (setq indent-tabs-mode nil
		   tab-width 4
		   python-indent-offset 4
		   python-indent 4
		   ;; comment-start " # "
		   )
	     ))

;; 删除行尾的空白字符
(add-hook 'python-mode-hook '(lambda ()
			      (add-to-list
			       'write-file-functions
			       'delete-trailing-whitespace)))

(setq python-check-command "pyflakes")



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
