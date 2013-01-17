;; Setting By Hua Liang [ [ Stupid ET ] Cedric Porter ]
;; Mail:    et@everet.org
;; website: http://EverET.org
;; Time-stamp: <2013-01-17 16:17:06 Thursday by Hua Liang>

;;Personal information
(setq user-full-name "Hua Liang")
(setq user-mail-address "et@everet.org") 

;; Add plugins to load-path.
;; We will put some tiny plugins in it
(add-to-list 'load-path "~/.emacs.d/plugins/") 
(add-to-list 'load-path "~/.emacs.d/plugins/configs") 

;; Environment
(push "~/.emacs.d/plugins/bin" exec-path)

(require 'my-functions)

(require 'my-misc-settings)

(require 'my-coding-style)

(require 'my-small-tools)

(require 'window-setting)

(require 'my-autocomplete-settings)

(require 'my-python-settings)

(require 'my-ruby-mode-settings)

;(require 'my-lisp-settings)

(require 'my-emacs-lisp-settings)

(require 'my-octopress-settings)

(require 'my-cedet-settings)
;(load-file "~/.emacs.d/plugins/cedet-bzr/cedet-devel-load.el")


(require 'my-gud-settings)

(require 'my-cscope-settings)

(require 'my-eshell-settings)

(require 'my-ecb-settings)

(require 'my-org-mode-settings)

(require 'my-yasnippet-settings)

(require 'my-iimage-settings)

(load "~/.emacs.d/plugins/configs/my-flymake-settings.el")

(load "~/.emacs.d/plugins/configs/my-auto-insert-settings.el")

;; (require 'my-el-get-settings)

;; -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
;; auto-generated

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-analyse-face ((t (:inherit ecb-default-highlight-face :background "dark magenta"))))
 '(ecb-default-highlight-face ((t (:background "dark magenta"))))
 '(ecb-history-face ((t (:inherit ecb-default-highlight-face :background "dark magenta"))))
 '(ecb-method-face ((t (:inherit ecb-default-highlight-face :background "dark magenta"))))
 '(ecb-tag-header-face ((((class color) (background dark)) (:background "SeaGreen4"))))
 '(which-func ((((class color) (min-colors 88) (background dark)) (:foreground "LightBlue1"))) t)
 '(xref-keyword-face ((t (:foreground "LightBlue"))))
 '(xref-list-pilot-face ((t (:foreground "blue violet"))))
 '(xref-list-symbol-face ((t (:foreground "light sky blue")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("a81bc918eceaee124247648fc9682caddd713897d7fd1398856a5b61a592cb62" "27470eddcaeb3507eca2760710cc7c43f1b53854372592a3afa008268bcf7a75" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" default)))
 '(ecb-options-version "2.40")
 '(safe-local-variable-values (quote ((eval when (fboundp (quote rainbow-mode)) (rainbow-mode 1)))))
 '(session-use-package t nil (session)))

