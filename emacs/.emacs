;; Setting By Hua Liang [ [ Stupid ET ] Cedric Porter ]
;; Mail:    et@everet.org
;; website: http://EverET.org
;; Time-stamp: <2013-03-21 10:30:56 Thursday by Hua Liang>

;;Personal information
(setq user-full-name "Hua Liang")
(setq user-mail-address "et@everet.org")

;; Add plugins to load-path.
;; We will put some tiny plugins in it
(add-to-list 'load-path "~/.emacs.d/plugins/")
(add-to-list 'load-path "~/.emacs.d/configs")

;; Environment
(push "~/.emacs.d/plugins/bin" exec-path)


;; UI
(load "~/.emacs.d/configs/my-themes.el")

(load "~/.emacs.d/configs/my-ui.el")

(load "~/.emacs.d/configs/my-functions.el")

(load "~/.emacs.d/configs/my-el-get-settings.el")

(load "~/.emacs.d/configs/my-tabbar.el")

(load "~/.emacs.d/configs/my-misc-settings.el")

(load "~/.emacs.d/configs/my-coding-style.el")

(load "~/.emacs.d/configs/my-small-tools.el")

(load "~/.emacs.d/configs/window-setting.el")

(load "~/.emacs.d/configs/my-python-settings.el")

(load "~/.emacs.d/configs/my-ruby-mode-settings.el")

(load "~/.emacs.d/configs/my-emacs-lisp-settings.el")

(load "~/.emacs.d/configs/my-octopress-settings.el")

(load "~/.emacs.d/configs/my-cedet-settings.el")

;(require 'my-lisp-settings)

;(load-file "~/.emacs.d/plugins/cedet-bzr/cedet-devel-load.el")

(load "~/.emacs.d/configs/my-gud-settings.el")

(load "~/.emacs.d/configs/my-cscope-settings.el")

(load "~/.emacs.d/configs/my-eshell-settings.el")

(load "~/.emacs.d/configs/my-ecb-settings.el")

(load "~/.emacs.d/configs/my-org-mode-settings.el")

(load "~/.emacs.d/configs/my-iimage-settings.el")

(load "~/.emacs.d/configs/my-flymake-settings.el")

(load "~/.emacs.d/configs/my-auto-insert-settings.el")

(load "~/.emacs.d/configs/my-coffee-script.el")

(load "~/.emacs.d/configs/my-helm-config.el")

(load "~/.emacs.d/configs/my-gtags-config.el")

;; 解决一些global按键绑定被minor给覆盖的问题
(load "~/.emacs.d/configs/my-minor-key-map.el")

;; 隐藏modeline的minor mode
(load "~/.emacs.d/configs/my-diminish.el")


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
 '(ansi-color-names-vector ["#3f3f3f" "#cc9393" "#7f9f7f" "#f0dfaf" "#8cd0d3" "#dc8cc3" "#93e0e3" "#dcdccc"])
 '(ansi-term-color-vector ["#3f3f3f" "#cc9393" "#7f9f7f" "#f0dfaf" "#8cd0d3" "#dc8cc3" "#93e0e3" "#dcdccc"] t)
 '(custom-safe-themes (quote ("8f0ed281527c8916f0c2dd580a37536ae37af194f7c7102a1fe9a3467b853671" "a81bc918eceaee124247648fc9682caddd713897d7fd1398856a5b61a592cb62" "27470eddcaeb3507eca2760710cc7c43f1b53854372592a3afa008268bcf7a75" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" default)))
 '(ecb-options-version "2.40")
 '(ede-project-directories (quote ("/home/cedricporter/projects/ethttpd/include" "/home/cedricporter/projects/ethttpd/src" "/home/cedricporter/projects/ethttpd")))
 '(fci-rule-color "#383838")
 '(org-startup-folded nil)
 '(org-startup-truncated nil)
 '(safe-local-variable-values (quote ((eval when (fboundp (quote rainbow-mode)) (rainbow-mode 1)))))
 '(session-use-package t nil (session))
 '(vc-follow-symlinks t))
