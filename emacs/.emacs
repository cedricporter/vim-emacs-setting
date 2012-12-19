;; Setting By Hua Liang [ [ Stupid ET ] Cedric Porter ]
;; Mail:    et@everet.org
;; website: http://EverET.org

;;Personal information
(setq user-full-name "Hua Liang")
(setq user-mail-address "et@everet.org") 

;; Add plugins to load-path.
;; We will put some tiny plugins in it
(add-to-list 'load-path "~/.emacs.d/plugins/") 
(add-to-list 'load-path "~/.emacs.d/plugins/configs") 

;; Environment
(push "~/.emacs.d/plugins/bin" exec-path)

(require 'my-misc-settings)

(require 'my-coding-style)

(require 'my-small-tools)

(require 'my-yasnippet-settings)

(require 'my-autocomplete-settings)

(require 'my-python-settings)

(require 'my-lisp-settings)

(require 'my-cedet-settings)

(require 'my-gud-settings)

(require 'my-cscope-settings)

(require 'my-eshell-settings)

(require 'my-ecb-settings)


;; -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
;; auto-generated

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-tag-header-face ((((class color) (background dark)) (:background "SeaGreen4"))))
 '(highlight ((t (:background "black" :foreground "LightGoldenrod"))))
 '(moinmoin-anchor-ref-id ((t (:foreground "LightBlue2" :underline t :height 0.8))))
 '(moinmoin-anchor-ref-title ((t (:foreground "LightBlue4" :underline t))))
 '(moinmoin-code ((t (:foreground "purple"))))
 '(moinmoin-email ((t (:foreground "LightBlue2"))))
 '(moinmoin-inter-wiki-link ((t (:foreground "LightBlue3" :weight bold))))
 '(moinmoin-url ((t (:foreground "LightBlue2" :height 0.8))))
 '(moinmoin-url-title ((t (:foreground "LightBlue4" :underline t))))
 '(moinmoin-wiki-link ((t (:foreground "LightBlue4" :weight bold))))
 '(which-func ((((class color) (min-colors 88) (background dark)) (:foreground "LightBlue1"))))
 '(xref-keyword-face ((t (:foreground "LightBlue"))))
 '(xref-list-pilot-face ((t (:foreground "blue violet"))))
 '(xref-list-symbol-face ((t (:foreground "light sky blue")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40")
 '(session-use-package t nil (session)))

