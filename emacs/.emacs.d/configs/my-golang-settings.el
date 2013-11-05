;;; my-golang-settings.el
;;
;; Author: Hua Liang[Stupid ET] <et@everet.org>

(require 'go-autocomplete)

(defun my-go-mode-hook () 
  (add-hook 'before-save-hook 'gofmt-before-save) 
  (setq tab-width 4
        indent-tabs-mode 1)
  (local-set-key (kbd "<f5>") 'my-go-run)
  ) 
(add-hook 'go-mode-hook 'my-go-mode-hook)

(defun my-go-run ()
  (interactive)
  (compile (concat "go run " (buffer-file-name))))

;;; my-golang-settings.el ends here
