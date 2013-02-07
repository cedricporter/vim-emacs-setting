;; author: Hua Liang [Stupid ET]
;; Time-stamp: <2013-02-07 13:40:43 Thursday by Hua Liang>


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


;; ==================== css ====================
(setq org-export-html-style-include-scripts nil
      org-export-html-style-include-default nil)

(setq org-export-html-style
      "<link rel=\"stylesheet\" type=\"text/css\" href=\"css/org-style.css\" />")
;; -------------------- css --------------------


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
	 )
	("org-wiki-static"
	 :base-directory "~/org-wiki/"
	 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
	 :publishing-directory "~/wiki_public_html/"
	 :recursive t
	 :publishing-function org-publish-attachment
	 )
	("wiki" :components ("org-wiki-notes" "org-wiki-static"))
	))
;; -------------------- wiki --------------------

;(load "~/.emacs.d/plugins/org-mode-markdown/markdown.el")

;; (provide 'my-org-mode-settings)
