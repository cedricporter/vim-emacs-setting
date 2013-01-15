;; author: Hua Liang [Stupid ET]
;; Time-stamp: <2013-01-15 11:27:08 Tuesday by Hua Liang>

;; ==================== flymake ====================
;; flymake
;; 对于c/c++，Makefile需要加上
;; check-syntax:
;;     $(CXXCOMPILE) -Wall -Wextra -pedantic -fsyntax-only $(CHK_SOURCES)

(add-hook 'find-file-hook 'flymake-find-file-hook)

(setq flymake-gui-warnings-enabled nil) ;烦死了
(setq flymake-log-level 0)

(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
	       'flymake-create-temp-inplace))
       (local-file (file-relative-name
	    temp-file
	    (file-name-directory buffer-file-name))))
      (list "pycheckers"  (list local-file))))
   (add-to-list 'flymake-allowed-file-name-masks
	     '("\\.py\\'" flymake-pyflakes-init)))

(load-library "flymake-cursor")

(global-set-key "\C-c\C-ep" 'flymake-goto-prev-error)
(global-set-key "\C-c\C-en" 'flymake-goto-next-error)
;; -------------------- flymake --------------------




(provide 'my-flymake-settings.el)

