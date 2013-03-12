;; author: Hua Liang [Stupid ET]
;; Time-stamp: <2013-03-12 20:53:18 Tuesday by Hua Liang>

;; (assq-delete-all "\\.py$" auto-mode-alist)
;; (assq-delete-all "\\.py\\" auto-mode-alist)

;; (add-to-list 'load-path "~/.emacs.d/el-get/python-mode/")
;; (autoload 'python-mode "~/.emacs.d/el-get/python-mode/python-mode.el" "Python Mode." t)
;; (load "~/.emacs.d/el-get/python-mode/python-mode.el")
;; (add-to-list 'auto-mode-alist '("\\.py$\\'" . python-mode))
;; (add-to-list 'interpreter-mode-alist '("python" . python-mode))


;; (require 'python)

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
		   ;; comment-start " # "
		   )
	     (set-variable 'python-indent-offset 4)
	     (set-variable 'python-indent-guess-indent-offset nil)
	     (local-set-key (kbd "<f5>") 'flymake-goto-next-error)
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
