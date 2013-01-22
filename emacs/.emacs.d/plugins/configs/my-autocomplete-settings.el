;; author: Hua Liang [Stupid ET]
;; Time-stamp: <2013-01-23 01:09:48 Wednesday by Hua Liang>

;;==================== auto complete ====================
;; auto complete with clang
(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete")
(require 'auto-complete-config)

(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/auto-complete/ac-dict/")  
(setq ac-auto-start t)
(setq ac-quick-help-delay 0.5)
;; (ac-set-trigger-key "TAB")
(define-key ac-mode-map [(control tab)] 'auto-complete)

(add-to-list 'ac-modes 'coffee-mode)
(add-to-list 'ac-modes 'markdown-mode)

;; -------------------- end of auto complete --------------------

(provide 'my-autocomplete-settings)
