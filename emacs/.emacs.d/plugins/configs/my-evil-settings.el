;;==================== evil ====================
;;vi emulator
(setq evil-want-C-i-jump t)
(setq evil-want-C-u-scroll t)

(add-to-list 'load-path "~/.emacs.d/plugins/evil")
(require 'evil)  
(evil-mode 1)
(require 'surround)
(global-surround-mode 1)

;;(global-set-key [(kdb "C-u")] 'evil-scroll-up)

(define-key evil-normal-state-map ",i" 'ibuffer)
(define-key evil-normal-state-map ",bs" 'ido-switch-buffer)
(define-key evil-normal-state-map ",bd" 'kill-this-buffer)
;(define-key evil-normal-state-map ",m" 'magit-status)
(define-key evil-normal-state-map ",w" 'save-buffer)
(define-key evil-normal-state-map ",ee" 'open-setting-file)
(define-key evil-normal-state-map "ZZ" (kbd "C-c C-c"))

;; org-mode relaterat
(define-key evil-normal-state-map ",a" 'org-agenda)

;; lisp-relaterat som annars inte verkar fungera
(define-key evil-normal-state-map ",hv" 'describe-variable)
(define-key evil-normal-state-map ",hk" 'describe-key)
(define-key evil-normal-state-map ",hf" 'describe-function)
(define-key evil-normal-state-map ",hm" 'describe-mode)

;; window
(define-key evil-normal-state-map ",0" 'delete-window)         ;delete this window, same as C-x 0 
(define-key evil-normal-state-map ",1" 'delete-other-windows)  ;delete other windows
(define-key evil-normal-state-map ",2" 'split-window-up-down)  ;split the window to up and down windows, which the upper one is bigger
(define-key evil-normal-state-map ",3" 'split-window-3)        ;split the window to 3 window, left big
(define-key evil-normal-state-map ",4" 'split-window-4)        ;split the window into 4 equal size window
(define-key evil-normal-state-map ",q" 'winner-undo)	       ;undo, in other word, restore to previous window style
(define-key evil-normal-state-map ",Q" 'winner-redo)	       ;redo window style change

;; End of evil config copied from monotux@reddit
;;-------------------- evil --------------------



(provide 'my-evil-settings)
