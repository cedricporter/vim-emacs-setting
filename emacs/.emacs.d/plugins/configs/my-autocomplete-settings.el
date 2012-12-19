;;==================== auto complete ====================
;; auto complete with clang
(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete")
(require 'auto-complete-config)

; bug fix, ac is incompatible with yas 0.8
(setq ac-sources (delq 'ac-source-yasnippet ac-sources))

(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/auto-complete/ac-dict/")  
(setq ac-auto-start t)
(setq ac-quick-help-delay 0.5)
;; (ac-set-trigger-key "TAB")
(define-key ac-mode-map [(control tab)] 'auto-complete)

;; -------------------- end of auto complete --------------------

(provide 'my-autocomplete-settings)
