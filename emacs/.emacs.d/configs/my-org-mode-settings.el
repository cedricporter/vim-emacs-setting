;; author: Hua Liang [Stupid ET]
;; Time-stamp: <2013-02-22 21:31:49 Friday by Hua Liang>

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

(setq org-html-style-include-scripts nil
      org-html-style-include-default nil)

(setq org-html-style
      "<link rel=\"stylesheet\" type=\"text/css\" href=\"css/default.css\" />")

;; -------------------- css --------------------

(setq org-html-postamble
      '(lambda (options)
	 "定制末尾显示"
	 (let ((author "Hua Liang [Stupid ET]"))
	   (format
	    (concat
	     "<a href=\"http://EverET.org/notes/\">[Back to Notes]</a>"
	     "<hr/>"
	     "<p class=\"author\">Author: %s</p>\n"
	     "<p class=\"date\">Date: %s<\p>\n"
	     )
	    author
	    (format-time-string "%Y-%m-%d %H:%M:%S %A")
	    )
	   )
	 ))
;; (setq org-html-postamble-format
;;       '(("en" "<hr/><p class=\"author\">Author: %a (%e)</p>\n<p class=\"date\">Date: %d</p>\n")))


;; ==================== wiki ====================
;; (require 'org-publish)
(setq org-publish-project-alist
      '(
	("org-wiki-notes"
	 :base-directory "~/octopress/org-wiki/"
	 :base-extension "org"
	 :publishing-directory "~/octopress/public/notes/" ; "/ssh:user@host:~/html/notebook/"
	 :recursive t
	 :publishing-function org-html-publish-to-html
	 :headline-levels 4             ; Just the default for this project.
         :section-numbers t
	 :auto-preamble t
	 :author "Hua Liang [Stupid ET]"
 	 :auto-sitemap t
	 :sitemap-filename "index.org"
	 :sitemap-title "Wiki of Stupid ET"
         ;; :style "<link rel=\"stylesheet\" type=\"text/css\" href=\"css/default.css\" />"   ; useless
	 )
	("org-wiki-static"
	 :base-directory "~/octopress/org-wiki/"
	 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
	 :publishing-directory "~/octopress/public/notes/"
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
