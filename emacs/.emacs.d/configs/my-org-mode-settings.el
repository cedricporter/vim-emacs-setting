;; author: Hua Liang [Stupid ET]
;; Time-stamp: <2013-02-27 18:39:59 Wednesday by Hua Liang>

;; ; org-mode install
;; (add-to-list 'load-path "~/.emacs.d/el-get/org-mode/lisp")
;; (add-to-list 'load-path "~/.emacs.d/el-get/org-mode/contrib/lisp")
;; (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
;; (require 'org-install)

(require 'org)
(define-key org-mode-map (kbd "C-<tab>") 'pcomplete)

;; ==================== Fix yasnippet's TAB ====================
(add-hook 'org-mode-hook
          (lambda ()
            (org-set-local 'yas/trigger-key [tab])
            (define-key yas/keymap [tab] 'yas/next-field-or-maybe-expand)))

(defun yas/org-very-safe-expand ()
  (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))

(add-hook 'org-mode-hook
          (lambda ()
            (make-variable-buffer-local 'yas/trigger-key)
            (setq yas/trigger-key [tab])
            (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
            (define-key yas/keymap [tab] 'yas/next-field)))
;; -------------------- Fix yasnippet's TAB --------------------

(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key (kbd "<f7>") 'org-publish-current-project)
	    ))


(setq org-src-fontify-natively t)

;; ==================== css ====================

(setq org-html-style-include-scripts nil
      org-html-style-include-default nil)

(setq org-html-style
      "<link rel=\"stylesheet\" type=\"text/css\" href=\"css/default.css?v=1\" />")

;; -------------------- css --------------------

;; (setq org-html-postamble 'my-org-html-postamble)
(setq org-html-postamble t)
(setq org-html-postamble-format
      '(("zh-CN" "<hr/><p class=\"author\">Author: %a (%e)</p>\n<p class=\"date\">Date: %d</p>\n")))

;; ==================== wiki ====================
;; (require 'org-publish)
(setq org-publish-project-alist
      '(
	("org-wiki-notes"
	 :base-directory "~/octopress/org-wiki/"
	 :base-extension "org"
	 :publishing-directory "~/octopress/source/notes/" ; "/ssh:user@host:~/html/notebook/"
	 :recursive t
	 :publishing-function org-html-publish-to-html
	 :headline-levels 4             ; Just the default for this project.
         :section-numbers t
	 :auto-preamble t
	 :author "Hua Liang [Stupid ET]"
 	 :auto-sitemap t
	 :language "zh-CN"
	 :sitemap-filename "sitemap.org"
	 :sitemap-title "" ;"Stupid ET's Wiki"
	 :completion-function (lambda ()
				 (shell-command "cp -rf ~/octopress/source/notes ~/octopress/public/")
				 )
         ;; :style "<link rel=\"stylesheet\" type=\"text/css\" href=\"css/default.css\" />"   ; useless
	 )
	("org-wiki-static"
	 :base-directory "~/octopress/org-wiki/"
	 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
	 :publishing-directory "~/octopress/source/notes/"
	 :recursive t
	 :publishing-function org-publish-attachment
	 )
	("wiki" :components ("org-wiki-notes" "org-wiki-static"))

	;; new
	("owiki"
	 :base-directory "~/octopress/source/_org_posts/"
	 :base-extension "org"
	 :publishing-directory "~/octopress/source/wiki/"
	 :sub-superscript ""
	 :recursive t
	 :publishing-function org-html-publish-to-html
	 :headline-levels 4
	 :html-extension "markdown"
	 :body-only t
	 )

	))
;; -------------------- wiki --------------------

;(load "~/.emacs.d/plugins/org-mode-markdown/markdown.el")

;; (provide 'my-org-mode-settings)
