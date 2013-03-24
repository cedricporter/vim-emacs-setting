;;; my-helm-config.el
;;
;; Author: Hua Liang[Stupid ET] <et@everet.org>
;; Time-stamp: <2013-03-24 18:34:58 Sunday by Hua Liang>


(require 'helm-config)
(require 'helm-gtags)

;;; Enable helm-gtags-mode
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

;; customize
(setq helm-gtags-path-style 'relative)
(setq helm-gtags-ignore-case t)
(setq helm-gtags-read-only nil)

;; key bindings
(add-hook 'helm-gtags-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-.") 'helm-gtags-find-tag)
             (local-set-key (kbd "C-,") 'helm-gtags-pop-stack)
             (local-set-key (kbd "M-r") 'helm-gtags-find-rtag)
             (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
             ))


;;; my-helm-config.el ends here
