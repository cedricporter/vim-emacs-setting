;; author: Hua Liang [Stupid ET]
;; Time-stamp: <2014-02-09 22:23:38 Sunday by Hua Liang>

;;==================== auto complete ====================
;; auto complete with clang
(require 'auto-complete-config)

(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict/")
(setq ac-auto-start t)
(setq ac-quick-help-delay 0.5)
;; (ac-set-trigger-key "TAB")
(define-key ac-mode-map [(control tab)] 'auto-complete)

(add-to-list 'ac-modes 'coffee-mode)
(add-to-list 'ac-modes 'markdown-mode)
(add-to-list 'ac-modes 'web-mode)
(add-to-list 'ac-modes 'js2-mode)

(require 'ac-emacs-eclim-source)
(ac-emacs-eclim-config)

;; -------------------- end of auto complete --------------------

;; (provide 'my-autocomplete-settings)
