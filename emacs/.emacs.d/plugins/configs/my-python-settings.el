;; author: Hua Liang [Stupid ET]
;; Time-stamp: <2013-01-21 20:57:16 Monday by Hua Liang>


;; Python Hook
(add-hook 'python-mode-hook
          '(lambda ()
             (setq indent-tabs-mode nil tab-width 4)
             (setq python-indent-offset 4)
             (setq python-indent 4)
             ))

;; 删除行尾的空白字符
(add-hook 'python-mode-hook '(lambda ()
			      (add-to-list 
			       'write-file-functions
			       'delete-trailing-whitespace)))

(setq python-check-command "pyflakes")

;; ==================== jedi ====================

;; deferred
(add-to-list 'load-path "~/.emacs.d/plugins/deferred")
(require 'deferred)
(require 'concurrent)

;; ctable
(add-to-list 'load-path "~/.emacs.d/plugins/ctable")
(require 'ctable)

;; epc
(add-to-list 'load-path "~/.emacs.d/plugins/epc")
(require 'epc)

;; jedi
(add-to-list 'load-path "~/.emacs.d/plugins/jedi")

(setq jedi:setup-keys t)
(autoload 'jedi:setup "jedi" nil t)

(add-hook 'python-mode-hook '(lambda ()
                               (define-key python-mode-map (kbd "C-c r") 'helm-jedi-related-names)
                               (jedi:setup))
          )

;; -------------------- jedi --------------------



;; ;;==================== python ====================
;; (require 'python)

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


(provide 'my-python-settings)

