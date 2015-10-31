;;; my-helm-config.el
;;
;; Author: Hua Liang[Stupid ET] <et@everet.org>
;; Time-stamp: <2015-10-31 11:22:22 星期六 by Hua Liang>


(require 'helm-config)
; (require 'helm-gtags)

;;; Enable helm-gtags-mode
; (add-hook 'c-mode-hook 'helm-gtags-mode)
; (add-hook 'c++-mode-hook 'helm-gtags-mode)
; (add-hook 'asm-mode-hook 'helm-gtags-mode)
; (add-hook 'java-mode-hook 'helm-gtags-mode)

;; customize
; (setq helm-gtags-path-style 'relative)
; (setq helm-gtags-ignore-case t)
; (setq helm-gtags-read-only nil)

(defun my-helm-gtags-func ()
  (interactive)
  (local-set-key (kbd "C-.") 'helm-gtags-find-tag-from-here)
  (local-set-key (kbd "C-,") 'helm-gtags-pop-stack)
  (local-set-key (kbd "M-r") 'helm-gtags-find-rtag)
  (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
  )

;; key bindings
; (add-hook 'helm-gtags-mode-hook 'my-helm-gtags-func)

(defun helm-mini ()
  "Preconfigured `helm' lightweight version \(buffer -> recentf\)."
  (interactive)
  (require 'helm-files)
  (helm-other-buffer '(helm-source-buffers-list
                       helm-source-files-in-current-dir
                       helm-source-ls-git
                       helm-source-recentf
                       helm-source-file-cache)
                     "*helm mini*"))

(setq helm-for-files-preferred-list '(helm-source-buffers-list
                                      helm-source-ls-git
                                      helm-source-files-in-current-dir
                                      helm-source-recentf
                                      helm-source-bookmarks
                                      helm-source-file-cache
                                      helm-source-locate))

;;; my-helm-config.el ends here
