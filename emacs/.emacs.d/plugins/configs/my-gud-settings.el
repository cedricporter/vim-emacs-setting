;; ==================== gud ====================

(gud-tooltip-mode 1)
(add-hook 'gdb-mode-hook '(lambda ()
                            (define-key c-mode-base-map [(f11)] 'gud-step) ; step in
                            (define-key c-mode-base-map [(f10)] 'gud-next) ; step out
                            (define-key c-mode-base-map [(f5)] 'gud-go)
                            (define-key c-mode-base-map [(shift f5)] 'gud-cont)
                            (define-key c-mode-base-map [(control f5)] 'gud-until) ; run to here
                            (define-key c-mode-base-map [(f9)] 'gud-break) ; set break point
                            (define-key c-mode-base-map [(control f9)] 'gud-remove) ; remove break point
                            (define-key c-mode-base-map [(shitf f11)] 'gud-finish) ; jump out of the function
			    )) 

(global-set-key [f10] 'gud-next)

;; -------------------- gud --------------------



(provide 'my-gud-settings)
