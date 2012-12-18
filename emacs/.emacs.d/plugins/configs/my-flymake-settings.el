;; ==================== flymake ====================
;; flymake
(add-hook 'find-file-hook 'flymake-find-file-hook)
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
;;  
-------------------- flymake --------------------




(provide 'my-flymake-settings.el)

