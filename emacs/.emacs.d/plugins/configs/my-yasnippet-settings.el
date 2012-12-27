;;==================== yasnippt ====================
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas/global-mode 1)

(add-hook 'eshell-mode-hook '(lambda ()
			       (yas-minor-mode -1)))

;; automatic reload after snippets changed
(defun reload-yasnippets-on-save-snippets ()
  (when (string-match "/snippets/" buffer-file-name)
    (yas/reload-all)
    ))
(add-hook 'after-save-hook 'reload-yasnippets-on-save-snippets)
;;-------------------- yasnippt --------------------

(provide 'my-yasnippet-settings)
