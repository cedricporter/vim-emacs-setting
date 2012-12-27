;; ==================== eshell ====================
(setq eshell-cmpl-cycle-completions nil)

(global-set-key [f4] 'eshell)
(global-set-key [S-f4] 'term)

;; (setq ansi-term-color-vector
;;       [ "black" "tomato" "PaleGreen2" "gold1"
;; 		   "DeepSkyBlue1" "MediumOrchid1" "cyan" "white"])

;; (autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; (add-to-list 'load-path "~/.emacs.d/plugins/emacs-bash-completion")
;; (require 'bash-completion)
;; (bash-completion-setup)

(add-hook 'eshell-load-hook
          (lambda()(setq last-command-start-time (time-to-seconds))))
(add-hook 'eshell-pre-command-hook
          (lambda()(setq last-command-start-time (time-to-seconds))))
(add-hook 'eshell-before-prompt-hook
          (lambda()
	    (message "spend %g seconds"
		     (- (time-to-seconds) last-command-start-time))))

(defalias 'll '(eshell/ls "-l"))
(defalias 'ff 'find-file)

;; (defvar ac-source-eshell-pcomplete
;;   '((candidates . (pcomplete-completions))))
;; (defun ac-complete-eshell-pcomplete ()
;;   (interactive)
;;   (auto-complete '(ac-source-eshell-pcomplete)))
;; ;; 自动开启 ac-mode
;; ;; 需要 (global-auto-complete-mode 1)
;; (add-to-list 'ac-modes 'eshell-mode)
;; (setq ac-sources '(ac-source-eshell-pcomplete
;;                    ;; ac-source-files-in-current-dir
;;                    ;; ac-source-filename
;;                    ;; ac-source-abbrev
;;                    ;; ac-source-words-in-buffer
;;                    ;; ac-source-imenu
;; 		   ))
;; -------------------- eshell --------------------


(provide 'my-eshell-settings)
