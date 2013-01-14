;; author: Hua Liang [Stupid ET]
;; Time-stamp: <2013-01-14 14:49:45 Monday by Hua Liang>

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

(define-key gud-mode-map [(f11)] 'gud-step)
(define-key gud-mode-map [(f10)] 'gud-next)

(define-key gud-mode-map [(f9)] 'gud-cont)
(define-key gud-mode-map [(shift f11)] 'gud-finish)



(defadvice gdb-setup-windows (after my-setup-gdb-windows activate)
  "my gdb UI"
  (gdb-get-buffer-create 'gdb-stack-buffer)
  (set-window-dedicated-p (selected-window) nil)
  (switch-to-buffer gud-comint-buffer)
  (delete-other-windows)
  (let ((win0 (selected-window))        
        (win1 (split-window nil nil 'left))      ;code and output
        (win2 (split-window-below (/ (* (window-height) 2) 3)))     ;stack
        )
    (select-window win2)
    (gdb-set-window-buffer (gdb-stack-buffer-name))
    (select-window win1)
    (set-window-buffer
     win1
     (if gud-last-last-frame
         (gud-find-file (car gud-last-last-frame))
       (if gdb-main-file
           (gud-find-file gdb-main-file)
         ;; Put buffer list in window if we
         ;; can't find a source file.
         (list-buffers-noselect))))
    (setq gdb-source-window (selected-window))
    (let ((win3 (split-window nil (/ (* (window-height) 3) 4)))) ;io
      (gdb-set-window-buffer (gdb-get-buffer-create 'gdb-inferior-io) nil win3))
    (select-window win0)
    ))
;; -------------------- gud --------------------



(provide 'my-gud-settings)
