;; author: Hua Liang [Stupid ET]
;; Time-stamp: <2013-02-20 12:11:42 Wednesday by Hua Liang>

;; ; org-mode install
;; (add-to-list 'load-path "~/.emacs.d/el-get/org-mode/lisp")
;; (add-to-list 'load-path "~/.emacs.d/el-get/org-mode/contrib/lisp")
;; (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
;; (require 'org-install)

(require 'org)
(define-key org-mode-map (kbd "C-<tab>") 'pcomplete)

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

(setq org-src-fontify-natively t)

;; ==================== css ====================
(setq org-export-html-style-include-scripts nil
      org-export-html-style-include-default nil)

(setq org-export-html-style
      "<link rel=\"stylesheet\" type=\"text/css\" href=\"css/default.css\" />")
;; -------------------- css --------------------

(setq org-export-html-postamble t)
(setq org-export-html-postamble-format
      '(("en" "<hr/><p class=\"author\">Author: %a (%e)</p>\n<p class=\"date\">Date: %d</p>\n")))


;; ==================== wiki ====================
(require 'org-publish)
(setq org-publish-project-alist
      '(
	("org-wiki-notes"
	 :base-directory "~/org-wiki/"
	 :base-extension "org"
	 :publishing-directory "~/wiki_public_html/"
	 :recursive t
	 :publishing-function org-publish-org-to-html
	 :headline-levels 4             ; Just the default for this project.
	 :auto-preamble t
	 :author "Hua Liang [Stupid ET]"
 	 :auto-sitemap t
	 :sitemap-filename "index.org"
	 :sitemap-title "My Wiki"
	 )
	("org-wiki-static"
	 :base-directory "~/org-wiki/"
	 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
	 :publishing-directory "~/wiki_public_html/"
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
	 :publishing-function org-publish-org-to-html
	 :headline-levels 4
	 :html-extension "markdown"
	 :body-only t
	 )

	))
;; -------------------- wiki --------------------

;(load "~/.emacs.d/plugins/org-mode-markdown/markdown.el")

;; (provide 'my-org-mode-settings)
