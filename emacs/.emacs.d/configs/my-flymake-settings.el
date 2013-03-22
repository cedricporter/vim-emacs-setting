;; author: Hua Liang [Stupid ET]
;; Time-stamp: <2013-03-22 13:44:05 Friday by Hua Liang>

;; ==================== flymake ====================
;; flymake
;; 对于c/c++，Makefile需要加上
;; check-syntax:
;;     gcc -Wall -Wextra -pedantic -fsyntax-only $(CHK_SOURCES)


(add-hook 'find-file-hook 'flymake-find-file-hook)


;; ==================== temp file ====================
;; Nope, I want my copies in the system temp dir.
(setq flymake-run-in-place nil)
;; This lets me say where my temp dir is.
(setq temporary-file-directory "~/.emacs.d/tmp/")
;; -------------------- temp file --------------------


;; ==================== privilege ====================
;; ;; http://www.emacswiki.org/emacs/FlyMake#toc14
;; (defun cwebber/safer-flymake-find-file-hook ()
;;   "Don't barf if we can't open this flymake file"
;;   (let ((flymake-filename
;;          (flymake-create-temp-inplace (buffer-file-name) "flymake")))
;;     (if (file-writable-p flymake-filename)
;;         (flymake-find-file-hook)
;;       (message
;;        (format
;;         "Couldn't enable flymake; permission denied on %s" flymake-filename)))))

;; (add-hook 'find-file-hook 'cwebber/safer-flymake-find-file-hook)
;; -------------------- privilege --------------------


(setq flymake-gui-warnings-enabled nil) ;烦死了
(setq flymake-log-level 0)


;; Nope, I want my copies in the system temp dir.
(setq flymake-run-in-place nil)
;; This lets me say where my temp dir is.
(setq temporary-file-directory "~/.emacs.d/tmp/")

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




;; (provide 'my-flymake-settings.el)

