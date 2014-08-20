;; author: Hua Liang [Stupid ET]
;; Time-stamp: <2014-08-20 09:21:04 Wednesday by Hua Liang>

(define-key emacs-lisp-mode-map (kbd "C-x C-r") 'eval-region)
(define-key lisp-interaction-mode-map (kbd "C-x C-r") 'eval-region)

;; ;; parenthese
;; (add-hook 'emacs-lisp-mode-hook
;;           '(lambda ()
;;              (highlight-parentheses-mode)
;;              (setq autopair-handle-action-fns
;;                    (list 'autopair-default-handle-action
;;                          '(lambda (action pair pos-before)
;;                             (hl-paren-color-update))
;; 			 ))))

;; (provide 'my-emacs-lisp-settings)


;; ==================== auto recompile Emacs Lisp File ====================
;; http://ergoemacs.org/emacs/emacs_byte_compile.html
;;
(defun byte-compile-current-buffer ()
  "`byte-compile' current buffer if it's emacs-lisp-mode and compiled file exists."
  (interactive)
  (when (and (eq major-mode 'emacs-lisp-mode)
             (file-exists-p (byte-compile-dest-file buffer-file-name)))
    (byte-compile-file buffer-file-name)))

(add-hook 'after-save-hook 'byte-compile-current-buffer)
;; -------------------- auto recompile Emacs Lisp File --------------------

