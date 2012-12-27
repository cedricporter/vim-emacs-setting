;; ==================== gud ====================

(defun set-my-gud-key-binding ()
  (define-key c-mode-base-map [(f11)] 'gud-step) ; step in
  (define-key c-mode-base-map [(f10)] 'gud-next) ; step out
  (define-key c-mode-base-map [(f5)] 'gud-go)
  (define-key c-mode-base-map [(shift f5)] 'gud-cont)
  (define-key c-mode-base-map [(control f5)] 'gud-until) ; run to here
  (define-key c-mode-base-map [(f9)] 'gud-break) ; set break point
  (define-key c-mode-base-map [(control f9)] 'gud-remove) ; remove break point
  (define-key c-mode-base-map [(shift f11)] 'gud-finish) ; jump out of the function
  )

(gud-tooltip-mode 1)

(global-set-key [(f11)] 'gud-step)
(global-set-key [(f10)] 'gud-next)
;; (add-hook 'gdb-mode-hook '(lambda ()
;;   			    )) 

;; (defadvice gdb-setup-windows (around setup-more-gdb-windows activate)
;;   ad-do-it
;;   (split-window-horizontally)
;;   (other-window 1)
;;   (gdb-set-window-buffer
;;    (gdb-get-buffer-create 'gdb-assembler-buffer)))


;; -------------------- gud --------------------



(provide 'my-gud-settings)
