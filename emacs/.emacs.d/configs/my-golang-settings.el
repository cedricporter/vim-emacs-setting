;;; my-golang-settings.el
;;
;; Author: Hua Liang[Stupid ET] <et@everet.org>

(require 'go-autocomplete)

(defun my-go-mode-hook () 
  (add-hook 'before-save-hook 'gofmt-before-save) 
  (setq tab-width 4
        indent-tabs-mode 1)) 
(add-hook 'go-mode-hook 'my-go-mode-hook)

;;; my-golang-settings.el ends here
