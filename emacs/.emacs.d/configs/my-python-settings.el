;; Author: Hua Liang [Stupid ET]
;; Time-stamp: <2015-07-23 12:42:55 Thursday by Hua Liang>

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

(defun my-add-delete-trailing-whitespace ()
  (interactive)
    (message "turn on delete-trailing-whitespace")
    (add-to-list
     'write-file-functions
     'delete-trailing-whitespace)
    )

;; (global-set-key (kbd "<C-f11>")
;; 		(lambda ()
;; 		  (interactive)
;; 		  (message "add delete-trailing-whitespace")
;; 		  (my-add-delete-trailing-whitespace)
;; 		  ))

;; 删除行尾的空白字符
(add-hook 'python-mode-hook 'my-add-delete-trailing-whitespace)

(setq python-check-command "pyflakes")


;; ==================== jedi ====================
;; http://txt.arboreus.com/2013/02/21/jedi.el-jump-to-definition-and-back.html

;; (defvar jedi:goto-stack '())
;; (defun jedi:jump-to-definition ()
;;   (interactive)
;;   (add-to-list 'jedi:goto-stack
;;                (list (buffer-name) (point)))
;;   (jedi:goto-definition))
;; (defun jedi:jump-back ()
;;   (interactive)
;;   (let ((p (pop jedi:goto-stack)))
;;     (if p (progn
;;             (switch-to-buffer (nth 0 p))
;;             (goto-char (nth 1 p))))))

(defun switch-to-vipbar-mode ()
  (interactive)
  (message "switch-to-vipbar-mode")
  (setq indent-tabs-mode t)
  (delete 'delete-trailing-whitespace write-file-functions)
  )

(defun disable-vipbar-mode ()
  (interactive)
  (message "disable-vipbar-mode")
  (setq indent-tabs-mode nil)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace)
  )


;; redefine jedi's C-. (jedi:goto-definition)
;; to remember position, and set C-, to jump back
(add-hook 'python-mode-hook
          '(lambda ()
             ;; (local-set-key (kbd "C-.") 'jedi:jump-to-definition)
             ;; (local-set-key (kbd "C-,") 'jedi:jump-back)
             ;; (local-set-key (kbd "C-c d") 'jedi:show-doc)
             ;; (local-set-key (kbd "C-<tab>") 'jedi:complete)
             ;; ;; (local-set-key (kbd "C-c r") 'jedi:key-related-names)

             (when (< (buffer-size) 10000)
               (message "turn on flymake")
               (flymake-mode-on))

	     (local-set-key (kbd "<f12>") 'flymake-mode)
	     (local-set-key (kbd "<f11>") 'switch-to-vipbar-mode)
	     (local-set-key (kbd "<S-f11>") 'disable-vipbar-mode)
             ))

;; -------------------- jedi --------------------



;; ;;==================== python ====================

;; (autoload 'python-mode "python-mode" "Python Mode." t)
;; (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;; (add-to-list 'interpreter-mode-alist '("python" . python-mode))
;; (add-to-list 'load-path "~/.emacs.d/plugins/pymacs")

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
(setq ropemacs-enable-autoimport t) ;; Too slow when I am saving

(add-hook 'python-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-.") 'rope-goto-definition)
             (local-set-key (kbd "C-,") 'rope-pop-mark)
             ))

;; (ac-ropemacs-initialize)
;; (add-hook 'python-mode-hook
;; 	  (lambda ()
;; 	    (add-to-list 'ac-sources 'ac-source-ropemacs)))

;; ;; ;;load pydb
;; ;; (require 'pydb)
;; ;; (autoload 'pydb "pydb" "Python Debugger mode via GUD and pydb" t)
;; ;;-------------------- python --------------------

;; 去掉cedet
(remove-hook 'python-mode-hook 'wisent-python-default-setup)

(define-coding-system-alias 'GB18030 'gb18030)
(define-coding-system-alias 'GB2312 'gb2312)
(define-coding-system-alias 'utf8 'utf-8)

(load "~/.emacs.d/plugins/autoflake.el")

;; (provide 'my-python-settings)
